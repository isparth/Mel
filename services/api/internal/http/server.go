package http

import (
  "net/http"

  "github.com/go-chi/chi/v5"
  "github.com/go-chi/chi/v5/middleware"
  "github.com/jackc/pgx/v5/pgxpool"

  "github.com/parthsharmapoudel/mel/services/api/internal/config"
)

type Server struct {
  cfg  config.Config
  pool *pgxpool.Pool
  r    chi.Router
}

func NewServer(cfg config.Config, pool *pgxpool.Pool) *Server {
  s := &Server{cfg: cfg, pool: pool, r: chi.NewRouter()}
  s.routes()
  return s
}

func (s *Server) Router() http.Handler {
  return s.r
}

func (s *Server) routes() {
  s.r.Use(middleware.RequestID)
  s.r.Use(middleware.RealIP)
  s.r.Use(middleware.Recoverer)
  s.r.Use(middleware.Logger)

  s.r.Get("/health", s.handleHealth())

  s.r.Route("/auth", func(r chi.Router) {
    r.Post("/magic_link", s.handleNotImplemented("magic_link"))
    r.Post("/verify", s.handleNotImplemented("verify"))
  })

  s.r.Get("/user/mel_address", s.handleNotImplemented("mel_address"))

  s.r.Route("/brief", func(r chi.Router) {
    r.Get("/daily", s.handleNotImplemented("brief_daily"))
    r.Get("/daily/{id}", s.handleNotImplemented("brief_daily_id"))
  })

  s.r.Route("/newsletters", func(r chi.Router) {
    r.Get("/", s.handleNotImplemented("newsletters"))
    r.Get("/{id}", s.handleNotImplemented("newsletter_id"))
  })

  s.r.Route("/chat", func(r chi.Router) {
    r.Post("/", s.handleNotImplemented("chat"))
    r.Get("/history", s.handleNotImplemented("chat_history"))
  })

  s.r.Post("/notifications/settings", s.handleNotImplemented("notifications_settings"))
}
