let s:dotvim=expand("~/.config/nvim/")

" ====================
" => Files and Backups
" ====================
set sessionoptions-=options

if has('persistent_undo')
    execute "set undodir=" . expand(s:dotvim . '/cache/undo/')
    set undofile
    set undolevels=1000
    if exists('+undoreload')
        set undoreload=1000
    endif
endif

" Backups
execute "set backupdir=" . expand(s:dotvim . '/cache/backup/')
" set nowritebackup
" set nobackup

" Swap Files
execute "set directory=" . expand(s:dotvim . '/cache/swap/')
set noswapfile

function! EnsureExists(path)
    if !isdirectory(expand(a:path))
        call mkdir(expand(a:path))
    endif
endfunction
call EnsureExists(s:dotvim . '/cache')
call EnsureExists(&undodir)
call EnsureExists(&backupdir)
call EnsureExists(&directory)

" ====================
" => Plugins
" ====================
call plug#begin(expand(s:dotvim . 'plugged'))

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'nvim-telescope/telescope.nvim'

Plug 'hrsh7th/nvim-compe'
Plug 'neovim/nvim-lspconfig'

Plug 'nvim-lua/lsp-status.nvim'

" Plug 'liuchengxu/eleline.vim'
Plug 'folke/which-key.nvim', { 'branch': 'main' }

Plug 'nvim-treesitter/nvim-treesitter' " , {'do': ':TSUpdate'}
Plug 'lewis6991/gitsigns.nvim', { 'branch': 'main' }
Plug 'ahmedkhalf/project.nvim', { 'branch': 'main' }
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'

Plug 'SmiteshP/nvim-gps'

Plug 'andreypopp/vim-colors-plain'

Plug 'tpope/vim-fugitive'
Plug 'TimUntersberger/neogit'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rsi'

Plug 'machakann/vim-sandwich'

Plug 'andymass/vim-matchup'
Plug 'wellle/targets.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'romainl/vim-qf'
Plug 'tpope/vim-unimpaired'
Plug 'justinmk/vim-gtfo'
Plug 'ojroques/nvim-bufdel', { 'branch': 'main' }

Plug 'sheerun/vim-polyglot'
Plug 'rust-lang/rust.vim'
Plug 'nvim-orgmode/orgmode'

Plug 'editorconfig/editorconfig-vim'

call plug#end()

" ====================
" => General
" ====================
set encoding=utf-8

set hidden

set mouse=a
set mousehide

set autoread
set autowrite

set nofoldenable
set foldcolumn=0
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" ====================
" => User Interface
" ====================
set shortmess=Iatc

" Blank vsplit separator
set fillchars+=vert:\ 

set signcolumn=yes

" Ask for confirmation for various things
set confirm

" Don't complete from other buffer
set complete=.

set scrolloff=10
set sidescrolloff=5

" Auto complete setting
set completeopt=menuone,noselect

" show list for autocomplete
set wildmenu
set wildmode=list,full
set wildignorecase

set ruler 

" Allow backspacing everything in insert mode
set backspace=indent,eol,start

set ignorecase " Ignore case when searching
set smartcase  " If there are any capitalized letters, case sensitive search

set hlsearch
set incsearch
set wrapscan

if has('nvim')
    set inccommand=nosplit
endif

set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m,%f:%l:%m

set showmatch
set matchtime=2

set nomodeline
set modelines=0

set lazyredraw

set updatetime=300

" ====================
" => Formatting
" ====================
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

set autoindent

" set list
" set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣,trail:• ",eol:¬
" set showbreak=↪

" set wrap
set whichwrap+=h,l,<,>,[,]
set linebreak

set formatoptions=ql

" ====================
" => Autocommands
" ====================
if has('autocmd')
    augroup MyAutoCmd
        autocmd!
    augroup END

    autocmd BufLeave * let b:winview = winsaveview()
    autocmd BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
endif

" ====================
" => Windows and Moving around
" ====================
set splitright
set splitbelow

set switchbuf=usetab

nmap K kJ

set equalalways

" line wrap movement
noremap j gj
noremap k gk

