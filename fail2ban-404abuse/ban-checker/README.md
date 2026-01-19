# Ban-Checker - Traefik ForwardAuth Service

Serviço Go de alta performance que atua como middleware ForwardAuth para Traefik, validando IPs em tempo real contra uma lista de banidos.

## 🎯 O que faz

- Recebe requisições do Traefik ANTES de processar
- Valida IP real do cliente (via headers Cloudflare)
- Retorna **403 Forbidden** se IP estiver banido
- Retorna **200 OK** se IP estiver liberado
- Recarrega lista automaticamente quando arquivo muda
- Suporta IPv4 e IPv6

## 🏗️ Arquitetura
```
Request → Cloudflare → Traefik → ban-checker → Decisão
                                      ↓
                                 banned-ips.txt
                                      ↓
                              403 ou 200 ← Traefik
```

## 🚀 Como funciona

### 1. Traefik consulta o ban-checker

Toda request passa por:
```yaml
# middlewares.yml
ban-check:
  forwardAuth:
    address: "http://ban-checker:8888"
    trustForwardHeader: true
```

### 2. Ban-checker valida o IP
```go
// Ordem de prioridade para extrair IP real:
1. CF-Connecting-IP       // Cloudflare
2. X-Forwarded-For        // Proxy padrão
3. ClientIP               // Direto
```

### 3. Verifica lista de banidos
```go
// Lê /data/banned-ips.txt
// Cada linha = 1 IP
// Recarrega automaticamente via fsnotify
```

### 4. Responde

- **IP banido:** HTTP 403 + log
- **IP liberado:** HTTP 200

## 📦 Instalação

### Requisitos

- Docker / Docker Swarm
- Network `proxy` criada
- Arquivo `banned-ips.txt` montado

### Build
```bash
# Build local
docker build -t ban-checker:latest .

# Ou push para registry
docker build -t registry.9level.dev/ban-checker:latest .
docker push registry.9level.dev/ban-checker:latest
```

### Deploy (Docker Swarm)
```bash
# Criar arquivo de IPs vazio
touch /home/julianoliberato/docker/ban-checker/banned-ips.txt
chmod 644 /home/julianoliberato/docker/ban-checker/banned-ips.txt

# Deploy stack
docker stack deploy -c stack.yml ban-checker

# Verificar
docker service ls | grep ban-checker
docker service logs ban-checker_ban-checker
```

## 🔧 Configuração

### Estrutura de arquivos
```
ban-checker/
├── main.go              # Código fonte
├── go.mod               # Dependências
├── go.sum               # Checksums
├── Dockerfile           # Multi-stage build
├── stack.yml            # Docker Swarm
├── banned-ips.txt       # Lista de IPs (gerado auto)
└── README.md
```

### banned-ips.txt

Formato: **1 IP por linha**
```txt
1.2.3.4
2001:db8::1
192.168.1.100
2804:389:0:0:0:0:0:62bd
```

**Comentários:**
```txt
# Linhas iniciando com # são ignoradas
1.2.3.4       # Atacante detectado em 2026-01-19
```

### Variáveis de ambiente

Nenhuma necessária - configuração via arquivo apenas.

### Volumes
```yaml
volumes:
  - /caminho/para/banned-ips.txt:/data/banned-ips.txt:ro
```

**Importante:** Mount como `:ro` (read-only) - apenas fail2ban escreve.

## 📊 Monitoramento

### Health Check
```bash
curl http://localhost:8888/health
# Resposta: OK
```

### Logs
```bash
# Logs em tempo real
docker service logs ban-checker_ban-checker -f

# Logs de IPs bloqueados
docker service logs ban-checker_ban-checker | grep "IP banido bloqueado"
```

**Exemplo de log:**
```
Ban-checker iniciado na porta 8888
Carregados 15 IPs banidos
Arquivo modificado, recarregando...
Carregados 16 IPs banidos
IP banido bloqueado: 1.2.3.4
```

### Metrics

Endpoint: `GET /health`

- Status: 200 OK = serviço rodando
- Status: erro = problema

### Performance

- **Latência:** ~2-5ms por request
- **Throughput:** ~1000 req/s por worker (4 workers = 4k req/s)
- **Memória:** ~10-20 MB por container
- **CPU:** Mínimo (~0.01 core)

## 🧪 Testes

### Teste local (sem Docker)
```bash
# Instalar Go
apt install golang-go

# Baixar dependências
go mod download

# Criar arquivo de teste
echo "1.2.3.4" > /tmp/banned-ips.txt

# Rodar (apontar para arquivo teste)
# Edite main.go: const bannedFile = "/tmp/banned-ips.txt"
go run main.go

# Testar em outro terminal
curl -H "CF-Connecting-IP: 1.2.3.4" http://localhost:8888/
# Deve retornar: Forbidden (403)

curl -H "CF-Connecting-IP: 8.8.8.8" http://localhost:8888/
# Deve retornar: OK (200)
```

