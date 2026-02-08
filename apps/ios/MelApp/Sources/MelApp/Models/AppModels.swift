import Foundation

enum BriefDuration: Int, CaseIterable, Identifiable {
  case two = 2
  case five = 5
  case ten = 10

  var id: Int { rawValue }

  var label: String {
    "\(rawValue) min"
  }

  var itemLimit: Int {
    switch self {
    case .two:
      return 2
    case .five:
      return 4
    case .ten:
      return 8
    }
  }
}

struct BriefSection: Identifiable {
  let id = UUID()
  let topic: String
  let bullets: [String]
  let sources: [String]
}

struct BriefCard: Identifiable {
  let id = UUID()
  let title: String
  let summary: String
  let sources: [String]
  let sections: [BriefSection]
}

struct NewsletterItem: Identifiable {
  let id = UUID()
  let source: String
  let subject: String
  let preview: String
  let topic: String
  let receivedAt: Date
  let content: String
  let keyPoints: [String]
  let isUnread: Bool
}

enum MessageRole {
  case user
  case assistant
}

struct ChatMessage: Identifiable {
  let id = UUID()
  let role: MessageRole
  let text: String
  let citations: [String]
}

struct ChatThread: Identifiable {
  let id = UUID()
  let title: String
  let source: String
  let updatedAt: Date
  let messages: [ChatMessage]
}

struct UserSettings {
  let email: String
  let melAddress: String
  let briefTime: Date
  let notificationsEnabled: Bool
}

enum MockData {
  static let briefCards: [BriefCard] = [
    BriefCard(
      title: "AI Product Launches",
      summary: "Three major AI product launches this morning with clear enterprise focus.",
      sources: ["The Information", "Ben's Bites", "Stratechery"],
      sections: [
        BriefSection(
          topic: "Launch Highlights",
          bullets: [
            "Two assistants shipped meeting summarization tied to calendar context.",
            "Pricing shifted toward seat + usage hybrid for enterprise teams."
          ],
          sources: ["The Information", "Ben's Bites"]
        ),
        BriefSection(
          topic: "What It Means",
          bullets: [
            "Distribution through existing productivity suites still dominates adoption.",
            "Model quality differences are narrowing; workflow fit is now a key moat."
          ],
          sources: ["Stratechery"]
        )
      ]
    ),
    BriefCard(
      title: "Markets Snapshot",
      summary: "Rates commentary and earnings surprises moved large-cap tech.",
      sources: ["Morning Brew", "Exec Sum"],
      sections: [
        BriefSection(
          topic: "Rates & Sentiment",
          bullets: [
            "Treasury commentary lowered near-term volatility expectations.",
            "Growth names recovered as guidance remained stable."
          ],
          sources: ["Morning Brew"]
        )
      ]
    ),
    BriefCard(
      title: "Developer Tools",
      summary: "Release cycle speed increased across CI and deployment products.",
      sources: ["TLDR", "Hacker Newsletter"],
      sections: [
        BriefSection(
          topic: "Platform Updates",
          bullets: [
            "Vendors are consolidating observability into release workflows.",
            "Policy-as-code surfaced as a standard feature in new rollouts."
          ],
          sources: ["TLDR", "Hacker Newsletter"]
        )
      ]
    ),
    BriefCard(
      title: "Policy & Regulation",
      summary: "Draft rules on AI transparency introduced compliance timing pressure.",
      sources: ["Fintech Brainfood", "Lawfare"],
      sections: [
        BriefSection(
          topic: "Compliance Timeline",
          bullets: [
            "Most proposals indicate staged enforcement over 12-18 months.",
            "Documentation requirements likely to affect procurement cycles."
          ],
          sources: ["Lawfare"]
        )
      ]
    ),
    BriefCard(
      title: "Startups to Watch",
      summary: "Early-stage teams are targeting workflow-specific copilots.",
      sources: ["Not Boring", "Every"],
      sections: [
        BriefSection(
          topic: "Emerging Patterns",
          bullets: [
            "Narrow vertical products are winning by tighter data integrations.",
            "User trust messaging is now as visible as model claims."
          ],
          sources: ["Not Boring", "Every"]
        )
      ]
    )
  ]

