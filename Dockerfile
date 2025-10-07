FROM node:20-alpine

WORKDIR /app

# Install docs-mcp-server globally
RUN npm install -g @arabold/docs-mcp-server

# Set environment variables
ENV DOCS_MCP_PROTOCOL=http
ENV PORT=6280
ENV HOST=0.0.0.0

# Expose port
EXPOSE 6280

# Start command - scrape from GitHub then start server
CMD docs-mcp-server scrape emma-docs https://github.com/Deschatelets/emma-insurance-docs && \
    docs-mcp-server mcp --protocol http --port ${PORT:-6280} --host 0.0.0.0 --read-only

