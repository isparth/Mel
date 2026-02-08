# API Service

Backend HTTP API for auth, briefs, newsletters, and chat.

## Run (local)
1. Ensure Postgres is running and MEL_DATABASE_URL is set.
2. From repo root:

```
cd /Users/parthsharmapoudel/Documents/GitHub/Mel/services/api

go run ./cmd/api
```

Health check:
```
curl http://localhost:8080/health
```
