# Guia para Configuração de Locale e Teclado no Linux com Vim

## 1. Configuração do Locale (pt_BR)

### Editando o arquivo de locale

1. Abra o arquivo de locale com vim:
   ```bash
   sudo vim /etc/default/locale
   ```

2. Dentro do vim, pressione `i` para entrar no modo de inserção.

3. Altere a linha:
   ```
   LANG=pt_PT.UTF-8
   ```
   
   Para:
   ```
   LANG=pt_BR.UTF-8
   ```

4. Se necessário, adicione também:
   ```
   LC_ALL=pt_BR.UTF-8
   ```

5. Para salvar e sair:
   - Pressione `Esc` para sair do modo de inserção
   - Digite `:wq` e pressione `Enter`

6. Após a edição, gere o locale e atualize:
   ```bash
   sudo locale-gen pt_BR.UTF-8
   sudo update-locale
   ```

7. Reinicie o sistema ou a sessão para aplicar as mudanças:
   ```bash
   sudo reboot
   ```

## 2. Configuração do Teclado

### Editando o arquivo de configuração do teclado

1. Abra o arquivo de configuração do teclado:
   ```bash
   sudo vim /etc/default/keyboard
   ```

2. Pressione `i` para entrar no modo de inserção.

3. Configure para teclado brasileiro ABNT2:
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

4. Para salvar e sair:
   - Pressione `Esc` para sair do modo de inserção
   - Digite `:wq` e pressione `Enter`

5. Aplique as alterações:
   ```bash
   sudo setupcon
   ```
   ou
   ```bash
   sudo service keyboard-setup restart
   ```

## 3. Ediçãop dos arquivos de configuração de keyboard com VIM

### Dicas para Edição de Arquivos de Configuração

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

Com essas configurações, seu sistema deve reconhecer corretamente o idioma português brasileiro e o layout de teclado ABNT2.
