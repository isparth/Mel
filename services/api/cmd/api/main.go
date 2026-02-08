package main

import (
  "context"
  "log"
  "net/http"
  "os"
  "os/signal"
  "syscall"
  "time"

  "github.com/parthsharmapoudel/mel/services/api/internal/config"
  "github.com/parthsharmapoudel/mel/services/api/internal/db"
  apihttp "github.com/parthsharmapoudel/mel/services/api/internal/http"
)

func main() {
  cfg := config.Load()

  ctx, stop := signal.NotifyContext(context.Background(), os.Interrupt, syscall.SIGTERM)
  defer stop()

  pool, err := db.Open(ctx, cfg.DatabaseURL)
  if err != nil {
    log.Fatalf("db connect failed: %v", err)
  }
  defer pool.Close()

  server := apihttp.NewServer(cfg, pool)

  httpServer := &http.Server{
    Addr:         cfg.HTTPAddr,
    Handler:      server.Router(),
    ReadTimeout:  10 * time.Second,
    WriteTimeout: 20 * time.Second,
    IdleTimeout:  60 * time.Second,
  }

  go func() {
    log.Printf("api listening on %s", cfg.HTTPAddr)
    if err := httpServer.ListenAndServe(); err != nil && err != http.ErrServerClosed {
      log.Fatalf("http server failed: %v", err)
    }
  }()

  <-ctx.Done()
  shutdownCtx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
  defer cancel()

  if err := httpServer.Shutdown(shutdownCtx); err != nil {
    log.Printf("server shutdown error: %v", err)
  }
}
