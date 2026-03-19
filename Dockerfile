FROM openclaw/openclaw:latest

# Copia configuração e skill
COPY openclaw.json /root/.openclaw/openclaw.json
COPY skill/ /root/.openclaw/skills/workspace/ipem-frota/

EXPOSE 3000

CMD ["openclaw", "gateway", "start", "--foreground"]
