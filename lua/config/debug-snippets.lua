-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Debugging Snippets for Cloud Security Engineering                          │
-- │ Common debugging patterns and utilities for various languages              │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

-- Common debugging snippets across languages
return {
	-- ╭─────────────────────────────────────────────────────────────────╮
	-- │ Go Debugging Snippets                                           │
	-- ╰─────────────────────────────────────────────────────────────────╮
	go = {
		s("debug-log", fmt([[
func debugLog(message string, fields ...interface{{}}) {{
	if os.Getenv("DEBUG") == "true" {{
		log.Printf("[DEBUG] %s: %+v", message, fields)
	}}
}}
]], {})),

		s("debug-trace", fmt([[
func trace(fn string) func() {{
	start := time.Now()
	log.Printf("[TRACE] Entering %s", fn)
	return func() {{
		log.Printf("[TRACE] Exiting %s (took %v)", fn, time.Since(start))
	}}
}}

// Usage: defer trace("{1}")()
]], {
	i(1, "functionName"),
})),

		s("debug-http", fmt([[
func debugHTTPRequest(r *http.Request) {{
	if os.Getenv("DEBUG_HTTP") == "true" {{
		log.Printf("[HTTP] %s %s", r.Method, r.URL.Path)
		log.Printf("[HTTP] Headers: %+v", r.Header)
		if r.Body != nil {{
			body, _ := io.ReadAll(r.Body)
			r.Body = io.NopCloser(bytes.NewBuffer(body))
			log.Printf("[HTTP] Body: %s", string(body))
		}}
	}}
}}
]], {})),

		s("debug-error", fmt([[
func debugError(err error, context string) {{
	if err != nil {{
		log.Printf("[ERROR] %s: %+v", context, err)
		debug.PrintStack()
	}}
}}
]], {})),

		s("debug-security", fmt([[
func debugSecurityEvent(event, user, resource string) {{
	if os.Getenv("DEBUG_SECURITY") == "true" {{
		log.Printf("[SECURITY] Event: %s, User: %s, Resource: %s, Time: %v", 
			event, user, resource, time.Now().UTC())
	}}
}}
]], {})),
	},

	-- ╭─────────────────────────────────────────────────────────────────╮
	-- │ Python Debugging Snippets                                       │
	-- ╰─────────────────────────────────────────────────────────────────╮
	python = {
		s("debug-log", fmt([[
import logging
import os

def debug_log(message: str, **kwargs):
    if os.getenv("DEBUG") == "true":
        logging.debug(f"[DEBUG] {{message}}: {{kwargs}}")
]], {})),

		s("debug-trace", fmt([[
import functools
import time
import logging

def trace_calls(func):
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        start_time = time.time()
        logging.debug(f"[TRACE] Entering {{func.__name__}}")
        try:
            result = func(*args, **kwargs)
            logging.debug(f"[TRACE] Exiting {{func.__name__}} (took {{time.time() - start_time:.4f}}s)")
            return result
        except Exception as e:
            logging.error(f"[TRACE] Error in {{func.__name__}}: {{e}}")
            raise
    return wrapper

# Usage: @trace_calls
]], {})),

		s("debug-request", fmt([[
import logging
import os

def debug_request(request):
    if os.getenv("DEBUG_HTTP") == "true":
        logging.debug(f"[HTTP] {{request.method}} {{request.url}}")
        logging.debug(f"[HTTP] Headers: {{dict(request.headers)}}")
        if hasattr(request, 'json') and request.is_json:
            logging.debug(f"[HTTP] JSON Body: {{request.get_json()}}")
        elif request.data:
            logging.debug(f"[HTTP] Body: {{request.get_data(as_text=True)}}")
]], {})),

		s("debug-security", fmt([[
import logging
import datetime
import os

def debug_security_event(event: str, user: str, resource: str):
    if os.getenv("DEBUG_SECURITY") == "true":
        logging.info(f"[SECURITY] Event: {{event}}, User: {{user}}, "
                    f"Resource: {{resource}}, Time: {{datetime.datetime.utcnow().isoformat()}}")
]], {})),

		s("debug-performance", fmt([[
import cProfile
import pstats
import io
from functools import wraps

def profile_performance(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        if os.getenv("DEBUG_PROFILE") == "true":
            profiler = cProfile.Profile()
            profiler.enable()
            
            result = func(*args, **kwargs)
            
            profiler.disable()
            s = io.StringIO()
            ps = pstats.Stats(profiler, stream=s).sort_stats('cumulative')
            ps.print_stats()
            
            print(f"Profile for {{func.__name__}}:")
            print(s.getvalue())
            return result
        else:
            return func(*args, **kwargs)
    return wrapper
]], {})),
	},

	-- ╭─────────────────────────────────────────────────────────────────╮
	-- │ JavaScript/TypeScript Debugging Snippets                        │
	-- ╰─────────────────────────────────────────────────────────────────╮
	javascript = {
		s("debug-log", fmt([[
function debugLog(message, data = {{}}) {{
    if (process.env.DEBUG === 'true') {{
        console.log(`[DEBUG] ${{message}}:`, data);
    }}
}}
]], {})),

		s("debug-trace", fmt([[
function trace(target, propertyKey, descriptor) {{
    const originalMethod = descriptor.value;
    
    descriptor.value = function(...args) {{
        const start = Date.now();
        console.log(`[TRACE] Entering ${{propertyKey}}`);
        
        try {{
            const result = originalMethod.apply(this, args);
            console.log(`[TRACE] Exiting ${{propertyKey}} (took ${{Date.now() - start}}ms)`);
            return result;
        }} catch (error) {{
            console.error(`[TRACE] Error in ${{propertyKey}}:`, error);
            throw error;
        }}
    }};
    
    return descriptor;
}}

// Usage: @trace (TypeScript decorator)
]], {})),

		s("debug-request", fmt([[
function debugRequest(req, res, next) {{
    if (process.env.DEBUG_HTTP === 'true') {{
        console.log(`[HTTP] ${{req.method}} ${{req.url}}`);
        console.log(`[HTTP] Headers:`, req.headers);
        if (req.body) {{
            console.log(`[HTTP] Body:`, req.body);
        }}
    }}
    next();
}}
]], {})),

		s("debug-async", fmt([[
async function debugAsync(fn, context = '') {{
    const start = Date.now();
    console.log(`[ASYNC] Starting ${{context}}`);
    
    try {{
        const result = await fn();
        console.log(`[ASYNC] Completed ${{context}} (took ${{Date.now() - start}}ms)`);
        return result;
    }} catch (error) {{
        console.error(`[ASYNC] Error in ${{context}}:`, error);
        throw error;
    }}
}}
]], {})),
	},

	-- ╭─────────────────────────────────────────────────────────────────╮
	-- │ Generic Debugging Patterns                                      │
	-- ╰─────────────────────────────────────────────────────────────────╮
	all = {
		s("debug-env", fmt([[
# Debug Environment Variables
DEBUG=true
DEBUG_HTTP=true
DEBUG_SECURITY=true
DEBUG_PROFILE=true
LOG_LEVEL=debug
]], {})),

		s("debug-docker", fmt([[
# Dockerfile debugging additions
ENV DEBUG=true
ENV LOG_LEVEL=debug

# Add debugging tools
RUN apt-get update && apt-get install -y \\
    strace \\
    tcpdump \\
    netstat-nat \\
    && rm -rf /var/lib/apt/lists/*

# Expose debug port
EXPOSE {1}
]], {
	i(1, "2345"),
})),

		s("debug-k8s", fmt([[
# Kubernetes debugging configuration
apiVersion: v1
kind: Pod
metadata:
  name: debug-pod
spec:
  containers:
  - name: debugger
    image: {1}
    env:
    - name: DEBUG
      value: "true"
    - name: LOG_LEVEL
      value: "debug"
    ports:
    - containerPort: {2}
      name: debug-port
    securityContext:
      capabilities:
        add:
        - SYS_PTRACE
]], {
	i(1, "app:debug"),
	i(2, "2345"),
})),
	},
}
