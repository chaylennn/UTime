//
//  Timer.swift
//  UTime
//
//  Created by Jolin Wang on 7/29/25.
//
import SwiftUI

struct CustomTimerView: View {
    @State private var totalTime: Int = 10
    @State private var timeLeft: Int = 10
    @State private var isRunning = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 20) {
            Image("cute animal plant")
                .frame(width:50,height: 50)

            Text("⏳ Countdown Timer")
                .font(.title2)
                .bold()

            Stepper("Seconds: \(totalTime)", value: $totalTime, in: 1...3600, step: 1)
                .disabled(isRunning)
                .padding()

            Text("\(timeLeft) seconds left")
                .font(.largeTitle)
                .monospacedDigit()
                .foregroundColor(timeLeft > 0 ? .primary : .red)
            
            HStack(spacing: 20) {
                Button(action: {
                    timeLeft = totalTime
                    isRunning = true
                }) {
                    Text("Start")
                        .frame(width: 80)
                }
                .disabled(isRunning)

                Button(action: {
                    isRunning = false
                    timeLeft = totalTime
                }) {
                    Text("Reset")
                        .frame(width: 80)
                }
            }
            .padding()
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .onReceive(timer) { _ in
            guard isRunning else { return }
            if timeLeft > 0 {
                timeLeft -= 1
            } else {
                isRunning = false
            }
        }
    }
}

#Preview {
    CustomTimerView()
}


          
