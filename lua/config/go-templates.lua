-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Cloud Security Go Project Templates                                        │
-- │ Templates for common cloud security and DevOps Go applications             │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

local M = {}

-- Create directory structure
local function create_dirs(base_path, dirs)
	for _, dir in ipairs(dirs) do
		local full_path = base_path .. "/" .. dir
		vim.fn.mkdir(full_path, "p")
	end
end

-- Write file with content
local function write_file(path, content)
	local file = io.open(path, "w")
	if file then
		file:write(content)
		file:close()
		return true
	end
	return false
end

-- Cloud-native microservice template
function M.create_microservice(name)
	name = name or "cloud-microservice"
	local base_path = vim.fn.getcwd() .. "/" .. name
	
	-- Create directory structure
	local dirs = {
		"cmd/" .. name,
		"internal/api/handlers",
		"internal/api/middleware",
		"internal/config",
		"internal/database",
		"internal/models",
		"internal/services",
		"pkg/logger",
		"pkg/metrics",
		"pkg/security",
		"deployments/k8s",
		"scripts",
		"test",
	}
	
	create_dirs(base_path, dirs)
	
	-- Main application file
	local main_go = string.format([[
package main

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	"%s/internal/api/handlers"
	"%s/internal/config"
	"%s/pkg/logger"
	"%s/pkg/metrics"
)

func main() {
	// Initialize configuration
	cfg, err := config.Load()
	if err != nil {
		log.Fatalf("Failed to load configuration: %%v", err)
	}

	// Initialize logger
	log := logger.New(cfg.LogLevel)
	log.Info("Starting %s", map[string]interface{}{
		"version": cfg.Version,
		"port":    cfg.Port,
	})

	// Initialize metrics
	metrics := metrics.New()

	// Initialize handlers
	h := handlers.New(log, metrics)

	// Setup HTTP server
	mux := http.NewServeMux()
	mux.HandleFunc("/health", h.Health)
	mux.HandleFunc("/metrics", h.Metrics)
	mux.HandleFunc("/api/v1/", h.APIHandler)

	server := &http.Server{
		Addr:         fmt.Sprintf(":%%d", cfg.Port),
		Handler:      h.WithMiddleware(mux),
		ReadTimeout:  cfg.ReadTimeout,
		WriteTimeout: cfg.WriteTimeout,
		IdleTimeout:  cfg.IdleTimeout,
	}

	// Start server in goroutine
	go func() {
		log.Info("Server starting", map[string]interface{}{
			"addr": server.Addr,
		})
		
		if err := server.ListenAndServe(); err != nil && err != http.ErrServerClosed {
			log.Fatal("Server failed to start", map[string]interface{}{
				"error": err.Error(),
			})
		}
	}()

	// Wait for interrupt signal
	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt, syscall.SIGTERM)
	<-c

	log.Info("Shutting down server...")

	// Graceful shutdown
	ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
	defer cancel()

	if err := server.Shutdown(ctx); err != nil {
		log.Error("Server forced to shutdown", map[string]interface{}{
			"error": err.Error(),
		})
	}

	log.Info("Server stopped")
}
]], name, name, name, name, name)
	
	write_file(base_path .. "/cmd/" .. name .. "/main.go", main_go)
	
	-- Configuration
	local config_go = [[
package config

import (
	"os"
	"strconv"
	"time"
)

type Config struct {
	Port         int
	LogLevel     string
	Version      string
	ReadTimeout  time.Duration
	WriteTimeout time.Duration
	IdleTimeout  time.Duration
	DatabaseURL  string
	JWTSecret    string
}

func Load() (*Config, error) {
	cfg := &Config{
		Port:         8080,
		LogLevel:     "info",
		Version:      "1.0.0",
		ReadTimeout:  15 * time.Second,
		WriteTimeout: 15 * time.Second,
		IdleTimeout:  60 * time.Second,
	}

	if port := os.Getenv("PORT"); port != "" {
		if p, err := strconv.Atoi(port); err == nil {
			cfg.Port = p
		}
	}

	if level := os.Getenv("LOG_LEVEL"); level != "" {
		cfg.LogLevel = level
	}

	if version := os.Getenv("VERSION"); version != "" {
		cfg.Version = version
	}

	cfg.DatabaseURL = os.Getenv("DATABASE_URL")
	cfg.JWTSecret = os.Getenv("JWT_SECRET")

	return cfg, nil
}
]]
	
	write_file(base_path .. "/internal/config/config.go", config_go)
	
	-- Handlers
	local handlers_go = [[
package handlers

import (
	"encoding/json"
	"net/http"
	"time"
)

type Handlers struct {
	log     Logger
	metrics Metrics
}

type Logger interface {
	Info(msg string, fields map[string]interface{})
	Error(msg string, fields map[string]interface{})
	Warn(msg string, fields map[string]interface{})
}

type Metrics interface {
	Counter(name string) Counter
	Histogram(name string) Histogram
}

type Counter interface {
	Inc()
}

type Histogram interface {
	Observe(value float64)
}

func New(log Logger, metrics Metrics) *Handlers {
	return &Handlers{
		log:     log,
		metrics: metrics,
	}
}

func (h *Handlers) Health(w http.ResponseWriter, r *http.Request) {
	response := map[string]interface{}{
		"status":    "healthy",
		"timestamp": time.Now().Unix(),
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}

func (h *Handlers) Metrics(w http.ResponseWriter, r *http.Request) {
	// Prometheus metrics endpoint
	w.Header().Set("Content-Type", "text/plain")
	w.WriteHeader(http.StatusOK)
	w.Write([]byte("# Metrics endpoint placeholder\n"))
}

func (h *Handlers) APIHandler(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	defer func() {
		duration := time.Since(start)
		h.metrics.Histogram("request_duration_seconds").Observe(duration.Seconds())
		h.metrics.Counter("requests_total").Inc()
	}()

	response := map[string]interface{}{
		"message": "API endpoint",
		"method":  r.Method,
		"path":    r.URL.Path,
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}

func (h *Handlers) WithMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		// Security headers
		w.Header().Set("X-Content-Type-Options", "nosniff")
		w.Header().Set("X-Frame-Options", "DENY")
		w.Header().Set("X-XSS-Protection", "1; mode=block")
		w.Header().Set("Strict-Transport-Security", "max-age=31536000; includeSubDomains")

		// CORS (configure as needed)
		w.Header().Set("Access-Control-Allow-Origin", "*")
		w.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")

		if r.Method == "OPTIONS" {
			w.WriteHeader(http.StatusOK)
			return
		}

		next.ServeHTTP(w, r)
	})
}
]]
	
	write_file(base_path .. "/internal/api/handlers/handlers.go", handlers_go)
	
	-- Dockerfile
	local dockerfile = string.format([[
# Build stage
FROM golang:1.21-alpine AS builder

# Security: Run as non-root user
RUN adduser -D -s /bin/sh appuser

WORKDIR /app

# Copy go mod files
COPY go.mod go.sum ./
RUN go mod download

# Copy source code
COPY . .

# Build binary with security flags
RUN CGO_ENABLED=0 GOOS=linux go build \
    -a -installsuffix cgo \
    -ldflags '-w -s -extldflags "-static"' \
    -o %s ./cmd/%s

# Final stage
FROM scratch

# Copy CA certificates
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# Copy user information
COPY --from=builder /etc/passwd /etc/passwd

# Copy binary
COPY --from=builder /app/%s /%s

# Use non-root user
USER appuser

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD ["/bin/sh", "-c", "wget --no-verbose --tries=1 --spider http://localhost:8080/health || exit 1"]

ENTRYPOINT ["/%s"]
]], name, name, name, name, name)
	
	write_file(base_path .. "/Dockerfile", dockerfile)
	
	-- Kubernetes deployment
	local k8s_deployment = string.format([[
apiVersion: apps/v1
kind: Deployment
metadata:
  name: %s
  labels:
    app: %s
spec:
  replicas: 3
  selector:
    matchLabels:
      app: %s
  template:
    metadata:
      labels:
        app: %s
    spec:
      securityContext:
        runAsNonRoot: true
        runAsUser: 1000
        fsGroup: 1000
      containers:
      - name: %s
        image: %s:latest
        ports:
        - containerPort: 8080
        env:
        - name: PORT
          value: "8080"
        - name: LOG_LEVEL
          value: "info"
        resources:
          requests:
            memory: "64Mi"
            cpu: "50m"
          limits:
            memory: "128Mi"
            cpu: "100m"
        livenessProbe:
          httpGet:
            path: /health
            port: 8080
          initialDelaySeconds: 15
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /health
            port: 8080
          initialDelaySeconds: 5
          periodSeconds: 5
        securityContext:
          allowPrivilegeEscalation: false
          readOnlyRootFilesystem: true
          capabilities:
            drop:
            - ALL
---
apiVersion: v1
kind: Service
metadata:
  name: %s-service
spec:
  selector:
    app: %s
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8080
  type: ClusterIP
]], name, name, name, name, name, name, name, name)
	
	write_file(base_path .. "/deployments/k8s/deployment.yaml", k8s_deployment)
	
	-- Go mod file
	local go_mod = string.format([[
module %s

go 1.21

require (
	github.com/gorilla/mux v1.8.0
	github.com/prometheus/client_golang v1.17.0
)
]], name)
	
	write_file(base_path .. "/go.mod", go_mod)
	
	-- Makefile
	local makefile = string.format([[
.PHONY: build run test clean docker-build docker-run

# Variables
APP_NAME=%s
VERSION?=latest
DOCKER_IMAGE=$(APP_NAME):$(VERSION)

# Build the application
build:
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-w -s' -o bin/$(APP_NAME) ./cmd/$(APP_NAME)

# Run the application
run:
	go run ./cmd/$(APP_NAME)

# Run tests
test:
	go test -v ./...

# Run tests with coverage
test-coverage:
	go test -v -coverprofile=coverage.out ./...
	go tool cover -html=coverage.out

# Security scan
security-scan:
	gosec ./...
	govulncheck ./...

# Lint code
lint:
	golangci-lint run

# Clean build artifacts
clean:
	rm -rf bin/
	rm -f coverage.out

# Docker build
docker-build:
	docker build -t $(DOCKER_IMAGE) .

# Docker run
docker-run:
	docker run -p 8080:8080 $(DOCKER_IMAGE)

# Deploy to Kubernetes
k8s-deploy:
	kubectl apply -f deployments/k8s/

# Remove from Kubernetes
k8s-remove:
	kubectl delete -f deployments/k8s/
]], name)
	
	write_file(base_path .. "/Makefile", makefile)
	
	vim.notify(string.format("Created cloud microservice project: %s", name), vim.log.levels.INFO, {
		title = "󰟓 Project Created"
	})
	
	-- Open the main file
	vim.cmd("edit " .. base_path .. "/cmd/" .. name .. "/main.go")
