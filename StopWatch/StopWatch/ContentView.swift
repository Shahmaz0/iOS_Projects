//
//  ContentView.swift
//  StopWatch
//
//  Created by Shahma on 04/11/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNightModeOn: Bool = false
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer? = nil
    @State private var isRunning: Bool = false
    @State private var hoursInput: String = "0"
    @State private var minutesInput: String = "1"
    @State private var secondsInput: String = "0"
    
    @State private var totalTime: TimeInterval = 60
    @State private var remainingTime: TimeInterval = 60
    let snowflakesColor: Color = Color(red: 0.7, green: 0.9, blue: 1.0)
    
    var body: some View {
        ZStack {
            Image("background2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            SnowfallView()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(Color(red: 0.2, green: 0.2, blue: 0.2))
                    
                    Circle()
                        .trim(from: 0, to: CGFloat(1 - (remainingTime / totalTime)))
                        .stroke(snowflakesColor, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                        .rotationEffect(.init(degrees: -90))
                        .padding()
                        .animation(.linear(duration: 1), value: remainingTime)
                    
                    VStack {
                        Text(timeString(from: remainingTime))
                            .font(.system(size: 40, weight: .medium, design: .monospaced))
                            .foregroundColor(.white)
                        Text("Work")
                            .font(.system(size: 30, weight: .light, design: .monospaced))
                            .foregroundColor(.white)
                    }
                }
                .offset(y: 50)
                
                Spacer()
                
                HStack(spacing: 80) {
                    Button {
                        DispatchQueue.main.async {
                            toggleTimer()
                        }
                        
                    } label: {
                        Image(systemName: isRunning ? "pause.circle.fill" : "play.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(snowflakesColor)
                    }
                    
                    Button {
                        stopTimer()
                    } label: {
                        Image(systemName: "stop.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .background(Color.black)
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func toggleTimer() {
        if isRunning {
            pauseTimer()
        } else {
            startTimer()
        }
    }
    
    private func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                stopTimer()
            }
        }
    }
    
    private func pauseTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    private func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
        remainingTime = totalTime
    }
}

#Preview {
    ContentView()
}
