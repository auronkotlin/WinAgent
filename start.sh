#!/bin/sh

mkdir -p /app/.openclaw

PORT=${PORT:-18789}

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

exec pnpm openclaw gateway --port $PORT --allow-unconfigured --verbose
