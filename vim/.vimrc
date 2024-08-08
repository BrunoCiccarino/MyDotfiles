call plug#begin(~/.vim/plugged)
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call plug#end()


" Global sets
syntax on
set hidden
set incsearch
set smartcase
set cmdheight 3
set updatetime=100
set colorcolumn=100
set encoding=utf-8
set autoread
set number          
set expandtab        
set shiftwidth=4     
set tabstop=4        
set autoindent       
set smartindent   
set nobackup
set splitright
set splitbelow
set mouse=a
filetype on
filetype plugin on
filetype indent on

" Themes
colorscheme neko

" Vim airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1


