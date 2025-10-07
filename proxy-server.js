#!/usr/bin/env node

/**
 * Proxy server to add caching headers and compression
 * Wraps the docs-mcp-server with additional HTTP optimizations
 */

const http = require('http');
const httpProxy = require('http-proxy');
const zlib = require('zlib');

const PORT = process.env.PORT || 8080;
const TARGET_PORT = parseInt(PORT) + 1; // MCP server runs on PORT+1

// Create proxy server
const proxy = httpProxy.createProxyServer({
  target: `http://127.0.0.1:${TARGET_PORT}`,
  ws: true, // Enable WebSocket proxying
});

// Create HTTP server with caching and compression
const server = http.createServer((req, res) => {
  // Health check endpoint
  if (req.url === '/health' || req.url === '/healthz') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ 
      status: 'healthy', 
      timestamp: new Date().toISOString(),
      service: 'emma-docs-mcp-proxy'
    }));
    return;
  }

  // Add compression headers
  const acceptEncoding = req.headers['accept-encoding'] || '';
  
  // Add cache headers based on path
  if (req.url.includes('/mcp') || req.url.includes('/sse')) {
    // MCP endpoints - no cache
    res.setHeader('Cache-Control', 'no-cache, no-store, must-revalidate');
  } else if (req.url.includes('/static') || req.url.includes('/assets')) {
    // Static assets - cache for 1 week
    res.setHeader('Cache-Control', 'public, max-age=604800, immutable');
  } else {
    // Other endpoints - cache for 5 minutes
    res.setHeader('Cache-Control', 'public, max-age=300');
  }

  // Proxy the request
  proxy.web(req, res, (err) => {
    console.error('Proxy error:', err);
    res.writeHead(502, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ error: 'Bad Gateway', message: err.message }));
  });
});

// Handle WebSocket upgrade
server.on('upgrade', (req, socket, head) => {
  proxy.ws(req, socket, head);
});

// Handle proxy errors
proxy.on('error', (err, req, res) => {
  console.error('Proxy error:', err);
  if (res.writeHead) {
    res.writeHead(502, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ error: 'Bad Gateway' }));
  }
});

// Start server
server.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 Proxy server listening on 0.0.0.0:${PORT}`);
  console.log(`   Forwarding to MCP server on 127.0.0.1:${TARGET_PORT}`);
  console.log(`   Cache-Control headers: enabled`);
  console.log(`   Compression: handled by Railway edge`);
});

// Graceful shutdown
process.on('SIGTERM', () => {
  console.log('SIGTERM received, closing server...');
  server.close(() => {
    console.log('Server closed');
    process.exit(0);
  });
});
