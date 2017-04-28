" .vimrc
" phallen
" Originally written Feb 1, 2014

" vim:fdm=marker

" Tabs, spaces and indenting {{{

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" }}}
" Key remapping {{{

" Make leader the , key

let mapleader = ","

" I don't use ;, I don't even know what it does! Let's just use :

nnoremap ; :

" Use jk and kj to escape

inoremap jk <Esc>
inoremap kj <Esc>

" Y to yank to the end of the line, to match C and D

nnoremap Y y$

" Leader-. to reload .vimrc

nmap <silent> <leader>. :so $MYVIMRC<CR>

" Remap <BS> to % to easily jump to matching identifier (bracket, paren, tag)

nmap <BS> %

" }}}
" Searching / Moving {{{

set ignorecase
set gdefault
set incsearch
set showmatch

" Highlight all the matches for the current search query

set hlsearch

" Clear the current query when hitting leader-<space>

nnoremap <silent> <leader><space> :noh<cr>

" When searching for things, keep the current match in the middle of the
" window and pulse the line when moving to them

nnoremap n nzzzv
nnoremap N Nzzzv

" Move up and down visually. I'm not totally sold on this...

nnoremap j gj
nnoremap k gk

" }}}
" Split windows {{{

" leader-w makes a new split and moves to it

nnoremap <leader>w <C-w>v<C-w>l

" leader-W makes a new horizontal split and moves to it

nnoremap <leader>W <C-w>s<C-w>j

" Remap ctrl-movement keys to move to adjacent splits

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

" Map arrow keys to move to adjacent splits also

nnoremap <silent> <left> :TmuxNavigateLeft<cr>
nnoremap <silent> <down> :TmuxNavigateDown<cr>
nnoremap <silent> <up> :TmuxNavigateUp<cr>
nnoremap <silent> <right> :TmuxNavigateRight<cr>

" Resize splits when resizing vim

au VimResized * :wincmd =

" }}}
" Tabs {{{

" Remap leader-t to make a new tab

nmap <silent> <leader>t :tabnew <CR>

" Remap ]w to next tab

