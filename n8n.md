# Como instalar n8n rápido?

Instalando docker
`apt update && apt upgrade -y && apt install docker.io vim curl wget -y`

Criar o volume persistente: 
`docker volume create n8n_data`


Executar com as váriaveis. A conexão com o postgresql serve para separar os arquivos de configuração do n8n onde contém usuários e senhas, pode rodar sem o postgresql em ambientes simples.
```
docker run -d --rm \
 --name n8n \
 -p 5678:5678 \
 -e DB_TYPE=postgresdb \
 -e DB_POSTGRESDB_DATABASE=dbn8n \
 -e DB_POSTGRESDB_HOST=192.168. \
 -e DB_POSTGRESDB_PORT=5432 \
 -e DB_POSTGRESDB_USER=juliano \
 -e DB_POSTGRESDB_SCHEMA=dbn8n \
 -e DB_POSTGRESDB_PASSWORD=password \
 -e WEBHOOK_URL=https://n8n.9level.com.br/ \
 -e GENERIC_TIMEZONE="America/Sao_Paulo" \
 -e TZ="America/Sao_Paulo" \ 
 -v n8n_data:/home/node/.n8n \
 docker.n8n.io/n8nio/n8n
```

Não precisa usar flags abaixo, elas servem só para mudar o endpoint "prod"  e "test" o mais importante é usar a variavel WEBHOOK_URL
```
 -e N8N_ENDPOINT_WEBHOOK=prod \
 -e N8N_ENDPOINT_WEBHOOK_TEST=test \
```


Manual:
https://docs.n8n.io/hosting/configuration/environment-variables/endpoints/
https://docs.n8n.io/hosting/configuration/environment-variables/