end

-- Cloud security scanner template
function M.create_security_scanner(name)
	name = name or "cloud-security-scanner"
	local base_path = vim.fn.getcwd() .. "/" .. name
	
	local dirs = {
		"cmd/" .. name,
		"internal/scanner",
		"internal/rules",
		"internal/output",
		"pkg/aws",
		"pkg/azure",
		"pkg/gcp",
		"configs",
	}
	
	create_dirs(base_path, dirs)
	
	local main_go = string.format([[
package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"os"

	"%s/internal/scanner"
)

func main() {
	var (
		provider = flag.String("provider", "aws", "Cloud provider (aws, azure, gcp)")
		region   = flag.String("region", "", "Cloud region to scan")
		output   = flag.String("output", "json", "Output format (json, yaml, table)")
		config   = flag.String("config", "configs/default.yaml", "Configuration file")
	)
	flag.Parse()

	if *region == "" {
		fmt.Fprintf(os.Stderr, "Error: region is required\n")
		flag.Usage()
		os.Exit(1)
	}

	ctx := context.Background()
	
	s, err := scanner.New(*provider, *region, *config)
	if err != nil {
		log.Fatalf("Failed to create scanner: %%v", err)
	}

	results, err := s.Scan(ctx)
	if err != nil {
		log.Fatalf("Scan failed: %%v", err)
	}

	if err := s.Output(results, *output); err != nil {
		log.Fatalf("Failed to output results: %%v", err)
	}
}
]], name)
	
	write_file(base_path .. "/cmd/" .. name .. "/main.go", main_go)
	
	vim.notify(string.format("Created security scanner project: %s", name), vim.log.levels.INFO, {
		title = "🔒 Security Scanner Created"
	})
	
	vim.cmd("edit " .. base_path .. "/cmd/" .. name .. "/main.go")
end

-- Infrastructure as Code validator
function M.create_iac_validator(name)
	name = name or "iac-validator"
	local base_path = vim.fn.getcwd() .. "/" .. name
	
	local dirs = {
		"cmd/" .. name,
		"internal/terraform",
		"internal/kubernetes",
		"internal/cloudformation",
		"internal/rules",
		"pkg/validator",
	}
	
	create_dirs(base_path, dirs)
	
	-- Implementation would continue here...
	vim.notify(string.format("Created IaC validator project: %s", name), vim.log.levels.INFO, {
		title = "⚙️  IaC Validator Created"
	})
	
	vim.cmd("edit " .. base_path .. "/cmd/" .. name .. "/main.go")
end

return M
