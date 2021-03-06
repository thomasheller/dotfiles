" ~/.vim/vimrc

" KEY MAPPINGS {{{

" fast escape
inoremap jj <esc>

" fast formatting (as it used to be)
vnoremap Q gq

" cancel search on ctrl+/
nnoremap <silent>  :nohlsearch<cr>

" whitespace
nnoremap <tab> i<tab><esc>
nnoremap <space> i<space><esc>
nnoremap <cr> O<esc>

" use Zsh-like mapping for command line
cnoremap <c-a> <home>

" unmap dangerous commands
nnoremap ZZ <nop>
nnoremap ZQ <nop>

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

imap <f8> <esc><f8>
nnoremap <f8> :bd<cr>

" F10 = toggle netrw

let g:NetrwToggled=0
fu! ToggleNetrw()
	if g:NetrwToggled
		let i = bufnr("$")
		while (i >= 1)
			if (getbufvar(i, "&filetype") == "netrw")
				silent exe "bwipeout " . i
			endif
			let i-=1
		endwhile
		let g:NetrwToggled=0
	else
		let g:NetrwToggled=1
		Lexplore
	endif
endfu

nnoremap <silent> <f10> :call ToggleNetrw()<cr>

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
" set noexpandtab
set expandtab
set shiftwidth=2

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

autocmd BufNewFile,BufRead *.c,*.cpp,*.h,*.go,*.php,*.js,*.ts,*.java let b:commenter_prefix = '\/\/ '
autocmd BufNewFile,BufRead *.tex let b:commenter_prefix = '% '
autocmd BufNewFile,BufRead vimrc,*.vim let b:commenter_prefix = '" '

nnoremap <leader>c :s/^\(\s*\)/\1<c-r><c-r>=b:commenter_prefix<cr>/<cr>:nohlsearch<cr>:call histdel('/', -1)<cr>
vnoremap <leader>c :s/^\(\s*\)/\1<c-r><c-r>=b:commenter_prefix<cr>/<cr>:nohlsearch<cr>:call histdel('/', -1)<cr>

nnoremap <leader>C :s/^\(\s*\)<c-r><c-r>=b:commenter_prefix<cr>/\1/<cr>:nohlsearch<cr>:call histdel('/', -1)<cr>
vnoremap <leader>C :s/^\(\s*\)<c-r><c-r>=b:commenter_prefix<cr>/\1/<cr>:nohlsearch<cr>:call histdel('/', -1)<cr>

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

execute pathogen#infect()

filetype plugin indent on

set wildmenu
set wildmode=longest,list:full

" set number
set number relativenumber

" augroup numbertoggle
  " autocmd!
  " autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  " autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
" augroup END

set showcmd

set linebreak

nnoremap <leader>e mxF<lyiw`xa</><esc>PF<
imap <leader>e <esc><leader>ei
nnoremap <leader>E mxF<lyiw`xo</><esc>P`x
imap <leader>E <esc><leader>Eo

if stridx(system('hostname'), 'TH') >= 0
	set expandtab
        set shiftwidth=4
endif

nmap n /<CR>
nmap N ?<CR>

nnoremap <leader>r Y:r!<c-r>"<bs><cr>
nnoremap <leader>R Y:@"<cr>

nnoremap <f1> :Make<cr><cr>
imap <f1> <esc><f1>
autocmd BufNewFile,BufRead *.go set makeprg=go\ build
command -nargs=* Make make <args> | cwindow 10
nnoremap <c-n> :cnext<cr>
nnoremap <c-p> :cprevious<cr>


