-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Cloud Security Go Snippets                                                 │
-- │ Professional snippets for cloud security and DevOps development           │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

-- Helper function to get current year
local function current_year()
	return os.date("%Y")
end

-- Helper function to get current date
local function current_date()
	return os.date("%Y-%m-%d")
end

-- Go snippets for cloud security development
return {
	-- ╭─────────────────────────────────────────────────────────────────╮
	-- │ Cloud Native HTTP Server                                       │
	-- ╰─────────────────────────────────────────────────────────────────╯
	s("cloud-server", fmt([[
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
)

func main() {{
	mux := http.NewServeMux()
	mux.HandleFunc("/health", healthHandler)
	mux.HandleFunc("/metrics", metricsHandler)
	mux.HandleFunc("/api/v1/", apiHandler)

	server := &http.Server{{
		Addr:         ":{1}",
		Handler:      withMiddleware(mux),
		ReadTimeout:  15 * time.Second,
		WriteTimeout: 15 * time.Second,
		IdleTimeout:  60 * time.Second,
	}}

	go func() {{
		log.Printf("Starting {2} server on %s", server.Addr)
		if err := server.ListenAndServe(); err != nil && err != http.ErrServerClosed {{
			log.Fatalf("Server failed to start: %v", err)
		}}
	}}()

	// Graceful shutdown
	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt, syscall.SIGTERM)
	<-c

	log.Println("Shutting down server...")
	ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
	defer cancel()

	if err := server.Shutdown(ctx); err != nil {{
		log.Fatalf("Server forced to shutdown: %v", err)
	}}
	log.Println("Server stopped")
}}

func healthHandler(w http.ResponseWriter, r *http.Request) {{
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	fmt.Fprintln(w, `{{"status":"healthy","timestamp":"`+fmt.Sprintf("%d", time.Now().Unix())+`"}}`)
}}

func metricsHandler(w http.ResponseWriter, r *http.Request) {{
	w.Header().Set("Content-Type", "text/plain")
	w.WriteHeader(http.StatusOK)
	fmt.Fprintln(w, "# Prometheus metrics")
}}

func apiHandler(w http.ResponseWriter, r *http.Request) {{
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	fmt.Fprintf(w, `{{"message":"API endpoint","method":"%s","path":"%s"}}`, r.Method, r.URL.Path)
}}

func withMiddleware(next http.Handler) http.Handler {{
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {{
		// Security headers
		w.Header().Set("X-Content-Type-Options", "nosniff")
		w.Header().Set("X-Frame-Options", "DENY")
		w.Header().Set("X-XSS-Protection", "1; mode=block")
		w.Header().Set("Strict-Transport-Security", "max-age=31536000; includeSubDomains")
		
		next.ServeHTTP(w, r)
	}})
}}
]], {
	i(1, "8080"),
	i(2, "cloud-app"),
})),

	-- ╭─────────────────────────────────────────────────────────────────╮
	-- │ AWS SDK Client                                                  │
	-- ╰─────────────────────────────────────────────────────────────────╯
	s("aws-client", fmt([[
package main

import (
	"context"
	"log"

	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/{1}"
)

func main() {{
	ctx := context.Background()
	
	// Load AWS configuration
	cfg, err := config.LoadDefaultConfig(ctx, config.WithRegion("{2}"))
	if err != nil {{
		log.Fatalf("Unable to load SDK config: %v", err)
	}}

	// Create service client
	client := {1}.NewFromConfig(cfg)

	// {3}
	{4}
}}
]], {
	i(1, "s3"),
	i(2, "us-east-1"),
	i(3, "Use the client to interact with AWS service"),
	i(4, "// Implementation here"),
})),

	-- ╭─────────────────────────────────────────────────────────────────╮
	-- │ Kubernetes Client                                               │
	-- ╰─────────────────────────────────────────────────────────────────╯
	s("k8s-client", fmt([[
package main

import (
	"context"
	"fmt"
	"log"

	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/tools/clientcmd"
)

func main() {{
	// Load kubeconfig
	config, err := clientcmd.BuildConfigFromFlags("", "{1}")
	if err != nil {{
		log.Fatalf("Error building kubeconfig: %v", err)
	}}

	// Create clientset
	clientset, err := kubernetes.NewForConfig(config)
	if err != nil {{
		log.Fatalf("Error creating clientset: %v", err)
	}}

	ctx := context.Background()

	// List pods in namespace
	pods, err := clientset.CoreV1().Pods("{2}").List(ctx, metav1.ListOptions{{}})
	if err != nil {{
		log.Fatalf("Error listing pods: %v", err)
	}}

	fmt.Printf("Found %d pods in namespace %s\n", len(pods.Items), "{2}")
	for _, pod := range pods.Items {{
		fmt.Printf("Pod: %s\n", pod.Name)
	}}
}}
]], {
	i(1, "~/.kube/config"),
	i(2, "default"),
})),

	-- ╭─────────────────────────────────────────────────────────────────╮
	-- │ Security Scanner Structure                                      │
	-- ╰─────────────────────────────────────────────────────────────────╯
	s("security-scanner", fmt([[
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"os"
)

type SecurityFinding struct {{
	ID          string            `json:"id"`
	Title       string            `json:"title"`
	Description string            `json:"description"`
	Severity    string            `json:"severity"`
	Resource    string            `json:"resource"`
	Tags        map[string]string `json:"tags"`
}}

type Scanner struct {{
	provider string
	region   string
	findings []SecurityFinding
}}

func NewScanner(provider, region string) *Scanner {{
	return &Scanner{{
		provider: provider,
		region:   region,
		findings: make([]SecurityFinding, 0),
	}}
}}

func (s *Scanner) Scan(ctx context.Context) error {{
	log.Printf("Starting security scan for %s in %s", s.provider, s.region)
	
	// {1}
	{2}
	
	return nil
}}

func (s *Scanner) AddFinding(finding SecurityFinding) {{
	s.findings = append(s.findings, finding)
}}

func (s *Scanner) GetFindings() []SecurityFinding {{
	return s.findings
}}

func (s *Scanner) OutputJSON() error {{
	output := map[string]interface{{}}{{
		"provider": s.provider,
		"region":   s.region,
		"findings": s.findings,
		"summary": map[string]int{{
			"total":    len(s.findings),
			"critical": s.countSeverity("critical"),
			"high":     s.countSeverity("high"),
			"medium":   s.countSeverity("medium"),
			"low":      s.countSeverity("low"),
		}},
	}}

	encoder := json.NewEncoder(os.Stdout)
	encoder.SetIndent("", "  ")
	return encoder.Encode(output)
}}

func (s *Scanner) countSeverity(severity string) int {{
	count := 0
	for _, finding := range s.findings {{
		if finding.Severity == severity {{
			count++
		}}
	}}
	return count
}}

func main() {{
	scanner := NewScanner("{3}", "{4}")
	
	ctx := context.Background()
	if err := scanner.Scan(ctx); err != nil {{
		log.Fatalf("Scan failed: %v", err)
	}}

	if err := scanner.OutputJSON(); err != nil {{
		log.Fatalf("Output failed: %v", err)
	}}
}}
]], {
	i(1, "Implement your security checks here"),
	i(2, "// Add security findings"),
	i(3, "aws"),
	i(4, "us-east-1"),
})),

	-- ╭─────────────────────────────────────────────────────────────────╮
	-- │ Structured Logger                                               │
	-- ╰─────────────────────────────────────────────────────────────────╯
	s("structured-logger", fmt([[
package logger

import (
	"encoding/json"
	"fmt"
	"log"
	"os"
	"time"
)

type Level int

const (
	DEBUG Level = iota
	INFO
	WARN
	ERROR
	FATAL
)

var levelNames = map[Level]string{{
	DEBUG: "DEBUG",
	INFO:  "INFO",
	WARN:  "WARN",
	ERROR: "ERROR",
	FATAL: "FATAL",
}}

type Logger struct {{
	level  Level
	logger *log.Logger
}}

type LogEntry struct {{
	Timestamp string                 `json:"timestamp"`
	Level     string                 `json:"level"`
	Message   string                 `json:"message"`
	Fields    map[string]interface{{}} `json:"fields,omitempty"`
}}

func New(levelStr string) *Logger {{
	level := INFO
	switch levelStr {{
	case "debug":
		level = DEBUG
	case "info":
		level = INFO
	case "warn":
		level = WARN
	case "error":
		level = ERROR
	case "fatal":
		level = FATAL
	}}

	return &Logger{{
		level:  level,
		logger: log.New(os.Stdout, "", 0),
	}}
}}

func (l *Logger) log(level Level, message string, fields map[string]interface{{}}) {{
	if level < l.level {{
		return
	}}

	entry := LogEntry{{
		Timestamp: time.Now().UTC().Format(time.RFC3339),
		Level:     levelNames[level],
		Message:   message,
		Fields:    fields,
	}}

	if data, err := json.Marshal(entry); err == nil {{
		l.logger.Println(string(data))
	}} else {{
		l.logger.Printf("Failed to marshal log entry: %v", err)
	}}
}}

func (l *Logger) Debug(message string, fields map[string]interface{{}}) {{
	l.log(DEBUG, message, fields)
}}

func (l *Logger) Info(message string, fields map[string]interface{{}}) {{
	l.log(INFO, message, fields)
}}

func (l *Logger) Warn(message string, fields map[string]interface{{}}) {{
	l.log(WARN, message, fields)
}}

func (l *Logger) Error(message string, fields map[string]interface{{}}) {{
	l.log(ERROR, message, fields)
}}

func (l *Logger) Fatal(message string, fields map[string]interface{{}}) {{
	l.log(FATAL, message, fields)
	os.Exit(1)
}}
]], {})),

	-- ╭─────────────────────────────────────────────────────────────────╮
	-- │ Prometheus Metrics                                              │
	-- ╰─────────────────────────────────────────────────────────────────╯
	s("prometheus-metrics", fmt([[
package metrics

import (
	"net/http"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

var (
	requestsTotal = prometheus.NewCounterVec(
		prometheus.CounterOpts{{
			Name: "{1}_requests_total",
			Help: "Total number of HTTP requests",
		}},
		[]string{{"method", "endpoint", "status"}},
	)

	requestDuration = prometheus.NewHistogramVec(
		prometheus.HistogramOpts{{
			Name:    "{1}_request_duration_seconds",
			Help:    "Duration of HTTP requests in seconds",
			Buckets: prometheus.DefBuckets,
		}},
		[]string{{"method", "endpoint"}},
	)

	activeConnections = prometheus.NewGauge(
		prometheus.GaugeOpts{{
			Name: "{1}_active_connections",
			Help: "Number of active connections",
		}},
	)
)

func init() {{
	prometheus.MustRegister(requestsTotal)
	prometheus.MustRegister(requestDuration)
	prometheus.MustRegister(activeConnections)
}}

func Handler() http.Handler {{
	return promhttp.Handler()
}}

func IncRequests(method, endpoint, status string) {{
	requestsTotal.WithLabelValues(method, endpoint, status).Inc()
}}

func ObserveRequestDuration(method, endpoint string, duration float64) {{
	requestDuration.WithLabelValues(method, endpoint).Observe(duration)
}}

func SetActiveConnections(count float64) {{
	activeConnections.Set(count)
}}
]], {
	i(1, "app"),
})),

	-- ╭─────────────────────────────────────────────────────────────────╮
	-- │ Error Handling                                                  │
	-- ╰─────────────────────────────────────────────────────────────────╮
	s("error-handling", fmt([[
package errors

import (
	"encoding/json"
	"fmt"
	"net/http"
	"runtime"
)

type AppError struct {{
	Code    string `json:"code"`
	Message string `json:"message"`
	Details string `json:"details,omitempty"`
	File    string `json:"file,omitempty"`
	Line    int    `json:"line,omitempty"`
}}

func (e *AppError) Error() string {{
	return fmt.Sprintf("[%s] %s", e.Code, e.Message)
}}

func New(code, message string) *AppError {{
	_, file, line, _ := runtime.Caller(1)
	return &AppError{{
		Code:    code,
		Message: message,
		File:    file,
		Line:    line,
	}}
}}

func Newf(code, format string, args ...interface{{}}) *AppError {{
	return New(code, fmt.Sprintf(format, args...))
}}

func (e *AppError) WithDetails(details string) *AppError {{
	e.Details = details
	return e
}}

func HandleHTTPError(w http.ResponseWriter, err error) {{
	var appErr *AppError
	var statusCode int

	switch e := err.(type) {{
	case *AppError:
		appErr = e
		switch e.Code {{
		case "VALIDATION_ERROR":
			statusCode = http.StatusBadRequest
		case "UNAUTHORIZED":
			statusCode = http.StatusUnauthorized
		case "FORBIDDEN":
			statusCode = http.StatusForbidden
		case "NOT_FOUND":
			statusCode = http.StatusNotFound
		case "INTERNAL_ERROR":
			statusCode = http.StatusInternalServerError
		default:
			statusCode = http.StatusInternalServerError
		}}
	default:
		appErr = &AppError{{
			Code:    "INTERNAL_ERROR",
			Message: "An internal error occurred",
		}}
		statusCode = http.StatusInternalServerError
	}}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(statusCode)
	json.NewEncoder(w).Encode(map[string]interface{{}}{{
		"error": appErr,
	}})
}}
]], {})),

	-- ╭─────────────────────────────────────────────────────────────────╮
	-- │ Configuration Management                                        │
	-- ╰─────────────────────────────────────────────────────────────────╯
	s("config-mgmt", fmt([[
package config

import (
	"fmt"
	"os"
	"strconv"
	"time"
)

type Config struct {{
	// Server configuration
	Port         int           `json:"port"`
	Host         string        `json:"host"`
	ReadTimeout  time.Duration `json:"read_timeout"`
	WriteTimeout time.Duration `json:"write_timeout"`
	IdleTimeout  time.Duration `json:"idle_timeout"`

	// Database configuration
	DatabaseURL      string `json:"database_url"`
	DatabaseTimeout  time.Duration `json:"database_timeout"`
	MaxOpenConns     int    `json:"max_open_conns"`
	MaxIdleConns     int    `json:"max_idle_conns"`
	ConnMaxLifetime  time.Duration `json:"conn_max_lifetime"`

	// Security configuration
	JWTSecret        string        `json:"-"` // Never log secrets
	SessionTimeout   time.Duration `json:"session_timeout"`
	RateLimitRPS     int           `json:"rate_limit_rps"`
	RateLimitBurst   int           `json:"rate_limit_burst"`

	// Application configuration
	LogLevel         string `json:"log_level"`
	Environment      string `json:"environment"`
	Version          string `json:"version"`
	EnableMetrics    bool   `json:"enable_metrics"`
	EnableProfiling  bool   `json:"enable_profiling"`
}}

func Load() (*Config, error) {{
	cfg := &Config{{
		// Default values
		Port:         8080,
		Host:         "0.0.0.0",
		ReadTimeout:  15 * time.Second,
		WriteTimeout: 15 * time.Second,
		IdleTimeout:  60 * time.Second,
		
		DatabaseTimeout:  10 * time.Second,
		MaxOpenConns:     25,
		MaxIdleConns:     5,
		ConnMaxLifetime:  5 * time.Minute,
		
		SessionTimeout:   24 * time.Hour,
		RateLimitRPS:     100,
		RateLimitBurst:   200,
		
		LogLevel:         "info",
		Environment:      "development",
		Version:          "1.0.0",
		EnableMetrics:    true,
		EnableProfiling:  false,
	}}

	// Load from environment variables
	if port := os.Getenv("PORT"); port != "" {{
		if p, err := strconv.Atoi(port); err == nil {{
			cfg.Port = p
		}}
	}}

	if host := os.Getenv("HOST"); host != "" {{
		cfg.Host = host
	}}

	if dbURL := os.Getenv("DATABASE_URL"); dbURL != "" {{
		cfg.DatabaseURL = dbURL
	}}

	if secret := os.Getenv("JWT_SECRET"); secret != "" {{
		cfg.JWTSecret = secret
	}} else if cfg.Environment == "production" {{
		return nil, fmt.Errorf("JWT_SECRET is required in production")
	}}

	if level := os.Getenv("LOG_LEVEL"); level != "" {{
		cfg.LogLevel = level
	}}

	if env := os.Getenv("ENVIRONMENT"); env != "" {{
		cfg.Environment = env
	}}

	if version := os.Getenv("VERSION"); version != "" {{
		cfg.Version = version
	}}

	return cfg, nil
}}

func (c *Config) IsProduction() bool {{
	return c.Environment == "production"
}}

func (c *Config) IsDevelopment() bool {{
	return c.Environment == "development"
}}
]], {})),
}
