# detalhes da migração para novo nó

[ ] Ativação S3 via TailScale - 
[ ] Ativação S3 no Traefik proxy -
[ ] Regras de Firewall S3 -
[ ] 
[ ] 


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
