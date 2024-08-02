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
set textwidth=125

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

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10



" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Toggle word wrap with F9
nnoremap <F9> :set wrap!<CR>:echo "Word wrap: " . (&wrap ? "ON" : "OFF")<CR>





" Set the cursor shape configuration
" Use a horizontal bar cursor with 50% height in insert mode
"set guicursor=i:hor75

" Alternatively, you can use a different percentage for the desired thickness
" For example, to use a 30% horizontal bar cursor in insert mode:
" set guicursor=i:hor30

" Use a block cursor in normal mode
"set guicursor+=n:block

" Ps = 0  -> blinking block.
" Ps = 1  -> blinking block (default).
" Ps = 2  -> steady block.
" Ps = 3  -> blinking underline.
" Ps = 4  -> steady underline.
" Ps = 5  -> blinking bar (xterm).
" Ps = 6  -> steady bar (xterm).

" Cursor shape configuration
" Use a horizontal bar cursor in insert mode
let &t_SI = "\e[1 q"
" Use a block cursor in normal mode
let &t_EI = "\e[2 q"

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Highlight cursor line underneath the cursor vertically.
"set cursorcolumn

" reset the cursor on start (for older versions of vim, usually not required)
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END







" Enhanced keyboard mappings
"

" in normal mode F2 will save the file
nmap <F2> :update<CR>

" in insert mode F2 will exit insert, save
imap <F2> <ESC>:update<CR>

" Save the current file and switch between header and source files in normal mode
"nmap <F4> :update<CR>:e %:p:s,.h$,.X123X,:s,\.\(c\)$,.h,:s,.X123X$,.c,<CR>

" Save the current file and switch between header and source files in insert mode
"imap <F4> <Esc>:update<CR>:e %:p:s,.h$,.X123X,:s,\.\(c\)$,.h,:s,.X123X$,.c,<CR>



" Switch between header/source with F4 (change between .c & .cpp)
nnoremap <F4> :update<CR>:e %:p:s,.h$,.X123X,:s,\\.c$,\\.h,:s,.X123X$,.c,<CR>
inoremap <F4> <ESC>:update<CR>:e %:p:s,.h$,.X123X,:s,\\.c$,\\.h,:s,.X123X$,.c,<CR>
vnoremap <F4> <ESC>:update<CR>:e %:p:s,.h$,.X123X,:s,\\.c$,\\.h,:s,.X123X$,.c,<CR>

" Switch between header/source and search for selected text/text under cursor with Shift+F4
nnoremap <S-F4> :let @/ = expand('<cword>')<CR>:update<CR>:e %:p:s,.h$,.X123X,:s,\\.c$,\\.h,:s,.X123X$,.c,<CR>ggnzt
inoremap <S-F4> <ESC>:let @/ = expand('<cword>')<CR>:update<CR>:e %:p:s,.h$,.X123X,:s,\\.c$,\\.h,:s,.X123X$,.c,<CR>ggnzt
vnoremap <S-F4> y:let @/ = @0<CR>:update<CR>:e %:p:s,.h$,.X123X,:s,\\.c$,\\.h,:s,.X123X$,.c,<CR>ggnzt




" Function to check if the current buffer is netrw
function! IsNetrw()
  return &filetype ==# 'netrw'
endfunction

" Define the key mapping to save changes, close the buffer, and open netrw
" but only if the current buffer is not netrw
autocmd FileType * if !IsNetrw() | nnoremap <buffer> <F1> :update <bar> bd <bar> Explore <CR> | inoremap <buffer> <F1> <ESC>:update <bar> bd <bar> Explore <CR> | endif
" Clear the <F1> mapping in netrw buffers
autocmd FileType netrw nnoremap <buffer> <F1> <Nop>


" goto definition with F12
map <F12> <C-]>



function! SaveAllTabs()
  " Save the current tab, window, and buffer number
  let l:current_tab = tabpagenr()
  let l:current_win = winnr()
  let l:current_buf = bufnr('%')

  " Enable 'hidden' option
  set hidden

  " Save all modified buffers
  tabdo windo if &modified | update | endif

  " Revert to 'nohidden' option
  set nohidden

  " Restore the original tab
  exec 'tabnext' l:current_tab

  " Restore the original window within the tab
  exec l:current_win . 'wincmd w'

  " Restore the original buffer within the window
  if bufnr('%') != l:current_buf
    exec 'buffer' l:current_buf
  endif
endfunction

" Map F5 to call the SaveAllTabs function
nnoremap <F5> :call SaveAllTabs()<CR>
