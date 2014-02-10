" let pathogen do its thing
execute pathogen#infect()

" Edit vimrc
map ,rc :tabnew $MYVIMRC<CR>
map ,src :source $MYVIMRC<CR>

" cursor movement in command line mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>

" bind jk and kj to Esc
inoremap jk <Esc>
inoremap kj <Esc>

" insert current date
nnoremap <D-D> "=strftime("%F")<CR>P
inoremap <D-D> <C-R>=strftime("%F")<CR>

" enable copy/paste on Mac OSX and tmux (see also notes/macosx.notes)
set clipboard=unnamed

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

" hybrid line numbers (requires 7.4)
set number " set number
set relativenumber " set relative line numbers

" General settings
set encoding=utf-8
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

" spell-checking
set nospell
set spellsuggest=5

" no swap files or backups
set nobackup         " no backup files
set nowritebackup    " only in case you don't want a backup file while editing
set noswapfile       " no swap files

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
command! Notes :browse ~/Dropbox/notes/

" Fullscreen with 
" command! FullScreenEditing :vertical new readonly | :vertical resize 120 | :wincmd w
command! FullScreenEditing :vertical new | :vertical resize 120 | :wincmd w

" show trailing spaces as dots, highlight tabs, etc.
set list!
set listchars=tab:>-,extends:»,precedes:«,trail:·
match ErrorMsg /\t/

" wild card settings
set wildmenu
set wildmode=list:full
" ignore these filenames during tab completion
set wildignore+=*.out,*.synctex.gz,*.aux,*.ilg,*.log,*.nls,*.idx,*.ind,*.blg,*.nlo,*.pdf,*.toc

" List of recent files, using CtrlP <https://github.com/kien/ctrlp.vim>
let g:ctrlp_cmd = 'CtrlPMRUFiles'
let g:ctrlp_by_filename = 1 " toggle with <c-d>
let g:ctrlp_regexp = 0 " toggle with <c-r>
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
nmap <C-p> :<C-U>CtrlPMRUFiles<CR>

" Use ReStructuredText syntax highlighting for .notes and .txt files
"autocmd BufRead,BufNewFile *.notes set filetype=rst
"autocmd BufRead,BufNewFile *.txt set filetype=rst | set nowrap

" vim2sage
if has("python")
python << EOL
import vim
def vim2sage(line1,line2):
    import vim, subprocess
    if line1 == line2:
        range = list(vim.current.buffer.range(line1,line2))
    else:
        range = [r'%cpaste'] + list(vim.current.buffer.range(line1,line2)) + [r'''''']
    args = ['/usr/local/bin/tmux', 'send-keys', '-t', '0']
    for line in range:
        sp = subprocess.call(args+[line])
        sp = subprocess.call(args+["Enter"])
        if sp != 0:
           raise Exception("no appropriate tmux session found")
EOL
command! -range SageVisualMode :call SageVisualModeFunction(<line1>,<line2>)
function! SageVisualModeFunction(line1,line2)
    execute ":python vim2sage(" . a:line1 . "," . a:line2 . ")"
endfunction
map <S-CR> :SageVisualMode<CR><CR>
imap <S-CR> <C-o><S-CR>
endif

function! OpenRejectFile()
    " splits window and opens the %.rej
    let filename=expand('%')
    let rejectsfile = filename.'.rej'
    split
    exec 'edit '.rejectsfile
endfunction
command! Rejects :call OpenRejectFile()

command! Notes :tabnew ~/Dropbox/notes/

" Scratchpad settings
command! ScratchPad :tabnew ~/Dropbox/scratchpad.rst

""""""""""""""""""""""""
" latexbox configuration
""""""""""""""""""""""""
if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        let g:LatexBox_viewer = "open -a /Applications/Skim.app"
        " use SyncTeX with the Skim viewer
        map <silent> <Leader>ls :silent
                \ !/Applications/Skim.app/Contents/SharedSupport/displayline
                \ <C-R>=line('.')<CR> "<C-R>=LatexBox_GetOutputFile()<CR>"
                \ "%:p" <CR>
    else
        let g:LatexBox_viewer = "okular"
    endif
