" burrima.ch own .vimrc file
"------------------------------------------------------------------------------

set encoding=utf-8  " The encoding displayed.
set fileencoding=utf-8  " The encoding written to file.

set nocompatible  " Use Vim defaults (much better!)
set bs=indent,eol,start   " allow backspacing over everything in insert mode
syntax on  " enable syntax highlighting

set backup  " keep a backup file
set directory=/tmp  " location of swap file
set backupdir=/tmp  " location of backup file

set viminfo='20,<500  " marks for 20 files, no more than 500 lines of registers
set history=100  " keep 100 lines of command line history

set ruler  " show line and col number of the cursor position
set laststatus=2  " always show window status line
set nowrap  " don't wrap displayed lines

set hlsearch  " highlight search results
set incsearch  " show matches while typing
set path=**  " search in all sub-dirs when searching for a file

set textwidth=80  " maximum width of inserted text
set tabstop=2  " tab width
set shiftwidth=2  " number of spaces for each step of (auto)indent
set expandtab  " use spaces instead of tabs
set autoindent  " auto indentation

set wildmode=longest,list
set hidden  " allow to have unsaved hidden buffers

" set switchbuf=useopen

set splitright  " open new vertical splits right of current window
set splitbelow  " open new horizontal splits right of current window

" abbreviations of ex-commands:
cabbrev tp tabprevious
cabbrev tn tabnext
cabbrev te tabedit
cabbrev vdiff vert diffsplit

" key mappings:
noremap ' `
noremap ö ;
noremap é ,
"noremap ü [
"noremap ¨ ]  " does not work on some systems
"noremap ä {
"noremap $ }

