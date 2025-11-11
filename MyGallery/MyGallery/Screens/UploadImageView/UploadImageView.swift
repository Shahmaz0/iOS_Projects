//
//  UploadImageView.swift
//  MyGallery
//
//  Created by Shahma on 27/10/25.
//

import SwiftUI

struct UploadImageView: View {
    let selectedImage: UIImage
    @StateObject var viewModel: UploadViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                VStack(spacing: 30) {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .frame(height: 500)
                        .clipped()
                    
                    TextField("Reference Name", text: $viewModel.referenceName)
                        .frame(width: 330, height: 50)
                        .padding(.leading, 10)
                        .cornerRadius(10)
                        .padding(.horizontal, 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        
                    
                    Button {
                        viewModel.uploadImage(selectedImage)
                    } label: {
                        if viewModel.isUploading {
                            ProgressView()
                                .frame(width: 350, height: 50)
                        } else {
                            Text("Submit")
                                .frame(width: 120, height: 50)
                        }
                    }
                    .frame(height: 50)
                    .frame(maxWidth: 120)
                    .background(viewModel.isSubmitDisabled ? Color.gray : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .padding(.horizontal, 10)
                    .disabled(viewModel.isSubmitDisabled)
                    
                    Spacer()
                }
                
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.red)
                        .padding(8)
                }
                .padding(.trailing, 16)
                .padding(.top, 8)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EmptyView()
                }
            }
            .alert("Upload", isPresented: $viewModel.showAlert) {
                if viewModel.alertMessage == "Image uploaded successfully!" {
                    Button("OK", role: .cancel) {
                        dismiss()
                    }
                } else {
                    Button("OK", role: .cancel) {}
                }
            } message: {
                Text(viewModel.alertMessage)
            }
        }
    }
}

#Preview {
    UploadImageView(selectedImage: UIImage(systemName: "photo")!, viewModel: UploadViewModel())
}

