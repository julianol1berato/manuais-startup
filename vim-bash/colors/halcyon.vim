" Halcyon Vim Color Scheme
" Um tema azul escuro elegante para Vim
" Inspirado no tema Halcyon de Brittany Chiang

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "halcyon"

" Definindo as cores do tema Halcyon
" Paleta principal
let s:black       = "#1d2433"  " Fundo principal
let s:dark_blue   = "#2f3b54"  " Fundo secundário
let s:blue        = "#a2aabc"  " Texto principal
let s:light_blue  = "#d7dce2"  " Texto mais claro
let s:cyan        = "#5ccfe6"  " Destaque ciano
let s:green       = "#bae67e"  " Strings e valores
let s:purple      = "#c3a6ff"  " Keywords
let s:red         = "#ef6b73"  " Erros e importantes
let s:orange      = "#ffae57"  " Números e constantes
let s:yellow      = "#ffd580"  " Classes e tipos
let s:comment     = "#8695b7"  " Comentários

" Interface Vim
exe "hi! Normal"          . " guifg="  . s:blue        . " guibg=" . s:black       . " gui=NONE"
exe "hi! Cursor"          . " guifg=NONE guibg="        . s:cyan        . " gui=NONE"
exe "hi! CursorLine"      . " guifg=NONE guibg="        . s:dark_blue   . " gui=NONE"
exe "hi! LineNr"          . " guifg="   . s:comment     . " guibg="      . s:black       . " gui=NONE"
exe "hi! CursorLineNr"    . " guifg="   . s:cyan        . " guibg="      . s:dark_blue   . " gui=NONE"
exe "hi! ColorColumn"     . " guifg=NONE guibg="        . s:dark_blue   . " gui=NONE"
exe "hi! SignColumn"      . " guifg="   . s:blue        . " guibg="      . s:black       . " gui=NONE"

" Gutter
exe "hi! Folded"          . " guifg="   . s:comment     . " guibg="      . s:dark_blue   . " gui=NONE"
exe "hi! FoldColumn"      . " guifg="   . s:comment     . " guibg="      . s:black       . " gui=NONE"
exe "hi! GitGutterAdd"    . " guifg="   . s:green       . " guibg="      . s:black       . " gui=NONE"
exe "hi! GitGutterChange" . " guifg="   . s:yellow      . " guibg="      . s:black       . " gui=NONE"
exe "hi! GitGutterDelete" . " guifg="   . s:red         . " guibg="      . s:black       . " gui=NONE"

" Barras e menus
exe "hi! StatusLine"      . " guifg="   . s:blue        . " guibg="      . s:dark_blue   . " gui=NONE"
exe "hi! StatusLineNC"    . " guifg="   . s:comment     . " guibg="      . s:dark_blue   . " gui=NONE"
exe "hi! TabLine"         . " guifg="   . s:comment     . " guibg="      . s:dark_blue   . " gui=NONE"
exe "hi! TabLineFill"     . " guifg="   . s:blue        . " guibg="      . s:dark_blue   . " gui=NONE"
exe "hi! TabLineSel"      . " guifg="   . s:black       . " guibg="      . s:cyan        . " gui=NONE"
exe "hi! Pmenu"           . " guifg="   . s:blue        . " guibg="      . s:dark_blue   . " gui=NONE"
exe "hi! PmenuSel"        . " guifg="   . s:black       . " guibg="      . s:cyan        . " gui=NONE"
exe "hi! PmenuSbar"       . " guifg=NONE guibg="        . s:dark_blue   . " gui=NONE"
exe "hi! PmenuThumb"      . " guifg=NONE guibg="        . s:comment     . " gui=NONE"
exe "hi! VertSplit"       . " guifg="   . s:dark_blue   . " guibg="      . s:dark_blue   . " gui=NONE"

" Busca e seleção
exe "hi! Search"          . " guifg="   . s:black       . " guibg="      . s:yellow      . " gui=NONE"
exe "hi! IncSearch"       . " guifg="   . s:black       . " guibg="      . s:cyan        . " gui=NONE"
exe "hi! Visual"          . " guifg=NONE guibg="        . s:dark_blue   . " gui=NONE"
exe "hi! MatchParen"      . " guifg="   . s:cyan        . " guibg=NONE"                   . " gui=underline"

" Mensagens
exe "hi! ErrorMsg"        . " guifg="   . s:red         . " guibg=NONE"  . " gui=NONE"
exe "hi! WarningMsg"      . " guifg="   . s:orange      . " guibg=NONE"  . " gui=NONE"
exe "hi! ModeMsg"         . " guifg="   . s:green       . " guibg=NONE"  . " gui=NONE"
exe "hi! MoreMsg"         . " guifg="   . s:green       . " guibg=NONE"  . " gui=NONE"
exe "hi! Question"        . " guifg="   . s:green       . " guibg=NONE"  . " gui=NONE"
exe "hi! Directory"       . " guifg="   . s:cyan        . " guibg=NONE"  . " gui=NONE"
exe "hi! Title"           . " guifg="   . s:yellow      . " guibg=NONE"  . " gui=bold"
exe "hi! Todo"            . " guifg="   . s:yellow      . " guibg=NONE"  . " gui=bold"
exe "hi! Error"           . " guifg="   . s:red         . " guibg=NONE"  . " gui=NONE"

" Elementos invisíveis
exe "hi! NonText"         . " guifg="   . s:comment     . " guibg=NONE"  . " gui=NONE"
exe "hi! SpecialKey"      . " guifg="   . s:comment     . " guibg=NONE"  . " gui=NONE"
exe "hi! Whitespace"      . " guifg="   . s:comment     . " guibg=NONE"  . " gui=NONE"

