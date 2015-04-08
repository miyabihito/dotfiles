"NeoBundle Scripts-----------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'
"NeoBundle 'honza/vim-snippets'
NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------


" Plugin settings
""""" neocomplete """""
if has('lua')
  let g:neocomplete#enable_at_startup = 1
endif
"""""""""""""""""""""""

""""" neosnippet """""
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
""""""""""""""""""""""

""""""" unite """"""""
nnoremap  [unite]  <Nop>
nmap      <Space>u  [unite]

nnoremap  [unite]f :<C-u>Unite -start-insert -default-action=tabopen -prompt=> file_rec buffer<CR>
nnoremap  [unite]y :<C-u>Unite history/yank<CR>
nnoremap  [unite]s :<C-u>Unite source<CR>
nnoremap  [unite]c :<C-u>Unite -auto-preview colorscheme<CR>

let g:unite_source_history_yank_enable = 1

call unite#filters#matcher_default#use(['matcher_fuzzy'])
""""""""""""""""""""""


" Vim settings
"" display
colorscheme Monokai " カラースキーマの指定
""" dark: Monokai, hybrid, jellybeans, Tomorrow-Night-Bright
""" bright: hybrid-light
syntax on        " 構文強調表示
set number       " 行番号表示
set cul          " カーソル行の強調表示
set hls          " highlight search
set is           " incremental search
set list         " TAB等の可視化
set listchars=tab:▸\ ,trail:- " TABとSPACEの表示指定 eol等も指定できる

"" edit
set backspace=indent,eol,start " allow backspacing over everything in insert mode

"" window
set sb           " splitbelow
set spr          " splitright
set helpheight=100

"" tab
set stal=2       " show tabline always

"" info
set showcmd      " 入力途中のコマンドの表示
set showmode     " 現在のモードの表示
set ruler        " カーソル位置の表示

"" command line
set history=500  " keep command history
set wildmode=longest,list " like bash completion
set cmdwinheight=15 " height of the command-line window

"" characterset
set encoding=utf-8 " character encoding inside Vim


" Key mappings
noremap tn gt
noremap tp gT
noremap tc :tabnew<CR>


" Definition of commands
"" command to see the difference between the current buffer and the file.
"" copied from vimrc_example.vim
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"" alias :e $MYVIMRC
if !exists(":EditRc")
  command EditRc edit $MYVIMRC
endif

"" alias :so $MYVIMRC
if !exists(":ReloadRc")
  command ReloadRc source $MYVIMRC
endif
