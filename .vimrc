set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

Plugin 'coderifous/textobj-word-column.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

if has('cscope')
    set cscopetag

    if has('quickfix')
        set cscopequickfix=s-,c-,d-,i-,t-,e-
    endif

    cnoreabbrev csa cs add
    cnoreabbrev csf cs find
    cnoreabbrev csk cs kill
    cnoreabbrev csr cs reset
    cnoreabbrev css cs show
    cnoreabbrev csh cs help

    command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
endif

set nocompatible                " choose no compatibility with legacy vi
syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=4 shiftwidth=4      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

hi Comment ctermfg=DarkGreen

set number

" whitespace highlighting
:highlight ExtraWhitespace ctermbg=red
:match ExtraWhitespace /\s\+$/

nmap oo o<Esc>k
nmap OO O<Esc>j

" usefull for oo commands
" although only really needed if not typing o on next line
"set timeoutlen=200
set timeoutlen=1000

" Map undo to cap U (normall undo all in line... useless)
map U <c-r>

"folding
"set foldmethod=syntax

" going to try a manual approach
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" Horizontal scroll
" Should get comfortable with the z commands instead
"  zs is to start text at cursor is useful
"map <C-L> 5zl " Scroll 5 characters to the right
"map <C-H> 5zh " Scroll 5 characters to the left

" Disable auto commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Less annoying auto c comments (subset of above)
"au FileType c,cpp,cc,h setlocal comments-=:// comments+=f://

" apply .lst / .asm syntax highlighting to .rst files
autocmd BufNewFile,BufRead *.rst   set syntax=asm


" This may get really messy and require movement reminds for all vim-mode
" tools
" tmux custom and existing nav, less, slickedit, man browse, etc.
"Movement:
"h left same
"t up   til.. need a good replacement
"n down next.. need a good replacement
"s right  subst char. never used, although subst line could be nice
"
"Now available:
"Need to figure out a look mneumonic
"l - look (till or next)
"    good layout relation between t and f
"k - kill line / char
"j - jump (till or next)
"
"j - next
"k - till
"l - subst
