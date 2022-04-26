let mapleader = "\<Space>"

language en_US

set clipboard=unnamed
set colorcolumn=100 " Set the column limit
set completeopt=menuone,noinsert,noselect " Better completion experience
set confirm
set cursorline " Highlight the cursor line
set expandtab
set hidden " Allow buffer change w/o saving
set icm=nosplit " Live preview splitting in neovim
set lazyredraw " Don't update while executing macros
set mouse=a " Enable mouse support
set noswapfile " Remove temporary swap file
set number
set scrolloff=4 " Keep at least 4 lines below cursor
set shiftwidth=2
set shortmess+=I " No intro when starting Vim
set signcolumn=yes " Always show sign column
set softtabstop=2
set tabstop=2
set termguicolors
set title

" Don't use ! and ? as word delimiters
set iskeyword+=!
set iskeyword+=?

" Sane defaults for searching
set gdefault
set ignorecase
set smartcase

" More natural splits
" https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright

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
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'github/copilot.vim'

  " Snippets
  Plug 'honza/vim-snippets'
  Plug 'Shougo/neosnippet.vim'
  Plug 'Shougo/neosnippet-snippets'

  " Interface
  Plug 'scrooloose/nerdtree'
  Plug 'machakann/vim-highlightedyank'
  Plug 'pbrisbin/vim-mkdir'
  Plug 'akinsho/nvim-bufferline.lua'
  Plug 'hoob3rt/lualine.nvim'

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
  Plug 'cakebaker/scss-syntax.vim'
  Plug 'jparise/vim-graphql'
  Plug 'vim-python/python-syntax'
  Plug 'fladson/vim-kitty'

  Plug 'rafamadriz/neon', { 'branch': 'main' }
  Plug 'neovim/nvim-lspconfig'
call plug#end()

" File-specific set commands
autocmd Filetype gitcommit set colorcolumn=72 textwidth=72

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

let g:neon_style = 'default'
colorscheme neon

" Tab buffer switching
nmap <Tab> :BufferLineCycleNext<CR>
nmap <S-Tab> :BufferLineCyclePrev<CR>

" Insert new lines above or below the cursor
nnoremap <silent> <M-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent> <M-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" Paste on newlines with Option-P
:nmap <M-p> :pu<CR>==

" Bubble lines : http://vimcasts.org/episodes/bubbling-text/
nmap <M-K> [e
nmap <M-J> ]e

vmap <M-K> [egv
vmap <M-J> ]egv

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

" Hardcode Copilot node version as node >16 is required on Apple Silicon
let g:copilot_node_command='/Users/yboulkaid/.asdf/installs/nodejs/17.8.0/bin/node'

" Snippets config
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory = '~/Projects/yboulkaid/dotfiles/snippets'

" Setup VTR and vim-rspec
augroup setup_vtr
  au!
  autocmd Filetype ruby call VtrForRuby()
augroup END

function! VtrForRuby()
  let g:rspec_command = "VtrSendCommand! spring rspec {spec}"
  map <Leader>t :call RunCurrentSpecFile()<CR>
  map <Leader>s :call RunNearestSpec()<CR>
endfunction

map <Leader>vtra :VtrAttachToPane<cr>

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

" Don't match patterns in the filename
" https://github.com/junegunn/fzf.vim/issues/346
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

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

" Split edit your vimrc.
nmap <leader>vr :e ~/.vimrc<cr>

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

" Leader F for search
map <leader>f :Ag<cr>

" Open in Github
map <leader>gh :GBrowse<cr>

" Github to master
map <leader>ghm :GBrowse master:%<cr>

" Quickfix
nmap <M-Down> :cn<cr>
nmap <M-Up> :cp<cr>

" I'm too old to re-learn
" https://www.reddit.com/r/neovim/comments/petq61/neovim_060_y_not_yanking_line_but_to_end_of_line/
nnoremap Y Y

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "ruby", "nix" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = false
  }
}

require'colorizer'.setup()
require('bufferline').setup{
  options = {
    show_buffer_close_icons = false,
  }
}
require('lualine').setup()
EOF