" Reselect visual block after indent
xnoremap < <gv
xnoremap > >gv

nmap <C-S-tab> :tabp<CR>
nmap <C-tab>   :tabn<CR>

nnoremap <M-1> 1gt
nnoremap <M-2> 2gt
nnoremap <M-3> 3gt
nnoremap <M-4> 4gt
nnoremap <M-5> 5gt
nnoremap <M-6> 6gt
nnoremap <M-7> 7gt
nnoremap <M-8> 8gt
nnoremap <M-9> 9gt

function! ExecuteMacroOverVisualRange() abort
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
endfunction
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

" ====================
" => Other Keys
" ====================
let mapleader = "\<Space>"

" Fix broken vim regexes when searching
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
cnoremap s/ s/\v

nnoremap Y yg_

nnoremap <silent> <leader><leader> "*
vnoremap <silent> <leader><leader> "*

nnoremap <silent> <leader>tb <C-u>:let &background = (&background == "dark"? "light" : "dark")<CR>
nnoremap <silent> <leader>tn <C-u>:set nu!<CR>

cmap W!! w !sudo tee % >/dev/null

silent! command -nargs=0 W w
silent! command -nargs=0 Q q
silent! command -nargs=0 WQ x
silent! command -nargs=0 Wq x

imap <C-BS> <C-W>
cnoremap <C-BS> <C-W>

" ====================
" => UI Stuff
" ====================
syntax enable

if has('nvim')
    if exists('g:GuiLoaded')
        set guifont=Rec\ Mono\ Duotone:h10
        GuiLinespace 0
        GuiTabline 0
        GuiPopupmenu 0
    endif
    if exists('g:neovide')
        set guifont=Rec\ Mono\ Duotone:h11
        let g:neovide_cursor_antialiasing = v:true
    endif
else
    set guifont=Sarasa_Mono_J:h9
    set guioptions=acg
endif

colors plain
set background=light

hi StatusLine gui=NONE
hi StatusLineNC gui=NONE
hi StatusLineError gui=NONE
hi StatusLineOk gui=NONE
hi StatusLineNC gui=NONE

" ====================
" => Statusline
" ====================
set laststatus=2
set showcmd

" ====================
" => Plugin Settings
" ====================
let g:bookmark_no_default_key_mappings = 1

nnoremap <silent> <leader>eb :<C-u>so %<CR>
vnoremap <silent> <leader>er :<C-u>@*<CR>

" Change cwd to current buffer directory
nnoremap          <leader>c :<C-u>cd %:p:h<CR>
nnoremap          <leader>g :<C-u>Git<CR>
nnoremap          <leader>s :<C-u>Startify<CR>

command! -nargs=0 Jq :%!jq "."

autocmd User targets#mappings#user call targets#mappings#extend({
    \ 'b': {'pair': [{'o':'(', 'c':')'}, {'o':'[', 'c':']'}, {'o':'{', 'c':'}'}]},
    \ })

let g:matchup_matchparen_nomode = 'i'
augroup matchup_highlight
    autocmd!
    autocmd ColorScheme * hi MatchParen gui=italic cterm=italic
augroup END

let g:startify_bookmarks = [ {'c': '~/.config/nvim/init.vim'} ]
let g:python3_host_prog = 'python'

nnoremap <silent> <leader>f <cmd>Telescope find_files<CR>
nnoremap <silent> <leader>l <cmd>Telescope live_grep<CR>
nnoremap <silent> <leader>b <cmd>Telescope buffers<CR>
nnoremap <silent> <leader>p <cmd>Telescope projects<CR>

nnoremap <silent> <A-x> <cmd>Telescope commands<CR>

runtime macros/sandwich/keymap/surround.vim

lua <<EOF
require("which-key").setup{}

require 'nvim-treesitter.install'.compilers = { "clang" }
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
    disable = {'org'},
    additional_vim_regex_highlighting = {'org'},
  },
  indent = { enable = false, },
  rainbow = { enable = true, },
}

-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()

require('orgmode').setup({
  org_agenda_files = {'~/org/*'},
  org_default_notes_file = '~/org/todo.org',
})

