//
//  AppetizerListView.swift
//  Appetizers
//
//  Created by Shahma on 27/10/25.
//

import SwiftUI

struct AppetizerListView: View {
    var body: some View {
        NavigationView {
            List(MockData.appetizers) { appetizer in
                AppetizerListCell(appetizer: appetizer)
            }
        }
        .navigationTitle("🍟 Appetizers")
        .listStyle(.plain)
    }
}

#Preview {
    AppetizerListView()
}
