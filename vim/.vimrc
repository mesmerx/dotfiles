set nocompatible
syntax on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
let python_highlight_all=1
set splitbelow
set splitright
set nu
set encoding=utf-8
set relativenumber
set hidden
set wildmenu
set showcmd
set hlsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set nostartofline
set ruler
set laststatus=2
set confirm
set visualbell
set t_vb=
set mouse=a
set number
set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F11>
set shiftwidth=4
set clipboard+=unnamedplus
set clipboard=unnamedplus
set softtabstop=4
set expandtab
map Y y$
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set whichwrap=b,s,<,>,[,]


augroup resCur
      autocmd!
        autocmd BufReadPost * call setpos(".", getpos("'\""))
    augroup END

""taglist     
let Tlist_Compact_Format = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 0
nnoremap <C-m> :TlistToggle<CR>

""nertree

nnoremap <C-n> :NERDTreeToggle<CR>


" Commenting blocks of code.
autocmd FileType c,cpp,java,scala,go let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cd :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

set wildchar=<Tab> wildmenu wildmode=full
set wildcharm=<C-Z>
nnoremap <F12> :buffers<CR>:buffer<Space>

set rtp^=/usr/share/vim/vimfiles/

set rtp+=~/.vim/bundle/Vundle.vim


"airline

let g:airline#extensions#tabline#enabled = 1

"" seta autocomplet
set omnifunc=htmlcomplete#CompleteTags

"" barra de sinais sem cor

highlight clear SignColumn

"" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_view_general_options = ' file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = ''


let g:SimpylFold_docstring_preview=1

"" chama plugins
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'virtualenv.vim'
Plugin 'EditPlus'
Plugin 'Tabular'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'SuperTab'
Plugin 'csv.vim'
Plugin 'Syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'python_fold_compact'
Plugin 'tmhedberg/SimpylFold'
Bundle 'Valloric/YouCompleteMe'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'OnSyntaxChange'
Plugin 'SearchComplete'
Plugin 'EasyMotion'
Plugin 'The-NERD-tree'
Plugin 'surround.vim'
Plugin 'Buffergator'
Plugin 'The-NERD-Commenter'
Plugin 'taglist.vim'
Plugin 'mathematic.vim'
Plugin 'Chiel92/vim-autoformat'
Plugin 'kshenoy/vim-signature'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'honza/vim-snippets'
Plugin 'kien/ctrlp.vim'
Plugin 'lervag/vimtex'
Plugin 'Yggdroot/indentLine'
Plugin 'nathanaelkane/vim-indent-guides'

call vundle#end()            " required
filetype plugin indent on    " required
let g:syntastic_quiet_messages = { "regex": [
        \ '\mpossible unwanted space at "{"',
        \ '\mWrong length of dash may have been used.',
        \ '\mCould not open "questoes\\serie"']}

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

let g:ycm_python_binary_path = '/usr/bin/python3'

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

call togglebg#map("<F5>")

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

noremap <F8> :set spell spelllang=pt-BR,en<CR>
noremap <F10> :set spell spelllang=<CR>

let g:syntastic_quiet_messages={'level':'warnings'}
" ============== syntastic settings ===============
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0 

" Specific checkers for tex
let g:syntastic_tex_checkers = ['chktex', 'proselint']

" Others
let g:syntastic_aggregate_errors = 1
let g:syntastic_enable_signs = 1

" Error symbols
" let g:syntastic_error_symbol = "✗"
" let g:syntastic_warning_symbol ="∙∙"
"

" Enable folding with the spacebar
nnoremap <space> za
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_enabled = 1
let g:indentLine_char = ''


nnoremap <C-I> :IndentLinesToggle
let g:indent_guides_guide_size = 1
" Enable folding
set foldmethod=indent
set foldlevel=99

au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

