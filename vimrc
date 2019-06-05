let mapleader = "\<Space>"

set clipboard=unnamed
language en_US

augroup ft_rb
  au!
  " fix the SLOOOW syntax highlighting
  " http://stackoverflow.com/questions/16902317/vim-slow-with-ruby-syntax-highlighting
  au FileType ruby setlocal re=1 foldmethod=manual
augroup END

autocmd VimResized * :wincmd =

set hidden                      " Allow buffer change w/o saving
set lazyredraw                  " Don't update while executing macros
set scrolloff=4                 " Keep at least 4 lines below cursor
set noswapfile " Remove temporary swap file

set title

set shortmess+=I " No intro when starting Vim
set cursorline " Highligt the cursor line

let g:loaded_python_provider=1

call plug#begin('~/.vim/plugged')
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'neomake/neomake'
  Plug 'MarcWeber/vim-addon-mw-utils'
  Plug 'tomtom/tlib_vim'
  Plug 'qpkorr/vim-bufkill'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'Townk/vim-autoclose'
  Plug 'mileszs/ack.vim'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-repeat'
  Plug 'junegunn/vim-easy-align'
  " Plug 'machakann/vim-swap'
  " Plug 'godlygeek/tabular'
  Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }

  " Snippets
  Plug 'garbas/vim-snipmate'
  Plug 'honza/vim-snippets'
  Plug 'Shougo/neosnippet.vim'
  Plug 'Shougo/neosnippet-snippets'

  " Interface
  " Plug 'romainl/vim-qf'
  Plug 'scrooloose/nerdtree'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'ap/vim-css-color'
  Plug 'wesQ3/vim-windowswap'
  Plug 'vimtaku/hl_matchit.vim'
  Plug 'machakann/vim-highlightedyank'

  " Tmux magic
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'christoomey/vim-tmux-runner'

  " Ruby dev
  Plug 'tpope/vim-rails'
  Plug 'thoughtbot/vim-rspec'

  " Text objects
  Plug 'kana/vim-textobj-user'
  Plug 'nelstrom/vim-textobj-rubyblock'
  Plug 'kana/vim-textobj-line'

  " Motions
  " Plug 'easymotion/vim-easymotion'
  Plug 'vim-scripts/ReplaceWithRegister'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'

  " Syntax
  " Plug 'gabrielelana/vim-markdown'
  Plug 'kchmck/vim-coffee-script'
  Plug 'slim-template/vim-slim'
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
  Plug 'cakebaker/scss-syntax.vim'
  Plug 'vim-ruby/vim-ruby'
  Plug 'robbles/logstash.vim'
  Plug 'chr4/nginx.vim'
  Plug 'jparise/vim-graphql'
  " Plug 'pedrohdz/vim-yaml-folds'

  " Writing
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'
call plug#end()

" Enable jsx highlighting on regular js files
let g:jsx_ext_required = 0

" Set the column limit
set colorcolumn=100

" Don't use ! as a word delimiter
set iskeyword+=!
set iskeyword+=?
" au Filetype slim set iskeyword-=_

autocmd! BufNewFile,BufRead Gemfile set filetype=ruby
autocmd filetype crontab setlocal nobackup nowritebackup
let g:neomake_slim_slimlint_maker = {
      \ 'exe': 'slim-lint',
      \ 'errorformat': '%f:%l [%t] %m'
      \ }
let g:neomake_scss_sasslint_maker = {
      \ 'exe': 'sass-lint',
      \ 'args': ['--no-exit', '--verbose', '--format', 'compact'],
      \ 'errorformat': neomake#makers#ft#javascript#eslint()['errorformat']
      \ }
let g:neomake_javascript_eslint_maker = {
    \ 'exe': 'eslint',
    \ 'args': ['--no-color','--format', 'compact'],
    \ 'errorformat': '%f: line %l\, col %c\, %m'
    \ }

let g:neomake_coffee_coffeelint_maker = {
    \ 'exe': 'coffeelint',
    \ 'args': ['--reporter', 'csv'],
    \ 'errorformat': '%f\,%l\,%\d%#\,%trror\,%m,%f\,%l\,%trror\,%m,%f\,%l\,%\d%#\,%tarn\,%m,%f\,%l\,%tarn\,%m'
    \ }

let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']
let g:neomake_scss_enabled_makers = ['sasslint']
let g:neomake_coffee_enabled_makers = ['coffeelint']
let g:neomake_slim_enabled_makers = ['slimlint']
let g:neomake_ruby_enabled_makers = ['rubocop']

" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 1s; no delay when writing).
call neomake#configure#automake('nrwi', 500)

let g:neomake_virtualtext_current_error = 0

" Always show sign column
augroup setup_linter
  autocmd!
  autocmd BufEnter * sign define dummy
  autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
augroup END

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

colorscheme blackboard
nmap ¶ :colorscheme morning <bar> :AirlineTheme papercolor<CR>
nmap © :colorscheme blackboard <bar> :AirlineTheme bubblegum<CR>

" Relative numbering
" set relativenumber
set number

" Tab buffer switching
nmap <Tab> :bn<cr>
nmap <S-Tab> :bp<cr>

