# detalhes da migração para novo nó

- [X] Ativação S3 via TailScale - ✅
- [X] Ativação S3 no Traefik proxy DNS - ✅
- [X] Regras de Firewall S3 - ✅
- [ ] 
- [ ] 


### regras de firewall s3 
```sh
# Redireciona o tráfego para o endereço interno
iptables -t nat -A PREROUTING -d XXXX.XX8 -p tcp --dport 9000 -j DNAT --to-destination 100.100.xxx.xxx:9000
iptables -t nat -A PREROUTING -d XXXX.XX8 -p tcp --dport 9001 -j DNAT --to-destination 100.100.xxx.xxx:9001

# Permite o encaminhamento de pacotes
iptables -A FORWARD -p tcp -d 100.100.XXX.XXX --dport 9000 -j ACCEPT
iptables -A FORWARD -p tcp -d 100.100.xxx.xx --dport 9001 -j ACCEPT

# Configurar o mascaramento para que os pacotes retornem corretamente
iptables -t nat -A POSTROUTING -d 100.100.xxx.xxx -p tcp --dport 9000 -j MASQUERADE
iptables -t nat -A POSTROUTING -d 100.100.xxx.xxx -p tcp --dport 9001 -j MASQUERADE
```

```
http:
  middlewares:
    redirect-to-https:
      redirectScheme:
        scheme: https
        permanent: true

    bad-gateway-error-page:
      errors:
        status:
          - "502"
        service: easypanel
        query: "/api/errors/bad-gateway"

  routers:
    http-prod_s3-0:
      service: prod_s3-0
      rule: "Host(`xxx.xxx.xxx.br`) && PathPrefix(`/`)"
      priority: 0
      middlewares:
        - redirect-to-https
        - bad-gateway-error-page
      entryPoints:
        - http

    https-prod_s3-0:
      service: prod_s3-0
      rule: "Host(`xxx.xxx.xxx.br`) && PathPrefix(`/`)"
      priority: 0
      middlewares:
        - bad-gateway-error-page
      tls:
        certResolver: letsencrypt
        domains:
          - main: xxx.xxx.xxx.br
      entryPoints:
        - https

  services:
    prod_s3-0:
      loadBalancer:
        servers:
          - url: http://xxx.xxx.xxx.xxx:9001
        passHostHeader: true
```
