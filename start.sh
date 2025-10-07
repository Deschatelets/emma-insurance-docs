#!/bin/bash
set -e

# Default port if not set by Railway
PORT=${PORT:-6280}
MCP_PORT=$((PORT + 1))

echo "==================================="
echo "Starting Emma Docs MCP Server"
echo "Proxy PORT: $PORT (external)"
echo "MCP PORT: $MCP_PORT (internal)"
echo "HOST: 0.0.0.0"
echo "==================================="

# Clone repo and scrape locally
echo "Cloning docs from GitHub..."
git clone --depth 1 https://github.com/Deschatelets/emma-insurance-docs.git /tmp/emma-docs

echo "Scraping docs from local files..."
docs-mcp-server scrape emma-docs "file:///tmp/emma-docs/produits-assurance-docs-french"

echo "Docs scraped successfully!"
echo "Starting MCP server on port $MCP_PORT..."

# Start MCP server in background
docs-mcp-server mcp --protocol http --port "$MCP_PORT" --host 127.0.0.1 --read-only &
MCP_PID=$!

# Wait for MCP server to be ready
echo "Waiting for MCP server to start..."
sleep 3

# Start proxy server in foreground
echo "Starting proxy server on port $PORT..."
export PORT=$PORT
exec node /app/proxy-server.js

# Cleanup on exit
trap "kill $MCP_PID 2>/dev/null || true" EXIT

