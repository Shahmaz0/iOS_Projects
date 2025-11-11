//
//  SomeView.swift
//  WeatherApp
//
//  Created by Shahma on 12/10/25.
//

import SwiftUI

struct SomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to Some View")
        }
        .navigationTitle("Some View")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    SomeView()
}
