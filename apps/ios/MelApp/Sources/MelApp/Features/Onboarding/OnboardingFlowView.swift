import SwiftUI

private enum OnboardingStep: Int, CaseIterable {
  case welcome
  case email
  case checkInbox
  case melAddress
  case samples

  var title: String {
    switch self {
    case .welcome:
      return "Welcome"
    case .email:
      return "Sign In"
    case .checkInbox:
      return "Check Inbox"
    case .melAddress:
      return "Your Mel Address"
    case .samples:
      return "How It Works"
    }
  }

  var primaryActionTitle: String {
    switch self {
    case .welcome:
      return "Get Started"
    case .email:
      return "Send Magic Link"
    case .checkInbox:
      return "I Used The Link"
    case .melAddress:
      return "Continue"
    case .samples:
      return "Open Mel"
    }
  }
}

struct OnboardingFlowView: View {
  @Binding var hasOnboarded: Bool

  @State private var step: OnboardingStep = .welcome
  @State private var email = ""

  var body: some View {
    NavigationStack {
      VStack(spacing: 20) {
        content
        Spacer()
        actions
      }
      .padding()
      .navigationTitle(step.title)
      .navigationBarTitleDisplayMode(.inline)
    }
  }

  @ViewBuilder
  private var content: some View {
    switch step {
    case .welcome:
      VStack(alignment: .leading, spacing: 12) {
        Text("Read your newsletters with a buddy.")
          .font(.title2)
          .bold()
        Text("Mel turns incoming newsletters into a short daily brief and lets you ask questions with citations.")
          .foregroundColor(.secondary)
      }
      .frame(maxWidth: .infinity, alignment: .leading)

    case .email:
      VStack(alignment: .leading, spacing: 12) {
        Text("Use your email to receive a magic link.")
          .font(.headline)
        TextField("you@example.com", text: $email)
          .keyboardType(.emailAddress)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled(true)
          .padding(12)
          .background(Color(.secondarySystemBackground))
          .clipShape(RoundedRectangle(cornerRadius: 10))
      }
      .frame(maxWidth: .infinity, alignment: .leading)

    case .checkInbox:
      VStack(alignment: .leading, spacing: 12) {
        Text("Check your inbox")
          .font(.headline)
        Text("We sent a magic link to \(email.isEmpty ? "your email" : email). You can continue after opening it.")
          .foregroundColor(.secondary)
        Button("Resend link") {
          // Placeholder until backend auth is wired.
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)

    case .melAddress:
      VStack(alignment: .leading, spacing: 12) {
        Text("Your dedicated Mel address")
          .font(.headline)
        Text(MockData.userSettings.melAddress)
          .font(.body.monospaced())
          .padding(12)
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(Color(.secondarySystemBackground))
          .clipShape(RoundedRectangle(cornerRadius: 10))
        Text("Use this address when subscribing to newsletters.")
          .foregroundColor(.secondary)
      }
      .frame(maxWidth: .infinity, alignment: .leading)

    case .samples:
      VStack(alignment: .leading, spacing: 12) {
        Text("What you will get")
          .font(.headline)
        Label("Daily Brief in 2/5/10 min formats", systemImage: "newspaper")
        Label("Ask Mel questions with citations", systemImage: "bubble.left.and.bubble.right")
        Label("Read full newsletters with contextual chat", systemImage: "book")
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }

  private var actions: some View {
    VStack(spacing: 10) {
      Button(step.primaryActionTitle) {
        goForward()
      }
      .buttonStyle(.borderedProminent)
      .frame(maxWidth: .infinity)
      .disabled(step == .email && !isValidEmail(email))

      if step != .welcome {
        Button("Back") {
          goBack()
        }
        .buttonStyle(.bordered)
      }
    }
    .frame(maxWidth: .infinity)
  }

  private func goForward() {
    if step == .samples {
      hasOnboarded = true
      return
    }

    if let next = OnboardingStep(rawValue: step.rawValue + 1) {
      step = next
    }
  }

  private func goBack() {
    if let previous = OnboardingStep(rawValue: step.rawValue - 1) {
      step = previous
    }
  }

  private func isValidEmail(_ candidate: String) -> Bool {
    candidate.contains("@") && candidate.contains(".")
  }
}
