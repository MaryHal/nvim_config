" ====================
" => Pre-init
" ====================
let s:is_cygwin = has('win32unix') || has('win64unix')
let s:is_windows = has('win32') || has('win64')
let s:is_mac = has('gui_macvim') || has('mac')
let s:is_msysgit = (has('win32') || has('win64')) && $TERM ==? 'cygwin'
let s:is_tmux = !empty($TMUX)
let s:is_ssh = !empty($SSH_TTY)

let s:dotvim=expand("~/.config/nvim/")
let s:is_gui = has('gui_running') || strlen(&term) == 0 || &term ==? 'builtin_gui'

" ====================
" => Files and Backups
" ====================
set sessionoptions-=options
set sessionoptions-=folds

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

Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }

if !has('nvim')
    Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'Shougo/neco-vim'
Plug 'neoclide/coc-neco'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'liuchengxu/eleline.vim'
Plug 'liuchengxu/vim-which-key'

" Plug 'w0rp/ale'

Plug 'mhinz/vim-signify'
Plug 'airblade/vim-rooter'
Plug 'mbbill/undotree'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'mhinz/vim-startify'

Plug 'andreypopp/vim-colors-plain'
Plug 'arzg/vim-corvine'
Plug 'ayu-theme/ayu-vim'

Plug 'junegunn/vim-peekaboo'

Plug 'lambdalisue/gina.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'

Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/vim-edgemotion'
Plug 'haya14busa/incsearch.vim'
Plug 'machakann/vim-sandwich'

Plug 'andymass/vim-matchup'
Plug 'wellle/targets.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'romainl/vim-qf'
Plug 'tpope/vim-unimpaired'
Plug 'justinmk/vim-gtfo'

Plug 'sheerun/vim-polyglot'
Plug 'rust-lang/rust.vim'

Plug 'editorconfig/editorconfig-vim'

call plug#end()

" ====================
" => General
" ====================
set encoding=utf-8

set hidden

" Allow Mouse Usage
set mouse=a
set mousehide

set autoread
set autowrite

set foldcolumn=0

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

" Always show current position
set ruler 

" Allow backspacing everything in insert mode
set backspace=indent,eol,start

" Searching
set ignorecase " Ignore case when searching
set smartcase  " If there are any capitalized letters, case sensitive search

set hlsearch
set incsearch
set wrapscan

if has('nvim')
    set inccommand=nosplit
endif

if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ag')
    set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
    set grepformat=%f:%l:%c:%m
endif

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
" => Functions
" ====================
function! RemoveBackground() abort
    if !s:is_gui
        hi Normal ctermbg=NONE
        hi Comment ctermbg=NONE
        hi Constant ctermbg=NONE
        hi Special ctermbg=NONE
        hi Identifier ctermbg=NONE
        hi Statement ctermbg=NONE
        hi PreProc ctermbg=NONE
        hi Type ctermbg=NONE
        hi Underlined ctermbg=NONE
        hi Todo ctermbg=NONE
        hi String ctermbg=NONE
        hi Function ctermbg=NONE
        hi Conditional ctermbg=NONE
        hi Repeat ctermbg=NONE
        hi Operator ctermbg=NONE
        hi Structure ctermbg=NONE
    endif
endfunction

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
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" " Fix broken vim regexes when searching
" " nnoremap / /\v
" " vnoremap / /\v
" " nnoremap ? ?\v
" " vnoremap ? ?\v
" " cnoremap s/ s/\v
" set magic

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
" => User Interface
" ====================
syntax enable

" See ginit.vim