" Insert new lines above or below the cursor
nnoremap <silent> √ :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent> ª :set paste<CR>m`O<Esc>``:set nopaste<CR>

" Paste on newlines with å
:nmap å :pu<CR>==

" Bubble lines : http://vimcasts.org/episodes/bubbling-text/
nmap º [e
nmap ¬ ]e

vmap º [egv
vmap ¬ ]egv

" Show the command while typing it
set showcmd

" Airline config
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1

let g:airline_section_y = '%{fnamemodify(getcwd(), ":t")}'
let g:airline_section_z = '%l'

" Enable top buffer list line
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_highlighting_cache = 1

" Alt + w to close the buffer
nmap Ω :BD!<cr>

" Alt + w to close the buffer and window
nmap Q :q<cr>

" Solargraph / LanguageClient
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
let g:LanguageClient_serverCommands = {
    \ 'ruby': ['solargraph', 'stdio'],
    \ }

" Run deoplete
let g:deoplete#enable_at_startup = 0
autocmd InsertEnter * call deoplete#enable()
let g:deoplete#max_list = 10

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-Y><C-c>" : "\<CR>"

" Don't press escape key twice to quit insert mode https://github.com/Shougo/deoplete.nvim/issues/386
let g:AutoClosePumvisible = {"ENTER": "<C-Y>", "ESC": "<ESC>"}

" Disable CTags source
call deoplete#custom#option('ignore_sources', {'_': ['tag']})

" Plugin key-mappings.
imap <C-e> <Plug>(neosnippet_expand_or_jump)
smap <C-e> <Plug>(neosnippet_expand_or_jump)
xmap <C-e> <Plug>(neosnippet_expand_target)

" Snippets config
let g:neosnippet#enable_snipmate_compatibility = 1

" Run ruby matchit
runtime macros/matchit.vim
let g:hl_matchit_enable_on_vim_startup = 1
let g:hl_matchit_speed_level = 1
let g:hl_matchit_hl_groupname = 'Underlined'

" Set python preference
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

" Setup VTR and vim-rspec
augroup setup_vtr
  au!
  autocmd Filetype ruby call VtrForRuby()
  autocmd Filetype python call VtrForPython()
augroup END

function! VtrForRuby()
  let g:rspec_command = "VtrSendCommand! bin/rspec {spec}"
  " let g:rspec_command = "VtrSendCommand! be rspec {spec}"
  map <Leader>t :call RunCurrentSpecFile()<CR>
  map <Leader>s :call RunNearestSpec()<CR>
  map <Leader>r :call RunLastSpec()<CR>
endfunction

function! VtrForPython()
  map <Leader>t :VtrSendFile!<CR>
  let g:VtrStripLeadingWhitespace = 0
  let g:VtrClearEmptyLines = 0
  let g:VtrAppendNewline = 1
endfunction

map <Leader>vtr :VtrOpenRunner<cr>
map <Leader>kvtr :VtrKillRunner<cr>
map <leader>b :VtrSendLinesToRunner<cr>
map <leader>B :VtrSendFile!<cr>

" redraws the screen and removes any search highlighting.
nnoremap <silent> <leader>l :noh<CR>

" V split
nmap <Leader>. :vsplit<cr>
nmap <Leader>- :split<cr>

" redraw the screen with alt-L
nmap ﬁ :redraw!

" Remove trailing whitespace
autocmd FileType yaml,ruby,html,haml,slim,css,scss,sass,js,javascript,vim,yml autocmd BufWritePre <buffer> %s/\s\+$//e

" Go to method definition
nmap <F12> :tag <C-R><C-W> <cr>

" Comment a line shortcut
nmap <C-c> gcil

" Ctrl-P for Fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden -g ""'
nmap <silent> <C-p> :Files<cr>
nmap <silent> <leader>p :Buffers<cr>

" More natural splits
" https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright

" Quickfix window
nmap <leader>x <Plug>QfCtoggle
" nmap [ <Plug>QfCnext
" nmap ] <Plug>QfCprevious

" Remap öä to []
nmap ö [
nmap ä ]
omap ö [
omap ä ]
xmap ö [
xmap ä ]

nmap zz za
" Navigate between ruby methods with leader-m/n
" map <leader>M [m
" map <leader>N [M
" map <leader>m ]m
" map <leader>n ]M

" Move up and down by visible lines if current line is wrapped
nmap j gj
nmap k gk

" Faster movement (https://news.ycombinator.com/item?id=12643887)
nnoremap J 7j
nnoremap K 7k
vnoremap J 7j
vnoremap K 7k

" Alt-S to save
nmap ß :w<cr>


" https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Sane defaults for searching
set ignorecase
set smartcase
set gdefault

" Split edit your vimrc. Type space, v, r in sequence to trigger
nmap <leader>vr :e ~/.vimrc<cr>

" Auto source vimrc on save
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" Open explorer
map <leader>, :NERDTreeToggle<cr>
nmap <F10> :NERDTreeFind<cr>

" Show hidden files in nerdtree
let NERDTreeShowHidden=1

" Close vim when only nerdtree is left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Leader F and C-f for search
map <leader>f :Ag<cr>
nmap <C-f> :Ag<cr>
let g:ackprg = 'ag --vimgrep'

" Refresh syntax with alt + L
nmap <silent> ﬁ :syntax on<cr>

" Alt+c copies the word in the clipboard
nmap ç yiw

" C-x deletes the current line (like in sublime)
nmap <C-x> dd

" Live preview splitting in neovim
set icm=nosplit

" Enable mouse support
set mouse=a

" Github to master
map <leader>gh :Gbrowse<cr>

" Github to master
map <leader>ghm :Gbrowse master:%<cr>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Writing mode (markdown)

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

autocmd FileType markdown call deoplete#custom#buffer_option('auto_complete', v:false)
autocmd FileType markdown set linebreak
