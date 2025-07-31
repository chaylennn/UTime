//
//  Timer.swift
//  UTime
//
//  Created by Jolin Wang on 7/29/25.
//

import SwiftUI

enum TimerMode {
    case pomodoro
    case breakTime
}

struct CustomTimerView: View {
    @State private var minutes: Int = 25
    @State private var seconds: Int = 0
    @State private var totalTime: Int = 1500  // 25 minutes in seconds
    @State private var timeLeft: Int = 1500
    @State private var isRunning = false
    @State private var mode: TimerMode = .pomodoro

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color.appCream.ignoresSafeArea()

            VStack(spacing: 20) {
                Image("cute animal plant")
                    .resizable()
                    .frame(width: 150, height: 100)
                    .clipShape(Circle())

                Text("Focus Timer")
                    .font(.title2)
                    .bold()

                // Display current mode
                Text(mode == .pomodoro ? "🌿Study Time" : "🌿 Break Time")
                    .foregroundColor(.gray)
                    .italic()

                // Time pickers (disabled while running)
                HStack {
                    Stepper("Minutes: \(minutes)", value: $minutes, in: 0...59)
                        .disabled(isRunning)
                    Stepper("Seconds: \(seconds)", value: $seconds, in: 0...59)
                        .disabled(isRunning)
                }
                .padding()

                // MM:SS Display
                Text(formatTime(timeLeft))
                    .font(.largeTitle)
                    .monospacedDigit()
                    .foregroundColor(timeLeft > 0 ? .primary : .red)

                // Buttons
                VStack(spacing: 10) {
                    HStack(spacing: 20) {
                        Button("Start Focus") {
                            mode = .pomodoro
                            isRunning = false
                            minutes = 25
                            seconds = 0
                            totalTime = 25 * 60
                            timeLeft = totalTime
                            isRunning = true
                        }
                        .frame(width: 140)

                        Button("Start Break") {
                            mode = .breakTime
                            isRunning = false
                            minutes = 5
                            seconds = 0
                            totalTime = 5 * 60
                            timeLeft = totalTime
                            isRunning = true
                        }
                        .frame(width: 120)
                    }

                    HStack(spacing: 60) {
                        Button("Start") {
                            totalTime = minutes * 60 + seconds
                            timeLeft = totalTime
                            isRunning = true
                        }
                        .frame(width: 80)
                        .disabled(isRunning)

                        Button("Reset") {
                            isRunning = false
                            switch mode {
                            case .pomodoro:
                                minutes = 25
                                seconds = 0
                            case .breakTime:
                                minutes = 5
                                seconds = 0
                            }
                            timeLeft = minutes * 60 + seconds
                        }
                        .frame(width: 80)
                    }
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.green)
            }
            .padding()
        }
        .onReceive(timer) { _ in
            guard isRunning else { return }
            if timeLeft > 0 {
                timeLeft -= 1
            } else {
                isRunning = false
            }
        }
    }

    func formatTime(_ seconds: Int) -> String {
        let mins = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", mins, secs)
    }
}

#Preview {
    CustomTimerView()
}
