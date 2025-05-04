# Configuração Vim para Desenvolvedores

Este repositório contém uma configuração completa do Vim otimizada para desenvolvimento de software, incluindo plugins avançados que transformam o Vim em um ambiente de desenvolvimento poderoso.

## Características

- **Visual aprimorado**: 
  - Numeração de linhas (absoluta e relativa)
  - Destaque da linha atual
  - Tema de cores Gruvbox otimizado para programação
  - Barra de status inteligente com informações contextuais

- **Suporte ao desenvolvimento**: 
  - Explorador de arquivos integrado
  - Autocompletar inteligente com o CoC.nvim (similar ao VSCode)
  - Verificação de sintaxe e linting em tempo real
  - Integração com Git
  - Fechamento automático de parênteses
  - Suporte a múltiplas linguagens de programação

- **Navegação eficiente**: 
  - Busca incremental e inteligente
  - Explorador de arquivos por árvore (NERDTree)
  - Navegação rápida entre arquivos

- **Indentação inteligente**: 
  - Configurada por tipo de arquivo
  - Adaptada para várias linguagens de programação

## A importância do Node.js nesta configuração

O Node.js é um componente essencial para esta configuração avançada do Vim, especialmente para o plugin CoC.nvim (Conquer of Completion). Entender sua função é importante:

### O que é o CoC.nvim e por que precisamos do Node.js?

O CoC.nvim é um sistema de autocompletar inteligente para o Vim, que funciona de maneira similar ao IntelliSense do Visual Studio Code. Ele fornece:

- **Autocompletação avançada** para dezenas de linguagens de programação
- **Exibição de erros e avisos** em tempo real enquanto você digita
- **Navegação inteligente** para definições, referências e implementações
- **Refatoração de código** e ações rápidas

O CoC.nvim é construído sobre o Language Server Protocol (LSP), a mesma tecnologia que o VS Code utiliza para fornecer recursos de IDE. O Node.js é necessário para:

1. **Executar o servidor LSP** que analisa seu código em tempo real
2. **Gerenciar extensões** específicas para cada linguagem
3. **Processar operações assíncronas** de análise e completação
4. **Comunicar-se com servidores de linguagem externos** (como Pylance para Python, tsserver para TypeScript, etc.)

Sem o Node.js, este sistema de autocompletação avançado não funcionaria, o que limitaria significativamente as capacidades do seu ambiente Vim.

## Instalação Passo a Passo

### 1. Configuração Básica

Primeiro, instale o Vim se ainda não estiver instalado:

```bash
# Debian/Ubuntu
sudo apt install vim

# Fedora/RHEL
sudo dnf install vim

# Arch Linux
sudo pacman -S vim

# Docker/Alpine
apk add vim
```

### 2. Instalar o Node.js

Esta é uma etapa crucial para o funcionamento completo da configuração, especialmente para o CoC.nvim:

#### Ubuntu/Debian:
```bash
# Adicionar repositório NodeSource
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -

# Instalar Node.js
sudo apt install -y nodejs

# Verificar a instalação
node --version
npm --version
```

#### Fedora/RHEL/CentOS:
```bash
# Adicionar repositório NodeSource
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -

# Instalar Node.js
sudo dnf install -y nodejs
# ou
sudo yum install -y nodejs

# Verificar a instalação
node --version
npm --version
```

#### Arch Linux:
```bash
# Instalar Node.js
sudo pacman -S nodejs npm

# Verificar a instalação
node --version
npm --version
```

#### Docker/Alpine:
```bash
# Instalar Node.js
apk add --update nodejs npm

# Verificar a instalação
node --version
npm --version
```

#### macOS (usando Homebrew):
```bash
# Instalar Node.js
brew install node

# Verificar a instalação
node --version
npm --version
```

### 3. Instalação do Gerenciador de Plugins

Instale o vim-plug, um gerenciador de plugins leve e poderoso:

```bash
# Para usuário normal
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Para o usuário root
curl -fLo /root/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### 4. Configuração do .vimrc

Crie ou substitua seu arquivo `.vimrc`:

```bash
# Para usuário normal
vim ~/.vimrc

