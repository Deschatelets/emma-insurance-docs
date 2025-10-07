#!/bin/bash
set -e

# Default port if not set by Railway
PORT=${PORT:-6280}

echo "==================================="
echo "Starting Emma Docs MCP Server"
echo "PORT: $PORT"
echo "HOST: 0.0.0.0"
echo "==================================="

# Scrape docs from GitHub (will use full-text search if no OpenAI API key)
echo "Scraping docs from GitHub..."
docs-mcp-server scrape emma-docs https://github.com/Deschatelets/emma-insurance-docs

echo "Docs scraped successfully!"
echo "Starting MCP server..."

# Start MCP server
exec docs-mcp-server mcp --protocol http --port "$PORT" --host 0.0.0.0 --read-only

