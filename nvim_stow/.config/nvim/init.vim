" vundle
set nocompatible
filetype off
set rtp+=~/.config/nvim/bundle/Vundle.vim

" package manager
call vundle#rc('~/.config/nvim/bundle')
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" allignment
Plugin 'junegunn/vim-easy-align'

" surround
Plugin 'tpope/vim-surround'

" Allow surround commands to be repeated
Plugin 'tpope/vim-repeat'

call vundle#end()

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Searching
"set hlsearch                    " highlight matches
"set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
