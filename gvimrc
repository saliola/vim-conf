set lines=49 columns=90
"set guifont=Ubuntu\ Mono\ 12
set guifont=Andale\ Mono\ 9

set guioptions-=T "no toolbar
set guioptions-=m "no menubar
set guioptions-=e "use text tabline instead of gui tabline
set guioptions-=l "no lefthand scrollbar
set guioptions-=r "no righthand scrollbar
set guioptions-=b "no bottom scrollbar

" relative line numbers
set relativenumber " set number
set colorcolumn=80

" disable spellcheck
set nospell

" disable mouse!
set mouse=
map <ScrollWheelDown> <nop>
map <ScrollWheelUp> <nop>
map <ScrollWheelRight> <nop>
map <ScrollWheelLeft> <nop>

" solarized is enabled in .vimrc.after
"syntax enable " enable syntax highlighting
"set background=dark
"colorscheme solarized

"highlight Search gui=underline guifg=Yellow guibg=#302028
match ErrorMsg /\t/

"hi CursorColumn guibg=grey10
"hi CursorLine guibg=grey10
set cursorline
set cursorcolumn

" Syntastic: enable marking of syntax errors in gui (disabled for terminal)
let g:syntastic_enable_signs=1

" unmap and reassign the Cmd-t key in the menu item of MacVim
if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  noremap  <D-t> :call RunTeXShop()<CR>
  inoremap <D-t> <C-o>:call RunTeXShop()<CR>
endif
