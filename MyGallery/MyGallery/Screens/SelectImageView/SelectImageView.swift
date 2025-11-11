//
//  SelectImageView.swift
//  MyGallery
//
//  Created by Shahma on 27/10/25.
//

import SwiftUI
import Combine
import PhotosUI

struct SelectImageView: View {
    @StateObject private var viewModel = SelectImageViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
                
                Spacer()
                
                PhotosPicker(selection: $viewModel.selectedPhotoItem, matching: .images) {
                    VStack(spacing: 20) {
                        Image(systemName: "photo")
                            .font(.system(size: 60))
                            .foregroundColor(.green)
                        
                        Text("Browse Gallery")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity, minHeight: 180)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [15]))
                            .foregroundColor(.green)
                    )
                }
                
                SeparatorView()
                
                Button(action: {
                    viewModel.showCamera = true
                }) {
                    VStack(spacing: 16) {
                        HStack {
                            Image(systemName: "camera.fill")
                                .font(.system(size: 18))
                                .foregroundColor(.green)
                            
                            Text("Open Camera")
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [15]))
                        .foregroundColor(.green)
                )
                
                Spacer()
            }
            .padding()
            .navigationTitle("Upload")
            .onChange(of: viewModel.selectedPhotoItem) { _, newValue in
                if let newValue = newValue {
                    viewModel.loadImage(from: newValue)
                }
            }
            .onChange(of: viewModel.selectedImage) { _, newValue in
                if newValue != nil {
                    viewModel.showImagePicker = true
                }
            }
            .sheet(isPresented: $viewModel.showImagePicker) {
                if let image = viewModel.selectedImage {
                    UploadImageView(selectedImage: image, viewModel: UploadViewModel())
                }
            }
            .fullScreenCover(isPresented: $viewModel.showCamera) {
                CameraView(selectedImage: $viewModel.selectedImage)
            }
        }
    }
}




