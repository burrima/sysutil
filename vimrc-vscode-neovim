"            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
"                    Version 2, December 2004
"
" Copyright (C) 2025 Martin Burri <info@burrima.ch>
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
" Personal vimrc file for vscode nvim
"

" General Config --------------------------------------------------------------
" map <Leader> key to ',':
let mapleader = ','

" default values, to be overwritten by .editorconfig files:
set textwidth=99  " maximum width of inserted text
set tabstop=4  " tab width
set shiftwidth=4  " number of spaces for each step of (auto)indent
set expandtab  " use spaces instead of tabs

set nowrap  " don't wrap displayed lines

" Key Mappings ----------------------------------------------------------------
" map hard-to-reach keys to simpler ones (useful for Swiss keyboard):
" Note: these mappings are in addition - original keys are still valid
noremap <silent> ' `
"noremap g0 ^
"noremap g$ g_
noremap ö ;
noremap é ,
noremap <Space>g <C-]>
" gq is broken, but luckily we have gw:
noremap gq gw

" Highlighting ----------------------------------------------------------------
" highlight search occurrences (<C-l> to clear):
set hlsearch

" highlight unprintable chars as error:
" hi clear SpecialKey
" hi link SpecialKey Error


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

" PACK vim-commentary - un-/commenting blocks of code
call minpac#add('tpope/vim-commentary')

" PACK vim-sensible - Defaults everyone can agree on
call minpac#add('tpope/vim-sensible')

" PACK vim-highlightedyank - mark what has just been yanked (visual feedback)
call minpac#add('machakann/vim-highlightedyank')

" PACK surround.vim - quoting/parenthesizing made simple
call minpac#add('tpope/vim-surround')

" PACK vim-repeat - Make plugin extensions repeatable
call minpac#add('tpope/vim-repeat')

" PACK vim-python-pep8-indent - PEP8 indentation for python
" call minpac#add('vimjas/vim-python-pep8-indent')

" PACK cutlass: delete without overwriting registers
" Vim, by default, performs a cut on all deletion operations (thus overwriting
" the default register). This plugin remaps c,C,d,D,s,S etc. to fix the issue.
" See https://github.com/nelstrom/vim-cutlass
call minpac#add('svermeulen/vim-cutlass')
" define a key to cut:
nnoremap x d
xnoremap x d
nnoremap xx dd
nnoremap X D

" Call VsCode commands --------------------------------------------------------
nnoremap <space>f <Cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>
nnoremap <space>c <Cmd>lua require('vscode').action('workbench.action.showCommands')<CR>
nnoremap <space>d <Cmd>lua require('vscode').action('editor.action.revealDefinition')<CR>
nnoremap <space>t <Cmd>lua require('vscode').action('editor.action.goToTypeDefinition')<CR>
nnoremap <space>i <Cmd>lua require('vscode').action('editor.action.goToImplementation')<CR>
nnoremap <space>r <Cmd>lua require('vscode').action('editor.action.goToReferences')<CR>
nnoremap <Leader>gd <Cmd>lua require('vscode').action('git.openChange')<CR>
noremap <leader>gu <Cmd>lua require('vscode').action('git.revertSelectedRanges')<CR>
noremap <leader>gp <Cmd>lua require('vscode').action('editor.action.dirtydiff.next')<CR>
noremap [c <Cmd>lua require('vscode').action('editor.action.dirtydiff.next')<CR>
noremap ]c <Cmd>lua require('vscode').action('editor.action.dirtydiff.previous')<CR>

" Re-map <c-w><c-hjkl> commands to <c-w>HJKL because <c-w><c-l> is too close to
" <c-w>l (typed wrong command too often)
unmap <c-w><c-h>
unmap <c-w><c-j>
unmap <c-w><c-k>
unmap <c-w><c-l>
nnoremap <C-w>J <Cmd>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
xnoremap <C-w>J <Cmd>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
nnoremap <C-w>K <Cmd>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
xnoremap <C-w>K <Cmd>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
nnoremap <C-w>H <Cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
xnoremap <C-w>H <Cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
nnoremap <C-w>L <Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>
xnoremap <C-w>L <Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>
