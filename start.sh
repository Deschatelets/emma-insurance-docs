#!/bin/bash
set -e

# Default port if not set by Railway
PORT=${PORT:-6280}

echo "==================================="
echo "Starting Emma Docs MCP Server"
echo "PORT: $PORT"
echo "HOST: 0.0.0.0"
echo "==================================="

# Clone repo and scrape locally
echo "Cloning docs from GitHub..."
git clone --depth 1 https://github.com/Deschatelets/emma-insurance-docs.git /tmp/emma-docs

echo "Scraping docs from local files..."
docs-mcp-server scrape emma-docs "file:///tmp/emma-docs/produits-assurance-docs-french"

echo "Docs scraped successfully!"
echo "Starting MCP server..."

# Start MCP server
exec docs-mcp-server mcp --protocol http --port "$PORT" --host 0.0.0.0 --read-only

