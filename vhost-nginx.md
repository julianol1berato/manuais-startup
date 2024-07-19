# hardening nginx vhost


```sh
server {
    listen 80;
    server_name www.DOMAIN.com.br DOMAIN.com.br;
    location / {
       return 301 https://$host$request_uri;
    }
}

server {
    listen 443 ssl http2;
    server_name www.DOMAIN.com.br DOMAIN.com.br;

    root /var/www/html/aproxima-site;
    index index.html;

    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers on;
    ssl_ciphers 'ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES25
6-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384';
    ssl_session_timeout 1d;
    ssl_stapling on;
    ssl_stapling_verify on;
    resolver 1.1.1.1 9.9.9.9 valid=300s;
    resolver_timeout 5s;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;
        add_header Referrer-Policy "no-referrer-when-downgrade" always;
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header Content-Security-Policy "default-src 'self'; script-src 'self'; style-src 'self'; font-src 'self' https://fonts.gstatic.com; img-src 's
elf' data:; object-src 'none'; base-uri 'self'; form-action 'self'; frame-ancestors 'self'; report-uri /csp-violation-report" always;
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;
    location / {
        try_files $uri $uri/ =404;
    }
    error_page 404 /404.html;
    location = /404.html {
        internal;
    }
    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
        internal;
    }
    ssl_certificate /etc/letsencrypt/live/DOMAIN.com.br/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/DOMAIN.com.br/privkey.pem; # managed by Certbot
}
```
