import SwiftUI

struct ChatThreadView: View {
  let thread: ChatThread

  @State private var draft = ""

  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading, spacing: 12) {
        ForEach(thread.messages) { message in
          MessageBubble(message: message)
        }
      }
      .padding()
    }
    .safeAreaInset(edge: .bottom) {
      HStack {
        TextField("Ask follow-up", text: $draft)
          .textFieldStyle(.roundedBorder)

        Button("Send") {
          draft = ""
        }
        .buttonStyle(.borderedProminent)
        .disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
      }
      .padding()
      .background(.ultraThinMaterial)
    }
    .navigationTitle(thread.title)
    .navigationBarTitleDisplayMode(.inline)
  }
}

private struct MessageBubble: View {
  let message: ChatMessage

  var body: some View {
    VStack(alignment: message.role == .user ? .trailing : .leading, spacing: 6) {
      Text(message.text)
        .padding(10)
        .frame(maxWidth: .infinity, alignment: message.role == .user ? .trailing : .leading)
        .background(message.role == .user ? Color.blue.opacity(0.2) : Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))

      if !message.citations.isEmpty {
        Text("Citations: \(message.citations.joined(separator: ", "))")
          .font(.caption)
          .foregroundColor(.secondary)
      }
    }
  }
}
