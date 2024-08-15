FROM binwiederhier/ntfy:v2.11.0

ENV BASE_URL=https://ntfy.9level.com.br \
    ENABLE_LOGIN=true \
    ENABLE_RESERVATIONS=true \
    CACHE_FILE=/var/cache/ntfy/cache.db \
    CACHE_DURATION=12h \
    AUTH_FILE=/etc/ntfy/auth.db \
    AUTH_DEFAULT_ACCESS=deny-all \
    WEB_PUSH_FILE=/var/cache/ntfy/webpush.db \
    WEB_PUSH_EMAIL_ADDRESS=ntfy@9level.com.br \
    BEHIND_PROXY=true \
    SMTP_SENDER_ADDR=smtp.sendgrid.net:587 \
    SMTP_SENDER_FROM=juliano@9level.com.br \
    SMTP_SENDER_USER=apikey \
    SMTP_SENDER_PASS=SG \
    SMTP_SERVER_DOMAIN=9level.com.br \
    UPSTREAM_BASE_URL=https://ntfy.sh \
    UPSTREAM_ACCESS_TOKEN=tk_ \
    TZ=America/Sao_Paulo

# Instalar SQLite para inicializar os arquivos .db
RUN apk add --no-cache sqlite

# Criar os diretórios necessários e arquivos .db durante o build, e ajustar as permissões
RUN mkdir -p /var/cache/ntfy /etc/ntfy && \
    sqlite3 /var/cache/ntfy/cache.db "VACUUM;" && \
    sqlite3 /etc/ntfy/auth.db "VACUUM;" && \
    sqlite3 /var/cache/ntfy/webpush.db "VACUUM;" && \
    chown -R 1000:1000 /var/cache/ntfy /etc/ntfy && \
    chmod 700 /var/cache/ntfy /etc/ntfy && \
    chmod 600 /var/cache/ntfy/cache.db /etc/ntfy/auth.db /var/cache/ntfy/webpush.db


EXPOSE 80/tcp
CMD ["serve"]
