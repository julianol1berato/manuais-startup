#Instalando pihole



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