require("project_nvim").setup{}

local neogit = require('neogit')
neogit.setup{}

require'lspconfig'.rust_analyzer.setup{}

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    -- vsnip = true;
    -- ultisnips = true;
    orgmode = true;
  };
}

require('gitsigns').setup()

local actions = require('telescope.actions')
local telescope = require('telescope')

telescope.setup{
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
      },
    },
  }
}

telescope.load_extension('projects')

local statusline = {}
local statusline_group = vim.api.nvim_create_augroup('custom_statusline', { clear = true })
local gps = require('nvim-gps')
gps.setup()

local c = {}

function statusline.set_colors()
  c.normal_bg = vim.fn.synIDattr(vim.fn.hlID('Normal'), 'bg')
  c.normal_fg = vim.fn.synIDattr(vim.fn.hlID('Normal'), 'fg')
  c.statusline_bg = vim.fn.synIDattr(vim.fn.hlID('Statusline'), 'bg')
  c.comment_fg = vim.fn.synIDattr(vim.fn.hlID('Comment'), 'fg')
  c.warning_fg = vim.fn.synIDattr(vim.fn.hlID('WarningMsg'), 'fg')
  c.error_fg = vim.fn.synIDattr(vim.fn.hlID('ErrorMsg'), 'fg')

  vim.cmd('hi StItem guibg=' .. c.statusline_bg .. ' guifg=' .. c.normal_bg .. ' gui=NONE')
  vim.cmd('hi StItem2 guibg=' .. c.statusline_bg .. ' guifg=' .. c.normal_bg .. ' gui=NONE')
  vim.cmd('hi StSep guifg=' .. c.statusline_bg .. ' guibg=' .. c.statusline_bg .. ' gui=NONE')
  vim.cmd('hi StSep2 guifg=' .. c.comment_fg .. ' guibg=' .. c.statusline_bg .. ' gui=NONE')
  vim.cmd('hi StErr guibg=' .. c.statusline_bg .. ' guifg=' .. c.error_fg .. ' gui=bold')
  vim.cmd('hi StErrSep guifg=' .. c.error_fg .. ' guibg=' .. c.statusline_bg .. ' gui=NONE')
  vim.cmd('hi StWarn guibg=' .. c.warning_fg .. ' guifg=' .. c.normal_bg .. ' gui=bold')
  vim.cmd('hi StWarnSep guifg=' .. c.warning_fg .. ' guibg=' .. c.statusline_bg .. ' gui=NONE')
  vim.cmd('hi StMode guibg=' .. c.statusline_bg .. ' guifg=' .. c.normal_bg .. ' gui=bold')
  vim.cmd('hi StModeSep guibg=' .. c.statusline_bg .. ' guifg=' .. c.normal_bg .. ' gui=NONE')
end

vim.api.nvim_create_autocmd({ 'VimEnter', 'ColorScheme' }, {
  group = statusline_group,
  pattern = '*',
  callback = statusline.set_colors,
})

local function show_item(item, opts, show)
  opts = opts or {}
  if show == nil then
    show = true
  end
  if not show then
    return ''
  end

  local color = opts.color or '%#StItem#'
  return color .. item
end

local function sep(opts, show)
  opts = opts or {}
  if show == nil then
    show = true
  end
  if not show then
    return ''
  end

  local sep_color = opts.sep_color or '%#StSep#'

  -- ''
  -- ''
  local sep = '  ' -- '█'

  return sep_color .. sep .. '%*'
end

local st_mode = { color = '%#StMode#', sep_color = '%#StModeSep#', no_before = true }
local st_err = { color = '%#StErr#', sep_color = '%#StErrSep#' }
local st_mode_right = vim.tbl_extend('force', st_mode, { side = 'right', no_before = false })
local st_err_right = vim.tbl_extend('force', st_err, { side = 'right' })
local st_warn = { color = '%#StWarn#', sep_color = '%#StWarnSep#', side = 'right', no_after = true }
local sec_2 = { color = '%#StItem2#', sep_color = '%#StSep2#' }

