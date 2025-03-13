# Configuração de Permissões para Mosquitto MQTT Broker

Este documento descreve as configurações de permissões necessárias para que o servidor Mosquitto MQTT funcione corretamente, evitando erros comuns relacionados a permissões de arquivos.

## Estrutura de Arquivos

O Mosquitto utiliza os seguintes arquivos importantes que requerem permissões específicas:

- `/etc/mosquitto/mosquitto.conf` - Arquivo principal de configuração
- `/etc/mosquitto/passwd` - Arquivo de senhas dos usuários
- `/etc/mosquitto/acl` - Arquivo de regras de controle de acesso

## Correções de Permissões

### Arquivo de Senha

Se você encontrar o erro: `Error opening password file "/etc/mosquitto/passwd"`

```bash
# Criar o arquivo de senha (se não existir)
sudo mosquitto_passwd -c /etc/mosquitto/passwd primeiro_usuario

# Corrigir permissões
sudo chmod 640 /etc/mosquitto/passwd
sudo chown mosquitto:mosquitto /etc/mosquitto/passwd
```

### Arquivo de ACL

Se você encontrar os avisos:
```
Warning: File /etc/mosquitto/acl has world readable permissions. Future versions will refuse to load this file.
Warning: File /etc/mosquitto/acl owner is not mosquitto. Future versions will refuse to load this file.
Warning: File /etc/mosquitto/acl group is not mosquitto. Future versions will refuse to load this file.
```

```bash
# Corrigir permissões do arquivo ACL (uma linha)
sudo chmod 0700 /etc/mosquitto/acl && sudo chown mosquitto:mosquitto /etc/mosquitto/acl
```

### Diretório e Arquivos de Certificados SSL/TLS

Se você estiver usando certificados Let's Encrypt diretamente:

```bash
# Permitir que o mosquitto acesse os certificados
sudo chmod 755 /etc/letsencrypt/{live,archive}
sudo chmod 755 /etc/letsencrypt/live/seu.dominio.com
sudo chmod 755 /etc/letsencrypt/archive/seu.dominio.com

# Proteger a chave privada, mas permitir acesso ao mosquitto
sudo chmod 640 /etc/letsencrypt/live/seu.dominio.com/privkey.pem
sudo chmod 640 /etc/letsencrypt/archive/seu.dominio.com/privkey*.pem

# Opção adicional: adicionar o usuário mosquitto ao grupo correto
sudo usermod -a -G ssl-cert mosquitto
```

Se você estiver copiando certificados para o diretório do Mosquitto:

```bash
# Criar diretório se não existir
sudo mkdir -p /etc/mosquitto/certs

# Copiar certificados
sudo cp /etc/letsencrypt/live/seu.dominio.com/fullchain.pem /etc/mosquitto/certs/
sudo cp /etc/letsencrypt/live/seu.dominio.com/privkey.pem /etc/mosquitto/certs/
sudo cp /etc/letsencrypt/live/seu.dominio.com/chain.pem /etc/mosquitto/certs/

# Corrigir permissões
sudo chmod 640 /etc/mosquitto/certs/*.pem
sudo chown mosquitto:mosquitto /etc/mosquitto/certs/*.pem
```

## Diretório de Logs

Certifique-se de que o diretório de logs também tenha as permissões corretas:

```bash
sudo mkdir -p /var/log/mosquitto
sudo chown mosquitto:mosquitto /var/log/mosquitto
sudo chmod 755 /var/log/mosquitto
```

## Diretório de Persistência

Se você estiver usando persistência:

```bash
sudo mkdir -p /var/lib/mosquitto
sudo chown mosquitto:mosquitto /var/lib/mosquitto
sudo chmod 755 /var/lib/mosquitto
```

## Verificação

Após fazer todas as correções necessárias, reinicie o Mosquitto e verifique o status:

```bash
sudo systemctl restart mosquitto
sudo systemctl status mosquitto
```

Verifique os logs para confirmar que não há mais erros de permissão:

```bash
sudo tail -f /var/log/mosquitto/mosquitto.log
```

## Notas Adicionais

- Versões futuras do Mosquitto serão mais rigorosas com permissões de arquivos por motivos de segurança
- É importante seguir estas recomendações de permissões para evitar problemas durante atualizações
- Sempre faça backup dos arquivos de configuração antes de fazer alterações significativas