" key to ex mappings:
nnoremap <silent> [l :lprev<CR>
nnoremap <silent> ]l :lnext<CR>
nnoremap <silent> [L :lfirst<CR>
nnoremap <silent> ]L :llast<CR>
nnoremap <silent> [q :cprev<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]Q :clast<CR>
nnoremap <silent> [b :bprev<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
nnoremap <silent> [t :tabprev<CR>
nnoremap <silent> ]t :tabnext<CR>
nnoremap <silent> [T :tabfirst<CR>
nnoremap <silent> ]T :tablast<CR>

" nnoremap <silent> <C-]> <C-w><C-]><C-w>T  " ctag jump into new Tab
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
nnoremap <Space> :buffers<CR>:buffer<Space>

" reserved word highlighting:
"autocmd Syntax * call matchadd('ErrorMsg', '\(ERROR\|FAILED\)')
"autocmd Syntax * call matchadd('DiffAdd', '\(PASSED\|OK\)')
autocmd Syntax * call matchadd('Todo', '\(TODO\|todo\|Todo\|tbd\|Tbd\)')

" highlight unprintable chars as error:
hi clear SpecialKey
hi link SpecialKey Error

" spell check:
set spell
set spelllang=en_us
hi clear SpellBad
hi SpellBad cterm=undercurl,bold
hi clear SpellLocal
hi SpellLocal cterm=undercurl,bold
hi clear SpellCap
hi SpellCap cterm=reverse

" plugins:
filetype plugin on

" ALE plugin configuration
let g:ale_linters = {
\   'javascript': ['standard'],
\   'cpp': ['cpplint'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_fix_on_save = 1  " run fixer on save
let g:ale_lint_on_enter = 0  " don't start linter on file open


execute 'silent! source .vimrc_module'

"-----------------------------------------------------------------------------
" OBSOLETE: (delete in near future if no suspicious behavior detected)
"-----------------------------------------------------------------------------

" map F5 to the command ':make'
"map <silent> <F5> :update<CR>:make<CR>
"map <silent> <S-F5> :wall<CR>:make!<CR>:make show &<CR>


" enter the display line after searches. (This makes it *much* easier to see
" the matched line.)
" "
" " More info: http://www.vim.org/tips/tip.php?tip_id=528
" "
"nnoremap n nzz
"nnoremap N Nzz
"nnoremap * *zz
"nnoremap # #zz
"nnoremap g* g*zz
"nnoremap g# g#zz


"set smartcase

" Only do this part when compiled with support for autocommands
"if has("autocmd")
"  augroup redhat
""    " In text files, always limit the width of text to 78 characters
""    autocmd BufRead *.txt set tw=80
"    " When editing a file, always jump to the last cursor position
"    autocmd BufReadPost *
"    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
"    \   exe "normal! g'\"" |
"    \ endif
"  augroup END
"endif

"if has("cscope") && filereadable("/usr/bin/cscope")
"   set csprg=/usr/bin/cscope
"   set csto=0
"   set cst
"   set nocsverb
"   " add any database in current directory
"   if filereadable("cscope.out")
"      cs add cscope.out
"   " else add database pointed to by environment
"   elseif $CSCOPE_DB != ""
"      cs add $CSCOPE_DB
"   endif
"   set csverb
"endif

" Custom tabline which shows tab numbers:
"if exists("+showtabline")
"    function! MyTabLine()
"        let s = ''
"        let wn = ''
"        let t = tabpagenr()
"        let i = 1
"        while i <= tabpagenr('$')
"            let buflist = tabpagebuflist(i)
"            let winnr = tabpagewinnr(i)
"            let s .= '%' . i . 'T'
"            let s .= (i == t ? '%1*' : '%2*')
"            let s .= ' '
"            let wn = tabpagewinnr(i,'$')
"
"            let s .= '%#TabNum#'
"            let s .= i
"            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
"            let bufnr = buflist[winnr - 1]
"            let file = bufname(bufnr)
"            let buftype = getbufvar(bufnr, 'buftype')
"            if buftype == 'nofile'
"                if file =~ '\/.'
"                    let file = substitute(file, '.*\/\ze.', '', '')
"                endif
"            else
"                let file = fnamemodify(file, ':p:t')
"            endif
"            if file == ''
"                let file = '[No Name]'
"            endif
"            let s .= ' ' . file . ' '
"            let i = i + 1
"        endwhile
"        let s .= '%T%#TabLineFill#%='
"        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
"        return s
"    endfunction
"    set stal=2
"    set tabline=%!MyTabLine()
"    set showtabline=1
"    highlight link TabNum Special
"endif




" Tabmerge -- Merge the windows in a tab with the current tab.
"
" Copyright July 17, 2007 Christian J. Robinson <infynity@onewest.net>
"
" Distributed under the terms of the Vim license.  See ":help license".

" Usage:
"
" :Tabmerge [tab number] [top|bottom|left|right]
"
" The tab number can be "$" for the last tab.  If the tab number isn't
" specified the tab to the right of the current tab is merged.  If there
" is no right tab, the left tab is merged.
"
" The location specifies where in the current tab to merge the windows.
" Defaults to "top".
"
" Limitations:
"
" Vertical windows are merged as horizontal splits.  Doing otherwise would be
" nearly impossible.

"if v:version < 700
"  echoerr "Tabmerge.vim requires at least Vim version 7"
"  finish
"endif
"
"command! -nargs=* Tabmerge call Tabmerge(<f-args>)
"
"function! Tabmerge(...)  " {{{1
"  if a:0 > 2
"    echohl ErrorMsg
"    echo "Too many arguments"
"    echohl None
"    return
"  elseif a:0 == 2
"    let tabnr = a:1
"    let where = a:2
"  elseif a:0 == 1
"    if a:1 =~ '^\d\+$' || a:1 == '$'
"      let tabnr = a:1
"    else
"      let where = a:1
"    endif
"  endif
"
"  if !exists('l:where')
"    let where = 'top'
"  endif
"
"  if !exists('l:tabnr')
"    if type(tabpagebuflist(tabpagenr() + 1)) == 3
"      let tabnr = tabpagenr() + 1
"    elseif type(tabpagebuflist(tabpagenr() - 1)) == 3
"      let tabnr = tabpagenr() - 1
"    else
"      echohl ErrorMsg
"      echo "Already only one tab"
"      echohl None
"      return
"    endif
"  endif
"
"  if tabnr == '$'
"    let tabnr = tabpagenr(tabnr)
"  else
"    let tabnr = tabnr
"  endif
"
"  let tabwindows = tabpagebuflist(tabnr)
"
"  if type(tabwindows) == 0 && tabwindows == 0
"    echohl ErrorMsg
"    echo "No such tab number: " . tabnr
"    echohl None
"    return
"  elseif tabnr == tabpagenr()
"    echohl ErrorMsg
"    echo "Can't merge with the current tab"
"    echohl None
"    return
"  endif
"
"  if where =~? '^t\(op\)\?$'
"    let where = 'topleft'
"  elseif where =~? '^b\(ot\(tom\)\?\)\?$'
"    let where = 'botright'
"  elseif where =~? '^l\(eft\)\?$'
"    let where = 'leftabove vertical'
"  elseif where =~? '^r\(ight\)\?$'
"    let where = 'rightbelow vertical'
"  else
"    echohl ErrorMsg
"    echo "Invalid location: " . a:2
"    echohl None
"    return
"  endif
"
"  let save_switchbuf = &switchbuf
"  let &switchbuf = ''
"
"  if where == 'top'
"    let tabwindows = reverse(tabwindows)
"  endif
"
"  for buf in tabwindows
"    exe where . ' sbuffer ' . buf
"  endfor
"
"  exe 'tabclose ' . tabnr
"
"  let &switchbuf = save_switchbuf
"endfunction

" vim:fdm=marker:fdc=2:fdl=1:


"function DeleteHiddenBuffers()
"  let tpbl=[]
"  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
"  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
"    silent execute 'bwipeout' buf
"  endfor
"endfunction


" python specific mappings
"noremap ) b?def <CR>w:nohl<CR>
"noremap ( /def <CR>w:nohl<CR>
"noremap } /^#* *$<CR>:nohl<CR>j^
"noremap { 2k?^#* *$<CR>:nohl<CR>j^
