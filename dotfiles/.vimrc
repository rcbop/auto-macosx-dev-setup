" Fix Delete (backspace) on Mac OS X
set backspace=2

" Enable syntax highlighting
syntax on

" Indentation
set autoindent
filetype plugin indent on
set shiftwidth=4
" Use OS clipboard for copypasta
set clipboard=unnamed

" Enable OS mouse clicking and scrolling
"
" Note for Mac OS X: Requires SIMBL and MouseTerm
"
" http://www.culater.net/software/SIMBL/SIMBL.php
" https://bitheap.org/mouseterm/
if has("mouse")
   set mouse=a
endif

" Bash-style tab completion
set wildmode=longest,list
set wildmenu

" No swap files, use version control instead
set noswapfile

" Emacs-style start of line / end of line navigation
nnoremap <silent> <C-a> ^
nnoremap <silent> <C-e> $
vnoremap <silent> <C-a> ^
vnoremap <silent> <C-e> $
inoremap <silent> <C-a> <esc>^i
inoremap <silent> <C-e> <esc>$i

inoremap <C-s> <esc>:w<cr>                 " save files
nnoremap <C-s> :w<cr>
inoremap <C-d> <esc>:xa!<cr>               " save and exit
nnoremap <C-d> :xa!<cr>
nnoremap <C-o> :CommandT<enter>

" Emacs-style line cutting
nnoremap <C-k> d$
vnoremap <C-k> d$
inoremap <C-k> <esc>d$i

vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

inoremap <Tab> <C-N>
inoremap <S-Tab> <C-P>

" Fix Alt key in MacVIM GUI
" TODO - Fix in MacVIM terminal
if has("gui_macvim")
  set macmeta
endif

" Do not attempt to fix style on paste
" Normally we would just `set paste`, but this interferes with other aliases.
nnoremap <silent> p "+p

" Disable comment continuation on paste
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Show line numbers
set number
" Show statusline
set laststatus=2

" Case-insensitive search
set ignorecase

" Highlight search results
set hlsearch

" Default to soft tabs, 2 spaces
set expandtab
set sw=2
set sts=2
" Except for Makefiles: Hard tabs of width 2
autocmd FileType make set ts=2
" And Markdown
autocmd FileType mkd set sw=4
autocmd FileType mkd set sts=4
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.cql set filetype=cql
autocmd BufRead,BufNewFile *.sh set filetype=sh

" And Java
autocmd FileType java set sw=2

" Default to Unix LF line endings
set ffs=unix

" Folding
set foldmethod=syntax
set foldcolumn=1
set foldlevelstart=20

let g:vim_markdown_folding_disabled=1 " Markdown
let javaScript_fold=1                 " JavaScript
let perl_fold=1                       " Perl
let php_folding=1                     " PHP
let r_syntax_folding=1                " R
let ruby_fold=1                       " Ruby
let sh_fold_enabled=1                 " sh
let vimsyn_folding='af'               " Vim script
let xml_syntax_folding=1              " XML

" ignore files
set wildignore=*.swp,*.bak,*.pyc,*.class,*.jar,*.gif,*.png,*.jpg
"
" Wrap window-move-cursor
"
function! s:GotoNextWindow( direction, count )
  let l:prevWinNr = winnr()
  execute a:count . 'wincmd' a:direction
  return winnr() != l:prevWinNr
endfunction

function! s:JumpWithWrap( direction, opposite )
  if ! s:GotoNextWindow(a:direction, v:count1)
    call s:GotoNextWindow(a:opposite, 999)
  endif
endfunction

nnoremap <silent> <C-w>h :<C-u>call <SID>JumpWithWrap('h', 'l')<CR>
nnoremap <silent> <C-w>j :<C-u>call <SID>JumpWithWrap('j', 'k')<CR>
nnoremap <silent> <C-w>k :<C-u>call <SID>JumpWithWrap('k', 'j')<CR>
nnoremap <silent> <C-w>l :<C-u>call <SID>JumpWithWrap('l', 'h')<CR>
nnoremap <silent> <C-w><Left> :<C-u>call <SID>JumpWithWrap('h', 'l')<CR>
nnoremap <silent> <C-w><Down> :<C-u>call <SID>JumpWithWrap('j', 'k')<CR>
nnoremap <silent> <C-w><Up> :<C-u>call <SID>JumpWithWrap('k', 'j')<CR>
nnoremap <silent> <C-w><Right> :<C-u>call <SID>JumpWithWrap('l', 'h')<CR>

function! StartUp()
  if 0 == argc()
    NERDTree
  end
endfunction

autocmd VimEnter * call StartUp()
au VimEnter *  NERDTree
autocmd VimEnter * wincmd p

"
" Vundle
" https://github.com/gmarik/vundle
"
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
  Plugin 'gmarik/Vundle.vim'
  Plugin 'gmarik/vundle'
  Plugin 'kien/ctrlp.vim'
  Plugin 'tpope/vim-fugitive'
  Plugin 'tomtom/tcomment_vim'
  Plugin 'bling/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'
  Plugin 'benjaminwhite/Benokai'
  Plugin 'wting/rust.vim'
  Plugin 'godlygeek/tabular'
  Plugin 'plasticboy/vim-markdown'
  Plugin 'mtth/scratch.vim'
  Plugin 'editorconfig/editorconfig-vim'
  Plugin 'altercation/vim-colors-solarized'
  Plugin 'Filesearch'
  Plugin 'SearchComplete'
  Plugin 'scrooloose/nerdtree'
  Plugin 'wincent/command-t'
  Plugin 'Townk/vim-autoclose'
  Plugin 'mileszs/ack.vim'
call vundle#end()

function! NumberToggle()
  if(&relativenumber == 1)
    set number
      else
        set relativenumber
      endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

" Enable Powerline fonts for airline
let g:airline_powerline_fonts = 1
let g:airline_theme='distinguished'

"colorscheme Benokai

" For solarized plugin (color scheme)
" https://github.com/altercation/vim-colors-solarized
syntax enable
set background=dark
colorscheme solarized

" Column 80 marker
highlight OverLength ctermbg=darkred ctermfg=white guibg=#660000
match OverLength /\%121v.\+/

" " Currently broken due to Vim/Semicolon issues
" " Alt+; to toggle comments
" nnoremap <silent> <M-;> gc
" vnoremap <silent> <M-;> gc
" inoremap <silent> <M-;> <esc>gci

" Scratch splits the current window in half
let g:scratch_height = 0.50
" Scratch opens in Markdown format
let g:scratch_filetype = 'markdown'

" ~/.vim/ftplugin/sh.vim
function! ShellCheck()
  set makeprg=shellcheck\ -x\ -f\ gcc\ %
  au BufWritePost * :silent make | redraw!
  au QuickFixCmdPost [^l]* nested cwindow
  au QuickFixCmdPost    l* nested lwindow
endfunction

nnoremap <C-i> :call ShellCheck()<cr>
