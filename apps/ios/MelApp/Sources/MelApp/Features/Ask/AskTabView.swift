import SwiftUI

private enum AskTimeFilter: String, CaseIterable, Identifiable {
  case last7Days = "Last 7 days"
  case last30Days = "Last 30 days"
  case allTime = "All time"

  var id: String { rawValue }
}

struct AskTabView: View {
  @State private var timeFilter: AskTimeFilter = .last7Days
  @State private var sourceFilter = "All Sources"

  private var sources: [String] {
    ["All Sources"] + Array(Set(MockData.chatThreads.map { $0.source })).sorted()
  }

  private var threads: [ChatThread] {
    MockData.chatThreads.filter { thread in
      if sourceFilter == "All Sources" {
        return true
      }
      return thread.source == sourceFilter
    }
    .sorted { $0.updatedAt > $1.updatedAt }
  }

  var body: some View {
    List {
      Section {
        Text("Ask about any newsletter you've received.")
          .font(.subheadline)
          .foregroundColor(.secondary)

        Picker("Time", selection: $timeFilter) {
          ForEach(AskTimeFilter.allCases) { filter in
            Text(filter.rawValue).tag(filter)
          }
        }
        .pickerStyle(.segmented)

        Menu(sourceFilter) {
          ForEach(sources, id: \.self) { source in
            Button(source) {
              sourceFilter = source
            }
          }
        }
      }

      if threads.isEmpty {
        Section {
          EmptyStateView(
            title: "No chat history",
            subtitle: "Start with a question in any newsletter or daily brief.",
            systemImage: "bubble.left"
          )
        }
      } else {
        Section("Recent Threads") {
          ForEach(threads) { thread in
            NavigationLink {
              ChatThreadView(thread: thread)
            } label: {
              VStack(alignment: .leading, spacing: 6) {
                Text(thread.title)
                  .font(.headline)

                Text(thread.source)
                  .font(.caption)
                  .foregroundColor(.secondary)
              }
            }
          }
        }
      }
    }
    .navigationTitle("Ask")
  }
}
