//
//  ImageListViewModel.swift
//  MyGallery
//
//  Created by Shahma on 27/10/25.
//

import Foundation
import Combine

@MainActor
class ImageListViewModel: ObservableObject {
    
    @Published var galleryItems: [GalleryItem] = []
    @Published var isLoading = true
    
    private let cloudinaryManager = CloudinaryManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupObservers()
    }
    
    private func setupObservers() {
        cloudinaryManager.$galleryItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                guard let self = self else { return }
                self.galleryItems = items
                self.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    var isEmpty: Bool {
        galleryItems.isEmpty && !isLoading
    }
    
    func refreshGallery() async {
        isLoading = true
        try? await Task.sleep(nanoseconds: 500_000_000)
        isLoading = false
    }
}

