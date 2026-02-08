package http

import (
  "encoding/json"
  "net/http"
)

func (s *Server) handleHealth() http.HandlerFunc {
  return func(w http.ResponseWriter, r *http.Request) {
    writeJSON(w, http.StatusOK, map[string]string{"status": "ok"})
  }
}

func (s *Server) handleNotImplemented(feature string) http.HandlerFunc {
  return func(w http.ResponseWriter, r *http.Request) {
    writeJSON(w, http.StatusNotImplemented, map[string]string{
      "error":   "not implemented",
      "feature": feature,
    })
  }
}

func writeJSON(w http.ResponseWriter, status int, payload any) {
  w.Header().Set("Content-Type", "application/json")
  w.WriteHeader(status)
  _ = json.NewEncoder(w).Encode(payload)
}
