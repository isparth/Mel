import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      VStack(spacing: 16) {
        Text("Mel")
          .font(.largeTitle)
          .bold()
        Text("Read newsletters with a buddy.")
          .foregroundColor(.secondary)
        Button("Get Started") {
          // TODO: wire onboarding
        }
        .buttonStyle(.borderedProminent)
      }
      .padding()
      .navigationTitle("Brief")
    }
  }
}
