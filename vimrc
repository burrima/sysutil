"            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
"                    Version 2, December 2004
"
" Copyright (C) 2021 Martin Burri <info@burrima.ch>
"
" Everyone is permitted to copy and distribute verbatim or modified
" copies of this license document, and changing it is allowed as long
" as the name is changed.
"
"            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
"   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
"
"  0. You just DO WHAT THE FUCK YOU WANT TO.
"

"
" Personal vimrc file version 2.1.0
"

" General Config --------------------------------------------------------------
" map <Leader> key to ',':
let mapleader = ','

set nocompatible  " Use Vim defaults (much better!)

" default values, to be overwritten by .editorconfig files (see vim-editorconfig
" plugin):
set textwidth=80  " maximum width of inserted text
set tabstop=4  " tab width
set shiftwidth=4  " number of spaces for each step of (auto)indent
set expandtab  " use spaces instead of tabs

" use maximum color range in tmux environments:
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set t_Co=256
set termguicolors

set splitright  " open new vertical splits right of current window
set splitbelow  " open new horizontal splits right of current window

set ruler  " show line and col number of the cursor position
set laststatus=2  " always show window status line
set nowrap  " don't wrap displayed lines

set path=**  " search in all sub-dirs when searching for a file

set colorcolumn=+1  " vertical line at maximum textwidth
"hi ColorColumn ctermbg=lightgrey

set wildmode=longest,list  " Tab completion like in bash
set hidden  " allow to have unsaved hidden buffers

" set switchbuf=useopen  " see :help switchbuf


" Swap, Backup and Undo Files -------------------------------------------------
set directory=~/.vim/swap//
call mkdir (&directory, 'p')
" uncomment to enable backup files:
"set backup
"set backupdir=~/.vim/backup//  " location of backup file
"call mkdir (&backupdir, 'p')
" uncoment to store undo-history (reload on next start of vim):
" set undofile
" set undodir=~/.vim/undo
" call mkdir (&undodir, 'p')

