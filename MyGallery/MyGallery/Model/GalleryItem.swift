//
//  GalleryItem.swift
//  MyGallery
//
//  Created by Shahma on 27/10/25.
//

import Foundation

struct GalleryItem: Identifiable {
    let id: String
    let imageURL: String
    let referenceName: String
    var url: URL? {
        return URL(string: imageURL)
    }
}


struct MockData {
    
    static let sampleData = [GalleryItem(id: "1", imageURL: "sampleImage", referenceName: "Green Parrot"),
                             GalleryItem(id: "2", imageURL: "sampleImage", referenceName: "Green Parrot"),
                             GalleryItem(id: "3", imageURL: "sampleImage", referenceName: "Green Parrot"),
                             GalleryItem(id: "4", imageURL: "sampleImage", referenceName: "Green Parrot")]
}
