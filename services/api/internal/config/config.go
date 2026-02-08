package config

import "os"

type Config struct {
  Env         string
  HTTPAddr    string
  DatabaseURL string
}

func Load() Config {
  return Config{
    Env:         getEnv("MEL_ENV", "dev"),
    HTTPAddr:    getEnv("MEL_HTTP_ADDR", ":8080"),
    DatabaseURL: getEnv("MEL_DATABASE_URL", "postgres://mel:mel@localhost:5432/mel?sslmode=disable"),
  }
}

func getEnv(key, fallback string) string {
  if value := os.Getenv(key); value != "" {
    return value
  }
  return fallback
}
