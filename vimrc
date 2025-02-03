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

call plug#begin('~/.vim/plugged')
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'dense-analysis/ale'
  Plug 'qpkorr/vim-bufkill'
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
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'pbrisbin/vim-mkdir'
  Plug 'akinsho/nvim-bufferline.lua'
  Plug 'hoob3rt/lualine.nvim'
  Plug 'zbirenbaum/copilot.lua'
  Plug 'folke/trouble.nvim'

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

  " Syntax
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'slim-template/vim-slim'
  Plug 'fladson/vim-kitty'
  Plug 'zorab47/procfile.vim'

  Plug 'yboulkaid/neon', { 'branch': 'main' }
call plug#end()

" File-specific set commands
autocmd Filetype gitcommit set colorcolumn=72 textwidth=72

" Disable unused providers
let g:loaded_python3_provider = 0
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0

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
  let g:rspec_command = "VtrSendCommand! bin/rspec {spec}"
  map <Leader>t :call RunCurrentSpecFile()<CR>
  map <Leader>s :call RunNearestSpec()<CR>
endfunction

let g:splitjoin_ruby_options_as_arguments = 1
let g:splitjoin_trailing_comma = 1
let g:splitjoin_ruby_hanging_args = 0

map <Leader>vtra :VtrAttachToPane<cr>

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

" Go to method definition
nmap <F12> :tag <C-R><C-W> <cr>

" Comment a line shortcut
nmap <C-c> gc$

" Ctrl-P for Fzf
" let $FZF_DEFAULT_COMMAND = 'ag --hidden -g ""'
nmap <silent> <C-p> :GFiles<cr>
nmap <silent> <leader>p :Buffers<cr>
let g:fzf_preview_window = ''

" https://github.com/junegunn/fzf.vim#example-advanced-ripgrep-integration
" https://github.com/junegunn/fzf/issues/2421
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --hidden --column --line-number --no-heading --color=always --smart-case --fixed-strings -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--disabled', '--query', a:query, '--bind', 'change:reload:sleep 0.2; '.reload_command]}
  call fzf#vim#grep(initial_command, 1, spec, a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

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
  autocmd BufWritePost ~/.vimrc source $MYVIMRC
augroup END

" Open explorer
map <leader>, :NvimTreeToggle<cr>
nmap <F10> :NvimTreeFindFile<cr>

" Folding
setlocal foldmethod=indent
set nofoldenable

" Leader F for search
map <leader>f :RG<cr>

" Open in Github
map <leader>gh :GBrowse<cr>

" Github to master
map <leader>ghm :GBrowse develop:%<cr>

" Rubocop autofix
map <Leader>r :ALEFix<CR>

" Quickfix
nmap <M-Down> :cn<cr>
nmap <M-Up> :cp<cr>

" I'm too old to re-learn
" https://www.reddit.com/r/neovim/comments/petq61/neovim_060_y_not_yanking_line_but_to_end_of_line/
nnoremap Y Y

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "ruby", "scss", "lua", "vim" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = { "ruby" },
  }
}

require'colorizer'.setup()

require('bufferline').setup{
  options = {
    show_buffer_close_icons = false,
  }
}

require('lualine').setup {
  sections = {
    lualine_a = {},
    lualine_b = {'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {},
    lualine_z = {}
  },
}

-- Set up nvim-cmp.
local cmp = require'cmp'
local cmp_buffer = require('cmp_buffer')
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
    ['<M-Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,
  }),

  sources = cmp.config.sources(
    {
      { name = 'buffer',
        max_item_count = 4,
        option = {
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end
        }
      },
    },
    {
      { name = 'nvim_lsp' },
      { name = 'snippy', max_item_count = 1 },
    }
  ),

  sorting = {
    comparators = {
      function(...) return cmp_buffer:compare_locality(...) end,
    }
  }
})

require('snippy').setup({
  mappings = {
    is = {
      ['<C-e>'] = 'expand_or_advance',
    },
  },
})
-- require("copilot_cmp").setup()

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
local lspconfig = require('lspconfig')
-- lspconfig.ruby_lsp.setup({})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Set up nvim-tree.
local function copy_file_to(node)
    local file_src = node['absolute_path']
    -- The args of input are {prompt}, {default}, {completion}
    -- Read in the new file path using the existing file's path as the baseline.
    local file_out = vim.fn.input("COPY TO: ", file_src, "file")
    -- Create any parent dirs as required
    local dir = vim.fn.fnamemodify(file_out, ":h")
    vim.fn.system { 'mkdir', '-p', dir }
    -- Copy the file
    vim.fn.system { 'cp', '-R', file_src, file_out }
end

local function my_on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)
end

require("nvim-tree").setup({
  on_attach = my_on_attach,
  actions = {
    remove_file = {
      close_window = false
    },
    open_file = {
      window_picker = {
        enable = false,
      }
    },
  },
  renderer = {
    group_empty = true,
    add_trailing = true,
    icons = {
      show = {
        file = false,
        folder = false,
        git = false,
      },
    },
  },
})

-- require('lint').linters_by_ft = {
--   ruby = {'rubocop', 'ruby'}
-- }
-- vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
--   callback = function()
--     require('lint').try_lint()
--   end,
-- })

-- Setup Ale Linters
vim.g.ale_use_neovim_diagnostics_api= 1
vim.g.ale_linters = { ruby = { 'rubocop', 'sorbet'} }
vim.g.ale_fixers = { ruby = { 'rubocop', 'sorbet'} }

vim.diagnostic.config({
  virtual_text = false,
  underline = true,
})
vim.api.nvim_create_autocmd({ 'CursorHold' }, {
  callback = function()
    vim.diagnostic.open_float(nil, {focus=false, scope='cursor'})
  end,
})

require "nvim-treesitter.configs".setup {
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}
EOF
