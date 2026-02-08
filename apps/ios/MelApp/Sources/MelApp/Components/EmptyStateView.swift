import SwiftUI

struct EmptyStateView: View {
  let title: String
  let subtitle: String
  let systemImage: String

  var body: some View {
    VStack(spacing: 10) {
      Image(systemName: systemImage)
        .font(.system(size: 32))
        .foregroundColor(.secondary)

      Text(title)
        .font(.headline)

      Text(subtitle)
        .font(.subheadline)
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical, 32)
  }
}
