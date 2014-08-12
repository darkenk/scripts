" force to use local .vimrc if present
set exrc
set secure

" install pathogen
execute pathogen#infect()

" syntax highlight
syntax on
filetype plugin indent on

" display white charactesrs
:set listchars=tab:>-,trail:~,extends:>,precedes:<
:set list

" turn on indentation
:set autoindent

" project specific
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" put color line at 110
set colorcolumn=110
highlight ColorColumn ctermbg=darkgreen
