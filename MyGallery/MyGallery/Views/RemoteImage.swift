//
//  RemoteImage.swift
//  MyGallery
//
//  Created by Shahma on 27/10/25.
//

import SwiftUI

struct RemoteImage: View {
    let url: URL?
    @State private var image: UIImage?
    @State private var isLoading = true
    @State private var hasError = false
    @State private var retryCount = 0
    
    private let maxRetries = 3
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
                    .frame(width: (UIScreen.main.bounds.width - 48) / 2,
                           height: (UIScreen.main.bounds.width - 48) / 2)
            } else if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: (UIScreen.main.bounds.width - 48) / 2,
                           height: (UIScreen.main.bounds.width - 48) / 2)
                    .clipped()
                    .cornerRadius(10)
                    .transition(.opacity)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: (UIScreen.main.bounds.width - 48) / 2,
                           height: (UIScreen.main.bounds.width - 48) / 2)
                    .foregroundColor(.gray)
                    .cornerRadius(10)
                    .onTapGesture {
                        retryLoad()
                    }
            }
        }
        .task {
            await loadImage()
        }
    }
    
    private func loadImage() async {
        guard let url = url else {
            isLoading = false
            hasError = true
            return
        }
        
        // Check cache first, this is the key for persistent caching
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            if let cachedImage = UIImage(data: cachedResponse.data) {
                await MainActor.run {
                    self.image = cachedImage
                    self.isLoading = false
                }
                return
            }
        }
        
        // Load from network only if not in cache
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let loadedImage = UIImage(data: data) {
                await MainActor.run {
                    self.image = loadedImage
                    self.isLoading = false
                }
            } else {
                await MainActor.run {
                    self.isLoading = false
                    self.hasError = true
                }
            }
        } catch {
            await MainActor.run {
                self.isLoading = false
                self.hasError = true
            }
        }
    }
    
    private func retryLoad() {
        guard retryCount < maxRetries else { return }
        
        retryCount += 1
        isLoading = true
        hasError = false
        
        Task {
            await loadImage()
        }
    }
}
