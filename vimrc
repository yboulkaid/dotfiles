let mapleader = "\<Space>"

set confirm
set clipboard=unnamed
set termguicolors
language en_US

" augroup ft_rb
"   au!
"   " fix the SLOOOW syntax highlighting
"   " http://stackoverflow.com/questions/16902317/vim-slow-with-ruby-syntax-highlighting
"   au FileType ruby setlocal re=1 foldmethod=manual
" augroup END
" let g:ruby_path = '/Users/yboulkaid/.asdf/shims/ruby'

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
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'neomake/neomake'
  Plug 'qpkorr/vim-bufkill'
  Plug 'Shougo/deoplete.nvim', { 'do': ':TSUpdate' }
  Plug 'Townk/vim-autoclose'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-repeat'
  " Plug 'junegunn/vim-easy-align'
  " Plug 'kovisoft/slimv'
  Plug 'norcalli/nvim-colorizer.lua'

  " Snippets
  Plug 'honza/vim-snippets'
  Plug 'Shougo/neosnippet.vim'
  Plug 'Shougo/neosnippet-snippets'

  " Interface
  Plug 'scrooloose/nerdtree'
  " Plug 'vim-airline/vim-airline'
  " Plug 'vim-airline/vim-airline-themes'
  " Plug 'ap/vim-css-color'
  Plug 'machakann/vim-highlightedyank'
  Plug 'pbrisbin/vim-mkdir'
  Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
  Plug 'akinsho/nvim-bufferline.lua'
  Plug 'hoob3rt/lualine.nvim'
  Plug 'bfredl/nvim-miniyank'

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
  Plug 'vim-scripts/ReplaceWithRegister'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'andymass/vim-matchup'

  " Syntax
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'slim-template/vim-slim'
  " Plug 'pangloss/vim-javascript'
  " Plug 'mxw/vim-jsx'
  Plug 'cakebaker/scss-syntax.vim'
  " Plug 'vim-ruby/vim-ruby'
  " Plug 'leafgarland/typescript-vim'
  " Plug 'robbles/logstash.vim'
  " Plug 'chr4/nginx.vim'
  Plug 'jparise/vim-graphql'
  Plug 'vim-python/python-syntax'
  " Plug 'leafgarland/typescript-vim'
  " Plug 'peitalin/vim-jsx-typescript'
  " Plug 'elixir-editors/vim-elixir'

  Plug 'rafamadriz/neon', { 'branch': 'main' }
  Plug 'neovim/nvim-lspconfig'
call plug#end()

" Enable jsx highlighting on regular js files
let g:jsx_ext_required = 0

" Set the column limit
set colorcolumn=100

" Don't use ! as a word delimiter
set iskeyword+=!
set iskeyword+=?

autocmd! BufNewFile,BufRead Gemfile set filetype=ruby
autocmd filetype crontab setlocal nobackup nowritebackup
let g:neomake_slim_slimlint_maker = {
      \ 'exe': 'slim-lint',
      \ 'errorformat': '%f:%l [%t] %m'
      \ }
let g:neomake_javascript_eslint_maker = {
    \ 'exe': 'eslint',
    \ 'args': ['--no-color','--format', 'compact'],
    \ 'errorformat': '%f: line %l\, col %c\, %m'
    \ }

let g:neomake_ruby_rubocop_maker = {
    \ 'exe': 'bin/rubocop',
    \ 'args': ['--format', 'emacs', '--force-exclusion', '--display-cop-names'],
    \ 'errorformat': '%f:%l:%c: %t: %m,%E%f:%l: %m',
    \ 'postprocess': function('neomake#makers#ft#ruby#RubocopEntryProcess'),
    \ 'output_stream': 'stdout',
    \ }
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']
let g:neomake_slim_enabled_makers = ['slimlint']
let g:neomake_ruby_enabled_makers = ['rubocop']

" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 1s; no delay when writing).
call neomake#configure#automake('rw', 100)
let g:neomake_tempfile_dir = '/tmp/neomake'

let g:neomake_virtualtext_current_error = 0

" Always show sign column
set signcolumn=yes

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

colorscheme neon
" nmap <M-2> :colorscheme morning <bar> :AirlineTheme papercolor<CR>
" nmap <M-1> :colorscheme blackboard <bar> :AirlineTheme bubblegum<CR>

set number

" Tab buffer switching
nmap <Tab> :bn<cr>
nmap <S-Tab> :bp<cr>

" Insert new lines above or below the cursor
nnoremap <silent> <M-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent> <M-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" Paste on newlines with å
" :nmap å :pu<CR>==
:nmap <M-p> :pu<CR>==

" Bubble lines : http://vimcasts.org/episodes/bubbling-text/
nmap <M-K> [e
nmap <M-J> ]e

