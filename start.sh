#!/bin/sh

mkdir -p /app/.openclaw

cat > /app/.openclaw/openclaw.json <<EOF
{
  "agent": {
    "model": "gemini-3.1-flash-lite-preview"
  },
  "gateway": {
    "port": 18789,
    "bind": "0.0.0.0"
  },
  "channels": {
    "telegram": {
      "botToken": "$TELEGRAM_BOT_TOKEN"
    }
  }
}
EOF

pnpm openclaw gateway --port 18789 --allow-unconfigured --verbose
