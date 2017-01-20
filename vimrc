" .vimrc
" by Thomas Heller

" fast escape
inoremap jj <esc>

vnoremap Q gq

" map Ctrl+/ 
nnoremap  :nohlsearch<cr>

" assign function keys
"nnoremap <f1> :!!<cr>
nnoremap <f1> :!gofmt -w % && go run %<cr>
nnoremap <f3> :up<cr>
nnoremap <f4> :q<cr>
imap <f3> <esc><f3>
imap <f4> <esc><f4>
set pastetoggle=<f5>

" insert whitespace easily from normal mode
nnoremap <tab> i<tab><esc>
nnoremap <space> i<space><esc>
nnoremap <cr> O<esc>
nnoremap <c-r> O<esc>

" formatting
set textwidth=70

" search options
set hlsearch
set ignorecase
set smartcase

" indentation options
set autoindent
set smartindent
set shiftwidth=2

" edit and load dotfiles
cab .v sp ~/dotfiles/vimrc
cab .z sp ~/dotfiles/zshrc
cab .s sp ~/dotfiles/screenrc
cab src source ~/dotfiles/vimrc

" useful programming abbreviations
iab cl class
iab fu function
iab ext extends
iab pu public
iab prot protected
iab priv private
iab ret return

" Plug plugins
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdcommenter'
Plug 'fatih/vim-go'
call plug#end()

nmap <leader>C <Plug>NERDCommenterToggle
vmap <leader>C <Plug>NERDCommenterToggle
