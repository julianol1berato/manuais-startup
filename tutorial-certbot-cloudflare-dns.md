# Guia: Certbot com Validação DNS via Cloudflare

Este guia mostra como obter e renovar certificados SSL/TLS do Let's Encrypt usando o Certbot com validação DNS via Cloudflare. Esse método é ideal para servidores atrás de CGNAT ou firewalls, pois não requer abertura da porta 80/443.

## Vantagens da Validação DNS via Cloudflare

- Não requer abertura de portas (80/443) no servidor
- Permite obter certificados wildcard (`*.seu.dominio.com`)
- Funciona mesmo para servidores não acessíveis pela internet
- Automatiza todo o processo através da API do Cloudflare

## Pré-requisitos

- Domínio gerenciado pelo Cloudflare (DNS)
- Conta no Cloudflare com acesso à API
- Servidor Linux (este guia usa Debian/Ubuntu)

## 1. Instalação do Certbot com Plugin Cloudflare

```bash
# Atualizar repositórios
sudo apt-get update

# Instalar Certbot e plugin do Cloudflare
sudo apt-get install certbot python3-certbot-dns-cloudflare
```

## 2. Criar Token API do Cloudflare

1. Faça login no painel do Cloudflare: https://dash.cloudflare.com
2. Navegue até "My Profile" > "API Tokens"
3. Clique em "Create Token"
4. Selecione "Create Custom Token"
5. Defina um nome para o token (ex: "Certbot DNS Validation")
6. Em permissões, configure:
   - Zone - Zone - Read
   - Zone - DNS - Edit
7. Em Zone Resources, configure:
   - Include - All Zones (ou selecione a zona específica)
8. Clique em "Continue to Summary" e depois em "Create Token"
9. **IMPORTANTE**: Copie o token gerado - ele será mostrado apenas uma vez!

## 3. Configurar Credenciais do Cloudflare

```bash
# Criar diretório seguro para credenciais
sudo mkdir -p /etc/letsencrypt/cloudflare
sudo nano /etc/letsencrypt/cloudflare/credentials.ini
```

Adicione o seguinte conteúdo ao arquivo:

```ini
# Cloudflare API token
dns_cloudflare_api_token = seu_token_aqui
```

Proteja o arquivo:

```bash
sudo chmod 600 /etc/letsencrypt/cloudflare/credentials.ini
sudo chown root:root /etc/letsencrypt/cloudflare/credentials.ini
```

## 4. Obter Certificado SSL/TLS

### Para um Domínio Único

```bash
sudo certbot certonly \
  --dns-cloudflare \
  --dns-cloudflare-credentials /etc/letsencrypt/cloudflare/credentials.ini \
  -d seu.dominio.com \
  --preferred-challenges dns-01
```

### Para um Wildcard

```bash
sudo certbot certonly \
  --dns-cloudflare \
  --dns-cloudflare-credentials /etc/letsencrypt/cloudflare/credentials.ini \
  -d seu.dominio.com \
  -d *.seu.dominio.com \
  --preferred-challenges dns-01
```

## 5. Verificar Certificado

```bash
sudo certbot certificates
```

O certificado e arquivos relacionados serão salvos em:
- `/etc/letsencrypt/live/seu.dominio.com/`

## 6. Configurar Renovação Automática

O Certbot instala automaticamente um timer systemd ou cron job para verificar renovações. Você pode testar o processo de renovação com:

```bash
# Teste sem fazer alterações reais
sudo certbot renew --dry-run
```

Para criar um script de hook personalizado que execute ações após a renovação:

```bash
sudo mkdir -p /etc/letsencrypt/renewal-hooks/post
sudo nano /etc/letsencrypt/renewal-hooks/post/restart-services.sh
```

Adicione o seguinte conteúdo:

```bash
#!/bin/bash

# Script executado após renovação bem-sucedida
# Exemplo: reiniciar serviços que usam os certificados

# Recarregar/reiniciar serviços
systemctl restart mosquitto  # Exemplo para Mosquitto MQTT
# systemctl reload nginx      # Exemplo para Nginx
# systemctl reload apache2    # Exemplo para Apache

echo "Certificados renovados e serviços reiniciados em $(date)" >> /var/log/letsencrypt-renewal.log
```

Torne o script executável:

```bash
sudo chmod +x /etc/letsencrypt/renewal-hooks/post/restart-services.sh
```

## 7. Usar os Certificados em Serviços

### Exemplo: Configuração para Mosquitto MQTT

Em `/etc/mosquitto/mosquitto.conf`:

```
# Configuração SSL/TLS
listener 8883
cafile /etc/letsencrypt/live/seu.dominio.com/chain.pem
certfile /etc/letsencrypt/live/seu.dominio.com/fullchain.pem
keyfile /etc/letsencrypt/live/seu.dominio.com/privkey.pem
tls_version tlsv1.2
```

### Correção de Permissões (se necessário)

Se o serviço não conseguir ler os certificados, ajuste as permissões:

```bash
# Permitir que o serviço acesse os certificados
sudo chmod 755 /etc/letsencrypt/{live,archive}
sudo chmod 755 /etc/letsencrypt/live/seu.dominio.com
sudo chmod 755 /etc/letsencrypt/archive/seu.dominio.com

# Proteger a chave privada mas permitir acesso ao serviço
sudo chmod 640 /etc/letsencrypt/live/seu.dominio.com/privkey.pem
sudo chmod 640 /etc/letsencrypt/archive/seu.dominio.com/privkey*.pem

# Adicionar usuário do serviço ao grupo apropriado (exemplo para mosquitto)
sudo usermod -a -G ssl-cert mosquitto
```

## 8. Revogação e Exclusão de Certificados

Para revogar e excluir um certificado que você não precisa mais:

```bash
# Revogar certificado
sudo certbot revoke --cert-name seu.dominio.com

# Excluir certificado após revogar
sudo certbot delete --cert-name seu.dominio.com
```

## Solução de Problemas

### Erros de permissão

Se os logs mostrarem erros de permissão ao acessar certificados:

```bash
# Verificar propriedade e permissões dos certificados
ls -la /etc/letsencrypt/live/seu.dominio.com/
ls -la /etc/letsencrypt/archive/seu.dominio.com/
```

### Erros de validação DNS

Se a validação DNS falhar:

1. Verifique se o token API tem permissões corretas
2. Confirme que o domínio está corretamente configurado no Cloudflare
3. Aumente o tempo de propagação de DNS:

```bash
sudo certbot certonly \
  --dns-cloudflare \
  --dns-cloudflare-credentials /etc/letsencrypt/cloudflare/credentials.ini \
  -d seu.dominio.com \
  --dns-cloudflare-propagation-seconds 60
```

## Notas de Segurança

- Mantenha o arquivo de credenciais do Cloudflare seguro (permissões 600)
- Use um token de API com privilégios mínimos necessários
- Considere criar um token de API específico para cada servidor

## Referências

- [Documentação oficial do Certbot](https://certbot.eff.org/docs/)
- [Plugin Cloudflare para Certbot](https://certbot-dns-cloudflare.readthedocs.io/)
- [Documentação da API do Cloudflare](https://developers.cloudflare.com/api/)