nmap <silent> ]w :tabnext <CR>
nmap <silent> [w :tabprevious <CR>

" }}}
" Line handling {{{

set formatoptions=qrn1

" Split lines (opposite of [J]oining lines)

nnoremap S i<cr><esc><right>

" }}}
" Filetypes {{{

filetype plugin indent on

" }}}
" Visual styling {{{

" Highlight folds to be the same as the background

hi Folded ctermbg=black

" Font

if has('gui_running')
    set guifont=Menlo\ Regular:h11
endif

" Turn on syntax highlighting

syntax on

" Advertise that our terminal supports 256 colors

set t_Co=256

" Disable everything in the GUI by passing empty guioptions

set guioptions=

" }}}
" Status Line {{{

" Divided into two sides:

" Left:

" Branch
" Notice that this doesn't start with a +=. This resets the statusline in the
" event that the .vimrc is reloaded

set statusline=%{fugitive#head()}

" Path

set statusline+=\ %F

" Modified state

set statusline+=\ %m

" Right:

" Delimeter character

set statusline+=%=

" Line

set statusline+=\ %l
set statusline+=\/

" Total lines

set statusline+=\%L

" Always hide the status line. This can always be re-enabled.

set statusline+=\ %P\ :

" Line

set statusline+=\ %l:

" Column

set statusline+=\ %c\
set laststatus=0

" }}}
" Line numbers {{{

let g:NumbersShowing = exists('w:NumbersShowing') ? w:NumbersShowing : 0

function ShowLineNumbers()
    let g:NumbersShowing = 1
    set number
    set relativenumber
endfunction

function HideLineNumbers()
    let g:NumbersShowing = 0
    set nonumber
    set norelativenumber
endfunction

function ToggleNumbers()
    if g:NumbersShowing
        call HideLineNumbers()
    else
        call ShowLineNumbers()
    endif
endfunction

nmap <silent> <leader>n :call ToggleNumbers() <CR>

" }}}
" Mouse Support {{{

" Turn on mouse support

set mouse=a

" }}}
" Folding {{{

" On insertion entering / leaving (or window leaving), disable folding
" This causes significant speed increases when using folds

autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" Toggle folds with Space

nnoremap <Space> za
vnoremap <Space> za

" }}}
" NeoBundle Setup {{{

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" }}}
" List of Plugins {{{

" Editing:

NeoBundle 'keith/swift.vim'
NeoBundle 'dag/vim-fish'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'tpope/vim-afterimage'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-obsession'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-vinegar'

" Syntax:

NeoBundle 'ervandew/supertab'
NeoBundle 'godlygeek/tabular'
NeoBundle 'jpalardy/vim-slime'

" Colors:

" Misc:

NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'mbbill/undotree'
NeoBundle 'vim-scripts/scratch.vim'
NeoBundle 'junegunn/vim-peekaboo'
NeoBundle 'christoomey/vim-tmux-navigator'

" Prose:

NeoBundle 'junegunn/goyo.vim'
NeoBundle 'reedes/vim-pencil'
NeoBundle 'reedes/vim-lexical'
NeoBundle 'reedes/vim-wordy'

call neobundle#end()

NeoBundleCheck

" Enable matchit, which has smarter matching support (HTML tags, etc.)

runtime macros/matchit.vim

" }}}
" Plugin Settings {{{

" Commentary

nmap <leader>/ :Commentary <CR>
vmap <leader>/ :Commentary <CR>

" Ctrl-P

set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_map = '<leader>,'
let g:ctrlp_switch_buffer = 0

" Fugitive

" Map leader-b to blame

nmap <silent> <leader>b :Gblame <CR>

" undotree

" Map control-u to toggle undotree

nmap <silent> <C-u> :UndotreeToggle<CR>

" vim-slime

" Activate tmux, my multiplexer of choice

let g:slime_target = "tmux"

" Default to a tmux configuration with a REPL on the right and editor on the
" left

let g:slime_default_config = {"socket_name": "default", "target_pane": ":.1"}

" }}}
" Prose mode configuration {{{

let g:ProseModeActive = exists('w:ProseModeActive') ? w:ProseModeActive : 0

function EnterProseMode()
    let g:ProseModeActive = 1
    Goyo
    SoftPencil
    call lexical#init()
    set nocursorline
endfunction

function ExitProseMode()
    let g:ProseModeActive = 0
    Goyo!
    NoPencil
    set cursorline
endfunction

function ToggleProseMode()
    if g:ProseModeActive
        call ExitProseMode()
    else
        call EnterProseMode()
    endif
endfunction

nmap <silent> <leader>e :call ToggleProseMode() <CR>

" }}}
" Marked 2.app Integration {{{

function OpenInMarked2()
    !open -a Marked\ 2.app %
endfunction

nmap <silent> <leader>m :call OpenInMarked2() <CR> <CR>

" }}}
" Misc. {{{

" Don't be `vi` compatible
set nocompatible

" Change the default shell vim uses to avoid a warning from Syntastic
set shell=bash

" Change vim's character encoding to UTF-8
set encoding=utf-8

" Never let there be less than 15 spaces above/below the insertion point
set scrolloff=15

" Automatically indent
set autoindent

" Show the current mode
set showmode

" Enable wildcard matching for commands. Complete until the longest common
" string
set wildmenu
set wildmode=list:longest

" Instead of beeping, use the visual bell
set visualbell

" Not sure.
set backspace=indent,eol,start

" Only show the tab line if there are >1 tabs
set showtabline=1

" Keep an undo file. TODO: Do we need this? Seems annoying...
set undofile

" Don't keep a backup file or swap file
set nobackup
set noswapfile

" Save all the time, automatically. It's 2015, computers should do this.
set autowriteall

" If a file has changed outside of vim, reload it (it seems MacVim may do this
" automatically, but terminal vim does not)
set autoread

" Sets up the clipboard to interface with the system clipboard
set clipboard=unnamed

" Turn on ttyfast and lazyredraw for speed in the Terminal
set ttyfast
set lazyredraw

" Disable non-text characters by coloring them like the background
highlight EndOfBuffer ctermfg=black ctermbg=black

" Don't show text control characters
set nolist

" Let filetype plugins do indents
if has('autocmd')
  filetype plugin indent on
endif

" Turn on syntax highlighting if possible
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Turn on "smarttab" for tab insertion / deletion
set smarttab

" For combos, give me 100 units of time (ms?) to hit a combo
set ttimeout
set ttimeoutlen=100

" Delete comment character when joining commented lines
set formatoptions+=j 

" Have a command history of 1000
set history=1000

" Not sure
if !empty(&viminfo)
  set viminfo^=!
endif

" }}}
