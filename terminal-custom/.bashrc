# ~/.bashrc: executed by bash(1) for non-login shells.

[ -z "$PS1" ] && return

# ================ CONFIGURAÇÕES DE HISTÓRICO ================
HISTCONTROL=ignoredups:ignorespace
shopt -s checkwinsize
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=20000
# Adiciona timestamp ao histórico de comandos
HISTTIMEFORMAT="%d/%m/%y %T "

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# ================ CONFIGURAÇÕES DE CORES ================
# Sempre ativar prompt colorido
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# ================ FUNÇÕES ÚTEIS PARA O PROMPT ================
# Função para mostrar branch git atual
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Função para mostrar status do git com cores
parse_git_status() {
  local status=$(git status --porcelain 2>/dev/null)
  if [[ "$status" != "" ]]; then
    echo -e "\033[31m✘"  # Vermelho se houver alterações não commitadas
  else
    echo -e "\033[32m✔"  # Verde se estiver tudo commitado
  fi
}

# Função para mostrar IP local (evitando interfaces Docker e VPN)
# Fácil de ajustar: basta editar a variável VALID_INTERFACES ou INVALID_PATTERNS conforme necessário
get_local_ip() {
  # Padrões para interfaces válidas - ajuste conforme necessário
  # Exemplo: "eth|en|wl|wlan" para incluir ethernet, wlan, etc.
  VALID_INTERFACES="eth|en|wlan|wl|eno|enp"
  
  # Padrões para interfaces inválidas - ajuste conforme necessário
  # Exemplo: docker, bridge, virtual, tun, etc.
  INVALID_PATTERNS="docker|veth|br-|tun|tap|vmnet|virbr|vboxnet|lo"
  
  if command -v ip >/dev/null 2>&1; then
    # Usando 'ip' (mais comum em sistemas modernos)
    local ip_addr=$(ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v '127.0.0.1' | 
                   grep -E "^192\.168\.|^10\.|^172\.(1[6-9]|2[0-9]|3[0-1])\." | 
                   head -n 1)
    if [ -n "$ip_addr" ]; then
      echo -e "[$ip_addr]"
    else
      echo -e "[IP]"
    fi
  elif command -v ifconfig >/dev/null 2>&1; then
    # Backup usando 'ifconfig' (mais antigo)
    local ip_addr=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | 
                   grep -v '127.0.0.1' | awk '{print $2}' | 
                   grep -E "^192\.168\.|^10\.|^172\.(1[6-9]|2[0-9]|3[0-1])\." |
                   head -n 1)
    if [ -n "$ip_addr" ]; then
      echo -e "[$ip_addr]"
    else
      echo -e "[IP]"
    fi
  else
    # Fallback para hostname
    echo -e "[$(hostname -I | awk '{print $1}')]"
  fi
}

# Função para mostrar carga do sistema
system_load() {
  local lavg=$(uptime | awk -F 'load average:' '{print $2}' | cut -d, -f1 | sed 's/ //g')
  echo -e "[$lavg]"
}

# Função para mostrar data e hora atuais
current_datetime() {
  echo -e "$(date +"%d/%m %H:%M")"
}

# ================ CONFIGURAÇÃO DO PROMPT ================
if [ "$color_prompt" = yes ]; then
    # Prompt colorido avançado com git, IP local, carga e hora
    PS1='\n${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[\033[38;5;214m\]$(get_local_ip)\[\033[00m\] \[\033[38;5;226m\]$(parse_git_branch)\[\033[00m\] $(parse_git_status)\[\033[00m\] \[\033[38;5;81m\]$(system_load)\[\033[00m\] \[\033[38;5;135m\]$(current_datetime)\[\033[00m\]\n\[\033[38;5;196m\]➜\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# ================ ALIAS ÚTEIS ================
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alFh'  # Adicionado -h para exibir tamanhos legíveis
alias la='ls -A'
alias l='ls -CFh'   # Adicionado -h para exibir tamanhos legíveis

# ----- ALIASES PARA GIT -----
alias gs='git status'
alias gp='git pull'
alias gc='git commit'
alias ga='git add'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate --all -n 15'
alias gb='git branch'
alias gco='git checkout'
alias gf='git fetch --all'

# ----- ALIASES PARA DOCKER -----
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dlog='docker logs -f'
alias dex='docker exec -it'
alias dclog='docker-compose logs -f --tail=100'
alias dprune='docker system prune -a'
alias dstop='docker stop $(docker ps -q)'

# ----- ALIASES PARA SISTEMA -----
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias myip='curl -s ipinfo.io/ip'
alias localip='get_local_ip'
alias ports='netstat -tulanp'
alias meminfo='free -m -l -t'
alias htop='htop -d 5'  # Atualização a cada 5 segundos
alias pscpu='ps auxf | sort -nr -k 3 | head -10'  # Top 10 processos por CPU
alias psmem='ps auxf | sort -nr -k 4 | head -10'  # Top 10 processos por memória
alias ips='ip -c a'     # Lista todas as interfaces com cor
alias connections='netstat -tunapel'  # Mostra todas as conexões

# ----- FUNÇÕES ÚTEIS -----
# Criar e navegar para um diretório de uma vez
mcd() { mkdir -p "$1" && cd "$1"; }

# Extrair arquivos compactados de diferentes formatos
extract() {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "'$1' não pode ser extraído" ;;
    esac
  else
    echo "'$1' não é um arquivo válido"
  fi
}

# Monitorar arquivo de log com realce de erros
logwatch() {
  if [ -z "$1" ]; then
    echo "Uso: logwatch arquivo_log [padrão]"
    return 1
  fi
  
  if [ -z "$2" ]; then
    tail -f "$1" | awk '
      /error|fail|critical/i {print "\033[31m" $0 "\033[0m"; next}
      /warn|caution/i {print "\033[33m" $0 "\033[0m"; next}
      /success|info/i {print "\033[32m" $0 "\033[0m"; next}
      {print}
    '
  else
    tail -f "$1" | grep --line-buffered --color=always -i "$2"
  fi
}

# Backup rápido de arquivo
bak() { cp "$1"{,.bak}; echo "Backup de $1 criado como $1.bak"; }

# Verificação detalhada de rede
netcheck() {
  echo "====== INTERFACES DE REDE ======"
  ip -c a
  
  echo -e "\n====== PORTAS ABERTAS ======"
  netstat -tulanp 2>/dev/null | grep LISTEN | sort
  
  echo -e "\n====== IP PÚBLICO ======"
  curl -s ipinfo.io/ip
  
  echo -e "\n====== DNS ======"
  cat /etc/resolv.conf
}

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Ignorar case no autocomplete
bind "set completion-ignore-case on"

# Mostrar lista de completions na primeira tab
bind "set show-all-if-ambiguous on"

# ================ MELHORIAS DE NAVEGAÇÃO ================
# Auto-correção de erros no cd
shopt -s cdspell

# Melhorar a navegação entre diretórios
shopt -s autocd  # Digite apenas o nome do diretório para cd
