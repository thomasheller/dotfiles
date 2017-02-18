" .vimrc
" by Thomas Heller

" fast escape
inoremap jj <esc>

vnoremap Q gq

" map Ctrl+/ 
nnoremap  :nohlsearch<cr>

" assign function keys
"nnoremap <f1> :!!<cr>
nnoremap <f1> :up\|:GoBuild<cr>
nnoremap <f2> :up\|:GoTest<cr>
nnoremap <f3> :up<cr>
nnoremap <f4> :q<cr>
imap <f1> <esc><f3>
imap <f2> <esc><f2>
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

set shell=zsh
" Load aliases etc. when using Zsh from Vim:
" A better solution would be to split the config in ~/.zshenv,
" ~/.zshrc and ~/.zprofile / ~/.zlogin because this breaks things.
" set shellcmdflag+=i

" edit and load dotfiles
cab .v sp ~/dotfiles/vimrc
cab .z sp ~/dotfiles/zshrc
cab .s sp ~/dotfiles/screenrc
cab .t sp ~/dotfiles/tmux.conf
cab src source ~/dotfiles/vimrc

" search in current file
command! -nargs=1 G vimgrep/<args>/ % | copen
" quickfix navigation:
nnoremap <C-j> :cnext<cr>
" nnoremap <C-k> :cprevious<cr> " conflicts with digraph mode

" useful programming abbreviations
iab cl class
iab fu function
iab ext extends
iab pu public
iab prot protected
iab priv private
iab ret return
ino ;f func  {<CR>}<Esc>kela
ino ;t func Test(t *testing.T) {<CR>}<Esc>kwwi

" Use netrw like NERDtree
" thanks to https://shapeshed.com/vim-netrw/
let g:netrw_banner = 0 " don't show the banner
let g:netrw_liststyle = 3 " tree style
let g:netrw_browse_split = 2 " open files in vertical split
let g:netrw_altv = 1 " left splitting
let g:netrw_winsize = 25
nmap <F12> :Lexplore<cr>

" folding
set foldmethod=syntax
set foldlevelstart=100 " high number to avoid folding on startup

" outline
nmap <F10> :TagbarToggle<cr>
let g:tagbar_sort = 0 " sort tags as they appear in the source (not by name)

" Golang tags configuration
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" auto-update on write in diff-mode
autocmd BufWritePost * if &diff == 1 | diffupdate | endif

" Plug plugins
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdcommenter'
Plug 'fatih/vim-go'
call plug#end()

nmap <leader>C <Plug>NERDCommenterToggle
vmap <leader>C <Plug>NERDCommenterToggle

" Google search using vim-g
nmap <leader>G viw:Google<cr>
vmap <leader>G :Google<cr>

if exists("pathogen#infect()")
  execute pathogen#infect()
endif

colorscheme ron
syntax on

