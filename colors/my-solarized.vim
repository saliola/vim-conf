hi clear
if exists("syntax_on")
    syntax reset
endif

syntax enable

" Load Solarized {{{ "

set t_Co=256
let g:solarized_termtrans = 1
let g:solarized_termcolors=256
let g:solarized_underline=0
let g:solarized_bold=0
let g:solarized_italic=0

runtime colors/solarized.vim

let g:colors_name = "my-solarized"

" }}} Load Solarized "

" Cursorline / CursorColumn {{{ "

set cursorline
set cursorcolumn

if &background == "dark"
    highlight SignColumn        cterm=None ctermfg=239 ctermbg=235 guifg=Yellow
    highlight SignifySignAdd    cterm=bold ctermfg=119 ctermbg=235
    highlight SignifySignDelete cterm=bold ctermfg=167 ctermbg=235
    highlight SignifySignChange cterm=bold ctermfg=227 ctermbg=235

    highlight CursorLine    ctermbg=52
    highlight CursorColumn  ctermbg=52

    augroup cursorline
        autocmd!
        autocmd WinEnter * setlocal cursorline | setlocal cursorcolumn
        autocmd WinLeave * setlocal nocursorline | setlocal nocursorcolumn
        autocmd InsertEnter * highlight CursorLine ctermbg=0 | highlight CursorColumn ctermbg=0
        autocmd InsertLeave * highlight CursorLine ctermbg=52 | highlight CursorColumn ctermbg=52
    augroup END

else

    highlight SignColumn        cterm=None ctermfg=245 ctermbg=187 guifg=Brown
    highlight SignifySignAdd    cterm=bold ctermfg=34  ctermbg=187
    highlight SignifySignDelete cterm=bold ctermfg=160 ctermbg=187
    highlight SignifySignChange cterm=bold ctermfg=22  ctermbg=187

    highlight CursorLine ctermbg=186
    highlight CursorColumn ctermbg=186

    augroup cursorline
        autocmd!
        autocmd WinEnter * setlocal cursorline | setlocal cursorcolumn
        autocmd WinLeave * setlocal nocursorline | setlocal nocursorcolumn
        autocmd InsertEnter * highlight CursorLine ctermbg=230 | highlight CursorColumn ctermbg=230
        autocmd InsertLeave * highlight CursorLine ctermbg=186 | highlight CursorColumn ctermbg=186
    augroup END
endif

" }}} Cursorline / CursorColumn "

" Enable ToggleBG to toggle between dark/light background {{{ "

call togglebg#map("")

" }}} Fold description "
