FROM ubuntu:24.04

# Instala dependências + Node.js como root
RUN apt-get update && apt-get install -y \
    curl bash git ca-certificates \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Instala OpenClaw como root (precisa de sudo/root para npm global)
RUN curl -fsSL https://openclaw.ai/install.sh | bash

ENV PATH="/root/.openclaw/bin:/root/.npm-global/bin:$PATH"

# Cria usuário e copia instalação
RUN useradd -m -s /bin/bash openclaw
WORKDIR /home/openclaw

# Copia a skill customizada
COPY --chown=openclaw:openclaw skill/ /home/openclaw/.openclaw/skills/workspace/ipem-frota/

# Copia configuração inicial (será sobrescrita por env vars)
COPY --chown=openclaw:openclaw openclaw.json /home/openclaw/.openclaw/openclaw.json

# Porta do WebChat (dashboard interno)
EXPOSE 3000

# Inicia o gateway
CMD ["openclaw", "gateway", "start", "--foreground"]
