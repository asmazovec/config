syntax on

noremap <silent> <ESC> :noh <RETURN>

"" Автоматически перечитывать конфигурацию VIM после сохранения
autocmd! bufwritepost $MYVIMRC source $MYVIMRC
set guicursor=
set hidden
set noerrorbells
set scrolloff=4
set tabstop=4 
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set number
set relativenumber
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.config/.nvim/undodir
set undofile
set mouse=a
set mousemodel=popup
set ch=1
set showmatch
set cursorline
highlight CursorLine guibg=lightblue ctermbg=lightgray
highlight CursorLine term=none cterm=none
set history=200
set ignorecase
set smartcase
set mousehide

setlocal spell spelllang=ru_yo,en_us
call plug#begin()
Plug 'lyokha/vim-xkbswitch'
Plug 'mbbill/undotree'
Plug 'Valloric/YouCompleteMe'
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'voldikss/vim-translate-me'
call plug#end()

colorscheme gruvbox
set background=dark

let g:XkbSwitchEnabled = 1
let g:XkbSwitchIMappings=['ru']
let g:netrw_browse_split=2
let g:netrw_banner=0
let g:netrw_winsize=25
let g:ctrlp_use_caching=0
let g:indentLine_enabled = 1
let g:indentLine_char='┊'
let g:translator_target_lang='ru'
let g:translator_default_engines=['google', 'bing']
let g:translator_window_borderchars=[]
let g:translator_window_max_width=60
let mapleader=' '

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 20 <bar> :setlocal wfw <CR>
nnoremap <silent> <leader>= :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize 20<CR>
nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>gf :YcmCompleter FixIt<CR>
nmap <silent> <Leader>t <Plug>TranslateW
vmap <silent> <Leader>t <Plug>TranslateWV

noremap <silent> <ESC> :noh <RETURN>
