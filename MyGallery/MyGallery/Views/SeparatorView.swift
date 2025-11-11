//
//  SeparatorView.swift
//  MyGallery
//
//  Created by Shahma on 27/10/25.
//

import SwiftUI

struct SeparatorView: View {
    var color: Color = .gray
    
    var body: some View {
        
        HStack {
            
            GeometryReader { geometry in
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
                }
                .stroke(color, style: StrokeStyle(lineWidth: 1, dash: [15]))
            }
            .frame(height: 1)
            
            Text("Or")
                .padding(.horizontal, 5)
            
            GeometryReader { geometry in
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
                }
                .stroke(color, style: StrokeStyle(lineWidth: 1, dash: [15]))
            }
            .frame(height: 1)
        }
    }
}


#Preview {
    SeparatorView()
}


