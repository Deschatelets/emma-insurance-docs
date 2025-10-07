FROM node:20-slim

WORKDIR /app

# Install system dependencies for sqlite-vec and git
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install docs-mcp-server globally
RUN npm install -g @arabold/docs-mcp-server

# Copy package.json and install dependencies
COPY package.json /app/package.json
RUN npm install --production

# Copy proxy server and startup script
COPY proxy-server.js /app/proxy-server.js
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh /app/proxy-server.js

# Set environment variables
ENV DOCS_MCP_PROTOCOL=http
ENV DOCS_MCP_EMBEDDING_MODEL=openai:text-embedding-3-small
ENV PORT=6280
ENV HOST=0.0.0.0
ENV DOCS_MCP_HOST=0.0.0.0
# OPENAI_API_KEY should be set in Railway Variables for security

# Expose port
EXPOSE 6280

# Start using shell script (shell form to allow variable expansion)
CMD /bin/bash /app/start.sh