vmap <M-K> [egv
vmap <M-J> ]egv

" Show the command while typing it
set showcmd

" Airline config
" let g:airline_theme='bubblegum'
" let g:airline_powerline_fonts = 1

" let g:airline_section_y = '%{fnamemodify(getcwd(), ":t")}'
" let g:airline_section_z = '%l'

" Enable top buffer list line
" let g:airline#extensions#tabline#enabled = 1

" Show just the filename
" let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline_highlighting_cache = 1

" Alt + w to close the buffer
nmap <M-w> :BD!<cr>

" Q to close the buffer and window
nmap Q :q<cr>

" Don't show matchup in status line
let g:matchup_matchparen_offscreen = {}

" Run deoplete
let g:deoplete#enable_at_startup = 0
autocmd InsertEnter * call deoplete#enable()
call deoplete#custom#option('max_list', 5)

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
let g:neosnippet#snippets_directory = '~/Projects/yboulkaid/dotfiles/snippets'

" Set python preference
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" Setup VTR and vim-rspec
augroup setup_vtr
  au!
  autocmd Filetype ruby call VtrForRuby()
augroup END

function! VtrForRuby()
  let g:rspec_command = "VtrSendCommand! spring rspec {spec}"
  " let g:rspec_command = "VtrSendCommand! bin/rspec {spec}"
  map <Leader>t :call RunCurrentSpecFile()<CR>
  map <Leader>s :call RunNearestSpec()<CR>
endfunction

" map <Leader>vtr :VtrOpenRunner<cr>
" map <Leader>kvtr :VtrKillRunner<cr>
map <Leader>vtra :VtrAttachToPane<cr>
" map <leader>b :VtrSendLinesToRunner<cr>
" map <leader>B :VtrSendFile!<cr>

" redraws the screen and removes any search highlighting.
nnoremap <silent> <leader>l :noh<CR>

" V split
nmap <Leader>. :vsplit<cr>
nmap <Leader>\ :vsplit<cr>
nmap <Leader>- :split<cr>
nmap <Leader>/ :split<cr>

" Remove trailing whitespace
autocmd FileType yaml,ruby,html,haml,slim,css,scss,sass,js,javascript,vim,yml,md,prolog,python autocmd BufWritePre <buffer> %s/\s\+$//e

" Go to method definition
nmap <F12> :tag <C-R><C-W> <cr>

" Comment a line shortcut
nmap <C-c> gcil

" Ctrl-P for Fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden -g ""'
nmap <silent> <C-p> :Files<cr>
nmap <silent> <leader>p :Buffers<cr>
let g:fzf_preview_window = ''

" Command palette
" nmap <silent> <D-p> :Commands<cr>

" Don't match patterns in the filename
" https://github.com/junegunn/fzf.vim/issues/346
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

" More natural splits
" https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright

nmap zz za

" Move up and down by visible lines if current line is wrapped
nmap j gj
nmap k gk

" Faster movement (https://news.ycombinator.com/item?id=12643887)
nnoremap J 7j
nnoremap K 7k
vnoremap J 7j
vnoremap K 7k

" Alt-S to save
nmap <M-s> :w<cr>
nmap <D-s> :w<cr>

" https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Sane defaults for searching
set ignorecase
set smartcase
set gdefault

" Split edit your vimrc. Type space, v, r in sequence to trigger
nmap <leader>vr :e ~/.vimrc<cr>

nmap <leader>gc :set filetype=gitcommit<cr>

" Auto source vimrc on save
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost /Users/yboulkaid/.vimrc source $MYVIMRC
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

" " Refresh syntax with alt + L
" nmap <silent> ﬁ :syntax on<cr>

" Live preview splitting in neovim
set icm=nosplit

" Enable mouse support
set mouse=a

autocmd Filetype gitcommit set colorcolumn=72 textwidth=72

" Github to master
map <leader>gh :GBrowse<cr>

" Github to master
map <leader>ghm :GBrowse master:%<cr>

" Start interactive EasyAlign in visual mode (e.g. vipga)
" xmap ga <Plug>(EasyAlign)

" Writing mode (markdown)
" autocmd FileType markdown call deoplete#custom#buffer_option('auto_complete', v:false)
autocmd FileType markdown set linebreak

" Quickfix
nmap <M-Down> :cn<cr>
nmap <M-Up> :cp<cr>

command! -bang App call fzf#run(fzf#wrap({'source': 'ag --hidden -g "" app'}, <bang>0))
let g:swank_log=1

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)
map <leader>n <Plug>(miniyank-cycle)
map <leader>N <Plug>(miniyank-cycleback)

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "ruby" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
  },
  indent = {
    enable = false
  }
}

require'colorizer'.setup()

require('bufferline').setup{}
require('lualine').setup()
EOF
