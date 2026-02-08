import SwiftUI

struct MainTabView: View {
  var body: some View {
    TabView {
      NavigationStack {
        BriefTabView()
      }
      .tabItem {
        Label("Brief", systemImage: "newspaper")
      }

      NavigationStack {
        LibraryTabView()
      }
      .tabItem {
        Label("Library", systemImage: "tray.full")
      }

      NavigationStack {
        AskTabView()
      }
      .tabItem {
        Label("Ask", systemImage: "bubble.left.and.bubble.right")
      }

      NavigationStack {
        SettingsTabView()
      }
      .tabItem {
        Label("Settings", systemImage: "gearshape")
      }
    }
  }
}
