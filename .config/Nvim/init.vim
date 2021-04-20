luafile ~/.config/nvim/lua/init.lua
" plugins 
call plug#begin()
Plug 'vbe0201/vimdiscord'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" settings
set sessionoptions-=options
"execute pathogen#infect()
set fillchars=eob:\ 
syntax on
filetype plugin indent on
let g:hexmode_patterns = '*.bin,*.exe,*.dat,*.o'
let g:hexmode_xxd_options = '-g 1'
" for coc 
nnoremap <silent> <C-t> :NvimTreeOpen ()<CR>
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

""" Customize colors
hi Pmenu cterm=bold ctermbg=red guifg='#8ec07c' guibg='#282828' 
hi PmenuSel cterm=bold ctermbg=red guifg='#8ec07c'  guibg='#282828'
hi PmenuSbar cterm=bold ctermbg=red guifg='#8ec07c' guibg='#282828'
hi PmenuThumb cterm=bold ctermbg=red guifg='#8ec07c' guibg='#282828'
highlight IndentBlanklineChar guifg=#000000 gui=nocombine

let g:coc_global_extensions = ['coc-json']

"source ~/.config/nvim/coc.vim
" Airline 
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline# = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_theme = 'powerlineish'
set showtabline=2
" for coc setting 

let g:coc_global_extensions = [
    \ 'coc-discord-rpc',
	\ 'coc-json',
\ ]

