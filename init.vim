set relativenumber
set nohlsearch
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set ignorecase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set updatetime=50
set shortmess
set signcolumn=yes
set cmdheight=2
set hidden
set autoindent
set smartindent

call plug#begin('~/.vim/plugged')

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'marko-cerovac/material.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'mbbill/undotree'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/popup.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'glepnir/dashboard-nvim'
Plug 'luochen1990/rainbow'
"Plug 'gruvbox-community/gruvbox'

call plug#end()

let g:rainbow_active = 1

let g:material_style = "deep ocean"
colorscheme material
set termguicolors
"let g:gruvbox_contrast_dark='medium'
"let g:gruvbox_contrast_light='hard'
"colorscheme gruvbox

lua << EOF
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
EOF

set termguicolors

let mapleader = " "
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep for: ")})<CR>
nnoremap tn :ts<CR>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap to :tabo<CR>
nnoremap vs :vs<CR>
nnoremap sp :sp<CR>
nnoremap <F5> :UndotreeToggle<CR>

lua << END
local db = require('dashboard')
local home = os.getenv('HOME')
db.custom_center = {
  {icon = '  ',
  desc = 'Recently latest session                  ',
  shortcut = 'SPC s l',
  action ='SessionLoad'},
  {icon = '  ',
  desc = 'Recently opened files                   ',
  action =  'DashboardFindHistory',
  shortcut = 'SPC f h'},
  {icon = '  ',
  desc = 'Find  File                              ',
  action = 'Telescope find_files find_command=rg,--hidden,--files',
  shortcut = 'SPC f f'},
  {icon = '  ',
  desc ='File Browser                            ',
  action =  'Telescope file_browser',
  shortcut = 'SPC f b'},
  {icon = '  ',
  desc = 'Find  word                              ',
  action = 'Telescope live_grep',
  shortcut = 'SPC f w'},
}
END

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup christian
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
