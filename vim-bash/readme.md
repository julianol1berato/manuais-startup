# Halcyon para Vim

Uma adaptação do tema Halcyon para o Vim, oferecendo uma experiência visual elegante com um esquema de cores azul escuro para desenvolvimento.

![Exemplo do Vim](https://github.com/julianol1berato/manuais-startup/raw/main/vim-bash/vim1.png)

## Sobre o Tema

Halcyon é um tema minimalista azul escuro, originalmente desenvolvido por [Brittany Chiang](https://github.com/bchiang7) para VSCode e outros editores. Esta adaptação traz a elegância e a funcionalidade desse tema para o Vim tradicional.

O tema é otimizado para:
- Desenvolvimento de código com destaque de sintaxe aprimorado
- Redução da fadiga visual em longas sessões de codificação
- Visual moderno e limpo com bom contraste

## Recursos

- **Interface aprimorada**: Destaque de linha atual, números de linha estilizados, e barra de status personalizada
- **Suporte a plugins populares**: NERDTree, vim-airline, ALE, Git Gutter e mais
- **Otimizado para performance**: Configurações para evitar problemas comuns de renderização
- **Compatibilidade com Coc.nvim**: Autocompletação inteligente com suporte a LSP
- **Suporte a múltiplas linguagens**: Configurações específicas para diferentes tipos de arquivos

## Instalação

### Pré-requisitos

- Vim 8.0+ ou Neovim
- Terminal com suporte a cores de 24 bits (True Color)
- Node.js (para o plugin Coc.nvim)

### Configuração básica

1. **Instale o gerenciador de plugins vim-plug**:
   ```bash
   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   ```

2. **Crie o diretório para o tema**:
   ```bash
   mkdir -p ~/.vim/colors
   ```

3. **Baixe o arquivo de tema**:
   ```bash
   # Crie o arquivo halcyon.vim em ~/.vim/colors/
   # com o conteúdo do arquivo de tema
   ```

4. **Use o arquivo .vimrc deste repositório**:
   ```bash
   curl -fLo ~/.vimrc --create-dirs \
       https://raw.githubusercontent.com/julianol1berato/manuais-startup/main/vim-bash/.vimrc
   ```

5. **Instale os plugins**:
   Abra o Vim e execute:
   ```
   :PlugInstall
   ```

### Instalação manual

Alternativamente, você pode clonar este repositório:

```bash
git clone https://github.com/julianol1berato/manuais-startup.git
cd manuais-startup/vim-bash
cp .vimrc ~/.vimrc
# Copie também o arquivo halcyon.vim para ~/.vim/colors/
```

## Resolução de Problemas

### O tema não está sendo aplicado corretamente

Verifique se seu terminal suporta cores de 24 bits:
```bash
echo $TERM
```

Se você estiver usando tmux, adicione ao seu `.tmux.conf`:
```
set -g default-terminal "screen-256color"
set-option -ga terminal-overrides ",xterm-256color:Tc"
```

### Problemas de renderização (tela preta parcial)

Se você notar partes da tela ficando pretas durante a rolagem, tente:
1. Pressionar `<Espaço>r` para forçar o redesenho da tela
2. Verificar se as configurações de performance no `.vimrc` estão ativas
3. Desativar temporariamente o `cursorline` com `:set nocursorline`

### Erro no tema do Airline

Se você encontrar erros relacionados ao tema do Airline, certifique-se de que o plugin `vim-airline-themes` está instalado.

## Personalização

Você pode ajustar o tema Halcyon modificando o arquivo `~/.vim/colors/halcyon.vim`. Algumas sugestões de personalização:

- Alterar cores de destaque: Modifique as variáveis de cores no início do arquivo
- Ajustar a coloração da interface: Edite as definições de `highlight` para os grupos desejados
- Personalizar o vim-airline: Experimente diferentes temas com `let g:airline_theme='...'`

## Inspiração e Créditos

- [Tema Halcyon original](https://github.com/bchiang7/halcyon-vscode) por Brittany Chiang
- [Halcyon para iTerm2](https://github.com/bchiang7/halcyon-iterm) por Brittany Chiang
- [halcyon-neovim](https://github.com/kwsp/halcyon-neovim) - Adaptação para Neovim

## Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests para melhorar este tema.

## Licença

MIT License
