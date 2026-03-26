FROM node:24-alpine

WORKDIR /app

RUN apk add --no-cache git

RUN git clone https://github.com/openclaw/openclaw.git .

RUN npm install -g pnpm
RUN pnpm install

RUN pnpm build

EXPOSE 18789

CMD ["pnpm", "openclaw", "gateway", "--port", "18789", "--verbose"]
