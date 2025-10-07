#!/bin/sh
set -e

# Default port if not set by Railway
PORT=${PORT:-6280}

echo "Starting MCP server on port $PORT"

# Scrape docs from GitHub
docs-mcp-server scrape emma-docs https://github.com/Deschatelets/emma-insurance-docs

# Start MCP server
docs-mcp-server mcp --protocol http --port "$PORT" --host 0.0.0.0 --read-only

