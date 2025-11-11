//
//  ContentView.swift
//  MyGallery
//
//  Created by Shahma on 27/10/25.
//

import SwiftUI

struct MyGalleryTabView: View {
    var body: some View {
        TabView {
            SelectImageView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Upload")
                }
            
            ImageListView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Images")
                }
        }
        .accentColor(Color(.green))
    }
}

#Preview {
    MyGalleryTabView()
}
