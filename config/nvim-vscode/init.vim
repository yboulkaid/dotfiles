" To copy vim-plug install:
" cp -r nvim/site nvim-vscode/site

let mapleader = "\<Space>"

language en_US

set clipboard=unnamed
set colorcolumn=180 " Set the column limit
set completeopt=menuone,noinsert,noselect " Better completion experience
set confirm
set cursorline " Highlight the cursor line
set expandtab
set inccommand=nosplit " Live preview splitting in neovim
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
set updatetime=250

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

" Disable netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
:command! -nargs=1 Browse silent execute '!open' shellescape(<q-args>,1)

call plug#begin('~/.vim/plugged-vscode')
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-repeat'

  " Ruby dev
  Plug 'tpope/vim-rails'
  Plug 'thoughtbot/vim-rspec'

  " Text objects
  Plug 'kana/vim-textobj-user'
  Plug 'nelstrom/vim-textobj-rubyblock'

  " Motions
  Plug 'vim-scripts/ReplaceWithRegister'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'andymass/vim-matchup'
call plug#end()

" Disable unused providers
let g:loaded_python3_provider = 0
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0

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

" redraws the screen and removes any search highlighting.
nnoremap <silent> <leader>l :noh<CR>

" Highlight yank
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=250}

" V split
nmap <Leader>. :vsplit<cr>
nmap <Leader>\ :vsplit<cr>
nmap <Leader>- :split<cr>
nmap <Leader>/ :split<cr>

" Remove trailing whitespace
fun! StripTrailingWhitespace()
  " Don't strip on these filetypes
  if &ft =~ 'markdown'
    return
  endif

  %s/\s\+$//e
endfun
autocmd BufWritePre * call StripTrailingWhitespace()

" Comment a line shortcut
nmap <C-c> gc$

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

" Edit your vimrc.
nmap <leader>vr :e ~/.vimrc-vscode<cr>

" Auto source vimrc on save
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost ~/.vimrc-vscode source $MYVIMRC
augroup END

" Open in Github
map <leader>gh :GBrowse<cr>

" Github to master
map <leader>ghm :GBrowse develop:%<cr>

" I'm too old to re-learn
" https://www.reddit.com/r/neovim/comments/petq61/neovim_060_y_not_yanking_line_but_to_end_of_line/
nnoremap Y Y
