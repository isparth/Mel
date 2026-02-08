import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

struct SettingsTabView: View {
  @State private var briefTime = MockData.userSettings.briefTime
  @State private var notificationsEnabled = MockData.userSettings.notificationsEnabled
  @State private var copied = false

  var body: some View {
    Form {
      Section("Account") {
        LabeledContent("Email", value: MockData.userSettings.email)
        Button("Log out") {
          // Placeholder until auth session handling is wired.
        }
      }

      Section("Mel Address") {
        LabeledContent("Address", value: MockData.userSettings.melAddress)
        Button(copied ? "Copied" : "Copy address") {
          copyAddress()
        }
      }

      Section("Brief & Notifications") {
        DatePicker("Daily brief time", selection: $briefTime, displayedComponents: .hourAndMinute)
        Toggle("Push notifications", isOn: $notificationsEnabled)
      }

      Section("Data Controls") {
        Button("Delete all data", role: .destructive) {
          // Placeholder until data controls are wired.
        }
        Button("Export data") {
          // Placeholder until export is wired.
        }
      }

      Section("Support") {
        Button("Help") {
          // Placeholder until help route is wired.
        }
        Button("Contact") {
          // Placeholder until contact route is wired.
        }
      }
    }
    .navigationTitle("Settings")
  }

  private func copyAddress() {
    #if canImport(UIKit)
    UIPasteboard.general.string = MockData.userSettings.melAddress
    #endif

    copied = true
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
      copied = false
    }
  }
}
