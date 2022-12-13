let mapleader = "\<Space>"

language en_US

set clipboard=unnamed
set colorcolumn=100 " Set the column limit
set completeopt=menuone,noinsert,noselect " Better completion experience
set confirm
set cursorline " Highlight the cursor line
set expandtab
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
  Plug 'neovim/nvim-lspconfig'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'neomake/neomake'
  Plug 'qpkorr/vim-bufkill'
  Plug 'Townk/vim-autoclose'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-repeat'
  Plug 'norcalli/nvim-colorizer.lua'

  " Snippets
  Plug 'honza/vim-snippets'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'dcampos/nvim-snippy'
  Plug 'dcampos/cmp-snippy'

  " Interface
  Plug 'scrooloose/nerdtree'
  Plug 'PhilRunninger/nerdtree-visual-selection'
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

  " Motions
  Plug 'vim-scripts/ReplaceWithRegister'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'andymass/vim-matchup'
  Plug 'AndrewRadev/splitjoin.vim'

  " Syntax
  Plug 'nvim-treesitter/nvim-treesitter', {'commit': '4cccb6f494', 'do': ':TSUpdate'}
  Plug 'slim-template/vim-slim'
  Plug 'vim-python/python-syntax'
  Plug 'fladson/vim-kitty'

  Plug 'rafamadriz/neon', { 'branch': 'main' }
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

    " \ 'exe': 'script/fmt',
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

let g:splitjoin_ruby_options_as_arguments = 1
let g:splitjoin_trailing_comma = 1
let g:splitjoin_ruby_hanging_args = 0

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
nmap <C-c> gc$

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

" Edit your vimrc.
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

" Remove when https://github.com/preservim/nerdtree/issues/1321 is fixed
let g:NERDTreeMinimalMenu=1

" Disble confirmations for batch edits
let g:nerdtree_vis_confirm_open=0
let g:nerdtree_vis_confirm_delete=0
let g:nerdtree_vis_confirm_copy=0
let g:nerdtree_vis_confirm_move=0

let g:NERDTreeAutoDeleteBuffer=1

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
  ensure_installed = { "ruby", "scss", "graphql", "lua" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true
  }
}

require'colorizer'.setup()

require('bufferline').setup{
  options = {
    show_buffer_close_icons = false,
  }
}

require('lualine').setup()

-- Set up nvim-cmp.
local cmp = require'cmp'
local snippy = require('snippy')

cmp.setup({
  snippet = {
    expand = function(args)
      snippy.expand_snippet(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-e>'] = function(fallback)
      if snippy.can_expand_or_advance() then
        snippy.expand_or_advance()
      else
        fallback()
      end
    end,
    ['<CR>'] = function(fallback)
        if cmp.visible() then
          vim.api.nvim_input('<Esc><Esc>')
        else
          fallback()
        end
      end,
    ['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,
  }),
  sources = cmp.config.sources(
    {
      { name = 'buffer', max_item_count = 2 },
    },
    {
      { name = 'nvim_lsp' },
      { name = 'snippy', max_item_count = 1 },
    }
  )
})

require('snippy').setup({
  mappings = {
    is = {
      ['<C-e>'] = 'expand_or_advance',
    },
  },
})


-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path', max_item_count = 10 }
  }, {
    { name = 'cmdline', max_item_count = 3 }
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
EOF
