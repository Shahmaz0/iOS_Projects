//
//  CloudinaryManager.swift
//  MyGallery
//
//  Created by Shahma on 27/10/25.
//

import Foundation
import Combine
import FirebaseFirestore
import UIKit

@MainActor
class CloudinaryManager: ObservableObject {
    static let shared = CloudinaryManager()
    
    @Published var galleryItems: [GalleryItem] = []
    
    private let db = Firestore.firestore()
    private let cloudName = "dctynhgaa"
    private let uploadPreset = "gallery_upload"
    
    private init() {
        fetchImages()
    }
    
    func saveImage(_ image: UIImage, referenceName: String) async throws {
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw CloudinaryError.imageConversionFailed
        }
        
        let imageId = UUID().uuidString
        let filename = "gallery/\(imageId)"
        
        let imageURL = try await uploadToCloudinary(imageData: imageData, filename: filename)
        
        let item = GalleryItem(
            id: imageId,
            imageURL: imageURL,
            referenceName: referenceName
        )
        
        await MainActor.run {
            galleryItems.insert(item, at: 0)
        }
        
        try await db.collection("galleryItems").document(imageId).setData([
            "id": item.id,
            "imageURL": item.imageURL,
            "referenceName": item.referenceName,
            "createdAt": Timestamp()
        ])
    }
    
    private func uploadToCloudinary(imageData: Data, filename: String) async throws -> String {
        let urlString = "https://api.cloudinary.com/v1_1/\(cloudName)/image/upload"
        guard let url = URL(string: urlString) else {
            throw CloudinaryError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"upload_preset\"\r\n\r\n".data(using: .utf8)!)
        body.append(uploadPreset.data(using: .utf8)!)
        body.append("\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"public_id\"\r\n\r\n".data(using: .utf8)!)
        body.append(filename.data(using: .utf8)!)
        body.append("\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw CloudinaryError.uploadFailed
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let secureURL = json["secure_url"] as? String else {
                throw CloudinaryError.invalidResponse
            }
            
            return secureURL
            
        } catch {
            throw error
        }
    }
    
    private func fetchImages() {
        db.collection("galleryItems")
            .order(by: "createdAt", descending: false)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error fetching images: \(error)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No documents found")
                    return
                }
                
                let newItems = documents.compactMap { document -> GalleryItem? in
                    let data = document.data()
                    guard let id = data["id"] as? String,
                          let imageURL = data["imageURL"] as? String,
                          let referenceName = data["referenceName"] as? String else {
                        return nil
                    }
                    
                    return GalleryItem(id: id, imageURL: imageURL, referenceName: referenceName)
                }
                
                self.galleryItems = newItems
            }
    }
    
    func deleteImage(_ item: GalleryItem) async throws {
        try await db.collection("galleryItems").document(item.id).delete()
        galleryItems.removeAll { $0.id == item.id }
    }
}

enum CloudinaryError: Error {
    case imageConversionFailed
    case invalidURL
    case uploadFailed
    case invalidResponse
}