" Elementos de sintaxe
exe "hi! Comment"         . " guifg="   . s:comment     . " guibg=NONE"  . " gui=italic"
exe "hi! Constant"        . " guifg="   . s:orange      . " guibg=NONE"  . " gui=NONE"
exe "hi! String"          . " guifg="   . s:green       . " guibg=NONE"  . " gui=NONE"
exe "hi! Character"       . " guifg="   . s:green       . " guibg=NONE"  . " gui=NONE"
exe "hi! Number"          . " guifg="   . s:orange      . " guibg=NONE"  . " gui=NONE"
exe "hi! Boolean"         . " guifg="   . s:orange      . " guibg=NONE"  . " gui=NONE"
exe "hi! Float"           . " guifg="   . s:orange      . " guibg=NONE"  . " gui=NONE"
exe "hi! Identifier"      . " guifg="   . s:red         . " guibg=NONE"  . " gui=NONE"
exe "hi! Function"        . " guifg="   . s:cyan        . " guibg=NONE"  . " gui=NONE"
exe "hi! Statement"       . " guifg="   . s:purple      . " guibg=NONE"  . " gui=NONE"
exe "hi! Conditional"     . " guifg="   . s:purple      . " guibg=NONE"  . " gui=NONE"
exe "hi! Repeat"          . " guifg="   . s:purple      . " guibg=NONE"  . " gui=NONE"
exe "hi! Label"           . " guifg="   . s:cyan        . " guibg=NONE"  . " gui=NONE"
exe "hi! Operator"        . " guifg="   . s:cyan        . " guibg=NONE"  . " gui=NONE"
exe "hi! Keyword"         . " guifg="   . s:purple      . " guibg=NONE"  . " gui=NONE"
exe "hi! Exception"       . " guifg="   . s:purple      . " guibg=NONE"  . " gui=NONE"
exe "hi! PreProc"         . " guifg="   . s:yellow      . " guibg=NONE"  . " gui=NONE"
exe "hi! Include"         . " guifg="   . s:purple      . " guibg=NONE"  . " gui=NONE"
exe "hi! Define"          . " guifg="   . s:purple      . " guibg=NONE"  . " gui=NONE"
exe "hi! Macro"           . " guifg="   . s:purple      . " guibg=NONE"  . " gui=NONE"
exe "hi! PreCondit"       . " guifg="   . s:yellow      . " guibg=NONE"  . " gui=NONE"
exe "hi! Type"            . " guifg="   . s:yellow      . " guibg=NONE"  . " gui=NONE"
exe "hi! StorageClass"    . " guifg="   . s:yellow      . " guibg=NONE"  . " gui=NONE"
exe "hi! Structure"       . " guifg="   . s:yellow      . " guibg=NONE"  . " gui=NONE"
exe "hi! Typedef"         . " guifg="   . s:yellow      . " guibg=NONE"  . " gui=NONE"
exe "hi! Special"         . " guifg="   . s:cyan        . " guibg=NONE"  . " gui=NONE"
exe "hi! SpecialChar"     . " guifg="   . s:orange      . " guibg=NONE"  . " gui=NONE"
exe "hi! Tag"             . " guifg="   . s:cyan        . " guibg=NONE"  . " gui=NONE"
exe "hi! Delimiter"       . " guifg="   . s:blue        . " guibg=NONE"  . " gui=NONE"
exe "hi! SpecialComment"  . " guifg="   . s:comment     . " guibg=NONE"  . " gui=italic"
exe "hi! Debug"           . " guifg="   . s:red         . " guibg=NONE"  . " gui=NONE"
exe "hi! Underlined"      . " guifg="   . s:cyan        . " guibg=NONE"  . " gui=underline"
exe "hi! Ignore"          . " guifg="   . s:blue        . " guibg=NONE"  . " gui=NONE"

" Marcadores diff
exe "hi! DiffAdd"         . " guifg="   . s:green       . " guibg="      . s:black       . " gui=NONE"
exe "hi! DiffChange"      . " guifg="   . s:yellow      . " guibg="      . s:black       . " gui=NONE"
exe "hi! DiffDelete"      . " guifg="   . s:red         . " guibg="      . s:black       . " gui=NONE"
exe "hi! DiffText"        . " guifg="   . s:cyan        . " guibg="      . s:black       . " gui=NONE"

" Configurações para NERDTree
exe "hi! NERDTreeFile"    . " guifg="   . s:blue        . " guibg=NONE"  . " gui=NONE"
exe "hi! NERDTreeDir"     . " guifg="   . s:cyan        . " guibg=NONE"  . " gui=NONE"
exe "hi! NERDTreeUp"      . " guifg="   . s:comment     . " guibg=NONE"  . " gui=NONE"
exe "hi! NERDTreeOpenable". " guifg="   . s:cyan        . " guibg=NONE"  . " gui=NONE"
exe "hi! NERDTreeClosable". " guifg="   . s:cyan        . " guibg=NONE"  . " gui=NONE"

" Configurações para vim-airline (se estiver usando)
if !exists('g:airline_theme_map')
  let g:airline_theme_map = {}
endif
let g:airline_theme_map['halcyon'] = 'oceanicnext'

" Configurações para ALE (linting)
exe "hi! ALEErrorSign"    . " guifg="   . s:red         . " guibg="      . s:black       . " gui=NONE"
exe "hi! ALEWarningSign"  . " guifg="   . s:orange      . " guibg="      . s:black       . " gui=NONE"
