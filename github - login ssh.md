# Git SSH: Configuração e Troubleshooting

## Problema: Porta Customizada Interferindo
```bash
ssh: connect to host github.com port 16001: Connection timed out
```

## Solução: Configurar SSH Corretamente

### 1. Verificar Config Atual
```bash
cat ~/.ssh/config | grep -A 5 github
```

### 2. Criar/Ajustar Configuração
```bash
nano ~/.ssh/config
```
```
Host github.com
  HostName github.com
  User git
  Port 22
  IdentityFile ~/.ssh/id_rsa
```

### 3. Testar Conexão
```bash
ssh -T git@github.com
# Deve retornar: Hi username! You've successfully authenticated...
```

## Gerenciando Remotes

### Adicionar Remote
```bash
git remote add origin git@github.com:usuario/repo.git
```

### Remover Remote
```bash
git remote remove origin
# ou
git remote rm origin
```

### Listar Remotes
```bash
git remote -v
```

### Mudar URL do Remote
```bash
# SSH para HTTPS
git remote set-url origin https://github.com/usuario/repo.git

# HTTPS para SSH
git remote set-url origin git@github.com:usuario/repo.git
```

## Primeiro Push

### 1. Criar Repo no GitHub (via web)
- Acesse github.com → New repository
- **NÃO** inicialize com README

### 2. Push Inicial
```bash
git branch -M main
git push -u origin main
```

## Alternativa: HTTPS ao invés de SSH

### Quando Usar
- Porta 22 bloqueada no firewall
- Problemas com chaves SSH
- Ambiente corporativo restritivo

### Como Usar
```bash
git remote add origin https://github.com/usuario/repo.git
git push -u origin main
```

### Autenticação HTTPS
```bash
# Token ao invés de senha (obrigatório desde 2021)
# Gere em: Settings → Developer settings → Personal access tokens
```

## Debug SSH

### Verbose Mode
```bash
ssh -vT git@github.com
```

### Especificar Chave
```bash
ssh -i ~/.ssh/id_rsa -T git@github.com
```

### Verificar Permissões
```bash
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
chmod 700 ~/.ssh
```
