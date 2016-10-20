let mapleader = "\<Space>"
set clipboard=unnamed
language en_US

augroup ft_rb
  au!
  " fix the SLOOOW syntax highlighting
  " http://stackoverflow.com/questions/16902317/vim-slow-with-ruby-syntax-highlighting
  au FileType ruby setlocal re=1 foldmethod=manual
augroup END

set number                      " Display line numbers beside buffer
set hidden                      " Allow buffer change w/o saving
set lazyredraw                  " Don't update while executing macros
set scrolloff=4                 " Keep at least 4 lines below cursor
set noswapfile " Remove temporary swap file

set shortmess+=I " No intro when starting Vim
set cursorline " Highligt the cursor line

call plug#begin('~/.vim/plugged')
  Plug '/Users/youssef.boulkaid/.biosphere/spheres/bukowskis/homebrew/opt/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'neomake/neomake'
  Plug 'MarcWeber/vim-addon-mw-utils'
  Plug 'tomtom/tlib_vim'
  Plug 'garbas/vim-snipmate'
  Plug 'honza/vim-snippets'
  Plug 'qpkorr/vim-bufkill'
  Plug 'Shougo/deoplete.nvim'
  Plug 'Shougo/neosnippet.vim'
  Plug 'Shougo/neosnippet-snippets'
  Plug 'Townk/vim-autoclose'
  Plug 'mileszs/ack.vim'

  " Interface
  Plug 'romainl/vim-qf'
  Plug 'scrooloose/nerdtree'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " Ruby dev
  Plug 'tpope/vim-dispatch'
  Plug 'thoughtbot/vim-rspec'

  " Text objects
  Plug 'kana/vim-textobj-user'
  Plug 'nelstrom/vim-textobj-rubyblock'
  Plug 'kana/vim-textobj-line'

  " Motions
  Plug 'easymotion/vim-easymotion'
  Plug 'vim-scripts/ReplaceWithRegister'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'

  " Syntax
  Plug 'kchmck/vim-coffee-script'
  Plug 'yoppi/fluentd.vim'
  Plug 'cespare/vim-toml'
  Plug 'slim-template/vim-slim'
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
call plug#end()

" Enable jsx highlighting on regular js files
let g:jsx_ext_required = 0

" Set the column limit
set colorcolumn=100

" Auto reload files
set autoread
au CursorHold,CursorHoldI * checktime

autocmd! BufNewFile,BufRead Gemfile set filetype=ruby
let g:neomake_ruby_rubocop_maker = {'args' : ["--config", "/Users/youssef.boulkaid/Projects/style-guide/rubocop.yml"]}
let g:neomake_ruby_reek_maker = {'args' : ["-c", "/Users/youssef.boulkaid/Projects/style-guide/config.reek"]}
let g:neomake_javascript_enabled_makers = ['standard']
let g:neomake_jsx_enabled_makers = ['standard']
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

" Relative numbering
set relativenumber
set number

" Tab buffer switching
nmap <Tab> :bn<cr>
nmap <S-Tab> :bp<cr>

" Insert new lines above or below the cursor
nnoremap <silent> √ :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent> ª :set paste<CR>m`O<Esc>``:set nopaste<CR>

" Move lines up and down
nnoremap <silent> ¬ :m .+1<CR>==
nnoremap <silent> º :m .-2<CR>==

" Mini buff on top
" let g:miniBufExplBRSplit = 0

" Airline config
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1

let g:airline_section_y = ''
let g:airline_section_z = '%l'

" Enable top buffer list line
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Alt + w to close the buffer
nmap Ω :BD<cr>

" Run deoplete
let g:deoplete#enable_at_startup = 1

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-Y><C-c>" : "\<CR>"

" Run ruby matchit
runtime macros/matchit.vim

" Use spring to set up vim rspec
let g:rspec_command = "Dispatch bin/rspec {spec}"
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>r :call RunLastSpec()<CR>

" redraws the screen and removes any search highlighting.
nnoremap <silent> <leader>l :noh<CR>

" redraw the screen with alt-L
nmap ﬁ :redraw!

" Remove trailing whitespace
autocmd FileType ruby,html,haml,slim,css,scss,sass,js,javascript,vim autocmd BufWritePre <buffer> %s/\s\+$//e

" Go to method definition
nmap <F12> :tag <C-R><C-W> <cr>

" Comment a line shortcut
nmap <C-c> gcil

" Ctrl-P for Fzf
nmap <silent> <C-p> :GFiles<cr>

" Easier window switching
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" More natural splits
" https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright

" Quickfix window
nmap <leader>x <Plug>QfCtoggle
nmap ö <Plug>QfCnext
nmap ä <Plug>QfCprevious

" Navigate between ruby methods with leader-m/n
map <leader>M [m
map <leader>N [M
map <leader>m ]m
map <leader>n ]M

" Move up and down by visible lines if current line is wrapped
nmap j gj
nmap k gk

" Faster movement (https://news.ycombinator.com/item?id=12643887)
nnoremap J 7j
nnoremap K 7k
vnoremap J 7j
vnoremap K 7k

" https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Sane defaults for searching
set ignorecase
set smartcase
set gdefault

" Split edit your vimrc. Type space, v, r in sequence to trigger
nmap <leader>vr :tabedit $MYVIMRC<cr>

" Source (reload) your vimrc. Type space, s, o in sequence to trigger
nmap <leader>so :source $MYVIMRC<cr>

" Open explorer
map <leader>, :NERDTreeToggle<cr>
nmap <F10> :NERDTreeFind<cr>

" Leader F for search
map <leader>f :Ack ''<left>
let g:ackprg = 'ag --vimgrep'

" C-f for the search buffer
nmap <C-f> q/

" Plugin key-mappings.
imap <C-e> <Plug>(neosnippet_expand_or_jump)
smap <C-e> <Plug>(neosnippet_expand_or_jump)
xmap <C-e> <Plug>(neosnippet_expand_target)

" Refresh syntax with alt + L
nmap <silent> ﬁ :syntax on<cr>

" Alt+c copies the word in the clipboard
nmap ç yiw

" C-x deletes the current line (like in sublime)
nmap <C-x> dd

" leader-c changes current word
" nmap <leader>c ciw