local function mode_statusline()
  local mode = vim.fn.mode()
  local modeMap = {
    n = 'NORMAL',
    i = 'INSERT',
    R = 'REPLACE',
    v = 'VISUAL',
    V = 'V-LINE',
    c = 'COMMAND',
    [''] = 'V-BLOCK',
    s = 'SELECT',
    S = 'S-LINE',
    [''] = 'S-BLOCK',
    t = 'TERMINAL',
  }

  return modeMap[mode] or 'UNKNOWN'
end

local function with_icon(value, icon)
  if not value then
    return value
  end
  return icon .. ' ' .. value
end

local function git_statusline()
  local result = {}
  if vim.b.gitsigns_head then
    table.insert(result, vim.b.gitsigns_head)
  elseif vim.g.gitsigns_head then
    table.insert(result, vim.g.gitsigns_head)
  end
  if vim.b.gitsigns_status then
    table.insert(result, vim.b.gitsigns_status)
  end
  if #result == 0 then
    return ''
  end
  return with_icon(table.concat(result, ' '), '')
end

local function get_path()
  local full_path = vim.fn.expand('%:p')
  local path = full_path
  local cwd = vim.fn.getcwd()
  if path == '' then
    path = cwd
  end
  local stats = vim.loop.fs_stat(path)
  if stats and stats.type == 'directory' then
    return vim.fn.fnamemodify(path, ':~')
  end

  if full_path:match('^' .. cwd) then
    path = vim.fn.expand('%:.')
  else
    path = vim.fn.expand('%:~')
  end

  if #path < (vim.fn.winwidth(0) / 4) then
    return '%f'
  end

  return vim.fn.pathshorten(path)
end

function statusline.search_result()
  if vim.v.hlsearch == 0 then
    return ''
  end
  local last_search = vim.fn.getreg('/')
  if not last_search or last_search == '' then
    return ''
  end
  local searchcount = vim.fn.searchcount({ maxcount = 9999 })
  return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
end

local function lsp_status(severity)
  local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity[severity] })
  if count > 0 then
    return count .. ' ' .. severity:sub(1, 1)
  end
  return ''
end

StatusLine = {}

StatusLine.active = function()
  local mode = mode_statusline()
  local git_status = git_statusline()
  local search = statusline.search_result()
  local ft = vim.bo.filetype
  local err = lsp_status('ERROR')
  local warn = lsp_status('WARN')
  local statusline_sections = {
    ' 𑁍 ',
    show_item(mode, st_mode),
    sep(st_mode_right),
    show_item(git_status, sec_2, git_status ~= ''),
    sep(st_mode_right),
    show_item(get_path(), vim.bo.modified and st_err or sec_2),
    show_item(' + ', st_err, vim.bo.modified),
    show_item(' - ', st_err, not vim.bo.modifiable),
    sep(st_mode_right),
    show_item('%w', nil, vim.wo.previewwindow),
    show_item('%r', nil, vim.bo.readonly),
    show_item('%q', nil, vim.bo.buftype == 'quickfix'),
    '%<',
    '%=',
    -- show_item(search, vim.tbl_extend('keep', { side = 'right' }, sec_2), search ~= ''),
    sep(st_mode_right),
    show_item(ft, vim.tbl_extend('keep', { side = 'right' }, sec_2), ft ~= ''),
    sep(st_mode_right),
    show_item('%l:%c', st_mode_right),
    sep(st_mode_right),
    show_item('%p%%', vim.tbl_extend('keep', { no_after = err == '' and warn == '' }, st_mode_right)),
    show_item(err, vim.tbl_extend('keep', { no_after = warn == '' }, st_err_right), err ~= ''),
    show_item(warn, st_warn, warn ~= ''),
    ' ',
    '%<',
  }

  return table.concat(statusline_sections, '')
end

StatusLine.inactive = function()
  return [[%f %y %m]]
end

function statusline.setup()
  local focus = vim.g.statusline_winid == vim.fn.win_getid()
  if focus then
    return statusline_active()
  end
  return statusline_inactive()
end

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.StatusLine.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.StatusLine.inactive()
  " au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)

EOF

