let mapleader = "\<Space>"

filetype off                  " required
set number                      " Display line numbers beside buffer
set hidden                      " Allow buffer change w/o saving
set lazyredraw                  " Don't update while executing macros
set scrolloff=4                 " Keep at least 4 lines below cursor
set noswapfile " Remove temporary swap file

set shortmess+=I " No intro when starting Vim
set cursorline " Highligt the cursor line

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'slim-template/vim-slim.git'
Plugin 'tpope/vim-fugitive'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'neomake/neomake'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdcommenter'
Plugin 'qpkorr/vim-bufkill'
Plugin 'Valloric/YouCompleteMe'
call vundle#end()            " required

autocmd! BufNewFile,BufRead Gemfile set filetype=ruby
let g:neomake_ruby_rubocop_maker = {'args' : ["--config", "/Users/youssef.boulkaid/Projects/style-guide/rubocop.yml"]}
let g:neomake_ruby_reek_maker = {'args' : ["-c", "/Users/youssef.boulkaid/Projects/style-guide/config.reek"]}
" Always show sign column
augroup setup_linter
  autocmd!
  autocmd BufWritePost * Neomake
  autocmd BufEnter * sign define dummy
  autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
augroup END

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

colorscheme blackboard

" Tab buffer switching
nmap <Tab> :bn<cr>
nmap <S-Tab> :bp<cr>

nmap <leader>w :BD<cr>

" Supertab
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
" Run ruby matchit
runtime macros/matchit.vim

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Remove trailing whitespace
autocmd FileType ruby,html,haml,slim,css,scss,sass,js,javascript autocmd BufWritePre <buffer> %s/\s\+$//e

" Go to method definition
nmap <F12> :tag <C-R><C-W> <cr>

" Comment shortcut
nmap <leader>cc <plug>NERDCommenterToggle
let g:NERDSpaceDelims = 1

nmap <silent> <C-p> :GFiles<cr>
nmap <silent> <C-h> :History<cr>
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
map <leader>k :NERDTreeToggle<cr>
nmap <F10> :NERDTreeFind<cr>

" Leader F for search
map <leader>f :Ggrep 
