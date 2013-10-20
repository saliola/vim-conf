set lines=49 columns=90
set guifont=Andale\ Mono\ 9

" remove toolbars, menubars, scrollbars, etc.
set guioptions-=T "no toolbar
set guioptions-=m "no menubar
set guioptions-=e "use text tabline instead of gui tabline
set guioptions-=l "no lefthand scrollbar
set guioptions-=r "no righthand scrollbar
set guioptions-=b "no bottom scrollbar

" disable the mouse!
set mouse=
map <ScrollWheelDown> <nop>
map <ScrollWheelUp> <nop>
map <ScrollWheelRight> <nop>
map <ScrollWheelLeft> <nop>

" unmap and reassign the Cmd-t key in the menu item of MacVim
if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  noremap  <D-t> :call RunTeXShop()<CR>
  inoremap <D-t> <C-o>:call RunTeXShop()<CR>
endif
