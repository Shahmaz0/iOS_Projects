//
//  SelectImageViewModel.swift
//  MyGallery
//
//  Created by Shahma on 27/10/25.
//

import Foundation
import SwiftUI
import Combine
import UIKit
import PhotosUI

@MainActor
class SelectImageViewModel: ObservableObject {
    @Published var selectedPhotoItem: PhotosPickerItem?
    @Published var selectedImage: UIImage?
    @Published var showImagePicker = false
    @Published var showCamera = false
    
    // MARK: - Methods
    func loadImage(from item: PhotosPickerItem) {
        item.loadTransferable(type: Data.self) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if case .success(let data) = result, let data = data {
                    if let image = UIImage(data: data) {
                        self.selectedImage = image
                    }
                }
                self.selectedPhotoItem = nil
            }
        }
    }
    
    func triggerImagePicker() {
        if selectedImage != nil {
            showImagePicker = true
        }
    }
}

