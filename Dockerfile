FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Sao_Paulo

# Instala dependências + Node.js 22
RUN apt-get update && apt-get install -y \
    curl bash git ca-certificates \
    && curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Instala OpenClaw via npm (sem setup interativo)
RUN npm install -g @openclaw/openclaw

WORKDIR /root/.openclaw

# Copia configuração e skill
COPY openclaw.json /root/.openclaw/openclaw.json
COPY skill/ /root/.openclaw/skills/workspace/ipem-frota/

EXPOSE 3000

CMD ["openclaw", "gateway", "start", "--foreground"]
