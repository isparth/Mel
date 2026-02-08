import SwiftUI

struct BriefTabView: View {
  @State private var duration: BriefDuration = .five

  private var cards: [BriefCard] {
    Array(MockData.briefCards.prefix(duration.itemLimit))
  }

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 16) {
        header

        if cards.isEmpty {
          EmptyStateView(
            title: "Waiting for your first newsletters",
            subtitle: "Subscribe using your Mel address and your first brief will appear here.",
            systemImage: "tray"
          )
          .padding(.top, 50)
        } else {
          ForEach(cards) { card in
            NavigationLink {
              BriefDetailView(card: card)
            } label: {
              BriefCardView(card: card)
            }
            .buttonStyle(.plain)
          }
        }
      }
      .padding()
    }
    .navigationTitle("Brief")
  }

  private var header: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(Date.now, format: .dateTime.weekday(.wide).month().day())
        .font(.headline)

      Picker("Duration", selection: $duration) {
        ForEach(BriefDuration.allCases) { option in
          Text(option.label).tag(option)
        }
      }
      .pickerStyle(.segmented)
    }
  }
}

private struct BriefCardView: View {
  let card: BriefCard

  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(card.title)
        .font(.headline)
        .foregroundColor(.primary)

      Text(card.summary)
        .font(.subheadline)
        .foregroundColor(.secondary)

      Text("Sources: \(card.sources.joined(separator: ", "))")
        .font(.caption)
        .foregroundColor(.secondary)

      HStack {
        Button("Ask about this") {
          // Placeholder until backend chat is wired.
        }
        .buttonStyle(.bordered)

        Button("Open full digest") {
          // Placeholder until full digest fetch is wired.
        }
        .buttonStyle(.bordered)
      }
    }
    .padding()
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(Color(.secondarySystemBackground))
    .clipShape(RoundedRectangle(cornerRadius: 12))
  }
}
