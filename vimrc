" .vimrc
" Author: Franco Saliola <saliola@gmail.com>
" credit: various sources, including steve losh's vimrc http://bitbucket.org/sjl/dotfiles/src/tip/vim/

" Things to look up ------------------------------------------------------- {{{
"
" <C-x><C-f>
" <C-x><C-l>
" <C-x><C-]>
" g;
" g,
" gv (reselect last visual selection)
" =ip (format inner paragraph)
" `` (jump to position before last jump)
" ------------------------------------------------------------------------- }}}

" Pathogen ---------------------------------------------------------------- {{{

execute pathogen#infect()

" ------------------------------------------------------------------------- }}}
" Leaders ----------------------------------------------------------------- {{{

let mapleader = ","
let maplocalleader = "\\"

" ------------------------------------------------------------------------- }}}
" vimrc ------------------------------------------------------------------- {{{

map <leader>ev :tabnew $MYVIMRC<CR>

" Source the vimrc file after saving it
augroup vimrc
    au!
    au bufwritepost .vimrc source $MYVIMRC
augroup END

augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END

" ------------------------------------------------------------------------- }}}
" Basic options ----------------------------------------------------------- {{{

set encoding=utf-8
set showmode
set showcmd
set visualbell
set nowrap " don't wrap text ; I have a wide monitor
set textwidth=0 " set textwidth to 75 to cause wrapping
set hlsearch " hightlight search
set history=50 " 50 lines of command lines history
set viminfo='20,\"50 " read/write a .viminfo file with at most 50 lines
set ruler " show the cursor position all the time
set nojoinspaces " only put one space after periods
set incsearch " incremental search
set scrolloff=1 " always show n screen lines to above and below the cursor
set tabstop=4|set shiftwidth=4|set softtabstop=4|set expandtab " tab settings for all files

set laststatus=2
set statusline=%F%m%r%h%w\ [Type=%Y]\ [POS=%04l,%04v]\ [%p%%]\ [LEN=%L]

set backspace=indent,eol,start " allow backspacing over everything in insert mode

set iskeyword=@,48-57,_,192-255
set formatoptions+=1n

" hybrid line numbers (requires 7.4)
set number " set number
set relativenumber " set relative line numbers

" spell-checking
set nospell
set spellsuggest=5

" show trailing spaces as dots, highlight tabs, etc.
set list
set listchars=tab:▸-,extends:❯,precedes:❮,trail:· ",eol:¬
"set listchars+=eol:¬
set showbreak=↪
match ErrorMsg /\t/

set splitbelow
set splitright
set linebreak

" wild card settings
set wildmenu
set wildmode=list:full

" Resize splits when the window is resized
au VimResized * :wincmd =

" enable copy/paste on Mac OSX and tmux (see also notes/macosx.notes)
set clipboard=unnamed

set undofile
set undoreload=10000
set undodir=~/.vim/tmp/undo//     " undo files

set backup
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files

set noswapfile       " no swap files

" ------------------------------------------------------------------------- }}}
" Command line mode ------------------------------------------------------- {{{

" cursor movement in command line mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>

" ------------------------------------------------------------------------- }}}
" Line Return ------------------------------------------------------------- {{{

" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Steve Losh https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" ------------------------------------------------------------------------- }}}
" Mappings ---------------------------------------------------------------- {{{

" insert current date
nnoremap <D-D> "=strftime("%F")<CR>P
inoremap <D-D> <C-R>=strftime("%F")<CR>

" Insert the current directory into a command-line path
" Notes:
" - if path contains whitespace, then ``escape`` will escape them
cmap <C-P> <C-R>=escape(expand("%:p:h"),' ') . "/"<CR>
" Insert the current filename into a command-line path
cmap %% <C-R>=escape(expand("%"),' ')<CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>t :tabnew
map <Leader>tp :tabnew <C-p>
map <Leader>tn :tabnew 
map <Leader>tN :tabnew ~/Dropbox/notes/
command! Notes :tabnew ~/Dropbox/notes/

" Scratchpad settings
command! ScratchPad :tabnew ~/Dropbox/scratchpad.rst

" Fullscreen with 
" command! FullScreenEditing :vertical new readonly | :vertical resize 120 | :wincmd w
command! FullScreenEditing :vertical new | :vertical resize 120 | :wincmd w

" Make the help key do something useful.
noremap  <F1> :checktime<cr>
inoremap <F1> <esc>:checktime<cr>

