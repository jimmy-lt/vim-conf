" vimrc - Vim configuration file
" Maintainer:   Jimmy Thrasibule <spack.world@gmail.com>
" Version:      0.1


"""         """
" Status line "
"""         """

" file_name [+][type][format][encoding]    (DEC:0xHEX) col:lnum\lines percentage| date, hour
set statusline=%F\ %m%r%w%y[%{&ff}]%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\"}%<%=(%02.3b:0x%02.2B)\ %v%V:%l\\%L\ %p%%\|\ %{strftime(\"%a\ %d\ %b\ %Y,\ %H:%M\")}
set laststatus=2



"""      """
" Pathogen "
"""      """
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()



"""                  """
" Editor configuration "
"""                  """

" Coloration.
syntax on

if has('gui_running')
  set background=light
else
  set background=dark
endif
let g:solarized_termtrans=1
let g:solarized_termcolors=256
colorscheme solarized

" Show line numbers.
set number
highlight LineNr ctermfg=3

" Show cursor line.
set cursorline

" Characters over the 80th column are highlighted.
hi OverLength guifg=NONE guibg=#32322f gui=none ctermbg=236
match OverLength '\%>80v.\+'
" Automatic wrapping at the 80th character.
set textwidth=80

"" Show tabulations and trailing spaces.
set list
set lcs=tab:»·    "Tabulations
set lcs+=trail:·  "Trailing spaces

" Allow modline in files
set modeline

" Function to enable/disable text wrapping.
function ToggleWrap()
  if &wrap
    echo "Wrap OFF"

    setlocal nowrap
    set virtualedit=all

    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
  else
    echo "Wrap ON"

    setlocal wrap linebreak
    setlocal display+=lastline
    set virtualedit=

    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
  endif
endfunction

" Tabs color.
highlight TabLine term=none cterm=none
highlight TabLineSel ctermbg=darkblue

" Force file types.
au BufRead,BufNewFile *.cf set filetype=cf3


"""              """
" Mouse management "
"""              """

" Function to change mouse mode.
let s:mouseActivation = 1
function! ToggleMouseActivation()
  if (s:mouseActivation)
    let s:mouseActivation = 0
    set mouse=n
    set paste
    echo "Paste OFF"
  else
    let s:mouseActivation = 1
    set mouse=a
    set nopaste
    echo "Paste ON"
  endif
endfunction

set mouse=a
set nopaste



"""         """
" Indentation "
"""         """
set autoindent
filetype on
filetype plugin indent on



"""                    """
" Tabulations management "
"""                    """

"" Tabulation size.
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Expand tabulations to spaces.
set expandtab

" True tabulations for Makefiles
autocmd FileType make setlocal noexpandtab



"""    """
" Python "
"""    """

autocmd FileType python set tabstop=4
autocmd FileType python set shiftwidth=4
autocmd FileType python set softtabstop=4
autocmd FileType python set completeopt=menuone,longest,preview

" Use modules inside the virtualenv for documentation.
py << EOF
import os.path
import sys
import vim

if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin', 'activate_this.py')
    execfile(activate_this, dict(__file__ = activate_this))
EOF



"""        """
" Completion "
"""        """
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

let g:SuperTabDefaultCompletionType = "context"


"""      """
" Mappings "
"""      """
execute 'source' . $HOME . '/.vim/maps.vim'



"""         """
" Buffer save "
"""         """
augroup BWCCreateDir
  au!
  autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p ".shellescape(expand('%:h'), 1) | redraw! | endif
augroup END

