hi clear
if exists("syntax_on")
    syntax reset
endif

" Load solarized
runtime colors/solarized.vim

set cursorline
set cursorcolumn

if &background == "dark"
    highlight SignColumn        cterm=None ctermbg=235 ctermfg=239 guifg=Yellow
    highlight SignifySignAdd    cterm=bold ctermbg=235 ctermfg=119
    highlight SignifySignDelete cterm=bold ctermbg=235 ctermfg=167
    highlight SignifySignChange cterm=bold ctermbg=235 ctermfg=227

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
    highlight SignColumn        cterm=None ctermbg=236 ctermfg=239 guifg=Yellow
    highlight SignifySignAdd    cterm=bold ctermbg=235 ctermfg=119
    highlight SignifySignDelete cterm=bold ctermbg=235 ctermfg=167
    highlight SignifySignChange cterm=bold ctermbg=235 ctermfg=227

    highlight CursorLine   ctermbg=186
    highlight CursorColumn ctermbg=186

    augroup cursorline
        autocmd!
        autocmd WinEnter * setlocal cursorline | setlocal cursorcolumn
        autocmd WinLeave * setlocal nocursorline | setlocal nocursorcolumn
        autocmd InsertEnter * highlight CursorLine ctermbg=0 | highlight CursorColumn ctermbg=0
        autocmd InsertLeave * highlight CursorLine ctermbg=186 | highlight CursorColumn ctermbg=186
    augroup END
endif
