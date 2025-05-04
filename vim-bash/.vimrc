" Configuração Vim para Desenvolvedores
" ====================================

" Configurações básicas
set nocompatible
syntax on
set number
set relativenumber
set ruler
set cursorline
set showcmd
set showmatch
set incsearch
set hlsearch
set ignorecase
set smartcase
set wildmenu
set wildmode=list:longest
set backspace=indent,eol,start
set laststatus=2
set encoding=utf-8

" Indentação
set autoindent
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Interface
set termguicolors
set background=dark
set scrolloff=3
set sidescrolloff=5

" Performance e renderização
set ttyfast
set nolazyredraw
set ttyscroll=3
set sidescroll=1
set scrolljump=5
set redrawtime=10000

" Plugin management - vim-plug
call plug#begin('~/.vim/plugged')

" Interface e visual
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'

" Desenvolvimento
Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdcommenter'
Plug 'sheerun/vim-polyglot'

call plug#end()

" Tema e cores
colorscheme halcyon
let g:airline_theme='base16_oceanicnext'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1

" Compatibilidade com cores do terminal
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Ajustes de compatibilidade de cores
highlight CursorLine ctermbg=236 guibg=#2f3b54
highlight CursorLineNr term=bold cterm=bold ctermfg=012 gui=bold guifg=#5ccfe6

" Mapeamentos de teclas
let mapleader = " "
nnoremap <leader>f :NERDTreeToggle<CR>
nnoremap <leader>n :nohl<CR>
nnoremap <C-p> :FZF<CR>
nnoremap <leader>r :redraw!<CR>

" Correção de problemas de renderização
augroup fix_redraw_issues
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * redraw!
  autocmd CursorHold * redraw!
augroup END

if &term =~ '256color'
  set t_ut=
endif

" Configurações do CoC.nvim
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Configurações específicas por linguagem
autocmd FileType javascript,typescript,html,css setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4

" Salva posição do cursor entre sessões
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
