# Adicionando Usuários no Ntfy

Este projeto utiliza o `ntfy`, uma ferramenta de notificações, para gerenciar os usuários e suas permissões. Aqui está um guia para adicionar um novo usuário com privilégios de administrador.

## Comando: `ntfy user add`

O comando `ntfy user add` é usado para adicionar novos usuários ao sistema de notificações `ntfy`. Você pode especificar o nome do usuário e o papel que ele terá no sistema. 

### Exemplo de Uso

```bash
ntfy user add --role=admin julianol1berato
```

### Explicação dos Argumentos
- `--role=admin`: Este argumento define o papel (role) do usuário. No caso, o usuário será adicionado como administrador (admin), o que significa que ele terá permissões elevadas no sistema, incluindo a capacidade de gerenciar outros usuários, configurar notificações e outras operações administrativas.

- `julianol1berato`: Este é o nome de usuário que está sendo adicionado ao sistema. No exemplo, o nome de usuário é julianol1berato.

### Resultados Esperados
Após a execução do comando, o usuário julianoliberato será adicionado ao sistema ntfy com privilégios de administrador. Isso permitirá que ele execute comandos administrativos no ntfy.

### Verificação
Para garantir que o usuário foi adicionado corretamente, você pode listar os usuários do ntfy usando o comando:
```bash
ntfy user list
```
Isso exibirá uma lista de todos os usuários cadastrados e seus respectivos papéis.


