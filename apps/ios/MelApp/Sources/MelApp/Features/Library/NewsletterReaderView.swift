import SwiftUI

struct NewsletterReaderView: View {
  let newsletter: NewsletterItem

  @State private var question = ""
  @State private var constrainToNewsletter = true

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 16) {
        Text(newsletter.subject)
          .font(.title3)
          .bold()

        Text("Source: \(newsletter.source)")
          .font(.caption)
          .foregroundColor(.secondary)

        if !newsletter.keyPoints.isEmpty {
          VStack(alignment: .leading, spacing: 8) {
            Text("Key points")
              .font(.headline)
            ForEach(newsletter.keyPoints, id: \.self) { point in
              Text("- \(point)")
            }
          }
          .padding()
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(Color(.secondarySystemBackground))
          .clipShape(RoundedRectangle(cornerRadius: 12))
        }

        Text(newsletter.content)
          .font(.body)
          .frame(maxWidth: .infinity, alignment: .leading)

        Text("Citation: \(newsletter.source)")
          .font(.caption)
          .foregroundColor(.secondary)
      }
      .padding()
    }
    .safeAreaInset(edge: .bottom) {
      VStack(alignment: .leading, spacing: 8) {
        Toggle("Only this newsletter", isOn: $constrainToNewsletter)
          .font(.caption)

        HStack {
          TextField("Ask Mel about this newsletter", text: $question)
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
    .navigationTitle("Reading with Mel")
    .navigationBarTitleDisplayMode(.inline)
  }
}
