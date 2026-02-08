# Mel iOS MVP Product/UX Spec

## Summary
- iOS-first MVP with backend ingestion and summarization.
- Core loop: onboarding -> subscribe newsletters -> daily brief -> ask questions -> read with buddy.
- Screen-by-screen UX, key interactions, error and edge states.
- Future-looking sections for Topic Pages and Audio Briefs (post-MVP).

## Assumptions and Defaults
- Target audience: busy professionals.
- Onboarding uses email magic link; optional auth expansion is out of scope for MVP.
- Users get a unique Mel email address to subscribe to newsletters.
- Standard retention: newsletters are stored to power chat and summaries.
- Daily Brief delivered in-app with push notifications; no email digests in MVP.
- Audio brief is explicitly post-MVP.

## Product Goals
- Make newsletters feel searchable, summarized, and immediately actionable.
- Reduce time-to-value (first useful brief within 24 hours).
- Enable "ask while reading" without leaving the article.

## Out of Scope (MVP)
- Topic pages and audio brief are documented only as "next."
- Social features, collaboration, and shared briefs are out.

## Key UX Principles
- Morning clarity: show the brief first, always.
- Ask is ambient: chat is always one tap away while reading.
- Trust over flash: show sources and newsletter attribution for every summary.

## Information Architecture
Tabs:
1. Brief
2. Library
3. Ask
4. Settings

## Screen-by-Screen Spec

### Onboarding
1. Welcome screen: value prop + CTA.
2. Email capture: enter email, send magic link.
3. Magic link confirmation: "Check your inbox" with polling fallback.
4. "Your Mel address" screen: copy button, tips for subscribing.
5. Sample newsletters onboarding: optional curated examples to demonstrate value.

### Brief (Daily Brief home)
1. Header: day + 2/5/10 min duration toggle.
2. Brief list cards: title, 1-line summary, source newsletters.
3. CTA: "Ask about this" and "Open full digest."
4. Empty state: "Waiting for your first newsletters," with subscribe guidance.
5. Brief refresh: generated daily at fixed time + manual "Regenerate" if available.

### Brief Detail
1. Sections by topic cluster.
2. Each section: topic title, bullets, sources, "Read originals."
3. Inline "Ask Mel" input with context chips.
4. "Save to library" toggle (optional).

### Library (Newsletter inbox)
1. List of individual newsletters, grouped by recency.
2. Each row: source logo/name, subject, 1-line extracted summary.
3. Filters: unread/read, source, topic.
4. Tap opens "Reading with Mel."

### Reading with Mel
1. Top: newsletter content with minimal chrome.
2. Persistent "Ask Mel about this" field.
3. Highlighted quotes or extracted key points (if confidence high).
4. Citations: link to the source email.

### Ask (Standalone chat)
1. Chat history (global).
2. System hint: "Ask about any newsletter you have received."
3. Context controls: optional filters (last 7 days, specific source).
4. Responses include citations back to newsletters.

### Settings
1. Account info + logout.
2. Mel address + copy.
3. Brief time + notification settings.
4. Data controls: delete all, export (if planned).
5. Help + contact.

## Behavioral Details
- Duration toggle (2/5/10 min): changes summary density and number of items.
- When user asks while reading: response is constrained to that newsletter unless toggled.
- Ask in Brief Detail: constrained to that topic cluster by default.

## Notifications
- Daily Brief ready push, default at 7:30 AM local time.
- Optional "Your first brief is ready" when ingestion completes.

## Edge States
- No newsletters received: show onboarding and "How to subscribe" steps.
- Failed magic link: allow resend.
- Ingestion delays: status badge "Processing."
- Newsletter parsing errors: show partial text with "Report issue."

## Analytics (MVP)
- Activation: user subscribes to at least 3 newsletters.
- Engagement: brief opened, ask used, read-with-buddy opened.
- Retention: 7-day brief opens.

## Future Features (Post-MVP)
- Topic Pages: canonical topic view, multi-day synthesis.
- Audio Brief: daily audio from brief content, optional download.

## Public API/Interface Additions
- POST /auth/magic_link
- POST /auth/verify
- GET /user/mel_address
- GET /brief/daily?duration=2|5|10
- GET /brief/daily/{id}
- GET /newsletters?filters=...
- GET /newsletters/{id}
- POST /chat
- GET /chat/history
- POST /notifications/settings

## Data Models (High-level)
- User: id, email, mel_address, timezone, notification_time.
- Newsletter: id, user_id, source, subject, received_at, content, summary.
- Brief: id, user_id, date, duration, sections[], sources[].
- TopicCluster: id, brief_id, title, summary, sources[].
- ChatMessage: id, user_id, content, created_at, citations[].

## Test Scenarios
1. First-time user completes onboarding and copies Mel address.
2. User receives first newsletters and sees a generated brief.
3. Brief duration toggle changes density and content count.
4. Ask Mel in Brief Detail returns citations from relevant newsletters.
5. Reading with Mel chat stays constrained to the open newsletter.
6. Empty state properly guides user to subscribe.

## Success Criteria
- 70% of new users reach a first brief within 48 hours.
- 50% of brief readers use Ask Mel within 7 days.
- NPS-style satisfaction score >= 8 after 2 weeks.
