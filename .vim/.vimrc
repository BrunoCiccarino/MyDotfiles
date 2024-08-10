" Maintainer:
"               Bruno Ciccarino
" License:
"               GPL-3


" Plugins

source ~/.vim/plugins/gardenal.vim

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'preservim/nerdtree'
Plugin 'morhetz/gruvbox'
Plugin 'luochen1990/rainbow'
Plugin 'jiangmiao/auto-pairs'
Plugin 'ryanoasis/vim-devicons'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'mhinz/vim-startify'
Plugin 'neoclide/coc.nvim'
Plugin 'sheerun/vim-polyglot'
Plugin 'gabrielelana/vim-markdown'
Plugin 'airblade/vim-gitgutter'
Plugin 'Yggdroot/indentLine.git'
Plugin 'AndrewRadev/tagalong.vim'
Plugin 'mattesgroeger/vim-bookmarks'
Plugin 'tpope/vim-commentary'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'mboughaba/i3config.vim'
Plugin 'mattn/emmet-vim'
Plugin 'jreybert/vimagit'
Plugin 'dracula/vim', {'name': 'dracula'}

call vundle#end()
filetype plugin on
filetype plugin indent on

let themes = ['solarized', 'gruvbox', 'dracula']

call MapThemeSwitcherKeys(themes)
nnoremap <silent> 1 :call ThemeSwitcher(themes, 1)<CR>
nnoremap <silent> 2 :call ThemeSwitcher(themes, 2)<CR>
nnoremap <silent> 3 :call ThemeSwitcher(themes, 3)<CR>

" Global sets
syntax on
set hidden
set incsearch
set smartcase
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
set ttyfast
set complete-=i
set lazyredraw
filetype on
filetype plugin on
filetype indent on

" Vim Airline
let g:airline_theme='violet'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1


function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction


let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]

let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 0

function! Run(arq)
  :w
  if &filetype == 'go'
    :exec '!go run' a:arq
  elseif &filetype == 'python'
    :exec '!pypy' a:arq '|| python3' a:arq
  elseif &filetype == 'javascript'
    :exec '!node' a:arq
  elseif &filetype == 'c'
    :exec '!clang' a:arq '|| gcc' a:arq
  elseif &filetype == 'rust'
    :exec "!cargo-fmt"
    :exec '!cargo-clippy && cargo run || cargo run || rustc' a:arq
  elseif &filetype == 'typescript'
    :exec '!tsc -w' a:arq
  elseif &filetype == 'cpp'
    :exec '!clang++' a:arq '|| g++' a:arq
  elseif &filetype == 'ruby'
    :exec '!ruby' a:arq
  elseif &filetype == 'php'
    :exec '!php' a:arq
  elseif &filetype == 'java'
    :exec '!javac' a:arq
  elseif &filetype == 'cs'
    :exec '!dotnet run'
  elseif &filetype == 'matlab'
    :exec '!gcc `gnustep-config --objc-flags` -lgnustep-base' a:arq
  elseif &filetype == 'swift'
    :exec '!swift' a:arq
  elseif &filetype == 'perl'
    :exec '!perl' a:arq
  elseif &filetype == 'sh'
    :exec '!bash' a:arq
  elseif &filetype == "lisp"
    :exec "!sbcl --script" a:arq
  elseif &filetype == "prolog"
    :exec "!swipl" a:arq
  elseif &filetype == "haskell"
    :exec "!stack run || cabal run || ghc" a:arq
  elseif &filetype == "elixir"
    :exec "!elixir" a:arq
  endif
endfunction
noremap <C-g> :call Run(shellescape(@%, 1))<CR>

" Keyboard shortcuts

" Close atual buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT
" Open next buffer
map <leader>l :bnext<cr>
" Open previous buffer
map <leader>h :bprevious<cr>