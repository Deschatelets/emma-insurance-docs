FROM node:20-alpine

WORKDIR /app

# Install docs-mcp-server globally
RUN npm install -g @arabold/docs-mcp-server

# Copy startup script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Set environment variables
ENV DOCS_MCP_PROTOCOL=http
ENV DOCS_MCP_EMBEDDING_MODEL=openai:text-embedding-3-small
ENV PORT=6280
ENV HOST=0.0.0.0

# Expose port
EXPOSE 6280

# Start using shell script (shell form to allow variable expansion)
CMD /bin/sh /app/start.sh

