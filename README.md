# IPEM-SJC Frota Bot — OpenClaw + Telegram

Agente de linguagem natural para gestão de frota via Telegram.

---

## ESTRUTURA

```
ipem-openclaw-agent/
├── Dockerfile          # container OpenClaw
├── render.yaml         # deploy Render
├── openclaw.json       # config do agente (lida por env vars)
└── skill/
    └── SKILL.md        # manual da skill IPEM (endpoints, fluxos, regras)
```

---

## SETUP — 3 ETAPAS

### 1. Criar o Bot no Telegram
1. Abra `@BotFather` no Telegram
2. `/newbot` → defina nome: `IPEM SJC Frota` → username: `ipemsjcfrota_bot`
3. Copie o token gerado → `TELEGRAM_BOT_TOKEN`

### 2. Chave Gemini (grátis)
1. Acesse https://aistudio.google.com/apikey
2. Clique "Create API Key"
3. Copie → `GEMINI_API_KEY`

### 3. Deploy no Render
1. Push deste diretório para um repositório GitHub
2. Acesse https://render.com → New → Web Service → conecte o repo
3. Render detecta o `render.yaml` automaticamente
4. Em **Environment Variables** preencha:

| Variável | Valor |
|---|---|
| `TELEGRAM_BOT_TOKEN` | token do @BotFather |
| `GEMINI_API_KEY` | chave do AI Studio |
| `IPEM_API_URL` | `https://sua-api.amazonaws.com` |
| `IPEM_MATRICULA` | matrícula do admin-bot |
| `IPEM_SENHA` | senha do admin-bot |

5. Clique **Deploy** — aguarde ~3 minutos

---

## USO — Exemplos de mensagens no Telegram

```
"Abrir OS para viatura SP-0012, saí agora, KM 54.200"
"Encerrar OS 42, cheguei, KM 54.890"
"Registrar abastecimento SP-0012: 45 litros, R$ 312,00, NF 9876"
"Cadastrar viatura placa ABC1D23, modelo Fiat Fiorino, prefixo SP-0015"
"KPIs do mês"
"Listar OS abertas"
```

---

## SEGURANÇA

- Crie um usuário `bot_admin` no IPEM com perfil `ADMIN` exclusivo para o bot
- Em `openclaw.json`, preencha `allowedUsers` com seu `telegram_user_id` para restringir acesso
  - Descubra seu ID: envie qualquer mensagem para `@userinfobot`
- **Nunca** versione `openclaw.json` com credenciais — use sempre env vars

---

## OBSERVAÇÃO SOBRE PLANO

O `starter` do Render (~$7/mês) mantém o bot ativo 24/7.
O plano `free` **dorme após 15 min de inatividade** — o bot não recebe mensagens do Telegram enquanto dormindo.
Para ambiente acadêmico/demo, o free funciona para demonstrações com warm-up manual.
