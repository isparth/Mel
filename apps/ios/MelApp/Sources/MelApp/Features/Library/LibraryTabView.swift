import SwiftUI

private enum ReadFilter: String, CaseIterable, Identifiable {
  case all = "All"
  case unread = "Unread"
  case read = "Read"

  var id: String { rawValue }
}

private enum RecencyBucket: String {
  case today = "Today"
  case thisWeek = "This Week"
  case older = "Older"
}

struct LibraryTabView: View {
  @State private var readFilter: ReadFilter = .all
  @State private var sourceFilter = "All Sources"
  @State private var topicFilter = "All Topics"

  private var sources: [String] {
    ["All Sources"] + Array(Set(MockData.newsletters.map { $0.source })).sorted()
  }

  private var topics: [String] {
    ["All Topics"] + Array(Set(MockData.newsletters.map { $0.topic })).sorted()
  }

  private var filteredNewsletters: [NewsletterItem] {
    MockData.newsletters.filter { item in
      let readMatch: Bool
      switch readFilter {
      case .all:
        readMatch = true
      case .unread:
        readMatch = item.isUnread
      case .read:
        readMatch = !item.isUnread
      }

      let sourceMatch = sourceFilter == "All Sources" || item.source == sourceFilter
      let topicMatch = topicFilter == "All Topics" || item.topic == topicFilter
      return readMatch && sourceMatch && topicMatch
    }
    .sorted { $0.receivedAt > $1.receivedAt }
  }

  private var grouped: [RecencyBucket: [NewsletterItem]] {
    Dictionary(grouping: filteredNewsletters) { item in
      if Calendar.current.isDateInToday(item.receivedAt) {
        return .today
      }

      if let days = Calendar.current.dateComponents([.day], from: item.receivedAt, to: Date()).day,
         days <= 7 {
        return .thisWeek
      }

      return .older
    }
  }

  var body: some View {
    List {
      Section {
        filters
      }

      if filteredNewsletters.isEmpty {
        Section {
          EmptyStateView(
            title: "No newsletters",
            subtitle: "Try adjusting your filters or send newsletters to your Mel address.",
            systemImage: "tray"
          )
        }
      } else {
        ForEach([RecencyBucket.today, .thisWeek, .older], id: \.rawValue) { bucket in
          if let items = grouped[bucket], !items.isEmpty {
            Section(bucket.rawValue) {
              ForEach(items) { item in
                NavigationLink {
                  NewsletterReaderView(newsletter: item)
                } label: {
                  NewsletterRow(item: item)
                }
              }
            }
          }
        }
      }
    }
    .navigationTitle("Library")
  }

  private var filters: some View {
    VStack(alignment: .leading, spacing: 10) {
      Picker("Read", selection: $readFilter) {
        ForEach(ReadFilter.allCases) { option in
          Text(option.rawValue).tag(option)
        }
      }
      .pickerStyle(.segmented)

      HStack {
        Menu(sourceFilter) {
          ForEach(sources, id: \.self) { source in
            Button(source) { sourceFilter = source }
          }
        }

        Spacer()

        Menu(topicFilter) {
          ForEach(topics, id: \.self) { topic in
            Button(topic) { topicFilter = topic }
          }
        }
      }
      .font(.subheadline)
    }
  }
}

private struct NewsletterRow: View {
  let item: NewsletterItem

  var body: some View {
    VStack(alignment: .leading, spacing: 6) {
      HStack {
        Text(item.source)
          .font(.caption)
          .foregroundColor(.secondary)

        if item.isUnread {
          Text("Unread")
            .font(.caption2)
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .background(Color.blue.opacity(0.15))
            .clipShape(Capsule())
        }
      }

      Text(item.subject)
        .font(.headline)

      Text(item.preview)
        .font(.subheadline)
        .foregroundColor(.secondary)
    }
    .padding(.vertical, 6)
  }
}
