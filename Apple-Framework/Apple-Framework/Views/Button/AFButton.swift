//
//  AFButton.swift
//  Apple-Framework
//
//  Created by Shahma on 13/10/25.
//

import SwiftUI

struct AFButton: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.semibold)
            .frame(width: 280, height: 50)
            .background(.red)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

#Preview {
    AFButton(title: "Test Title")
}
