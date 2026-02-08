import SwiftUI

struct BriefDetailView: View {
  let card: BriefCard

  @State private var question = ""
  @State private var saveToLibrary = false
  @State private var constrainToTopic = true

  var body: some View {
    List {
      Section {
        Toggle("Save to library", isOn: $saveToLibrary)
      }

      ForEach(card.sections) { section in
        Section(section.topic) {
          ForEach(section.bullets, id: \.self) { bullet in
            Text("- \(bullet)")
          }

          Text("Sources: \(section.sources.joined(separator: ", "))")
            .font(.caption)
            .foregroundColor(.secondary)

          Button("Read originals") {
            // Placeholder until newsletter deep links are available.
          }
        }
      }
    }
    .safeAreaInset(edge: .bottom) {
      VStack(alignment: .leading, spacing: 8) {
        Toggle("Constrain Ask Mel to this topic", isOn: $constrainToTopic)
          .font(.caption)

        HStack {
          TextField("Ask Mel about this topic", text: $question)
            .textFieldStyle(.roundedBorder)

          Button("Send") {
            question = ""
          }
          .buttonStyle(.borderedProminent)
          .disabled(question.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
      }
      .padding()
      .background(.ultraThinMaterial)
    }
    .navigationTitle(card.title)
    .navigationBarTitleDisplayMode(.inline)
  }
}
