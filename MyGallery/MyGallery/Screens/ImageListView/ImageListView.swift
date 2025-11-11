//
//  ImageListView.swift
//  MyGallery
//
//  Created by Shahma on 27/10/25.
//

import SwiftUI

struct ImageListView: View {
    @StateObject private var viewModel = ImageListViewModel()
    
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.isEmpty {
                    VStack {
                        Text("No images yet")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 350)
                } else {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.galleryItems) { item in
                            VStack(spacing: 10) {
                                RemoteImage(url: item.url)
                                    .id(item.id)
                                
                                Text(item.referenceName)
                                    .font(.body)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.6)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: (UIScreen.main.bounds.width - 48) / 2)
                            }
                        }
                    }
                }
            }
            .refreshable {
                await viewModel.refreshGallery()
            }
            .navigationTitle("Images")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ImageListView()
}