" ====================
" => Statusline
" ====================
function! CustomStatusLine()
    " let &statusline=" %{winnr('$')>1?'['.winnr().'/'.winnr('$')"
    "             \ . ".(winnr('#')==winnr()?'#':'').']':''}\ "
    "             \ . "%{(&previewwindow?'[preview] ':'').expand('%:t:.')} "
    "             \ . "\ %=%m%y%{'['.(&fenc!=''?&fenc:&enc).','.&ff.']'}"
    "             \ . "%{printf('  %4d/%d',line('.'),line('$'))}\ "
    if has('statusline')
        function! ALEWarnings() abort
            let l:counts = ale#statusline#Count(bufnr(''))
            let l:all_errors = l:counts.error + l:counts.style_error
            let l:all_non_errors = l:counts.total - l:all_errors
            return l:counts.total == 0 ? '' : printf('  W:%d ', all_non_errors)
        endfunction

        function! ALEErrors() abort
            let l:counts = ale#statusline#Count(bufnr(''))
            let l:all_errors = l:counts.error + l:counts.style_error
            let l:all_non_errors = l:counts.total - l:all_errors
            return l:counts.total == 0 ? '' : printf(' E:%d ', all_errors)
        endfunction

        function! ALEStatus() abort
            let l:counts = ale#statusline#Count(bufnr(''))
            let l:all_errors = l:counts.error + l:counts.style_error
            let l:all_non_errors = l:counts.total - l:all_errors
            return l:counts.total == 0 ? ' ok ' : ''
        endfunction

        set statusline=\ %<%f
        set statusline+=%w%h%m%r

        set statusline+=\ %y
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%\ 
        " set statusline+=\%#StatusLineOk#%{ALEStatus()}
        " set statusline+=\%#StatusLineError#%{ALEErrors()}
        " set statusline+=\%#StatusLineWarning#%{ALEWarnings()}

        set statusline+=%{coc#status()}\ 
    endif
endfunction

highlight link CocErrorSign StatusLineError
highlight link CocWarningSign StatusLineWarning
highlight link CocInfoSign StatusLineOk

" exec CustomStatusLine()

set laststatus=2

" Show incomplete commands
set showcmd

" ====================
" => Plugin Settings
" ====================
let g:bookmark_no_default_key_mappings = 1

nnoremap <silent> <leader>eb :<C-u>so %<CR>
vnoremap <silent> <leader>er :<C-u>@*<CR>

" Change cwd to current buffer directory
nnoremap          <leader>c :<C-u>cd %:p:h<CR>
nnoremap          <leader>g :<C-u>Gstatus<CR>
nnoremap          <leader>s :<C-u>Startify<CR>

map <C-j> <Plug>(edgemotion-j)
map <C-k> <Plug>(edgemotion-k)

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap <leader>w <Plug>(easymotion-bd-f2)

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

command! -nargs=0 Jq :%!jq "."

let g:targets_argOpening = '[({[]'
let g:targets_argClosing = '[]})]'

let g:matchup_matchparen_nomode = 'i'
augroup matchup_highlight
    autocmd!
    autocmd ColorScheme * hi MatchParen gui=italic cterm=italic
augroup END

let g:startify_bookmarks = [ {'c': '~/.config/nvim/init.vim'} ]

" ====================
" => Auto-Complete
" ====================

let g:coc_global_extensions = ['coc-snippets', 'coc-tsserver', 'coc-html', 'coc-css']

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

inoremap <silent><expr> <c-space> coc#refresh()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

let g:python3_host_prog = 'python'

nnoremap <silent> <leader>u :<C-u>Clap buffers<CR>
nnoremap <silent> <leader>f :<C-u>Clap files<CR>
nnoremap <silent> <leader>p :<C-u>Clap gfiles<CR>
nnoremap <silent> <C-p>     :<C-u>Clap gfiles<CR>
nnoremap <silent> <leader>l :<C-u>Clap blines<CR>
nnoremap <silent> <leader>x :<C-u>Clap command<CR>
nnoremap <silent> <M-x>     :<C-u>Clap command<CR>

" let g:clap_theme = 'material_design_dark'

if has('nvim')
    if exists('g:GuiLoaded')
        set guifont=Iosevka\ Term\ SS05:h9
        GuiLinespace 2
        GuiTabline 0
        GuiPopupmenu 0
    endif
    if exists('g:neovide')
        set guifont=Iosevka\ Term\ SS05:h12
        let g:neovide_cursor_antialiasing = v:false
    endif
else
    set guifont=Sarasa_Mono_J:h9
    set guioptions=acg
endif

colors plain
set background=light

hi link ClapCurrentSelection DiffAdd
hi StatusLine gui=NONE
hi StatusLineNC gui=NONE
hi StatusLineError gui=NONE
hi StatusLineOk gui=NONE
hi StatusLineNC gui=NONE
