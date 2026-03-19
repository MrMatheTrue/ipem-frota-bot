FROM ubuntu:24.04

# Dependências do sistema
RUN apt-get update && apt-get install -y \
    curl \
    bash \
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Cria usuário dedicado (não rodar como root)
RUN useradd -m -s /bin/bash openclaw
USER openclaw
WORKDIR /home/openclaw

# Instala OpenClaw
RUN curl -fsSL https://openclaw.ai/install.sh | bash

ENV PATH="/home/openclaw/.openclaw/bin:$PATH"

# Copia a skill customizada
COPY --chown=openclaw:openclaw skill/ /home/openclaw/.openclaw/skills/workspace/ipem-frota/

# Copia configuração inicial (será sobrescrita por env vars)
COPY --chown=openclaw:openclaw openclaw.json /home/openclaw/.openclaw/openclaw.json

# Porta do WebChat (dashboard interno)
EXPOSE 3000

# Inicia o gateway
CMD ["openclaw", "gateway", "start", "--foreground"]