### Teste com Docker
```bash
# Build
docker build -t ban-checker:test .

# Run standalone
docker run --rm -p 8888:8888 \
  -v $(pwd)/banned-ips.txt:/data/banned-ips.txt:ro \
  ban-checker:test

# Testar
curl -H "CF-Connecting-IP: 1.2.3.4" http://localhost:8888/
```

### Teste integrado com Traefik
```bash
# Adicionar seu IP
echo "SEU_IP_AQUI" >> banned-ips.txt

# Acessar qualquer site
curl https://seu-dominio.com

# Deve retornar 403 Forbidden
```

## 🔒 Segurança

### Pontos importantes

1. **Arquivo read-only:** Container não escreve no arquivo
2. **Sem credenciais:** Não armazena senhas/tokens
3. **Logs seguros:** Não loga IPs de requests normais (só bloqueios)
4. **Isolamento:** Roda em network isolada (proxy)

### Headers confiáveis
```go
// Ordem de confiança:
1. CF-Connecting-IP  ← Cloudflare (confiável)
2. X-Forwarded-For   ← Proxy genérico (pode ser spoofado)
3. ClientIP          ← IP da conexão TCP
```

**Recomendação:** Use sempre com Cloudflare ativado.

## 🐛 Troubleshooting

### Container não inicia
```bash
# Ver logs de erro
docker service logs ban-checker_ban-checker

# Comum: arquivo banned-ips.txt não existe
touch /home/julianoliberato/docker/ban-checker/banned-ips.txt
```

### IPs não são bloqueados
```bash
# 1. Verificar se arquivo tem IPs
cat /home/julianoliberato/docker/ban-checker/banned-ips.txt

# 2. Ver se container recarregou
docker service logs ban-checker_ban-checker | grep "Carregados"

# 3. Testar diretamente
curl -H "CF-Connecting-IP: IP_BANIDO" http://ban-checker:8888/
```

### Middleware não é chamado
```bash
# Verificar se middleware existe
curl -u usuario:senha http://localhost:8080/api/http/middlewares | \
  jq '.[] | select(.name | contains("ban-check"))'

# Verificar chain
grep -A5 "waf-chain:" /home/julianoliberato/docker/traefik/middlewares.yml
```

### Performance lenta
```bash
# Aumentar replicas
docker service scale ban-checker_ban-checker=4

# Ver uso de recursos
docker stats --no-stream | grep ban-checker
```

## 🔄 Atualizações

### Atualizar código
```bash
# 1. Editar main.go
nano main.go

# 2. Rebuild
docker build -t registry.9level.dev/ban-checker:latest .
docker push registry.9level.dev/ban-checker:latest

# 3. Update service
docker service update --image registry.9level.dev/ban-checker:latest \
  ban-checker_ban-checker
```

### Rolling update
```yaml
# stack.yml
deploy:
  update_config:
    parallelism: 1      # 1 container por vez
    delay: 10s          # Aguarda 10s entre updates
  rollback_config:
    parallelism: 1
```

## 📚 Dependências

### Go Modules
```go
github.com/gin-gonic/gin v1.10.0      // Web framework
github.com/fsnotify/fsnotify v1.7.0   // File watcher
```

### Build

- **Stage 1:** `golang:1.21-alpine` (build)
- **Stage 2:** `alpine:latest` (runtime)
- **Tamanho final:** ~15-20 MB

## 🚀 Performance

### Benchmarks
```bash
# Apache Bench
ab -n 10000 -c 100 -H "CF-Connecting-IP: 8.8.8.8" \
  http://ban-checker:8888/

# Resultado esperado:
# - 1000+ req/s
# - Latência média: 2-5ms
```

### Otimizações

- ✅ Read lock (sync.RWMutex) - múltiplas leituras simultâneas
- ✅ Map in-memory - lookup O(1)
- ✅ Debounce de 100ms - evita recargas excessivas
- ✅ Gin release mode - sem debug logs

## 📖 API

### Endpoints

#### `GET /health`

Health check do serviço.

**Response:**
```
200 OK
Body: "OK"
```

#### `GET /*` (qualquer rota)

Valida IP do cliente.

**Headers obrigatórios:**
- `CF-Connecting-IP` (recomendado)
- ou `X-Forwarded-For`

**Response:**

- **IP permitido:** `200 OK` + body "OK"
- **IP banido:** `403 Forbidden` + body "Forbidden"

**Exemplos:**
```bash
# IP permitido
curl -H "CF-Connecting-IP: 8.8.8.8" http://ban-checker:8888/
# 200 OK

# IP banido
curl -H "CF-Connecting-IP: 1.2.3.4" http://ban-checker:8888/
# 403 Forbidden
```

## 📄 Licença

MIT

## 🤝 Contribuindo

1. Fork o projeto
2. Crie feature branch
3. Commit mudanças
4. Push para branch
5. Abra Pull Request

## 📧 Suporte

- GitHub Issues
