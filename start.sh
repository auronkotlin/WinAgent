#!/bin/sh

mkdir -p /app/.openclaw

PORT=${PORT:-10000}

cat > /app/.openclaw/openclaw.json <<EOF
{
  "agent": {
    "model": "gemini-3.1-flash-lite-preview"
  },
  "gateway": {
    "port": $PORT,
    "bind": "0.0.0.0"
  },
  "channels": {
    "telegram": {
      "botToken": "$TELEGRAM_BOT_TOKEN"
    }
  }
}
EOF

# Health check server (responde rápido a Render)
cat > /app/health.js <<'HEALTHEOF'
const http = require('http');
const server = http.createServer((req, res) => {
  if (req.url === '/health') {
    res.writeHead(200);
    res.end('ok');
  } else {
    res.writeHead(404);
    res.end();
  }
});
server.listen(process.env.PORT || 10000);
HEALTHEOF

# Inicia health check
node /app/health.js &

# Inicia OpenClaw
exec pnpm openclaw gateway --port $PORT --allow-unconfigured --verbose
