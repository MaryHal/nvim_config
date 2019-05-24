" ====================
" => Pre-init
" ====================
let s:is_cygwin = has('win32unix') || has('win64unix')
let s:is_windows = has('win32') || has('win64')
let s:is_mac = has('gui_macvim') || has('mac')
let s:is_msysgit = (has('win32') || has('win64')) && $TERM ==? 'cygwin'
let s:is_tmux = !empty($TMUX)
let s:is_ssh = !empty($SSH_TTY)

if s:is_windows && !s:is_cygwin && !s:is_msysgit
    let s:dotvim=expand("~/AppData/Local/nvim/")
else
    let s:dotvim=expand("~/.vim/")
endif

let s:is_gui = exists('g:gui_oni') || has('gui_running') || strlen(&term) == 0 || &term ==? 'builtin_gui'

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

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

if !has('nvim')
    Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'Shougo/neco-vim'
Plug 'neoclide/coc-neco'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

Plug 'w0rp/ale'

Plug 'mhinz/vim-signify'
Plug 'airblade/vim-rooter'
Plug 'mbbill/undotree'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'mhinz/vim-startify'

Plug 'MaryHal/Apprentice'
Plug 'MaryHal/vim-colors-plain'
Plug 'NLKNguyen/papercolor-theme'

Plug 'junegunn/vim-peekaboo'

Plug 'lambdalisue/gina.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'

Plug 'haya14busa/vim-edgemotion'
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

" Set 3 lines to pad the cursor - when moving vertical..
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

set nohlsearch " Don't Highlight search things
set incsearch  " Make search act like search in modern browsers
set wrapscan   " Search wraps around the end of the file

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
    " Reset autogroup
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

nnoremap <silent> <leader>k :<C-u>bw<CR>

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

cmap W!! w !sudo tee % >/dev/null

silent! command -nargs=0 W w
silent! command -nargs=0 Q q
silent! command -nargs=0 WQ x
silent! command -nargs=0 Wq x

imap <C-BS> <C-W>
cnoremap <C-BS> <C-W>

nnoremap <C-G> <ESC>:<C-u>cclose<CR><ESC>

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
        set statusline+=\%#StatusLineOk#%{ALEStatus()}
        set statusline+=\%#StatusLineError#%{ALEErrors()}
        set statusline+=\%#StatusLineWarning#%{ALEWarnings()}

        set statusline+=%{coc#status()}\ 
    endif
endfunction

highlight link CocErrorSign StatusLineError
highlight link CocWarningSign StatusLineWarning
highlight link CocInfoSign StatusLineOk

exec CustomStatusLine()

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

let g:coc_global_extensions = ['coc-snippets', 'coc-tsserver', 'coc-rls', 'coc-json', 'coc-css']

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

let g:python3_host_prog = 'python'

" ====================
" => FZF
" ====================
" if s:is_windows && !s:is_cygwin && !s:is_msysgit
"     let $TERM = ''
" endif

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': 'botright 15split enew' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'hl':      ['fg', 'String'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'hl+':     ['fg', 'String'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
"
let g:fzf_history_dir = expand(s:dotvim . '/cache/fzf_history')

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)

let g:rg_command = '
            \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
            \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
            \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

nnoremap <silent> <leader>u :<C-u>Buffers<CR>
nnoremap <silent> <leader>f :<C-u>Files<CR>
nnoremap <silent> <leader>p :<C-u>GFiles<CR>
nnoremap <silent> <C-p>     :<C-u>GFiles<CR>
nnoremap <silent> <leader>l :<C-u>BLines<CR>
nnoremap <silent> <leader>x :<C-u>Commands<CR>
nnoremap <silent> <M-x>     :<C-u>Commands<CR>

