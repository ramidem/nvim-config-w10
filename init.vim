" Vim Plug
" =============================================================================
call plug#begin('~/AppData/Local/nvim/plugged')

  " Auto pairs for '(' '[' '{'
  Plug 'jiangmiao/auto-pairs'

  " Gruvbox Colorscheme
  Plug 'gruvbox-community/gruvbox'

  " Airline Status Line
  Plug 'vim-airline/vim-airline'

  " Syntax highlighting
  Plug 'sheerun/vim-polyglot'

  " Emmet.Vim
  Plug 'mattn/emmet-vim'

  " Vim Fugitive
  Plug 'tpope/vim-fugitive'

  " Vim Commentary
  Plug 'tpope/vim-commentary'

  " Blamer
  Plug 'APZelos/blamer.nvim'

call plug#end()

" Settings
" =============================================================================

" Color
" -----------------------------------------------------------------------------
syntax on
colorscheme gruvbox
set background=dark

" General Settings
" -----------------------------------------------------------------------------
set autoindent

set cursorline
set clipboard=unnamedplus
set conceallevel=0

set encoding=utf-8
set expandtab

set fileencoding=utf-8
set formatoptions-=cro

set hlsearch

set iskeyword+=-

set ignorecase
set incsearch

set laststatus=2

set mouse=a

set nohlsearch
set noshowmatch
set noshowmode
set noswapfile
set nowrap
set number relativenumber

set pumheight=10

set scrolloff=6
set shiftwidth=2
set showtabline=1
set showcmd
set smartcase
set smartindent
set smarttab
set splitbelow
set splitright

set tabstop=2 softtabstop=2
set termguicolors
set timeoutlen=500
set t_Co=256

set undofile
set undodir=~/.vim/undodir

set showbreak=↪\
set list
set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨

" Thick Black Column
" =============================================================================
set colorcolumn=80
highlight colorcolumn ctermbg=0 guibg=#1b1b1b
highlight OverLength ctermbg=black ctermfg=lightgrey
match OverLength /\%81v.\+/

" copy current file's filename
nmap cp :let @+ = expand("%:t")<CR>

" Mappings
" -----------------------------------------------------------------------------
let mapleader = "\<Space>"

" --- Press `jj` to escape insert mode
:imap jj <Esc>

" --- Space + w = save
noremap <Leader>w :w<CR>

" --- Space + q = quit
nmap <Leader>q :q<CR>

" Tabs
" --- Tab Previous
nmap <S-h> :tabprev<CR>
" --- Tab Next
nmap <S-l> :tabnext<CR>

" --- new tab
nmap te :tabedit<CR>

" --- Space + Q = close current buffer
nmap qq :tabc<CR>

" --- split window: vertical
nmap vv :vs<CR>
nmap vs :sp<CR>

" Panes
" --- Tab Previous
" --- Space + <direction> = switch between windows
noremap <Left> :wincmd h<CR>
noremap <Down> :wincmd j<CR>
noremap <Up> :wincmd k<CR>
noremap <Right> :wincmd l<CR>

" --- Space + x = swap windows
noremap <Leader>x :wincmd x<CR>

" --- Space + > = resize window
noremap <Leader>> :vertical resize 86<CR>

" --- Source vimrc
nnoremap <Leader><CR> :so ~/.vimrc<CR>

" Commentary.Vim
" -----------------------------------------------------------------------------
nnoremap <Leader>/ :Commentary<CR>
vnoremap <Leader>/ :Commentary<CR>

" Run Python file in vim
" https://stackoverflow.com/questions/18948491/running-python-code-in-vim
" -----------------------------------------------------------------------------
" --- Normal mode
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" --- Insert mode
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" Move entire line up or down
" https://stackoverflow.com/questions/741814/move-entire-line-up-and-down-in-vim
" -----------------------------------------------------------------------------
function! s:swap_lines(n1, n2)
  let line1 = getline(a:n1)
  let line2 = getline(a:n2)
  call setline(a:n1, line2)
  call setline(a:n2, line1)
endfunction

function! s:swap_up()
  let n = line('.')
  if n == 1
    return
  endif

  call s:swap_lines(n, n - 1)
  exec n - 1
endfunction

function! s:swap_down()
  let n = line('.')
  if n == line('$')
    return
  endif

  call s:swap_lines(n, n + 1)
  exec n + 1
endfunction

noremap <silent> <A-k> :call <SID>swap_up()<CR>
noremap <silent> <A-j> :call <SID>swap_down()<CR>

" make the current pane obvious when switching to it
" =============================================================================
augroup ReduceNoise
  autocmd!
  autocmd WinEnter * :call ResizeSplits()
augroup END

" https://hackernoon.com/automatic-window-resizing-in-vim-g9n3ueb
function! ResizeSplits()
  if &ft == 'nerdtree'
    return
  elseif &ft == 'qf'
    " Always set quickfix list to a height of 10
    resize 10
    return
  else
    set winwidth=100
    wincmd =
  endif
endfunction

" Vim Airline
" =============================================================================

" enable tabline
let g:airline_extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

" enable powerline fonts
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''

set ttimeoutlen=50
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled = 1

" define the set of names to be displayed instead of a specific filetypes
" (for section a and b):
let g:airline_filetype_overrides = {
      \ 'help':  [ 'H', '%f'  ],
      \ 'minibufexpl': [ 'MiniBufExplorer', ''  ],
      \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', 'NERD'), ''  ],
      \ 'startify': [ 'startify', ''  ],
      \ 'vim-plug': [ 'Plugins', ''  ],
      \ }

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.dirty='✗'

" Blamer
" =============================================================================
let g:blamer_enabled = 1
let g:blamer_delay = 300
let g:blamer_template = '<committer> - <summary> - <committer-time>'
let g:blamer_date_format = '%d/%m/%y'
let g:blamer_relative_time = 1
let g:blamer_show_in_visual_modes = 0
let g:blamer_show_in_insert_modes = 0
