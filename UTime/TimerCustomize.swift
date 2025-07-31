//
//  TimerCustomize.swift
//  UTime
//
//  Created by Jolin Wang on 7/31/25.
//

import SwiftUI

struct SettingsView: View {
    @Binding var studyMinutes: Int
    @Binding var breakMinutes: Int
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Pomodoro Settings")) {
                    Stepper("Study Time: \(studyMinutes) min", value: $studyMinutes, in: 1...60)
                    Stepper("Break Time: \(breakMinutes) min", value: $breakMinutes, in: 1...30)
                }
            }
            .navigationTitle("Customize Timer")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        dismiss()
                    }
                }
            }
        }
    }
}
