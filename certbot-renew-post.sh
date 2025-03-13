#!/bin/bash
# Script para renovar certificados Let's Encrypt e atualizar o Mosquitto
# Salve como /etc/letsencrypt/renewal-hooks/post/mosquitto-cert-copy.sh

DOMAIN="xxxx.9level.network"
LETSENCRYPT_LIVE_DIR="/etc/letsencrypt/live/$DOMAIN"
MOSQUITTO_USER="mosquitto"

chmod 755 /etc/letsencrypt/{live,archive}
chmod 755 /etc/letsencrypt/live/$DOMAIN
chmod 755 /etc/letsencrypt/archive/$DOMAIN

# Certifique-se de que os arquivos privados ainda estão protegidos
chmod 640 $LETSENCRYPT_LIVE_DIR/privkey.pem
chmod 640 /etc/letsencrypt/archive/$DOMAIN/privkey*.pem

# Reinicie o serviço Mosquitto
systemctl restart mosquitto

echo "Permissões ajustadas para Mosquitto em $(date)" >> /var/log/letsencrypt-mosquitto-renewal.log
