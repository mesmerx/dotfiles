"this disables compatibility with vi, 
"so if it's not set most upgrades from vim is disabled
set nocompatible

"this ativates the plugin files and inent files 
filetype indent plugin on

"permitis the syntax highlighted
syntax on

"set a column in the cursor
set cursorcolumn

"set the color for the column
hi CursorColumn ctermbg=8

"set the number in the left as relative
set relativenumber

"set the indentation as automatic
set autoindent

"try to separate the indentation by type
set smartindent

" put the number in left n cursor line as the corect line
set nu

"permits usage for clipboard of system in vim and vice-versa
set clipboard+=unnamedplus

"set the table to stop in 8 spaces
set tabstop=8
set shiftwidth=4

" if you want to run vim in a terminal
set termguicolors 

"put no background for vim
hi Normal guibg=NONE ctermbg=NONE

"set max number of times the key can be pressed
let g:hardtime_maxcount=2

"show msg when hardtime is on
let g:hardtime_showmsg=1

"auto ativate hardtime
let g:hardtime_default_on=1

" run the fixers when save
let g:ale_fix_on_save=1

"set vim to hidden markdown  (for json is quotes for example)simbols unless are set
set conceallevel=2

"hidde cursor when visual insert or normal
set concealcursor=vin



"put f6 to try fix current file
nmap <F6> <Plug>(ale_fix)

"put split to be bellow
set splitbelow

"opens firefox with markdown code when opened .MD file
let vim_markdown_preview_toggle=1
let vim_markdown_preview_browser='Firefox'


" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif



"set the colorscheme for vim
colorscheme breezy
