# Terminal Bash Aprimorado para SysAdmin e Dev

Um conjunto de configurações para o Bash que torna o terminal Linux mais amigável e eficiente para administradores de sistemas e desenvolvedores, sem a necessidade de plugins complexos.

![Exemplo do Terminal]([https://via.placeholder.com/800x200?text=Exemplo+do+Terminal](https://github.com/julianol1berato/manuais-startup/blob/main/terminal-custom/terminal1.png))

## 🚀 Funcionalidades

- **Prompt informativo e colorido** mostrando:
  - Nome de usuário e hostname
  - Diretório atual
  - IP local da rede principal
  - Branch Git atual e status (✓/✗)
  - Carga do sistema
  - Data e hora atuais
- **Histórico de comandos aprimorado** com timestamps
- **Aliases úteis** para Git, Docker e operações de sistema
- **Funções práticas** para tarefas comuns
- **Autocompletion melhorado** e navegação inteligente

## ⚙️ Instalação

1. Faça backup do seu arquivo `.bashrc` atual:
   ```bash
   cp ~/.bashrc ~/.bashrc.backup
   ```

2. Clone este repositório ou baixe o arquivo `.bashrc`:
   ```bash
   git clone https://github.com/julianol1berato/terminal-custom
   ```

3. Copie o arquivo para seu diretório home:
   ```bash
   cp terminal-custom/.bashrc ~/.bashrc
   ```

4. Aplique as configurações:
   ```bash
   source ~/.bashrc
   ```

## 🔧 Personalização

### Ajustando a detecção de IP local

A função `get_local_ip()` foi projetada para mostrar apenas o IP da sua interface de rede principal, excluindo IPs de interfaces virtuais como Docker e VPNs. Se não estiver mostrando o IP correto, você pode ajustar os padrões no início da função:

```bash
# Abra o arquivo .bashrc:
nano ~/.bashrc

# Localize a função get_local_ip() e ajuste esses parâmetros:
VALID_INTERFACES="eth|en|wlan|wl|eno|enp"  # Adicione seus padrões de interfaces válidas
INVALID_PATTERNS="docker|veth|br-|tun|tap" # Adicione padrões a serem ignorados
```

### Alterando as cores do prompt

O prompt usa códigos ANSI para as cores. Para alterá-las, edite o arquivo `.bashrc` e localize a definição do `PS1`:

```bash
# Cores disponíveis (exemplos):
# \[\033[30m\] - Preto        \[\033[31m\] - Vermelho
# \[\033[32m\] - Verde        \[\033[33m\] - Amarelo
# \[\033[34m\] - Azul         \[\033[35m\] - Magenta
# \[\033[36m\] - Ciano        \[\033[37m\] - Branco
# \[\033[38;5;XXXm\] - Cores avançadas (substitua XXX pelo código da cor, 0-255)
```

### Adicionando novos aliases

Para adicionar mais aliases, você pode editar o arquivo `.bashrc` diretamente ou criar/editar um arquivo `.bash_aliases`:

```bash
# Criar ou editar .bash_aliases
nano ~/.bash_aliases

# Adicione seus aliases, por exemplo:
alias update='sudo apt update && sudo apt upgrade -y'
alias limpar='sudo apt autoremove && sudo apt autoclean'
```

## 📋 Comandos e Aliases Disponíveis

### Git

| Alias | Comando | Descrição |
|-------|---------|-----------|
| `gs`  | `git status` | Mostra o status dos arquivos |
| `gp`  | `git pull` | Obtém atualizações do repositório remoto |
| `gc`  | `git commit` | Registra alterações no repositório |
| `ga`  | `git add` | Adiciona arquivos para o próximo commit |
| `gd`  | `git diff` | Mostra mudanças entre commits |
| `gl`  | `git log --oneline --graph --decorate --all -n 15` | Mostra log de commits em formato gráfico |
| `gb`  | `git branch` | Lista branches |
| `gco` | `git checkout` | Alterna entre branches ou commits |
| `gf`  | `git fetch --all` | Busca atualizações de todos os remotes |

### Docker

| Alias | Comando | Descrição |
|-------|---------|-----------|
| `d`   | `docker` | Comando docker encurtado |
| `dc`  | `docker-compose` | Comando docker-compose encurtado |
| `dps` | `docker ps` | Lista containers em execução |
| `dpsa`| `docker ps -a` | Lista todos os containers |
| `di`  | `docker images` | Lista imagens |
| `dlog`| `docker logs -f` | Exibe logs de um container |
| `dex` | `docker exec -it` | Executa comandos em um container |
| `dclog` | `docker-compose logs -f --tail=100` | Exibe logs do compose |
| `dprune` | `docker system prune -a` | Remove recursos não utilizados |
| `dstop` | `docker stop $(docker ps -q)` | Para todos os containers |

### Sistema

| Alias | Comando | Descrição |
|-------|---------|-----------|
| `ll`  | `ls -alFh` | Lista detalhada de arquivos |
| `df`  | `df -h` | Uso de disco em formato legível |
| `free`| `free -h` | Uso de memória em formato legível |
| `myip`| `curl -s ipinfo.io/ip` | Mostra IP público |
| `localip` | `get_local_ip` | Mostra IP local da rede principal |
| `ports` | `netstat -tulanp` | Lista portas abertas |
| `ips` | `ip -c a` | Lista interfaces de rede com cores |

### Funções

| Função | Descrição |
|--------|-----------|
| `mcd diretório` | Cria e entra no diretório especificado |
| `extract arquivo` | Extrai arquivos compactados de vários formatos |
| `logwatch arquivo [padrão]` | Monitora arquivo de log com realce de erros |
| `bak arquivo` | Cria backup rápido de um arquivo (arquivo.bak) |
| `netcheck` | Verifica informações de rede (interfaces, portas, IP público, DNS) |

## 📝 Notas

- Esta configuração utiliza apenas recursos nativos do Bash, sem necessidade de plugins adicionais
- Requer Bash 4.0 ou superior
- Funciona melhor em terminais que suportam cores ANSI (a maioria dos terminais modernos)

## 🤝 Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para abrir um issue ou enviar um pull request.

## 📜 Licença

Este projeto está licenciado sob a licença MIT - veja o arquivo LICENSE para detalhes.
