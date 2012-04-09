" maps.vim - Vim key mappings
" Maintainer:   Jimmy Thrasibule <spack.world@gmail.com>
" Version:      0.1


" Use arrow keys to move between tabs.
map <C-t><Left>   <Esc>:tabprevious<CR>   " Previous tab
map <C-t><Right>  <Esc>:tabnext<CR>       " Next tab
map <C-t><Down>   <Esc>:tabclose<CR>      " Close tab
map <C-t><Up>     <Esc>:tabnew<CR>        " New tab

" Toggle mouse mode.
map <C-w>m        <Esc>:call ToggleMouseActivation()<CR>
" Toggle text wrapping.
map <F2> <ESC>:call ToggleWrap()<CR>

" Smart moves inside the file
noremap  <expr> <Home> (col('.') == matchend(getline('.'), '^\s*')+1 ? '0' : '^')
noremap  <expr> <End>  (col('.') == match(getline('.'),    '\s*$')   ? '$' : 'g_')
vnoremap <expr> <End>  (col('.') == match(getline('.'),    '\s*$')   ? '$h' : 'g_')
imap <Home> <C-o>g<Home>
imap <End>  <C-o>g<End>

noremap <buffer> <silent> <Up>   gk
noremap <buffer> <silent> <Down> gj
imap    <buffer> <silent> <Up>   <C-o>gk
imap    <buffer> <silent> <Down> <C-o>gj



"""    """
" Panels "
"""    """

" Show file tree.
map <F9> <Esc>:NERDTreeToggle<CR>
" Show functions list.
map <F8> <Esc>:TlistToggle<CR>
" Gundo
map <C-u> <Esc>:GundoToggle<CR>



"""    """
" Python "
"""    """

autocmd FileType python map <F7> <Esc>:w<CR>!\/usr\/bin\/env python % <CR>
autocmd FileType python map <F4> <Esc>:RopeGotoDefinition<CR>
autocmd FileType python map <F3> <Esc>:RopeRename<CR>

