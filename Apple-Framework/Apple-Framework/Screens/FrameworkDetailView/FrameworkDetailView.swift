//
//  FrameworkDetailView.swift
//  Apple-Framework
//
//  Created by Shahma on 13/10/25.
//

import SwiftUI

struct FrameworkDetailView: View {
    
    let framework: Framework
    @State private var isShowingSafariView: Bool = false
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            FrameworkTitleView(framework: framework)
            Text(framework.description)
                .padding()
                .font(.body)
            
            Spacer()
            
            Button {
                isShowingSafariView = true
            }label: {
                AFButton(title: "Learn More")
            }
        }
        .sheet(isPresented: $isShowingSafariView, content: {
            SafariView(url: URL(string: framework.urlString) ?? URL(string: "www.apple.com")!)
        })
    }
}

#Preview {
    FrameworkDetailView(framework: MockData.sampleFramework)
        .preferredColorScheme(.dark)
}
