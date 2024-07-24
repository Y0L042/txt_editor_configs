" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" disable vi compatibility (emulation of old bugs)
set nocompatible

" use indentation of previous line
set autoindent

" use intelligent indentation for C
set smartindent
set backspace=indent,eol,start

" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
"set expandtab        " expand tabs to spaces

" wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
set textwidth=120

" turn syntax highlighting on
set t_Co=256
syntax on

" colorscheme wombat256
" turn line numbers on
set number
set relativenumber

" Highlight searched terms
set hlsearch

" Highlight matches as you type
set incsearch

" highlight matching braces
set showmatch

" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

" Disable word wrap by default
set nowrap

" Toggle word wrap with F9
nnoremap <F9> :set wrap!<CR>:echo "Word wrap: " . (&wrap ? "ON" : "OFF")<CR>

" Function to check if the current buffer is netrw
function! IsNetrw()
  return &filetype ==# 'netrw'
endfunction

" Define the key mapping to save changes, close the buffer, and open netrw
" but only if the current buffer is not netrw
autocmd FileType * if !IsNetrw() | nnoremap <buffer> <F1> :update <bar> bd <bar> Explore <CR> | inoremap <buffer> <F1> <ESC>:update <bar> bd <bar> Explore <CR> | endif

" Clear the <F1> mapping in netrw buffers
autocmd FileType netrw nnoremap <buffer> <F1> <Nop>




" Ps = 0  -> blinking block.
" Ps = 1  -> blinking block (default).
" Ps = 2  -> steady block.
" Ps = 3  -> blinking underline.
" Ps = 4  -> steady underline.
" Ps = 5  -> blinking bar (xterm).
" Ps = 6  -> steady bar (xterm).

" Cursor shape configuration
" Use a vertical bar cursor in insert mode
let &t_SI = "\e[3 q"
" Use a block cursor in normal mode
let &t_EI = "\e[2 q"


" reset the cursor on start (for older versions of vim, usually not required)
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END



" Enhanced keyboard mappings
"

" in normal mode F2 will save the file
nmap <F2> :w<CR>

" in insert mode F2 will exit insert, save
imap <F2> <ESC>:w<CR>

" Save the current file and switch between header and source files in normal mode
nmap <F4> :w<CR>:e %:p:s,.h$,.X123X,:s,\.\(c\)$,.h,:s,.X123X$,.c,<CR>

" Save the current file and switch between header and source files in insert mode
imap <F4> <Esc>:w<CR>:e %:p:s,.h$,.X123X,:s,\.\(c\)$,.h,:s,.X123X$,.c,<CR>i

" goto definition with F12
map <F12> <C-]>
