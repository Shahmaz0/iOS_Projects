//
//  UploadViewModel.swift
//  MyGallery
//
//  Created by Shahma on 27/10/25.
//

import Foundation
import UIKit
import Combine

@MainActor
class UploadViewModel: ObservableObject {
    
    @Published var referenceName = ""
    @Published var isUploading = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    private let cloudinaryManager = CloudinaryManager.shared
    
    
    func uploadImage(_ selectedImage: UIImage) {
        guard !referenceName.isEmpty else {
            print("⚠️ Reference name is empty")
            alertMessage = "Please enter a reference name"
            showAlert = true
            return
        }
        
        isUploading = true
        
        Task {
            do {
                try await cloudinaryManager.saveImage(selectedImage, referenceName: referenceName)
                isUploading = false
                alertMessage = "Image uploaded successfully!"
                showAlert = true
                
            } catch {
                isUploading = false
                alertMessage = "Failed to upload image: \(error.localizedDescription)"
                showAlert = true
            }
        }
    }
    
    var isSubmitDisabled: Bool {
        isUploading || referenceName.isEmpty
    }
}

