//
//  MyGalleryApp.swift
//  MyGallery
//
//  Created by Shahma on 27/10/25.
//

import SwiftUI
import FirebaseCore

@main
struct MyGalleryApp: App {
    
    init() {
        FirebaseApp.configure()
        setupImageCache()
    }
    
    var body: some Scene {
        WindowGroup {
            MyGalleryTabView()
        }
    }
    
    private func setupImageCache() {
        let cacheSizeMemory = 50 * 1024 * 1024
        let cacheSizeDisk = 200 * 1024 * 1024
        
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let diskPath = cacheDirectory.appendingPathComponent("MyGalleryImageCache")
        
        let cache = URLCache(
            memoryCapacity: cacheSizeMemory,
            diskCapacity: cacheSizeDisk,
            diskPath: diskPath.path
        )
        
        URLCache.shared = cache
    }
}
