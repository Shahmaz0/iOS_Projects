//
//  DayView.swift
//  WeatherApp
//
//  Created by Shahma on 11/10/25.
//

import SwiftUI

struct DayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 8) {
            Text(dayOfWeek)
                .font(.system(size: 30, weight: .medium, design: .default))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            Text("\(temperature)°")
                .font(.system(size: 30, weight: .medium, design: .default))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    DayView(dayOfWeek: "Tue", imageName: "cloud.sun.fill", temperature: 70)
}
