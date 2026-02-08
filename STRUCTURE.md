# Mel Folder Structure

```
apps/
  ios/                # iOS app (Swift/SwiftUI)
services/
  api/                # Public API (auth, briefs, newsletters, chat)
  ingest/             # Email ingestion and parsing pipeline
  briefing/           # Daily brief generation and clustering
packages/
  shared/             # Shared types/schemas across services and clients
infra/                # Infrastructure and deployment
scripts/              # One-off or operational scripts
config/               # Environment templates and shared config

docs/                 # Product and UX documentation
```

Notes:
- This is a lean monorepo layout to keep the iOS client and backend services aligned.
- Go services live under `services/` and are wired together via `go.work`.
- The iOS app uses Swift Package Manager under `apps/ios/MelApp`.
