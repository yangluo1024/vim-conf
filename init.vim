set nocompatible              
filetype off                 
execute pathogen#infect()
syntax on
filetype plugin indent on

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'w0rp/ale'
""Plugin 'tpope/vim-fugitive'
""Plugin 'kannokanno/previm'
Plugin 'tyru/open-browser.vim'
Plugin 'luochen1990/rainbow'
Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'vim-airline/vim-airline'
Plugin 'liuchengxu/space-vim-dark'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'ycm-core/YouCompleteMe'
Plugin 'liuchengxu/space-vim-theme'
Plugin 'preservim/nerdtree'
Plugin 'fatih/vim-go'
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'
Plugin 'jremmen/vim-ripgrep'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }

call vundle#end()
set rnu
" defaults for vim only.
filetype plugin indent on
if !has('nvim')
    syntax enable
    syntax on
    set laststatus=2
    set fileencodings=utf-8,gbk
    set hlsearch
    set incsearch
endif


set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
 
let mapleader = ","
set sw=4 ts=4 et
set splitbelow
set splitright
set rtp+=/usr/local/opt/fzf
nnoremap <leader><CR> :noh\|hi Cursor guibg=red<CR>
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>
nnoremap <Leader>l :setlocal number!<CR>
nnoremap <Leader>o :set paste!<CR>
nnoremap j gj
nnoremap k gk
" clipboard
nnoremap <leader>y "*y
vnoremap <leader>y "*y
nnoremap <leader>d "*d
vnoremap <leader>d "*d
nnoremap <leader>p "*p
vnoremap <leader>p "*p

map <F6> :silent! NERDTreeToggle<CR>
map <F7> :Tlist <CR>
map <F8> :terminal <CR>
map <F11>:bp <CR>
map <F12>:bn <CR>

" swap :tag and :tselect
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
nnoremap g<c-]> <c-]>
vnoremap g<c-]> <c-]>


if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m

endif

let Tlist_Show_One_File = 1                  
let Tlist_Exit_OnlyWindow = 1               
let Tlist_Use_Left_Window = 1              

set laststatus=2 
let g:airline_powerline_fonts = 1 
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme="bubblegum"
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" airline setting
let g:airline_left_sep = '->'
let g:airline_left_alt_sep = '->'
let g:airline_right_sep = '->'
let g:airline_right_alt_sep = '->'
let g:airline_symbols.branch = '->'
let g:airline_symbols.readonly = '->'
let g:airline_symbols.linenr = '->'
let g:airline#extensions#tabline#enabled = 1
" show absolute file path in status line
let g:airline_section_c = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
" show tab number in tab line
let g:airline#extensions#tabline#tab_nr_type = 1

set fdm=marker
" colorschema
set termguicolors
" colorscheme solarized8_flat

" terminal
tnoremap <C-w> <C-\><C-n><C-w>
if has('nvim')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
endif
augroup term
  au!
  if has('nvim')
    au BufWinEnter,WinEnter term://* startinsert
    au BufLeave term://* stopinsert
    au TermClose * bd!|q
  else
    au BufWinEnter,WinEnter term://* exec 'normal! i'
  endif
augroup END

" languages
augroup langs
  au!
  au FileType python,lua set foldmethod=indent foldnestmax=2
  au FileType vim set foldmethod=indent foldnestmax=2 sw=2
au BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
au BufWrite *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&"
  " Source the vimrc file after saving it
  au BufWritePost .vimrc source $MYVIMRC
  au BufWritePost *.hs,*.hsc silent !update-tags %
  au FileType haskell set formatprg=stylish-haskell
augroup END

" ale
au FileType haskell let g:ale_linters.haskell = ['hlint']
nnoremap <silent> <leader>aj :ALENext<cr>
nnoremap <silent> <leader>ak :ALEPrevious<cr>
" let g:ale_linters = {'go': ['golangci-lint']}
let g:go_fmt_fail_silently = 1  " https://github.com/w0rp/ale/issues/609
let g:ale_echo_msg_format = '%linter% says %s'
let g:go_fmt_command = "goimports"
let g:go_def_command = "godef"
au FileType go nmap <Leader>gs <Plug>(go-def-split)
au FileType go nmap <Leader>gv <Plug>(go-def-vertical)


" LanguageClient-neovim
let g:LanguageClient_rootMarkers = ['.git']

" bufexplorer
nnoremap <C-L> :BufExplorer<CR>

