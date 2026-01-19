# Fail2ban + Traefik + Cloudflare - Sistema de Banimento em Camadas

Sistema integrado de proteção contra ataques com três camadas de defesa:
1. **Cloudflare WAF** - Bloqueia antes de chegar no servidor (Account-level)
2. **Traefik ForwardAuth** - Middleware que valida IPs via serviço Go
3. **iptables** - Firewall local como última camada

## 🎯 Características

- ✅ Banimento automático baseado em 404 abuse
- ✅ Bloqueio em 3 camadas (Cloudflare → Traefik → iptables)
- ✅ Suporta IPv4 e IPv6
- ✅ Funciona atrás do Cloudflare
- ✅ Compatível com Docker Swarm
- ✅ Banimento permanente
- ✅ **FREE** - usa Cloudflare IP Access Rules (ilimitado)

## 📋 Requisitos

- Ubuntu/Debian
- Docker Swarm
- Traefik v3.6+
- Fail2ban
- Cloudflare (plano FREE funciona)
- jq (JSON parser)

## 🚀 Instalação

### 1. Instalar dependências
```bash
apt update
apt install -y fail2ban jq curl
```

### 2. Instalar scripts
```bash
# Copiar scripts
cp scripts/traefik-ban /usr/local/bin/
cp scripts/cloudflare-ban /usr/local/bin/
cp scripts/permaban /usr/local/bin/

# Dar permissão
chmod +x /usr/local/bin/{traefik-ban,cloudflare-ban,permaban}
```

### 3. Configurar Cloudflare

**Obter credenciais:**

1. **API Token:**
   - Acesse: https://dash.cloudflare.com/profile/api-tokens
   - Create Token → Custom Token
   - Permissions: `Account → Firewall Services → Edit`
   - Create Token → Copiar

2. **Account ID:**
   - Acesse: https://dash.cloudflare.com/
   - Qualquer domínio → Sidebar direita → Account ID

**Configurar no script:**
```bash
vim /usr/local/bin/cloudflare-ban
# Preencher CF_API_TOKEN e CF_ACCOUNT_ID
```

**Testar:**
```bash
/usr/local/bin/cloudflare-ban test
/usr/local/bin/cloudflare-ban add 1.2.3.4
/usr/local/bin/cloudflare-ban list
```

### 4. Deploy ban-checker (Traefik ForwardAuth)
```bash
# Copiar código Go
mkdir -p /home/julianoliberato/docker/ban-checker
cp traefik/ban-checker/* /home/julianoliberato/docker/ban-checker/

# Build imagem
cd /home/julianoliberato/docker/ban-checker
docker build -t registry.9level.dev/ban-checker:latest .

# Push para registry (ajuste URL)
docker push registry.9level.dev/ban-checker:latest

# Criar arquivo de IPs vazio
touch /home/julianoliberato/docker/ban-checker/banned-ips.txt

# Deploy
docker stack deploy -c stack.yml ban-checker
```

### 5. Configurar Traefik
```bash
# Copiar configs
cp traefik/config/dynamic-routers.yml /home/julianoliberato/docker/traefik/config/
cp traefik/config/middlewares.yml /home/julianoliberato/docker/traefik/config/

# Editar traefik.yml
vim /home/julianoliberato/docker/traefik/traefik.yml
```

Adicionar:
```yaml
providers:
  swarm:
    endpoint: "unix:///var/run/docker.sock"
    exposedByDefault: false
    network: proxy
  file:
    directory: /config
    watch: true
```

Adicionar mount no stack:
```yaml
volumes:
  - /home/julianoliberato/docker/traefik/config:/config:ro

```

Atualizar:
```bash
docker stack deploy -c stack.yml traefik
```

### 6. Configurar Fail2ban
```bash
# Copiar configs
cp fail2ban/filters/traefik-404.conf /etc/fail2ban/filter.d/
cp fail2ban/actions/traefik-middleware.conf /etc/fail2ban/action.d/
cp fail2ban/jails/traefik-404.conf /etc/fail2ban/jail.d/

# Reload
systemctl restart fail2ban
fail2ban-client status traefik-404
```

## 🔧 Configuração

### Ajustar sensibilidade

Editar `/etc/fail2ban/jail.d/traefik-404.conf`:
```ini
maxretry = 5      # Número de 404s
findtime = 300    # Em quantos segundos (5min)
bantime = -1      # -1 = permanente
```

### Desbanir IP
```bash
# Via fail2ban
fail2ban-client set traefik-404 unbanip <IP>

# Remover de todas camadas
/usr/local/bin/traefik-ban <IP> remove
```

### Listar IPs banidos
```bash
# Cloudflare
/usr/local/bin/cloudflare-ban list

# Traefik
cat /home/julianoliberato/docker/ban-checker/banned-ips.txt

# iptables
/usr/local/bin/permaban list
```

## 📊 Monitoramento
```bash
# Logs fail2ban
tail -f /var/log/fail2ban.log | grep traefik-404

# Logs ban-checker
docker service logs ban-checker_ban-checker -f

# Logs Traefik
tail -f /home/julianoliberato/docker/traefik/logs/access.log
```

## 🧪 Testes

### Testar bloqueio
```bash
# Fazer 5 requests 404 em menos de 5 minutos
curl https://seu-dominio.com/teste1
curl https://seu-dominio.com/teste2
curl https://seu-dominio.com/teste3
curl https://seu-dominio.com/teste4
curl https://seu-dominio.com/teste5

# Verificar ban
fail2ban-client status traefik-404
```

## 📁 Estrutura de Arquivos
```
/usr/local/bin/
├── traefik-ban           # Script unificado
├── cloudflare-ban        # Integração Cloudflare
└── permaban              # Gestão iptables

/etc/fail2ban/
├── filter.d/traefik-404.conf      # Regex de detecção
├── action.d/traefik-middleware.conf
└── jail.d/traefik-404.conf        # Configuração principal

/home/julianoliberato/docker/
├── ban-checker/
│   ├── main.go
│   ├── Dockerfile
│   ├── stack.yml
│   └── banned-ips.txt    # Lista de IPs (gerado automaticamente)
└── traefik/
    ├── dynamic-routers.yml
    └── middlewares.yml
```

## 🔒 Segurança

- ✅ Credenciais Cloudflare no script (chmod 700)
- ✅ Arquivo banned-ips.txt com permissão 644
- ✅ Logs em /var/log/syslog via logger
- ✅ Validação de IPs antes de banir
- ✅ Rollback automático em caso de erro

## 🚀 Upgrade para Cloudflare Pro

Para usar IP Lists (> 1000 IPs) no plano Pro ($20/mês):
```bash
# Usar versão PRO do script
cp scripts/cloudflare-ban-pro /usr/local/bin/cloudflare-ban
```

Ver: `docs/cloudflare-pro.md`

## 📝 Licença
MIT

## 🤝 Contribuindo

Pull requests são bem-vindos!
