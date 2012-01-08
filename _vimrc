"
"
" My Vimrc file
" Maintainer:	Isaiah Qian <qianlongzju@gmail.com>
" Last change:	2011-07-28 Thu 03:22 PM
"
"

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" set maximum width of text that is being inserted.
set textwidth=78

" enable syntax highlighting
syntax on

if has('gui_running')
    set background=light
else
    set background=dark
endif

filetype plugin indent on

" set list

" Set color scheme that I like.
" colorscheme evening
colorscheme murphy

" Automatically indent when adding a curly bracket, etc.
" All indent options: autoindent smartindent cindent
" Tip: `set paste` when pasting text into vim to avoid unnecessary
" indentation, then `set nopaste` to recover the indent option
set smartindent
set shiftwidth=4
set softtabstop=4
set tabstop=4
set smarttab
set expandtab

" for spell checking
" setlocal spell spelllang=en

if has('win32')
    set backspace=indent,eol,start  whichwrap+=<,>,[,]
else " on my Linux
    " Set the current language (aka locale).
    language en_US.UTF-8

    " Use UTF-8
    set encoding=utf-8
    " Use cp936 on windows
endif

" Set the character encoding for the file of this buffer
set fileencoding=utf-8

" set a list of fileencodings
set fileencodings=ucs-bom,utf8,cp936,big5

" Show line number, cursor position.
set ruler		

" Display incomplete commands
set showcmd		

" Show autocomplete menus.
set wildmenu

" Show editing mode
set showmode

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" To insert timestamp, press F3.
nmap <F3> a<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>

" Search as you type
set incsearch

" Ignore case when searching
set ignorecase

" Overide the 'ignorecase' option if the search pattern contains upper case
" characters.
set smartcase

" Switch on highlighting the last used search pattern
set hlsearch    

" In many terminal emulators the mouse works just fine, thus enable it.
" set mouse=a

" Print the line number in front of each line.
" set number

" When a bracket is inserted, briefly jump to the matching one and be back
set showmatch

" Status line
set laststatus=2
set statusline=
set statusline+=%-3.3n\                         " buffer number
set statusline+=%f\                             " filename
set statusline+=%h%m%r%w                        " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}]    " file type
set statusline+=%=                              " right align remainder
set statusline+=0x%-8B                          " character value
set statusline+=%-14(%l,%c%V%)                  " line, character
set statusline+=%<%P                            " file position

set colorcolumn=80

let $VIMFILES=$HOME.'/.vim'

" persistent undo
set undofile
set undodir=$VIMFILES/\_undodir
set undolevels=1000 "maximum number of changes that can be undone

" Abbreviations for my habit writing
abbreviate qlemail qianlongzju@gmail.com
abbreviate qlnick Isaiah Qian

" Python Coding Setting
autocmd BufRead,BufNewFile *.py nmap <F5> :w<CR>:!python %<CR>
set tags+=$HOME/.vim/tags/python.ctags
python <<EOF
import os
import sys
import vim
for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF
autocmd FileType python set omnifunc=pythoncomplete#Complete

" pyflakes.vim
if has("gui_running")
  highlight SpellBad term=underline gui=undercurl guisp=Orange
endif

" For pydoc.vim
" Usage: 
" :Pydoc os.path
" :PydocSearch foobar
" <leader>pw or <leader>pW
let g:pydoc_cmd="/usr/bin/pydoc"
let g:pydoc_highlight=0

" acp autocomplpop 
let g:acp_behaviorSnipmateLength=1

" vim-latex
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
set completefunc=omnifunc

" Java Coding Setting
autocmd BufRead,BufNewFile *.java nmap <F5> :w<CR>:!javac %<CR>
autocmd BufRead,BufNewFile *.java nmap <F6> :w<CR>:!java %<<CR>

" C Coding Setting
autocmd BufRead,BufNewFile *.c nmap <F5> :w<CR>:!gcc -Wall -std=c99 -lm %<CR>
autocmd BufRead,BufNewFile *.c nmap <F6> :w<CR>:!./a.out<CR>

" CPP Coding Setting
autocmd BufRead,BufNewFile *.cpp nmap <F5> :w<CR>:!g++ -Wall %<CR>
autocmd BufRead,BufNewFile *.cpp nmap <F6> :w<CR>:!./a.out<CR>

" bash Setting
autocmd BufRead,BufNewFile *.sh nmap <F5> :w<CR>:!bash %<CR>

" tex Setting
" autocmd BufRead,BufNewFile *.tex nmap <F5> :w<CR>:!latex %<CR>
autocmd BufRead,BufNewFile *.tex nmap <F6> :!dvipdf %<.dvi<CR>
autocmd BufRead,BufNewFile *.tex nmap <S-F6> :!evince %<.pdf<CR>

" Folding
" set foldmethod=indent

" NERD tree
" autocmd VimEnter * NERDTree

" Project: create a Project-manager kind of usage to Vim
" requierment: project.vim
" :help project.txt
" :Project
" \\c
" za
" Run scripts at the start and end of using a project, this helps setting the
" PATH or setting compiler options and so on.
"
" ctags: cross-references between files, help you jump to the position which
" defines the tag
" requirements: Exuberant ctags, taglist.vim
" :help taglist-intro
" :help taglist
" $etags -R *   --to generate a TAGS file to be used by vim
" :TlistToggle  --Open the taglist window
" :tag foo      --to jump to the definition of foo
" ctrl-]        --to jump to the definition of that symbol
" ctrl-t        --to return to the previous code 
" ctrl-w ]      --to jump to the definition of the symbol in a split window
" :tnext, :tprev, :tfirst, :tlast  -- to move between matching tags
"
"
" cscope
" requirements: cscope, cscope_maps.vim
" :help cscope-intro
" :help cscope-suggestions
" $cscope -R -b --to 'b'uild the database 'r'ecursively for all
" subdirectories.
" NOTE: the previous command only generate the reference files in the home
" directory, and we need first start vim at home directory and then cd to the source
" file directory to use cscope. Need to find a better solution.
" :cscope find symbol foo(:cs f s foo)  --locate the symbol foo
" :cs f g   --find this definition
" :cs f d   --find functions called by this function
" :cs f c   --find functions calling this function
" :cs f t   --find this text string
" :cs f e   --find this egrep pattern
"
"
" TODO
" Source Code Obedience: provides easy shortcut keys on top of cscope/ctags.
" Link: http://www.vim.org/scripts/script.php?script_id=1638
"
" TODO
" c.vim: C/C++ IDE--Write and run programs. Insert statements, idioms,
" comments etc. 
" Link: http://vim.sourceforge.net/scripts/script.php?script_id=213
"
"
"
"
" TODO
" Vim Tip: Using vim as an IDE all in one[http://vim.wikia.com/wiki/Using_vim_as_an_IDE_all_in_one]
" C++/Python Vim+IDE plugins list[http://phraktured.net/vimmity-vim-vim.html]
"
" TODO
" SuperTab[http://www.vim.org/scripts/script.php?script_id=1643]
" python_calltips[http://www.vim.org/scripts/script.php?script_id=1074]

" TODO
" quickfix
"