" Make the Q key to something useful.
nnoremap Q gqip
vnoremap Q gq

" Join an entire paragraph.
" Source: Steve Losh
nnoremap <Leader>J mzvipJ`z

" Don't move on *
" Source: Steve Losh
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

" Keep search matches in the middle of the window.
" Source: Steve Losh
nnoremap n nzzzv
nnoremap N Nzzzv


" ------------------------------------------------------------------------- }}}
" Folding ----------------------------------------------------------------- {{{

" From Steve Losh:
" "Focus" the current line.  Basically:
"
" 1. Close all folds.
" 2. Open just the folds containing the current line.
" 3. Move the line a few lines above the center of the screen.
" 4. Pulse the cursor line.
"
" Warning: This mapping wipes out the z mark.
nnoremap <Leader>f mzzMzvzz10<c-e>`z:Pulse<cr>

" ------------------------------------------------------------------------- }}}
" Appearance -------------------------------------------------------------- {{{

" Pretty Colours
syntax enable " enable syntax highlighting
if has('gui_running')
    set background=light
    colorscheme solarized
else
    set background=light
    set t_Co=256
    let g:solarized_termtrans = 1
    let g:solarized_termcolors=256
    let g:solarized_italic=0 " disable display of italics (bgcolor is too dark)
    colorscheme solarized
endif

" syntax colouring for folded blocks: turn off underlining in the terminal
highlight Folded term=none cterm=none

" Crosshair
set cursorline
set cursorcolumn
set colorcolumn=80
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
function! RedCursorLine()
    let w:red_cursor = exists('w:red_cursor') ? !w:red_cursor : 0
    if w:red_cursor
        colorscheme solarized
        set cursorline
        set cursorcolumn
        set colorcolumn=80
    else
        set cursorline
        hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
        set nocursorcolumn
        hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
        set colorcolumn=
    endif
endfunction
command! RedCursorLine :call RedCursorLine()

" ------------------------------------------------------------------------- }}}
" Plugin settings --------------------------------------------------------- {{{

" CtrlP ------------------------------------------------------------------- {{{

" List of recent files, using CtrlP <https://github.com/kien/ctrlp.vim>
let g:ctrlp_cmd = 'CtrlPMRUFiles'
let g:ctrlp_by_filename = 1 " toggle with <c-d>
let g:ctrlp_regexp = 0 " toggle with <c-r>
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
nmap <C-p> :<C-U>CtrlPMRUFiles<CR>

" ------------------------------------------------------------------------- }}}
" UltiSnips --------------------------------------------------------------- {{{

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"

" ------------------------------------------------------------------------- }}}
" ------------------------------------------------------------------------- }}}
" Filetype-specific ------------------------------------------------------- {{{

" txt {{{

augroup ft_txt
    au!

    " Use ReStructuredText syntax highlighting for .txt files
    autocmd BufRead,BufNewFile *.txt set filetype=rst
augroup END

" }}}
" notes {{{

augroup ft_notes
    au!

    " Use ReStructuredText syntax highlighting for .notes and .txt files
    autocmd BufRead,BufNewFile *.notes set filetype=rst
augroup END

" }}}
" Hg {{{

function! OpenHGRejectFile()
    " splits window and opens the %.rej
    let filename=expand('%')
    let rejectsfile = filename.'.rej'
    split
    exec 'edit '.rejectsfile
endfunction
command! HGRejects :call OpenHGRejectFile()

" }}}
" Python {{{

augroup ft_python
    au!

    au FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
augroup END

" }}}
" bash vi-input mode {{{
" Syntax highlighting in Bash vi-input mode
" Source: http://stackoverflow.com/questions/7115324/syntax-highlighting-in-bash-vi-input-mode/7115478#7115478

augroup bash_vi_input_mode
    au!

    au BufRead,BufNewFile bash-fc-* set filetype=sh
augroup END

" }}}

" ------------------------------------------------------------------------- }}}
" Latex ------------------------------------------------------------------- {{{

augroup ft_tex
    au!

    " ignore these filenames during tab completion
    au FileType tex setlocal wildignore+=*.out,*.synctex.gz,*.aux,*.ilg,*.log,*.nls,*.idx,*.ind,*.blg,*.nlo,*.pdf,*.toc

    " load configuration
    au FileType tex source ~/.vim/bundle/my-vim-latex-config/latexbox-conf.vim
