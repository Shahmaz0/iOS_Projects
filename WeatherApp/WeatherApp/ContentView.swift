//
//  ContentView.swift
//  WeatherApp
//
//  Created by Shahma on 11/10/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var isNight: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView(isNight: isNight)
                
                VStack {
                    
                    CityTextView(cityName: "Cupertino, CA")
                    MainWeatherStatusView(imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill", temperature: 70)
                    
                    HStack(spacing: 20){
                        DayView(dayOfWeek: "Tue", imageName: "cloud.sun.fill", temperature: 70)
                        DayView(dayOfWeek: "Wed", imageName: "sun.max.fill", temperature: 34)
                        DayView(dayOfWeek: "Thu", imageName: "wind.snow", temperature: 55)
                        DayView(dayOfWeek: "Fri", imageName: "sunset.fill", temperature: 67)
                        DayView(dayOfWeek: "Sat", imageName: "cloud.moon.fill", temperature: 12)
                    }
                    
                    Spacer()
                    
                    Button {
                        isNight.toggle()
                    } label: {
                        WeatherButton(title: "Change Day Time", textColor: .blue, backgroundColor: Color.white)
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(isNight: false)
    }
}


struct BackgroundView: View {
    
    
    var isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : .cyan]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}


struct CityTextView: View {
    var cityName: String
    var body: some View {
        
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}


struct MainWeatherStatusView: View {
    
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium, design: .default))
                .foregroundColor(.white)

        }
        .padding(.bottom, 80)
    }
}


struct WeatherButton: View {
    
    var title: String
    var textColor: Color
    var backgroundColor: Color
    
    var body: some View {
        Text(title)
            .frame(width: 200, height: 50)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .font(.system(size: 20, weight: .medium, design: .default))
            .cornerRadius(10)
    }
}
