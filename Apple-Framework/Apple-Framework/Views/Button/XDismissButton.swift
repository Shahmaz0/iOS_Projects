//
//  XDismissButton.swift
//  Apple-Framework
//
//  Created by Shahma on 26/10/25.
//

import SwiftUI

struct XDismissButton: View {
    
    @Binding var isShowingDetailView: Bool
    
    var body: some View {
        HStack {
            
            Spacer()
            
            Button {
                isShowingDetailView = false
            }label: {
                 Image(systemName: "xmark")
                    .foregroundColor(Color(.label))
                    .frame(width: 44, height: 44)
            }
        }
        .padding()
    }
}

#Preview {
    XDismissButton(isShowingDetailView: .constant(false))
}
