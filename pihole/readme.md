# Instalando pihole

Instalação do Certbot para HTTPS

`apt install python3-certbot-dns-cloudflare certbot`

Criar arquivo cloudflare.ini para setar as credenciais
vim /etc/letsencrypt/cloudflare.ini
```
dns_cloudflare_email = 
dns_cloudflare_api_key = global-token
```

Configurando permissões do .ini

`chmod 600 /etc/letsencrypt/cloudflare.ini`

Executar criação do certificado via cloudflare

`certbot certonly --dns-cloudflare --dns-cloudflare-credentials /etc/letsencrypt/cloudflare.ini -d pihole.9level.com.br`

Saida esperada: 
![image](https://github.com/julianol1berato/manuais-startup/assets/6303689/537f81cf-6bb9-4714-a08b-a88be9a867af)


Configuração HTTPS - SSL:

cat /etc/lighttpd/conf-enabled/10-ssl.conf
```
server.modules += ( "mod_openssl" )

ssl.cipher-list = "HIGH"
ssl.pemfile = "/etc/letsencrypt/live/pihole.9level.com.br/fullchain.pem"
ssl.privkey = "/etc/letsencrypt/live/pihole.9level.com.br/privkey.pem"

$SERVER["socket"] == ":443" {
    ssl.engine = "enable"
    server.name = "pihole.9level.com.br"
}

include_shell "/usr/share/lighttpd/use-ipv6.pl 443"
```
