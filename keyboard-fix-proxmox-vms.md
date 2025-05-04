# Configuração de Locale e Teclado em Servidores Linux (Modo Console)

> **IMPORTANTE**: Este guia é destinado especificamente para servidores Linux em modo console exemplo: "tty1" (sem interface gráfica). Os procedimentos aqui descritos são particularmente úteis para administradores de sistemas que trabalham diretamente no console de servidores, VMs no Proxmox ou outros ambientes sem GUI linux.
> O problema enfrentando foi em um Ubuntu 24.04.2 LTS \n \l 

## 1. Configuração do Locale (pt_BR)

### Editando o arquivo de locale

1. Abra o arquivo de locale:
   ```bash
   sudo nano /etc/default/locale
   # ou com qualquer editor de sua preferência
   ```

2. Altere a linha:
   ```
   LANG=pt_PT.UTF-8
   ```
   
   Para:
   ```
   LANG=pt_BR.UTF-8
   ```

3. Se necessário, adicione também:
   ```
   LC_ALL=pt_BR.UTF-8
   ```

4. Salve o arquivo e saia do editor.

5. Após a edição, gere o locale e atualize:
   ```bash
   sudo locale-gen pt_BR.UTF-8
   sudo update-locale
   ```

6. Reinicie o sistema ou a sessão para aplicar as mudanças:
   ```bash
   sudo reboot
   ```

7. Verifique se a configuração foi aplicada:
   ```bash
   locale
   # ou
   echo $LANG
   ```

## 2. Configuração do Teclado

### Editando o arquivo de configuração do teclado

1. Abra o arquivo de configuração do teclado:
   ```bash
   sudo nano /etc/default/keyboard
   # ou com qualquer editor de sua preferência
   ```

2. Configure para teclado brasileiro ABNT2:
   ```
   XKBMODEL="abnt2"
   XKBLAYOUT="br"
   XKBVARIANT="abnt2"
   XKBOPTIONS=""
   BACKSPACE="guess"
   ```

   Ou para teclado americano:
   ```
   XKBMODEL="pc105"
   XKBLAYOUT="us"
   XKBVARIANT=""
   XKBOPTIONS=""
   BACKSPACE="guess"
   ```

3. Salve o arquivo e saia do editor.

4. Aplique as alterações:
   ```bash
   sudo setupcon
   ```
   ou
   ```bash
   sudo service keyboard-setup restart
   ```

## 3. Instalação de Pacotes Necessários

Em alguns casos, pode ser necessário instalar pacotes adicionais:

```bash
sudo apt-get update
sudo apt-get install console-setup keyboard-configuration
```

Após a instalação, reconfigure o teclado:

```bash
sudo dpkg-reconfigure keyboard-configuration
```

## 4. Resolução de Problemas Comuns

### Problema: Configuração do teclado não está sendo aplicada

Solução:
```bash
# Reinstale os pacotes
sudo apt-get install --reinstall console-setup keyboard-configuration

# Reconfigure
sudo dpkg-reconfigure console-setup
sudo dpkg-reconfigure keyboard-configuration
```

### Problema: Comandos como "loadkeys" não funcionam

Solução:
```bash
# Instale o pacote kbd
sudo apt-get install kbd

# Depois tente
sudo loadkeys br-abnt2
# ou
sudo loadkeys us
```

### Problema: Caracteres especiais não funcionam no console

Verifique se o codeset está configurado corretamente em `/etc/default/console-setup`:

```
CODESET="Lat15"
```

## 5. Configurações Específicas para Ambientes Virtualizados

### Para VMs no Proxmox:

1. No arquivo de configuração da VM no Proxmox (`/etc/pve/qemu-server/VMID.conf`), adicione:
   ```
   args: -k br
   # ou
   args: -k us
   ```

2. Reinicie a VM para aplicar as alterações.

---

## Dicas para Edição de Arquivos de Configuração

1. Sempre faça backup antes de editar arquivos de sistema:
   ```bash
   sudo cp /etc/default/keyboard /etc/default/keyboard.bak
   ```

2. Se algo der errado, você pode restaurar o backup:
   ```bash
   sudo cp /etc/default/keyboard.bak /etc/default/keyboard
   ```

3. Tenha cuidado com a sintaxe - observe espaços e aspas nos arquivos de configuração.

4. Após editar arquivos de configuração, é recomendável reiniciar o sistema ou o serviço relacionado para aplicar as alterações.

---

Com essas configurações, seu sistema deve reconhecer corretamente o idioma português brasileiro e o layout de teclado no ambiente de console sem interface gráfica.