augroup restore
  autocmd!
  " disable undofile for files in /tmp/:
  autocmd BufWritePre /tmp/* setlocal noundofile
  " Always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.vim/viminfo


" Key Mappings ----------------------------------------------------------------
" in command-line mode, fix <C-p> and <C-n> to filter history:
cnoremap <C-p> Up
cnoremap <C-n> Down

" map hard-to-reach keys to simpler ones (useful for Swiss keyboard):
" Note: these mappings are in addition - original keys are still valid
noremap <silent> ' `
noremap g0 ^
noremap g$ g_
noremap ö ;
noremap é ,
noremap <Space>g <C-]>

" location-list:
nnoremap <silent> [l :lprev<CR>
nnoremap <silent> ]l :lnext<CR>
nnoremap <silent> [L :lfirst<CR>
nnoremap <silent> ]L :llast<CR>
nnoremap <silent> <Space>l :lopen<CR>
" quickfix-list:
nnoremap <silent> [q :cprev<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]Q :clast<CR>
nnoremap <silent> <Space>q :copen<CR>
" buffer-list
nnoremap <silent> [b :bprev<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
nnoremap <silent> <Space>b :Buffers<CR>
nnoremap <silent> <Space># :b#<CR>
" tag-list:
nnoremap <silent> [t :tprev<CR>
nnoremap <silent> ]t :tnext<CR>
nnoremap <silent> [T :tfirst<CR>
nnoremap <silent> ]T :tlast<CR>
nnoremap <silent> <Space>t :tselect<CR>


" Abbreviations of Ex-Commands ------------------------------------------------
" Function to map ex commands (works like cabbrev, but ignores words when
" needed):
function! SetupCommandAlias(input, output)
  exec 'cabbrev <expr> '.a:input
       \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:input.'")'
       \ .'? ("'.a:output.'") : ("'.a:input.'"))'
endfunction

call SetupCommandAlias("tp", "tabprevious")
call SetupCommandAlias("tn", "tabnext")
call SetupCommandAlias("te", "tabedit")
call SetupCommandAlias("tc", "tabclose")
call SetupCommandAlias("vdiff", "vert diffsplit")


" Highlighting ----------------------------------------------------------------
" highlight search occurrences (<C-l> to clear):
set hlsearch

" highlight unprintable chars as error:
hi clear SpecialKey
hi link SpecialKey Error

augroup highlilghting
  autocmd!
  " reserved word highlighting:
  "autocmd Syntax * call matchadd('ErrorMsg', '\(ERROR\|FAILED\)')
  "autocmd Syntax * call matchadd('DiffAdd', '\(PASSED\|OK\)')
  autocmd Syntax * call matchadd('Todo', '\(TODO\|todo\|Todo\|tbd\|Tbd\)')
augroup END


" Spell Checking --------------------------------------------------------------
set spell
set spelllang=en_us
" hi clear SpellBad
" hi SpellBad cterm=underline,bold
" hi clear SpellLocal
" hi SpellLocal cterm=underline,bold
" hi clear SpellCap
" hi SpellCap cterm=underline
augroup spellcheck
  autocmd!
  " disable spell check for log files
  autocmd  BufReadPre *.log setlocal nospell
augroup END


" Plugins ---------------------------------------------------------------------
" pre-condition: install minpac bare-metal as optional package
packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()
command! PackMaintain call minpac#clean() | call minpac#update()

" enable file type detection (with plugin and auto-indent):
filetype plugin indent on

" PACK FZF (export FZF_DEFAULT_COMMAND='rg --files' to use ripgrep search):
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')
nnoremap <silent> <Space>f :<C-u>FZF<CR>
let g:fzf_layout = { 'down': '~40%' }  " for a more natural feeling

" PACK ALE Linter:
call minpac#add('w0rp/ale')
let g:ale_linters = {
\   'javascript': ['standard'],
\   'cpp': ['cpplint'],
\   'python': ['flake8', 'jedils'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_set_loclist = 0  " don't use location list (use [W,[w,]w,]W instead)
let g:ale_echo_msg_format = '[%linter%] %code: %%s [%severity%]'
let g:ale_fix_on_save = 1  " run fixer on save
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)
" code completion/navigation/etc. via language-server (see :h ale):
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
autocmd VimEnter * set omnifunc=ale#completion#OmniFunc
let g:ale_update_tagstack = 1
let g:ale_lsp_suggestions = 1
let g:ale_maximum_file_size = 500000
noremap <Space>d :ALEGoToDefinition<CR>
noremap <Space>t :ALEGoToTypeDefinition<CR>
noremap <Space>r :ALEFindReferences<CR>
noremap <Space>h :ALEHover<CR>
call SetupCommandAlias("rename", "ALERename")

" PACK vim-grepper:
call minpac#add('mhinz/vim-grepper')
let g:grepper = {}
let g:grepper.tools = ['rg', 'git', 'grep']
" search for current word:
nnoremap <silent> <Leader>* :Grepper -cword -noprompt<CR>
" search for current selection:
nmap <silent> gs <plug>(GrepperOperator)
xmap <silent> gs <plug>(GrepperOperator)
" replace original grep with GrepperRg:
call SetupCommandAlias("grep", "GrepperRg")

" PACK vim-editorconfig - Respecting Project Conventions
let g:editorconfig_verbose = 1
call minpac#add('sgur/vim-editorconfig')

" PACK vim-commentary - un-/commenting blocks of code
call minpac#add('tpope/vim-commentary')

" PACK vim-projectionist - Granular project configuration
call minpac#add('tpope/vim-projectionist')
function! s:loadProjections() abort
  let l:linters = projectionist#query('linters')
  let l:fixers = projectionist#query('fixers')
  if len(l:linters) > 0
    let b:ale_linters = {&filetype: l:linters[0][1]}
  endif
  if len(l:fixers) > 0
    let b:ale_fixers = {&filetype: l:fixers[0][1]}
  endif
endfunction
augroup configure_projects
  autocmd!
  autocmd User ProjectionistActivate call s:loadProjections()
augroup END

" PACK vim-sensible - Defaults everyone can agree on
call minpac#add('tpope/vim-sensible')

" PACK vim-fugitive - Awesome git wrapper
call minpac#add('tpope/vim-fugitive')

" PACK vim-signify - show, jump-to and stage partial git hunks (supports other vcs)
call minpac#add('mhinz/vim-signify')
nnoremap <silent> <leader>gp :SignifyHunkDiff<CR>
nnoremap <silent> <leader>gu :SignifyHunkUndo<CR>
nnoremap <silent> <leader>gs :tab Gstatus<CR>
nnoremap <silent> <leader>gl :tab Git log<CR>
nnoremap <silent> <leader>gd :tab Gdiff<CR>
nnoremap <silent> <leader>gc :tabclose<CR>

" PACK vim-taglist
call minpac#add('vim-scripts/taglist.vim')
let Tlist_Show_One_File = 1
let Tlist_Close_On_Select = 1
nnoremap <silent> <leader>t :TlistOpen<CR>

" PACK vim-obsession
call minpac#add('tpope/vim-obsession')

" PACK gruvbox - color scheme
call minpac#add('morhetz/gruvbox')
set background=dark  " dark or light
let g:gruvbox_contrast_dark = 'hard'  " hard, medium, soft
let g:gruvbox_contrast_light = 'hard'  " hard, medium, soft
colorscheme gruvbox

" fix spelling error highlighting for selected theme:
hi clear SpellBad SpellLocal SpellCap
hi SpellBad cterm=underline,bold
hi SpellLocal cterm=underline,bold
hi SpellCap cterm=underline

" PACK vim-highlightedyank - mark what has just been yanked (visual feedback)
call minpac#add('machakann/vim-highlightedyank')

" PACK surround.vim - quoting/parenthesizing made simple
call minpac#add('tpope/vim-surround')

" PACK vim-airline - more sophisticated status line
call minpac#add('vim-airline/vim-airline')
" call minpac#add('vim-airline/vim-airline-themes')
let g:airline_section_a=''
let g:airline_section_y=''
autocmd VimEnter * let g:airline#extensions#ale#enabled = 1

" PACK vim-rainbow - different colors for different pairs of brackets
call minpac#add('frazrepo/vim-rainbow')
nnoremap <silent> <leader>b :RainbowToggle<CR>

" PACK vim-repeat - Make plugin extensions repeatable
call minpac#add('tpope/vim-repeat')

" PACK vim-python-pep8-indent - PEP8 indentation for python
call minpac#add('vimjas/vim-python-pep8-indent')
