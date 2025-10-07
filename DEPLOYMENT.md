# Deployment Guide

## Overview

This MCP server is deployed on Railway with caching, compression, and semantic search capabilities.

## Architecture

```
Client Request
    ↓
Railway Edge (automatic gzip compression)
    ↓
Proxy Server (port 8080)
  - Caching headers
  - Health checks
    ↓
MCP Server (port 8081, internal)
  - docs-mcp-server
  - SQLite + vector search
  - OpenAI embeddings
```

## Features Enabled

### ✅ Caching Headers
- **MCP endpoints** (`/mcp`, `/sse`): No cache
- **Static assets**: 1 week cache
- **Other endpoints**: 5 minutes cache

### ✅ Compression
- Handled automatically by Railway edge
- gzip/brotli based on client support

### ✅ Semantic Search
- OpenAI text-embedding-3-small
- Vector search via sqlite-vec
- Natural language queries


### ✅ Health Checks
- Endpoint: `/health` or `/healthz`
- Railway auto-recovery

## Environment Variables (Railway)

Required:
- `PORT` - Auto-set by Railway
- `OPENAI_API_KEY` - Your OpenAI API key

Optional:
- `DOCS_MCP_EMBEDDING_MODEL` - Default: `openai:text-embedding-3-small`
- `DOCS_MCP_HOST` - Default: `0.0.0.0`

## Endpoints

- **Main URL**: `https://emma-insurance-docs-production.up.railway.app`
- **MCP Protocol**: `https://emma-insurance-docs-production.up.railway.app/mcp`
- **Server-Sent Events**: `https://emma-insurance-docs-production.up.railway.app/sse`
- **Health Check**: `https://emma-insurance-docs-production.up.railway.app/health`

## Files

### Configuration
- `Dockerfile` - Container build
- `railway.toml` - Railway config
- `package.json` - Node.js dependencies

### Application
- `proxy-server.js` - Caching/compression proxy
- `start.sh` - Startup orchestration
- `mcp-config-remote.json` - Client configuration

### Documentation
- `README.md` - Main documentation
- `produits-assurance-docs-french/INDEX.md` - Provider index
- `produits-assurance-docs-french/GLOSSARY.md` - Insurance terms
- `produits-assurance-docs-french/COMPARISON.md` - Provider comparison

## Deployment Process

1. **Push to GitHub**
   ```bash
   git add -A
   git commit -m "Your message"
   git push
   ```

2. **Railway Auto-Deploy**
   - Detects push
   - Builds Docker image
   - Runs database migrations
   - Clones docs repo
   - Creates embeddings (~2 min)
   - Starts servers

3. **Verify Deployment**
   ```bash
   curl https://emma-insurance-docs-production.up.railway.app/health
   ```

## Monitoring

### Railway Dashboard
- View logs
- Check metrics (CPU, memory, network)
- Monitor requests

### Health Check
```bash
curl https://emma-insurance-docs-production.up.railway.app/health
```

Expected response:
```json
{
  "status": "healthy",
  "timestamp": "2025-10-07T21:00:00.000Z",
  "service": "emma-docs-mcp-proxy"
}
```

## Performance

### Caching Strategy
- **First request**: Full search (~100-500ms)
- **Cached requests**: ~10-50ms
- **Embedding creation**: One-time on deploy (~2 min)

### Costs (OpenAI)
- **Initial indexing**: ~$0.10-0.20 (one-time per deploy)
- **Per search query**: ~$0.0001-0.001
- **Monthly estimate**: <$10 for moderate usage

## Troubleshooting

### 502 Bad Gateway
- Check Railway logs
- Verify health check passes
- Ensure MCP server started successfully

### Slow Searches
- Verify `OPENAI_API_KEY` is set
- Check Railway metrics for CPU/memory
- Consider scaling horizontally

### No Embeddings
- Check logs for OpenAI API errors
- Verify API key has sufficient credits
- Confirm embedding model name is correct

## Scaling

### Horizontal Scaling
- Add replicas in Railway
- Each replica has full doc index
- Automatic load balancing

### Vertical Scaling
- Upgrade Railway plan
- More CPU/memory for concurrent requests

## Updates

### Content Updates
1. Update markdown files in repo
2. Push to GitHub
3. Railway redeploys and re-indexes

### Code Updates
1. Update Dockerfile, start.sh, or proxy-server.js
2. Push to GitHub
3. Railway rebuilds and redeploys

## Security

### Best Practices
- ✅ No hardcoded secrets
- ✅ Environment variables only
- ✅ Private GitHub repo option supported
- ✅ HTTPS enforced by Railway

### Rate Limiting
- Handled by Railway edge (automatic)
- DDoS protection included

---

**Last Updated**: October 2025
