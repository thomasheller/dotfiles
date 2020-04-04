" ~/.vim/vimrc

" KEY MAPPINGS {{{

" fast escape
inoremap jj <esc>

" fast formatting (as it used to be)
vnoremap Q gq

" cancel search on ctrl+/
nnoremap  :nohlsearch<cr>

" whitespace
nnoremap <tab> i<tab><esc>
nnoremap <space> i<space><esc>
nnoremap <cr> O<esc>

" use Zsh-like mapping for command line
cnoremap <c-a> <home>

" }}}

" FUNCION KEYS {{{

" F2 = edit next file
imap <f2> <esc><f2>
nnoremap <f2> :next<cr>

" F3 = save file if changed
imap <f3> <esc><f3>
nnoremap <f3> :up<cr>

" F4 = quit if not changed
imap <f4> <esc><f4>
nnoremap <f4> :q<cr>

" F5 = toggle paste mode
set pastetoggle=<f5>

" }}}

" OPTIONS {{{

" wrapping
set nowrap
" set textwidth=80

" clipboard
set clipboard=unnamedplus

" search options
set hlsearch
set ignorecase
set smartcase

" auto-indent
set autoindent
set smartindent
set noexpandtab

" status bar
set laststatus=2

" make ~ behave like an operator
set tildeop

" shell
set shell=zsh

" }}}

" COMMANDS {{{

" reload configuration
command! SRC source ~/.vim/vimrc

" edit dotfiles
command! A vsplit ~/.config/alacritty/alacritty.yml
command! B vsplit ~/.config/bspwm/bspwmrc
command! P vsplit ~/.config/polybar/config
command! S vsplit ~/.screenrc
command! SX vsplit ~/.config/sxhkd/sxhkdrc
command! T vsplit ~/.tmux.conf
command! V vsplit ~/.vim/vimrc
command! XI vsplit ~/.xinitrc
command! XM vsplit ~/.Xmodmap
command! Z vsplit ~/.zshrc
command! ZE vsplit ~/.zshenv

" execute line under cursor in shell
command! RUN .w !zsh

" execute line under cursor in Vim
command! EX execute getline('.')
"
" }}}

" SYNTAX HIGHLIGHTING {{{

colorscheme zellner
syntax on

" }}}

" COMMENTING {{{

let b:commenter_prefix = '# '

autocmd BufNewFile,BufRead *.c,*.cpp,*.go,*.php let b:commenter_prefix = '\/\/ '
autocmd BufNewFile,BufRead vimrc,*.vim let b:commenter_prefix = '" '

nnoremap <leader>c :s/^\(\s*\)/\1<c-r><c-r>=b:commenter_prefix<cr>/<cr>:nohlsearch<cr>
vnoremap <leader>c :s/^\(\s*\)/\1<c-r><c-r>=b:commenter_prefix<cr>/<cr>:nohlsearch<cr>

nnoremap <leader>C :s/^\(\s*\)<c-r><c-r>=b:commenter_prefix<cr>/\1/<cr>:nohlsearch<cr>
vnoremap <leader>C :s/^\(\s*\)<c-r><c-r>=b:commenter_prefix<cr>/\1/<cr>:nohlsearch<cr>

" }}}

" TODO

set foldmethod=indent
set foldlevel=100

autocmd BufNewFile,BufRead */.config/polybar/config,polybar set filetype=dosini

autocmd BufNewFile,BufRead *.ts set filetype=javascript

autocmd BufNewFile,BufRead .zshenv,.zshrc,vimrc set foldmethod=marker foldlevel=0

autocmd BufNewFile,BufRead *.htm,*.html,*.phtml filetype indent on
autocmd BufNewFile,BufRead *.htm,*.html,*.phtml set filetype=html

autocmd BufNewFile,BufRead *.sh,.zshenv,.zshrc filetype indent on
autocmd BufNewFile,BufRead *.sh,.zshenv,.zshrc set filetype=sh

let g:go_fmt_command = "goimports"

filetype plugin indent on

set wildmenu
set wildmode=longest,list:full

