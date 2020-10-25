"dein Scripts----------------------------- {{{
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  call dein#add('tpope/vim-fugitive')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('flazz/vim-colorschemes')
  call dein#add('itchyny/lightline.vim')
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('ctrlpvim/ctrlp.vim')
  call dein#add('thinca/vim-quickrun')
  call dein#add('kannokanno/previm')
  call dein#add('tpope/vim-surround')
  call dein#add('posva/vim-vue')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts------------------------- }}}


" Plugin settings {{{
"" deoplete {{{
let g:deoplete#enable_at_startup = 1
"" }}}

"" neosnippet {{{
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" for use of vim-snippets
"let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
"" }}}

"" lightline {{{
let g:lightline = {
	\ 'colorscheme': 'wombat',
	\ 'active': {
	\ 	'left': [ [ 'mode', 'paste' ],
	\ 		  [ 'git_branch', 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component': {
	\ 	'readonly': '%{&readonly?"":""}',
	\ },
	\ 'component_function': {
	\ 	'git_branch': 'LlGitBranch'
	\ },
	\ 'separator': { 'left': '', 'right': '' },
	\ 'subseparator': { 'left': '', 'right': '' }
\ }

function! LlGitBranch()
	if exists("*fugitive#head")
		let branch = fugitive#head()
		return strlen(branch) ? ' '.branch : ''
	endif
	return ''
endfunction
"" }}}

"" editorconfig {{{
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
"" }}}

"" NERDTree {{{
map <C-n> :NERDTreeToggle<CR>
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '^\.git$[[dir]]', '\.swp$']
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
"" }}}

"" ctrlp {{{
let g:ctrlp_show_hidden = 1
"" lightlineとの競合解決(http://leafcage.hateblo.jp/entry/2013/10/21/lightlinevim-customize)
let g:ctrlp_buffer_func = {'enter': 'CtrlPEnter'}
function! CtrlPEnter()
  let w:lightline = 0
endfunction
"" }}}

"" quickrun {{{
let g:quickrun_config = {
\ '_': {
\   'runner': 'vimproc',
\   'runner/vimproc/updatetime': 100,
\ },
\ 'node': {
\   'type': 'javascript/nodejs',
\ },
\}

" <C-c>で強制終了
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
"" }}}

"" previm {{{
let g:previm_open_cmd = 'open /Applications/Google\ Chrome.app'
"" }}}
" }}}


" Option settings {{{
"" display
colorscheme jellybeans " カラースキーマの指定
""" dark: Monokai, hybrid, jellybeans, Tomorrow-Night-Bright
""" bright: hybrid-light
syntax on        " 構文強調表示
set number       " 行番号表示
set cul          " カーソル行の強調表示
set hls          " highlight search
set is           " incremental search
set list         " TAB等の可視化
set listchars=tab:▸\ ,trail:- " TABとSPACEの表示指定 eol等も指定できる
set conceallevel=0

"" edit
set backspace=indent,eol,start " allow backspacing over everything in insert mode

"" window
set laststatus=2 " always display status line
set sb           " splitbelow
set spr          " splitright
set helpheight=100

"" tab
set stal=2       " show tabline always

"" info
set showcmd      " 入力途中のコマンドの表示
set noshowmode   " 現在のモードを非表示（lightlineで表示されるので）
set ruler        " カーソル位置の表示

"" swap file
set updatetime=250 " for gitgutter

"" command line
set history=500  " keep command history
set wildmode=longest,list " like bash completion
set cmdwinheight=15 " height of the command-line window

"" characterset
set encoding=utf-8 " character encoding inside Vim
" }}}


" Key mappings {{{
noremap tn gt
noremap tp gT
noremap tc :tabnew<CR>
" }}}


" Definition of commands {{{
"" command to see the difference between the current buffer and the file.
"" copied from vimrc_example.vim
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif

"" alias :e $MYVIMRC
if !exists(":EditRc")
  command EditRc tabnew $MYVIMRC
endif
" }}}


" Definition of autocommands {{{
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost *vimrc nested source $MYVIMRC
augroup END

augroup vim_folding
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup vim_grep
  autocmd!
  autocmd QuickFixCmdPost *grep* cwindow
augroup END

augroup detect_markdown
  autocmd!
  autocmd BufNewFile,BufRead *.md set filetype=markdown
augroup END
" }}}
