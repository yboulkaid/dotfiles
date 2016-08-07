" Use the space key as our leader. Put this near the top of your vimrc
let mapleader = "\<Space>"

filetype off                  " required

" https://thoughtbot.com/upcase/videos/onramp-to-vim-configuration
set number                      " Display line numbers beside buffer
set nocompatible                " Don't maintain compatibilty with Vi.
set hidden                      " Allow buffer change w/o saving
set lazyredraw                  " Don't update while executing macros
set backspace=indent,eol,start  " Sane backspace behavior
set history=1000                " Remember last 1000 commands
set scrolloff=4                 " Keep at least 4 lines below cursor

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-sensible.git'
Plugin 'wincent/command-t'
Plugin 'slim-template/vim-slim.git'
Plugin 'tpope/vim-fugitive'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'scrooloose/syntastic'
call vundle#end()            " required
filetype plugin indent on    " required

autocmd BufNewFile,BufRead Gemfile set filetype=ruby

map <Esc>[B <Down>
set noswapfile " Remove temporary swap file

let g:netrw_chgwin=2 "Open files in new split
let g:netrw_altv=1 "Open new splits on the right

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

syntax on
colorscheme blackboard

" Run ruby matchit
runtime macros/matchit.vim

set paste
" Remove trailing whitespace
autocmd FileType ruby,html,haml,slim,css,scss,sass,js,javascript autocmd BufWritePre <buffer> %s/\s\+$//e

" Use esc to close commandT
let g:CommandTCancelMap = ['<ESC>', '<C-c>']
nmap <silent> <C-p> <Plug>(CommandT)
nmap <silent> <C-h> <Plug>(CommandTHistory)
nmap <silent> <C-b> :MBEFocus<cr>

autocmd QuickFixCmdPost *grep* cwindow
nmap ö :cn<cr>
nmap ä :cp<cr>
nmap <leader>x :ccl<cr>

" Move up and down by visible lines if current line is wrapped
nmap j gj
nmap k gk

" Split edit your vimrc. Type space, v, r in sequence to trigger
nmap <leader>vr :tabedit $MYVIMRC<cr>

" Source (reload) your vimrc. Type space, s, o in sequence to trigger
nmap <leader>so :source $MYVIMRC<cr>

" Open explorer
map <leader>k :Explore<cr>

" Leader F for search
map <leader>f :Ggrep 

" Syntastic default
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_ruby_checkers = ['rubocop', 'reek']
let g:syntastic_ruby_rubocop_exec = 'rubocop --config /Users/youssef.boulkaid/Projects/style-guide/rubocop.yml'
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
