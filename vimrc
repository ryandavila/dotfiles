set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'hdima/python-syntax'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'justinmk/vim-syntax-extra'
Plugin 'kchmck/vim-coffee-script'
Plugin 'let-def/ocp-indent-vim'
Plugin 'othree/html5.vim'
Plugin 'groenewege/vim-less'
Plugin 'tpope/vim-liquid'
Plugin 'tpope/vim-surround'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'vim-scripts/DrawIt'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Valloric/YouCompleteMe'
call vundle#end()

filetype plugin indent on

set wildmenu
set wildignore="*.o,*~,*.pyc,*.class"

set si
set autoindent
set smartindent
set number
set mouse=a " Mouse does not select line numbers
syntax on
set synmaxcol=356

set hlsearch " Highlight searches
set ignorecase " Ignore case in searches

highlight Comment ctermfg=DarkGrey
set cursorline
" highlight Cursorline cterm=none ctermbg=236
" autocmd InsertEnter * highlight Cursorline cterm=none ctermbg=None
" autocmd InsertLeave * highlight Cursorline cterm=none ctermbg=236
highlight CursorLine cterm=none ctermfg=none ctermbg=none
highlight LineNr cterm=none ctermfg=Brown ctermbg=none
highlight CursorLineNr cterm=none ctermfg=Cyan ctermbg=none

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Fix problem with backspace key
set backspace=indent,eol,start

" Show status line on all windows, not just on splits
set laststatus=2

" Map key to toggle opt
function MapToggle(key, opt)
    let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
    exec 'nnoremap '.a:key.' '.cmd
    exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command -nargs=+ MapToggle call MapToggle(<f-args>)

" Key Mappings
" ==================
let mapleader = "\<Space>"

" ======== file specific ========

" Use tabs instead of spaces for Makefile
if @% != 'Makefile'
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set expandtab
endif

" Use two spaces in yaml files
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

"find new python support

" javascript support
let javascript_enable_domhtmlcss = 1

" ocaml support
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
set rtp+=~/.vim/bundle/ocp-indent-vim
autocmd FileType ocaml setlocal ts=2 sts=2 sw=2 tw=80 cc=80 expandtab
" ruby support
autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab

" For you-complete-me
let g:ycm_disable_for_files_larger_than_kb = 1000
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
" ## added by OPAM user-setup for vim / ocp-indent ## 52964f762c2e30ed67ec7ce84a508511 ## you can edit, but keep this line
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line