augroup END

" ------------------------------------------------------------------------- }}}
" Useful functions -------------------------------------------------------- {{{

" mapping to toggle (no)paste before pasting from the clipboard ----------- {{{

" Reference: http://tilvim.com/2014/03/18/a-better-paste.html
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

" ------------------------------------------------------------------------- }}}
" Diff current file with the version on disk ------------------------------ {{{

" [From Hacking Vim, Chapter 4, by Kim Schulz]
function! DiffWithFileFromDisk()
    let filename=expand('%')
    let diffname = filename.'.fileFromBuffer'
    exec 'saveas! '.diffname
    diffthis
    vsplit
    exec 'edit '.filename
    diffthis
endfunction

" ------------------------------------------------------------------------- }}}
" Open the url under the cursor with gx ----------------------------------- {{{

if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        " defaults to 'open' on Mac OSX
        let g:netrw_browsex_viewer='-'
    else
        let g:netrw_browsex_viewer='gvfs-open'
    endif
endif

" ------------------------------------------------------------------------- }}}
" Show the highlight group syntax under the cursor ------------------------ {{{
" http://vim.wikia.com/wiki/Showing_syntax_highlight_group_in_statusline
function! ShowSyntaxHighlightGroup()
    echo synIDattr(synID(line("."),col("."),1),"name")
endfunction

" Show the stack of syntax hilighting classes affecting whatever is under the
" cursor.
" Source: Steve Losh
function! SynStack()
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), " > ")
endfunc

" ------------------------------------------------------------------------- }}}
" Pulse Line -------------------------------------------------------------- {{{
" Source: Steve Losh

function! s:Pulse() " {{{
    redir => old_hi
        silent execute 'hi CursorLine'
    redir END
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')

    let steps = 4
    let width = 1
    let start = width
    let end = steps * width
    let color = 160

    for i in range(start, end, width)
        execute "hi CursorLine ctermbg=" . (color + i)
        redraw
        sleep 6m
    endfor
    for i in range(end, start, -1 * width)
        execute "hi CursorLine ctermbg=" . (color + i)
        redraw
        sleep 6m
    endfor

    execute 'hi ' . old_hi
endfunction " }}}
command! -nargs=0 Pulse call s:Pulse()

" ------------------------------------------------------------------------- }}}
" Indent Guides ----------------------------------------------------------- {{{

let g:indentguides_state = 0
function! IndentGuides() " {{{
    if g:indentguides_state
        let g:indentguides_state = 0
        2match None
    else
        let g:indentguides_state = 1
        execute '2match IndentGuides /\%(\_^\s*\)\@<=\%(\%'.(0*&sw+1).'v\|\%'.(1*&sw+1).'v\|\%'.(2*&sw+1).'v\|\%'.(3*&sw+1).'v\|\%'.(4*&sw+1).'v\|\%'.(5*&sw+1).'v\|\%'.(6*&sw+1).'v\|\%'.(7*&sw+1).'v\)\s/'
    endif
endfunction " }}}
hi def IndentGuides guibg=#303030 ctermbg=234
nnoremap <leader>I :call IndentGuides()<cr>

" ------------------------------------------------------------------------- }}}
" Highlight Word ---------------------------------------------------------- {{{
"
" Source: Steve Losh
" This mini-plugin provides a few mappings for highlighting words temporarily.
"
" Sometimes you're looking at a hairy piece of code and would like a certain
" word or two to stand out temporarily.  You can search for it, but that only
" gives you one color of highlighting.  Now you can use <leader>N where N is
" a number from 1-6 to highlight the current word in a specific color.

function! HiInterestingWord(n) " {{{
    " Save our location.
    normal! mz

    " Yank the current word into the z register.
    normal! "zyiw

    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    let mid = 86750 + a:n

    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)

    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'

    " Actually match the words.
    call matchadd("InterestingWord" . a:n, pat, 1, mid)

    " Move back to our original location.
    normal! `z
endfunction " }}}

" Mappings {{{

nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>

" }}}
" Default Highlights {{{

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

" }}}

" ------------------------------------------------------------------------- }}}
" ------------------------------------------------------------------------- }}}
" Mac OSX Specific -------------------------------------------------------- {{{

" For the French keyboard on the MacBook: map the key §/± key to `/~
map! § `
map! ± ~

" ------------------------------------------------------------------------- }}}
