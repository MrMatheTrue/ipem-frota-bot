FROM node:22-slim

ENV DEBIAN_FRONTEND=noninteractive

# Dependências mínimas
RUN apt-get update && apt-get install -y curl bash git ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Instala OpenClaw (nome correto no npm)
RUN npm install -g openclaw@latest

WORKDIR /root/.openclaw

COPY openclaw.json /root/.openclaw/openclaw.json
COPY skill/ /root/.openclaw/skills/workspace/ipem-frota/

EXPOSE 3000

CMD ["openclaw", "gateway", "start", "--foreground"]
