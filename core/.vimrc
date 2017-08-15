set nocompatible              " be iMproved, required
filetype off                  " required

filetype plugin indent on    " required

"test again
" Need to vet this section
"if has('cscope')
"    set cscopetag
"
"    if has('quickfix')
"        set cscopequickfix=s-,c-,d-,i-,t-,e-
"    endif
"
"    cnoreabbrev csa cs add
"    cnoreabbrev csf cs find
"    cnoreabbrev csk cs kill
"    cnoreabbrev csr cs reset
"    cnoreabbrev css cs show
"    cnoreabbrev csh cs help
"
"    "command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
"endif

set nocompatible                " choose no compatibility with legacy vi
syntax enable     "   'syntax on'   is kinda incorrect
set encoding=utf-8
set showcmd                     " display incomplete commands

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=5 shiftwidth=4      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" workaround for tough to see dark blue comments in some terminals
hi Comment ctermfg=DarkGreen

" associate *.tsx with js filetype
au BufRead,BufNewFile *.tsx setfiletype javascript

" show line numbers
set number

" whitespace highlighting
:highlight ExtraWhitespace ctermbg=red
:match ExtraWhitespace /\s\+$/

" trim command to remove trailing whitespace
command! Trim :%s/\s\+$//e

" Create newlines
" Jump cluttering variant
nmap oo m`o<Esc>``
nmap OO m`O<Esc>``

" usefull for oo commands
" although only really needed if not typing o on next line
set timeoutlen=200
" Very iritated that cscope leader <C-_> will not block, even though there is
" no non-suffixed use for it alone to timeout to.
" Not consistent behavior with commands such as 'd' which will ignore timeout and wait forever.
" Had to setup special cscope handling functions to generate this delay.
" Can verify with the following
"unmap <C-_> " unnecessary, already unbound
"map <C-_>a :echo "cscope a - I will timeout"<CR>

" Map undo to cap U (previous function undoes all in line... useless)
noremap U <c-r>
"map <C-r> :echo "Ctrl-R is unbound"<CR> "not sure what I want to do with this yet
map <C-r> :source ~/.vimrc<CR> " Reload config

" Map ctrl-C to escape in insert mode - allows block insert to apply
inoremap <C-c> <Esc>

"folding - doesn't work well for GNU block style with openening brace on
"newline
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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE settings for vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim...
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " Only add cscope db if not already done through system config
    if system("grep -q cscope /etc/vimrc")
        " add any cscope database in current directory
        if filereadable("cscope.out")
            cs add cscope.out
        " else add the database pointed to by environment variable
        elseif $CSCOPE_DB != ""
            cs add $CSCOPE_DB
        endif
    endif

    " show msg when any other cscope db added
    set cscopeverbose

    " Refresh database
    map <F5> :!cscope -b<CR>:cs reset<CR><CR>

    """"""""""""" cscope/vim key mappings

    "          Leader options
    " Ctrl-Space       horizontal split for result
    " Ctrl-Space-Space   vertical split for result
    " Ctrl--   Result in same window

    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "

    " Workaround functions to ignore timeout - stall forever
    " May want to mark as script scope, s: <SNR>
    " The ! allows resourcing without errors
    function! CscopeDash()
        echom "Jump: sym, glob, call, txt, egrep, file, inc, calleD"
        let char=getchar()
        if type(char)==type(0) | let char=nr2char(char) | endif

        if char is# 'i'
            return ':cs find ' . char . ' ^' . expand("<cword>") . '$'
        endif
        return ':cs find ' . char . ' ' . expand("<cword>")
    endfunction

    nnoremap <expr> <C-_> CscopeDash() . "\<CR>"


    function! CscopeSpace()
        echom "Jump: sym, glob, call, txt, egrep, file, inc, calleD"
        let char=getchar()
        if type(char)==type(0) | let char=nr2char(char) | endif

        if char is# 'i'
            return ':scs find ' . char . ' ^' . expand("<cword>") . '$'
        endif
        return ':scs find ' . char . ' ' . expand("<cword>")
    endfunction

    nnoremap <expr> <C-@> CscopeSpace() . "\<CR>"


    function! CscopeSpaceSpace()
        echom "Jump: sym, glob, call, txt, egrep, file, inc, calleD"
        let char=getchar()
        if type(char)==type(0) | let char=nr2char(char) | endif

        if char is# 'i'
            return ':vert scs find ' . char . ' ^' . expand("<cword>") . '$'
        endif
        return ':vert scs find ' . char . ' ' . expand("<cword>")
    endfunction

    nnoremap <expr> <C-@><C-@> CscopeSpaceSpace() . "\<CR>"

else
    echom "No CSCOPE"

endif