" ctrlp
nn <C-s> :CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
imap <F4> <C-x><C-o>

" vim-grepper
nnoremap <leader>g :Grepper -tool git -highlight<cr>
nnoremap <leader>G :Grepper -tool rg -highlight<cr>
nnoremap gs <plug>(GrepperOperator)
xnoremap gs <plug>(GrepperOperator)

let g:go_bin_path = "/Users/leefong/go/bin"
""let g:ycm_gopls_binary_path="/Users/leefong/go/bin/gopls"
let g:ycm_use_clangd = 0
let Tlist_Show_One_File=1    
let Tlist_Exit_OnlyWindow=1    
let Tlist_Ctags_Cmd="/usr/local/Cellar/universal-ctags/HEAD-02cf1a6/bin/ctags" 
" go vim
let $GOPATH = "/Users/leefong/go"
let $GOBIN = "/usr/local/Cellar/go/1.14.5/bin/go"
let $GOROOT = "/usr/local/Cellar/go/1.14.5/libexec"
""let g:go_highlight_functions = 1
""let g:go_highlight_methods = 1
""let g:go_highlight_structs = 1
""let g:go_highlight_operators = 1
""let g:go_highlight_build_constraints = 1
let g:go_gopls_complete_unimported = v:false
let g:go_gopls_deep_completion = v:false
let g:go_gopls_matcher = v:false
let g:go_gopls_enabled = 1
"ale setting 
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
nmap <Leader>s :ALEToggle<CR>
map <Leader>d :ALEDetail<CR>

let g:tagbar_type_rust = {
            \ 'ctagstype' : 'rust',
            \ 'kinds' : [
            \'T:types,type definitions',
            \'f:functions,function definitions',
            \'g:enum,enumeration names',
            \'s:structure names',
            \'m:modules,module names',
            \'c:consts,static constants',
            \'t:traits,traits',
            \'i:impls,trait implementations',
            \]
            \}

function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>


" Return to last edit position when opening files (You want this!)
augroup last_edit
  autocmd!
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif
augroup END
" Remember info about open buffers on close
set viminfo^=%

function! InsertGates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . gatename
  execute "normal! o#define " . gatename . " "
  execute "normal! Go#endif /* " . gatename . " */"
  normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} call InsertGates()
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let Tlist_Ctags_Cmd="/usr/local/Cellar/universal-ctags/HEAD-02cf1a6/bin/ctags"
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1

" auto
set autoindent
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab
""imap{ {}<ESC>i<CR><ESC>O


imap {<CR> {<CR>}<ESC>O

inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap < <><ESC>i
inoremap ‘ ’‘<ESC>i
inoremap " ""<ESC>i
inoremap ` ``<ESC>i
" cscope
nmap <leader><Space>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <leader><Space>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <leader><Space>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <leader><Space>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <leader><Space>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <leader><Space>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <leader><Space>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <leader><Space>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <leader><Space>a :cs find a <C-R>=expand("<cword>")<CR><CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>

colorscheme space-vim-dark
set guifont=Monaco:h11

" setting rust source path and racer cmd url
let $RUST_SRC_PATH="/Users/leefong/.rustup/toolchains/nightly-2020-04-30-x86_64-apple-darwin/lib/rustlib/src/rust/src"
let g:racer_cmd = "/Users/leefong/.cargo/bin/racer"
let g:racer_experimental_completer = 1
let g:racer_insert_paren = 1
let g:rustfmt_command = 'rustfmt'

augroup Racer
    autocmd!
    autocmd FileType rust nmap <buffer> gd         <Plug>(rust-def)
    autocmd FileType rust nmap <buffer> gs         <Plug>(rust-def-split)
    autocmd FileType rust nmap <buffer> gx         <Plug>(rust-def-vertical)
    autocmd FileType rust nmap <buffer> gt         <Plug>(rust-def-tab)
    autocmd FileType rust nmap <buffer> <leader>gd <Plug>(rust-doc)
    autocmd FileType rust nmap <buffer> <leader>gD <Plug>(rust-doc-tab)
augroup END

	
nn <M-1> 1gt
nn <M-2> 2gt
nn <M-3> 3gt
nn <M-4> 4gt
nn <M-5> 5gt
nn <M-6> 6gt
nn <M-7> 7gt
nn <M-8> 8gt
nn <M-9> 9gt
nn <M-0> :tablast<CR>

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"


