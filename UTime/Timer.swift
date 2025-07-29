//
//  Timer.swift
//  UTime
//
//  Created by Jolin Wang on 7/29/25.
//

import SwiftUI

struct TimerView: View {
    @State private var currentTime = 0
    
    // Create a timer that fires every second
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 20) {
            Text("⏰ Timer:")
                .font(.headline)
            Text("\(currentTime) seconds")
                .font(.largeTitle)
                .bold()
            
            Button("Reset") {
                currentTime = 0
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .onReceive(timer) { _ in
            currentTime += 1
        }
    }
}

#Preview {
    TimerView()
}
