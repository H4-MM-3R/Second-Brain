" .obsidian.vimrc
"
" A small .vimrc for Obsidian vim bindings
"
" To enable this file, you must install the Vimrc Support plugin for Obsidian:
" https://github.com/esm7/obsidian-vimrc-support
"_________________________________________________________________________

" ; (semicolon) - same as : (colon)
nmap ; :

" (space) - same as : (colon)
nmap <SPACE> :

" j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk
imap jj <Esc>