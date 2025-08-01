import SwiftUI

enum TimerMode {
    case pomodoro
    case breakTime
}

struct CustomTimerView: View {
    @State private var showSettings = false

    @State private var minutes: Int = 25 {
        didSet {
            if !isRunning {
                timeLeft = minutes * 60 + seconds
            }
        }
    }
    @State private var seconds: Int = 0 {
        didSet {
            if !isRunning {
                timeLeft = minutes * 60 + seconds
            }
        }
    }

    @State private var totalTime: Int = 1500
    @State private var timeLeft: Int = 1500
    @State private var isRunning = false
    @State private var mode: TimerMode = .pomodoro

    @State private var studyMinutes: Int = 25
    @State private var breakMinutes: Int = 5

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color.appCream.ignoresSafeArea()

            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .font(.title2)
                            .padding()
                            .foregroundColor(.gray)
                    }
                }

                Image("cute animal plant")
                    .resizable()
                    .frame(width: 150, height: 100)
                    .clipShape(Circle())

                Text("Focus Timer")
                    .font(.title)
                    .bold()
                    .foregroundColor(.darkGreen)

                Text(mode == .pomodoro ? "🍅 Study Time" : "🌿 Break Time")
                    .foregroundColor(.darkGreen)
                    .italic()

                // Time picker
                HStack {
                    Stepper("Minutes: \(minutes)", value: $minutes, in: 0...59)
                        .disabled(isRunning)
                    Stepper("Seconds: \(seconds)", value: $seconds, in: 0...59)
                        .disabled(isRunning)
                }
                .padding()

                // Time display
                Text(formatTime(timeLeft))
                    .font(.largeTitle)
                    .monospacedDigit()
                    .foregroundColor(timeLeft > 0 ? .primary : .red)

                // Focus/Break Buttons
                HStack(spacing: 20) {
                    Button("Start Focus") {
                        mode = .pomodoro
                        isRunning = false
                        minutes = studyMinutes
                        seconds = 0
                        totalTime = minutes * 60
                        timeLeft = totalTime
                        isRunning = true
                    }
                    .foregroundColor(AppColorTheme.darkGreenColor)

                    Button("Start Break") {
                        mode = .breakTime
                        isRunning = false
                        minutes = breakMinutes
                        seconds = 0
                        totalTime = minutes * 60
                        timeLeft = totalTime
                        isRunning = true
                    }
                    .foregroundColor(AppColorTheme.darkGreenColor)
                }
                .padding(.top, 10)

                // Start/Reset Buttons
                HStack(spacing: 20) {
                    Button("Start") {
                        totalTime = minutes * 60 + seconds
                        timeLeft = totalTime
                        isRunning = true
                    }
                    .disabled(isRunning)

                    Button("Reset") {
                        isRunning = false
                        switch mode {
                        case .pomodoro:
                            minutes = studyMinutes
                        case .breakTime:
                            minutes = breakMinutes
                        }
                        seconds = 0
                        timeLeft = minutes * 60
                    }
                }
                .padding(.bottom)
                .buttonStyle(.borderedProminent)
                .tint(AppColorTheme.lightGreenColor)
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
        .sheet(isPresented: $showSettings) {
            SettingsView(studyMinutes: $studyMinutes, breakMinutes: $breakMinutes)
        }
        .foregroundColor(.darkGreen)
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