  static let newsletters: [NewsletterItem] = [
    NewsletterItem(
      source: "Morning Brew",
      subject: "Markets rally on steady guidance",
      preview: "Big tech outperformed after a stronger earnings week.",
      topic: "Markets",
      receivedAt: daysAgo(0),
      content: "Today markets moved higher as tech guidance remained resilient. Analysts noted stronger software renewals and cooling rate concerns.",
      keyPoints: [
        "Software renewals came in stronger than expected.",
        "Rate sentiment improved versus prior week.",
        "Large-cap tech led gains."
      ],
      isUnread: true
    ),
    NewsletterItem(
      source: "TLDR",
      subject: "CI platforms move into policy workflows",
      preview: "CI/CD vendors are bundling security and policy layers.",
      topic: "Developer Tools",
      receivedAt: daysAgo(0),
      content: "Deployment pipelines now include policy gates by default. Teams report fewer late-stage release rollbacks when controls are defined earlier.",
      keyPoints: [
        "Policy-as-code appears in most major CI releases.",
        "Early controls reduce deployment rollbacks."
      ],
      isUnread: true
    ),
    NewsletterItem(
      source: "Stratechery",
      subject: "Distribution is still the moat",
      preview: "Model parity shifts competition toward integrated workflows.",
      topic: "AI",
      receivedAt: daysAgo(1),
      content: "As foundation models converge in quality, distribution advantages and workflow embedding become the durable differentiator for platform companies.",
      keyPoints: [
        "Workflow fit outweighs incremental model gains.",
        "Integrated distribution remains a key moat."
      ],
      isUnread: false
    ),
    NewsletterItem(
      source: "Lawfare",
      subject: "AI transparency framework draft",
      preview: "Regulators published new draft requirements on disclosures.",
      topic: "Policy",
      receivedAt: daysAgo(3),
      content: "Draft frameworks emphasize explainability documentation and procurement transparency, with staged deadlines for enterprise adoption.",
      keyPoints: [
        "Staged deadlines likely over 12-18 months.",
        "Documentation burden may slow procurement."
      ],
      isUnread: false
    ),
    NewsletterItem(
      source: "Not Boring",
      subject: "Vertical copilots are breaking out",
      preview: "Startups are winning by solving one workflow end-to-end.",
      topic: "Startups",
      receivedAt: daysAgo(7),
      content: "Vertical copilots in legal, sales, and operations are growing quickly because they focus on deep integrations and specific outcomes.",
      keyPoints: [
        "Vertical focus drives faster ROI proof.",
        "Deep integrations are core to retention."
      ],
      isUnread: false
    )
  ]

  static let chatThreads: [ChatThread] = [
    ChatThread(
      title: "What changed in AI launches?",
      source: "All Sources",
      updatedAt: daysAgo(0),
      messages: [
        ChatMessage(role: .user, text: "What changed in today's AI launches?", citations: []),
        ChatMessage(
          role: .assistant,
          text: "Most launches emphasized enterprise workflow integrations and pricing changes over raw model benchmarks.",
          citations: ["The Information", "Ben's Bites", "Stratechery"]
        )
      ]
    ),
    ChatThread(
      title: "Summarize market signals",
      source: "Morning Brew",
      updatedAt: daysAgo(1),
      messages: [
        ChatMessage(role: .user, text: "Give me the market signal in under 30 seconds", citations: []),
        ChatMessage(
          role: .assistant,
          text: "Guidance stability improved sentiment, and large-cap tech led the rebound.",
          citations: ["Morning Brew"]
        )
      ]
    ),
    ChatThread(
      title: "Regulation timeline",
      source: "Lawfare",
      updatedAt: daysAgo(2),
      messages: [
        ChatMessage(role: .user, text: "What is the likely compliance timeline?", citations: []),
        ChatMessage(
          role: .assistant,
          text: "The current drafts indicate staged enforcement windows, mostly within 12-18 months.",
          citations: ["Lawfare"]
        )
      ]
    )
  ]

  static let userSettings = UserSettings(
    email: "you@example.com",
    melAddress: "you@inbox.withmel.app",
    briefTime: Calendar.current.date(bySettingHour: 7, minute: 30, second: 0, of: Date()) ?? Date(),
    notificationsEnabled: true
  )

  private static func daysAgo(_ days: Int) -> Date {
    Calendar.current.date(byAdding: .day, value: -days, to: Date()) ?? Date()
  }
}