endif

let g:LatexBox_output_type = "pdf"
"let g:LatexBox_latexmk_options = '-pdfdvi'
"
let g:LatexBox_Folding = 1

" disable async compile since it requires a vim server (complains in terminal)
let g:LatexBox_latexmk_async = 0

" disable automatic opening the quickfix window post-compilation;
" use :copen to open the window; or use <Leader>le (latexbox errors)
let g:LatexBox_quickfix = 0

"""""""""""""""""""
" latexbox commands
"""""""""""""""""""
" \lt Table of Contents
" \ll Compile with latexmk.
" \lL Force compilation with latexmk.
" \lc Clean temporary output from LaTeX.
" \lC Clean all output from LaTeX.
" \lk Kill latexmk if it is running.
" \lg Show the running status of latexmk for the current buffer.
" \lG Show the running status of latexmk for all buffers with process group ID's.
" \le Load the log file for the current document and jump to the first error.

" open a .tex file in TeXShop
function! TeXShop()
    let filename=expand('%')
    execute '!open -a /Applications/TeX/TeXShop.app '.filename
endfunction

" Run LaTeX through TexShop
function! RunTeXShop()
   if &ft != 'tex'
      echo "calling RunTeXShop from a non-tex file"
      return ''
   end

   "write the file
   :w

   "New Script:
   " tell app \"TeXShop\"
   "    set theDoc to open ((POSIX file \"'.thePath.'\") as alias)
   "    try
   "        tell theDoc to latexinteractive
   "    on error
   "        set theDoc to front document
   "        tell theDoc to latexinteractive
   "    end try
   "    end tell
   let thePath = getcwd() . '/'. expand("%")
   let execString = 'osascript -e "tell app \"TeXShop\"" -e "set theDoc to open ((POSIX file \"'.thePath.'\") as alias)" -e "try" -e "tell theDoc to latexinteractive" -e "on error" -e "set theDoc to front document" -e "tell theDoc to latexinteractive" -e "end try" -e "end tell"'
   
   exec 'silent! !' execString
   exec '!' execString
   return ''
endfunction

noremap  <D-t> :call RunTeXShop()<CR>

" Diff current file with the version on disk
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
" To execute this function:
":call DiffWithFileFromDisk()

""""" Mac OSX Specific
" For the French keyboard on the MacBook: map the key §/± key to `/~
map! § `
map! ± ~

""""""
"" From Hacking Vim, Chapter 4, by Kim Schulz
""
"" Try, in order:
""    - omni-completion
""    - dictionary-completion
""    - buffer-completion
"function! SuperCleverTab()
"    "check if at beginning of line or after a space
"    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
"        return "\<Tab>"
"    else
"        " use known-word completion
"        return "\<C-N>"
"        "" do we have omni completion available
"        "if &omnifunc != ''
"        "    " try omni-completion
"        "    return "\<C-X>\<C-O>"
"        "elseif &dictionary != ''
"        "    " try dictionary completion
"        "    return "\<C-K>"
"        "else
"        "    " use known-word completion
"        "    return "\<C-N>"
"        "endif
"    endif
"endfunction
"" binds SuperCleverTab to Tab
"inoremap <Tab> <C-R>=SuperCleverTab()<CR>

" OpenURL function
" http://www.vim.org/scripts/script.php?script_id=3291
function! OpenURL()
python << EOM
# coding=utf-8
import vim
import re
import webbrowser
re_obj = re.compile(r'https?://[a-zA-Z0-9-./"#$%&\':?=_+]+')
line = vim.current.line
match_obj = re_obj.search(line)
try:
    url = match_obj.group()
    webbrowser.open(url)
    print 'open URL : %s' % url
except:
    print 'failed! : open URL'
EOM
endfunction
" set a command for OpenURL function
map <Leader>gw :call OpenURL()<CR><CR>

" Show the highlight group syntax under the cursor
" http://vim.wikia.com/wiki/Showing_syntax_highlight_group_in_statusline
function! ShowSyntaxHighlightGroup()
    echo synIDattr(synID(line("."),col("."),1),"name")
endfunction
