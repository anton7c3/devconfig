" ============================ Vundle ========================================
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Indentwise, movement based on indentation level
Plugin 'jeetsukumaran/vim-indentwise'

" Buffer Explorer, to navigate opened buffers quickly
Plugin 'jlanzarotta/bufexplorer'

" Some Tim Pope's plugins
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'

" LightLine at the bottom of the screen
Plugin 'itchyny/lightline.vim'

" File tree at the left side
Plugin 'preservim/nerdtree'

" Plugion to make % command follow different language constructions
Plugin 'adelarsq/vim-matchit'

" Vim crystal support
Plugin 'vim-crystal/vim-crystal'

" GitGutter, line at the left of the buffer that shows git tracked changes
Plugin 'airblade/vim-gitgutter'

" YCM from GitHub
Plugin 'ycm-core/YouCompleteMe.git'

" NERD Commenter
" Plugin 'scrooloose/nerdcommenter'

" CtrlP
" Plugin 'ctrlpvim/ctrlp.vim.git'

" Tagbar
Plugin 'preservim/tagbar'

" Minimap
Plugin 'severin-lemaignan/vim-minimap'

" Fzf
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

" FAR, Find And Replace plugin
Plugin 'brooth/far.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ============================== Common Vim setup =============================

set mouse=a

set hlsearch
set incsearch
set ignorecase
set smartcase
set hidden
set wildmenu
set showcmd

" Autoreload files
set autoread
au FocusGained,BufEnter * :silent! !

" Ctrl+C/+V clipboard
vnoremap <C-Insert> "+y
vnoremap <C-Del> "+d

" Close buffer without closing the window
nnoremap <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" Line numbers and stuff...
set number
set relativenumber
highlight LineNr term=bold cterm=NONE ctermbg=17 ctermfg=11

" Highlight extra whitespaces
highlight ExtraWhitespace ctermbg=darkred guibg=darkred
match ExtraWhitespace /\s\+$/

" Use 4 spaced for indentation by default
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set colorcolumn=80
highlight ColorColumn ctermbg=darkgrey guibg=darkgrey

" nnoremap <F9> za
" nnoremap <C-F9> zr
" nnoremap <S-F9> zm

set scrolloff=3

" Grep the word under the cursor
nnoremap <leader>gw :grep <C-R><C-W> . -Irn<CR>
" Grep the WORD under the cursor
nnoremap <leader>gW :grep <C-R><C-A> . -Irn<CR>

" ====================== Some scripts above standard vim  =====================

function! UndoIfShellError()
    if v:shell_error
        undo
    endif
endfunction

" Use F8 to format selected json fragment in visual mode, fallback on error
vnoremap <F8> :!python3 -m json.tool<CR>:call UndoIfShellError()<CR>

" Search for visually selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Hide highlight on Ctrl+/
nnoremap <silent> <c-_> :nohl<CR>

" Automatically recognize HAR files as JSON (which they really are)
au BufRead,BufNewFile *.har set ft=json

" Stolen from defaults.vim
" Put these in an autocmd group, so that you can revert them with:
" ":augroup vimStartup | au! | augroup END"
augroup vimStartup
au!

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid, when inside an event handler
" (happens when dropping a file on gvim) and for a commit message (it's
" likely a different one than last time).
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

augroup END

" Copy current file name to clipboard
nmap <leader>cf :let @+=expand("%")<CR>
nmap <leader>cp :let @+=expand("%:p")<CR>
nmap <leader>yf :let @*=expand("%")<CR>
nmap <leader>yp :let @*=expand("%:p")<CR>
" ========================== Per-filetype indentation =========================

" Use 2 spaced in .cr files
autocmd FileType crystal setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab

" Use 2 spaced in .yamlfiles
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab

filetype indent plugin on

" =========================== Per-filetype functions ==========================
" autocmd FileType crystal nnoremap <C-f> :g/def <CR>
" autocmd FileType crystal set foldmethod=syntax
" autocmd FileType crystal set foldlevel=5
" Use ':set foldlevel' ;)
" =============================== Bufer explorer ==============================

" Buffer explorer key mapping
nnoremap <F2> :ToggleBufExplorer<CR>

" =============================== LightLine ===================================
set laststatus=2

" ================================ NERDTree ===================================
nnoremap <F3> :NERDTreeFocus<CR>

" This is a tricky part: the 'ESCAPE' symbol has to be pasted.
" Press Ctrl+V and the desired keystroke
set <S-F3>=[1;2R
nnoremap <S-F3> :NERDTreeToggle<CR>

" ============================= NERD Commenter ================================

let g:NERDCustomDelimiters = { 'crystal': { 'left': '# '} }

" ================================= Tagbar ====================================

nnoremap <F4> :TagbarOpenAutoClose<CR>
set <S-F4>=[1;2S
nnoremap <S-F4> :TagbarToggle<CR>

let g:tagbar_type_crystal = {
    \ 'ctagstype': 'crystal',
    \ 'kinds' : [
        \'d:defs',
        \'f:functions',
        \'c:classes',
        \'m:modules',
        \'l:libs',
        \'s:structs'
    \]
    \}

" Some additional tags related stuff
" Regenerate tags on <leader><F4>
nnoremap <leader><F4> :!ctags -R .<CR>

" ================================== fzf ======================================
" Browse tags on <leader>p
" nnoremap <leader>p :CtrlPTag<CR>
nnoremap <C-p> :Files<CR>
nnoremap <leader>p :Tags<CR>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)


" =============================== gitgutter ===================================
" shows git status marks in left column

let g:gitgutter_set_sign_backgrounds = 1
highlight SignColumn      ctermbg=black
highlight GitGutterAdd    ctermbg=black ctermfg=green  guifg=#009900
highlight GitGutterChange ctermbg=black ctermfg=yellow guifg=#bbbb00
highlight GitGutterDelete ctermbg=black ctermfg=red    guifg=#ff2222

" Integrate GitGutter status into LightLine
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('git: +%d / ~ %d / - %d', a, m, r)
endfunction

let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified', 'gitgutter' ] ]
      \ },
      \ 'component': {
      \   'gitgutter': ''
      \ },
      \ 'component_function': {
      \   'gitgutter': 'GitStatus'
      \ },
      \ }

" ============================ YouCompleteMe setup ============================

command! YD :YcmComplete GoToDefinition

let g:ycm_auto_hover = ''

nnoremap <leader>h <plug>(YCMHover)

" let g:ycm_language_server =
"   \ [
"   \   {
"   \     'name': 'crystal',
"   \     'cmdline': [ 'crystalline'],
"   \     'project_root_files' : [ 'shard.yml' ],
"   \     'filetypes': [ 'crystal' ]
"   \   }
"   \ ]

" Uncomment to see YCM <-> LSP log in the stderr log of ycmd
" let g:ycm_log_level='debug'

let g:ycm_autoclose_preview_window_after_insertion = 1


" =============================== CoC setup ===================================
" source ~/.vim/coc_setup.vim

" ============================ debugger setup  ================================
packadd termdebug

" ================================== FAR ======================================
" Search for visually selected text
vnoremap /F y:F <C-R>=escape(@",'/\')<CR><CR>