# Para o usuário root
vim /root/.vimrc
```

Copie e cole a configuração fornecida no arquivo `.vimrc`.

### 5. Instalação dos Plugins

Abra o Vim e execute o comando para instalar os plugins:

```
:PlugInstall
```

Aguarde a instalação dos plugins. Quando terminar, reinicie o Vim.

### 6. Configuração do CoC.nvim

Após a instalação dos plugins, você precisará instalar extensões específicas para as linguagens que deseja usar. Dentro do Vim, execute:

```
:CocInstall coc-json coc-tsserver coc-html coc-css coc-python
```

Isso instalará suporte para JSON, TypeScript/JavaScript, HTML, CSS e Python. Você pode adicionar mais extensões conforme necessário.

## Plugins Incluídos

### Plugins Principais

- **Gruvbox**: Tema de cores ergonômico com excelente contraste
- **Vim-airline**: Barra de status informativa e elegante
- **NERDTree**: Explorador de arquivos em árvore (atalho: `<Espaço>f`)
- **Vim-gitgutter**: Mostra mudanças no Git na lateral do editor
- **Auto-pairs**: Fecha automaticamente parênteses, chaves e colchetes
- **ALE**: Verificação de sintaxe e linting em tempo real
- **Vim-fugitive**: Comandos Git integrados ao Vim
- **NERDCommenter**: Facilita a adição/remoção de comentários no código
- **Vim-polyglot**: Pacote com suporte a dezenas de linguagens

### Plugin de Destaque: CoC.nvim

O CoC.nvim (Conquer of Completion) é o principal diferencial desta configuração, transformando o Vim em um ambiente quase tão poderoso quanto IDEs modernas como o Visual Studio Code.

Benefícios do CoC.nvim:

- **Autocompletação inteligente**: Sugestões de código contextuais
- **Detecção de erros em tempo real**: Marcação de problemas enquanto você digita
- **Documentação inline**: Exibição de documentação ao passar o mouse sobre funções
- **Refatoração**: Renomeação de variáveis e funções de forma segura
- **Navegação de código**: Vá para definições, referências e implementações
- **Sistema de extensões**: Personalize o suporte para qualquer linguagem

## Solução de Problemas

### Erro "[coc.nvim] 'node' is not executable"

Este erro indica que o CoC.nvim não consegue encontrar o Node.js no seu sistema. Soluções:

1. **Verifique se o Node.js está instalado corretamente**:
   ```bash
   node --version
   ```

2. **Verifique se o Node.js está no PATH**:
   ```bash
   which node
   ```

3. **Configure o caminho do Node.js no Vim**:
   Adicione ao seu `.vimrc`:
   ```vim
   let g:coc_node_path = '/caminho/para/seu/node'
   ```

4. **Instale o Node.js** seguindo as instruções acima se ainda não tiver feito.

### Erro "E117: Função desconhecida: plug#begin"

Este erro indica que o vim-plug não foi instalado corretamente. Verifique:

1. Se o vim-plug foi instalado usando o comando curl fornecido
2. Se o diretório `~/.vim/autoload/` contém o arquivo `plug.vim`
3. Se há permissões de acesso ao diretório `.vim`

## Comandos e Atalhos Úteis

- `<Espaço>f`: Abre/fecha o explorador de arquivos (NERDTree)
- `<Espaço>n`: Remove o destaque de busca
- `<Ctrl-p>`: Busca rápida de arquivos (FZF)
- `gcc`: Comenta/descomenta a linha atual (NERDCommenter)
- `:Git`: Acessa comandos do Git (Fugitive)

### Atalhos específicos do CoC.nvim:

- `gd`: Vai para a definição
- `gy`: Vai para a implementação do tipo
- `gi`: Vai para a implementação
- `gr`: Mostra referências
- `K`: Mostra a documentação
- `<F2>`: Renomear símbolo
- `<Espaço>a`: Mostrar ações disponíveis no contexto atual

## Por que usar esta configuração com CoC.nvim?

1. **Produtividade significativamente maior**: O CoC.nvim traz recursos de IDE para o Vim, permitindo que você trabalhe mais rápido e com menos erros.

2. **Sistema unificado**: Em vez de vários plugins para completação, linting e navegação, o CoC.nvim unifica tudo em uma única interface consistente.

3. **Melhor suporte a linguagens modernas**: O CoC.nvim aproveita os mesmos servidores de linguagem usados por IDEs como VS Code, oferecendo suporte atualizado para as últimas versões de linguagens e frameworks.

4. **Flexibilidade**: Mantém a eficiência e leveza do Vim enquanto oferece funcionalidades avançadas quando necessário.

5. **Extensibilidade**: Sistema fácil de extensões que permite adicionar suporte para praticamente qualquer linguagem ou framework.

---

*Esta configuração é um equilíbrio perfeito entre a eficiência tradicional do Vim e as capacidades modernas de uma IDE completa, tornando-se ideal para desenvolvedores que desejam manter a produtividade em ambientes de terminal.*
