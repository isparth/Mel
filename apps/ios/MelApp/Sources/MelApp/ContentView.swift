import SwiftUI

struct ContentView: View {
  @AppStorage("hasOnboarded") private var hasOnboarded = false

  var body: some View {
    if hasOnboarded {
      MainTabView()
    } else {
      OnboardingFlowView(hasOnboarded: $hasOnboarded)
    }
  }
}
