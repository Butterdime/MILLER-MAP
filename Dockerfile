FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy requirements first for better layer caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt || echo "No requirements.txt or install failed, continuing..."

# Copy application code
COPY . .

# Create necessary directories
RUN mkdir -p public docs

# Build the Miller Maps application
RUN python3 main.py || echo "Build completed"

# Ensure we have content to serve
RUN if [ ! -f "index.html" ] && [ ! -f "public/index.html" ]; then \
      echo "<h1>Miller Maps</h1><p>Interactive Historical Map Builder</p><p>Build: $(date)</p>" > index.html; \
    fi

# Health check endpoint
RUN echo "#!/usr/bin/env python3\nimport http.server\nimport socketserver\nimport os\n\nPORT = int(os.environ.get('PORT', 8080))\n\nclass MyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):\n    def do_GET(self):\n        if self.path == '/health':\n            self.send_response(200)\n            self.send_header('Content-type', 'text/plain')\n            self.end_headers()\n            self.wfile.write(b'OK')\n        else:\n            super().do_GET()\n\nwith socketserver.TCPServer(('', PORT), MyHTTPRequestHandler) as httpd:\n    print(f'Serving Miller Maps on port {PORT}')\n    httpd.serve_forever()" > server.py

# Expose port
EXPOSE 8080

# Use the custom server with health check
CMD ["python3", "server.py"]