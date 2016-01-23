".vimrc
"Author: Addisu Taddese
"Source: http://github.com/azeey/dotfiles/vimrc
"
"Preamble ------------------------------------------------------------{{{
"
"Initialize vundle
if !has('nvim')
set nocompatible               " be iMproved
endif
filetype off                   " required!

"call plug#begin('~/.vim/plugged')
call plug#begin()

"}}}
"Plugins -------------------------------------------------------------{{{

Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
"Plug 'tpope/vim-markdown'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'

Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'

" From vim-scripts
Plug 'scratch.vim'
Plug 'YankRing.vim'
Plug 'Gundo'
Plug 'taglist.vim'
Plug 'fontzoom.vim'
Plug 'bclear'
Plug 'ShowMarks'
"Plug 'camelcasemotion'

" All others
Plug 'altercation/vim-colors-solarized'
Plug 'austintaylor/vim-commaobject'
"Plug 'coderifous/textobj-word-column.vim'
Plug 'edsono/vim-matchit'
" For supertab and smartinput, the order matters
Plug 'kana/vim-smartinput'
Plug 'cohama/vim-smartinput-endwise'
Plug 'godlygeek/tabular'
Plug 'ivanov/vim-ipython'
"Plug 'kana/vim-textobj-user'
Plug 'kien/ctrlp.vim'
"Plug 'klen/python-mode'
Plug 'Lokaltog/vim-easymotion'
Plug 'markabe/bufexplorer'
Plug 'michaeljsmith/vim-indent-object'
"Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'othree/xml.vim'
"Plug 'plasticboy/vim-markdown'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'sjl/badwolf'
Plug 'Source-Explorer-srcexpl.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'NesC-Syntax-Highlighting'
Plug 'bling/vim-airline'
Plug 'myhere/vim-nodejs-complete'
Plug 'moll/vim-node'
"Plug 'jcf/vim-latex'
Plug 'lervag/vim-latex'
Plug 'pangloss/vim-javascript'
Plug 'Valloric/YouCompleteMe'
"Plug 'Rykka/riv.vim'

"Plug 'majutsushi/vim-textobj-function'
Plug 'rosenfeld/conque-term'
Plug 'rainbow_parentheses.vim'

"The silver searcher
Plug 'rking/ag.vim'
Plug 'jshint2.vim'
Plug 'tpope/vim-sensible'
Plug 'airblade/vim-gitgutter'


"Plug 'davidhalter/jedi-vim'
"Plug 'ervandew/supertab'

"Testing
Plug 'justinmk/vim-sneak'
"Plug 'justmao945/vim-clang'
Plug 'taketwo/vim-ros'
"Plug 'quickfixsigns'
"Plug 'tlib'
"Plug 'nielsadb/df_mode.vim'
"Plug 'jalcine/cmake.vim', {'pinned': 1} "Until I get a new version of vim with the 'uniq' function
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'tmhedberg/SimpylFold'

Plug 'benekastah/neomake'

Plug 'chrisbra/NrrwRgn'

call plug#end()

runtime! plugin/sensible.vim

filetype plugin indent on     " required!
"}}}
"Leaders -------------------------------------------------------------{{{
let mapleader = ","
let maplocalleader = "\\"
"}}}
"Options -------------------------------------------------------------{{{

" Don't show current mode down the bottom
"set noshowmode

" hilight searches by default
"set hlsearch

" dont wrap lines
set nowrap

set ttyfast
set number
set relativenumber

" Round indent to multiple of 'shiftwidth'. Applies to > and < commands.
set shiftround
set dictionary=/usr/share/dict/words
set spellfile=~/.vim/custom-dictionary.utf-8.add

" Highlight column after 'textwidth'
set colorcolumn=+1

" Don't try to highlight lines longer than 800 characters.
set synmaxcol=800

" make cmdline tab completion similar to bash
set wildmode=list:longest

" enable ctrl-n and ctrl-p to scroll thru matches
set wildmenu

" stuff to ignore when tab completing
set wildignore=*.o,*.obj,*~

" some stuff to get the mouse going in term
set mouse=a

" set the search scan so that it ignores case when the search is all lower case but recognizes uppercase if it's specified
set ignorecase

" Override the 'ignorecase' option if the search pattern contains upper case characters.
set smartcase

" Make sure that unsaved buffers that are to be put in the background are allowed to go in there (ie. the "must save first" error doesn't come up)
set hidden


set tabstop=4
set shiftwidth=4
set softtabstop=4
"}}}

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"visual search mappings
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>


"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

" This is the timeout used while waiting for user input on a multi-keyed macro
" or while just sitting and waiting for another key to be pressed measured
" in millisecons.
"
" i.e. for the ",d" command, there is a "timeoutlen" wait period between the
"      "," key and the "d" key.  If the "d" key isn't pressed before the
"      timeout expires, one of two things happens: The "," command is executed
"      if there is one (which there isn't) or the command aborts.

if has('nvim')
    set ttimeout
    set ttimeoutlen=0
    tnoremap <Esc> <C-\><C-n>
endif

set timeoutlen=500

"set textwidth=120 " Set the textwidth to be 120 chars
set expandtab " Turn tabs into spaces
set diffopt+=iwhite " Add ignorance of whitespace to diff
set hlsearch " Enable search highlighting
set incsearch " Incrementally match the search
set path=.  " Initial path seeding
set tags=./tags,tags,~/tags " Set the tags files to be the following

" Toggle paste mode
nnoremap <silent> <leader>p :set invpaste<CR>:set paste?<CR>

" cd to the directory containing the file in the buffer
nnoremap <silent> <leader>cd :lcd %:h<CR>
nnoremap <silent> <leader>md :!mkdir -p %:p:h<CR>

" Turn off that stupid highlight search
nnoremap <silent> <leader>n :set invhls<CR>:set hls?<CR>

" put the vim directives for my file editing settings in
nnoremap <silent> <leader>vi
     \ ovim:set ts=4 sts=4 sw=4:<CR>vim600:fdm=marker fdl=1 fdc=0:<ESC>

" set text wrapping toggles
nnoremap <silent> <leader>w :set invwrap<CR>:set wrap?<CR>

" Run the command that was just yanked
nnoremap <silent> <leader>rc :@"<cr>

" Maps to make handling windows a bit easier
noremap <silent> <C-F9>  :vertical resize -10<CR>
noremap <silent> <C-F10> :resize +10<CR>
noremap <silent> <C-F11> :resize -10<CR>
noremap <silent> <C-F12> :vertical resize +10<CR>
noremap <silent> <leader>s8 :vertical resize 83<CR>
noremap <silent> <leader>s1 :vertical resize 123<CR>

" Buffer commands
noremap <silent> ,bd :bd<CR>

" Edit the vimrc file
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>


"Insert the string under the cursor to the search bar
":nnoremap <leader>s :%s/\<<C-r><C-w>\>/
nnoremap <leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" Search the current file for what's currently in the search
" register and display matches
nnoremap <silent> <leader>gs
     \ :vimgrep /<C-r>// %<CR>:ccl<CR>:cwin<CR><C-W>J:set nohls<CR>

" Search the current file for the word under the cursor and display matches
nnoremap <silent> <leader>gw
     \ :vimgrep /<C-r><C-w>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:set nohls<CR>

" Search the current file for the WORD under the cursor and display matches
nnoremap <silent> <leader>gW
     \ :vimgrep /<C-r><C-a>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:set nohls<CR>

" Swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

" Underline the current line with '='
nmap <silent> ,ul :t.\|s/./=/g\|set nohls<cr>

" Delete all buffers
nnoremap <silent> <leader>da :exec "1," . bufnr('$') . "bd"<cr>

" Select just pasted block
nnoremap <silent> vv v']

"-----------------------------------------------------------------------------
" Functions
"-----------------------------------------------------------------------------

function! RunSystemCall(systemcall)
    let output = system(a:systemcall)
    let output = substitute(output, "\n", '', 'g')
    return output
endfunction

function! WriteMode()
    setlocal background=light
    let g:solarized_visibility="low"    "default value is normal
    let g:solarized_contrast="normal"
    colorscheme solarized
    hi NonText guifg=bg
    setlocal guioptions=aic cc=0 statusline=""
    " Increase font size
    "set guifont=Inconsolata-dz\ for\ Powerline\ 14
    "Change the colorscheme for Airline
    let g:airline_theme='solarized'

    "Disable statusline
    setlocal statusline=
    setlocal laststatus=0
    "No ruler
    setlocal noruler
    setlocal linebreak
    "Disable textwidth column
    setlocal colorcolumn=0 tw=120
    "Disable list chars
    setlocal nolist
    setlocal nocursorline
    setlocal nowrap
    setlocal spell

endfunction

nnoremap <leader>wm :call WriteMode()<CR>
"-----------------------------------------------------------------------------
" Auto commands
"-----------------------------------------------------------------------------

" Fix constant spelling mistakes {{{

iab teh       the
iab Teh       The
iab taht      that
iab Taht      That
iab alos      also
iab Alos      Also
iab aslo      also
iab Aslo      Also
iab becuase   because
iab Becuase   Because
iab bianry    binary
iab Bianry    Binary
iab bianries  binaries
iab Bianries  Binaries
iab charcter  character
iab Charcter  Character
iab charcters characters
iab Charcters Characters
iab exmaple   example
iab Exmaple   Example
iab exmaples  examples
iab Exmaples  Examples
iab shoudl    should
iab Shoudl    Should
iab seperate  separate
iab Seperate  Separate
iab fone      phone
iab Fone      Phone
iab unnec     unnecessary
"}}}
"-----------------------------------------------------------------------------
" Set up the window colors and size
"-----------------------------------------------------------------------------
if has("gui_running")
    " Set up the gui cursor to look nice
    set guicursor=n-v-c:block-Cursor-blinkon0
    set guicursor+=ve:ver35-Cursor
    set guicursor+=o:hor50-Cursor
    set guicursor+=i-ci:ver25-Cursor
    set guicursor+=r-cr:hor20-Cursor
    set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

    "set guicursor=n-c:block-Cursor-blinkon0
    "set guicursor+=v:block-vCursor-blinkon0
    "set guicursor+=i-ci:ver20-iCursor

    set go-=T
    set go-=l
    set go-=L
    set go-=r
    set go-=R

    "set guifont=Monaco\ 10
    "set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 13
    "set guifont=Source\ Code\ Pro\ for\ Powerline\ 10
    "set guifont=Inconsolata-dz\ for\ Powerline\ 10
    set guifont=Inconsolata\ for\ Powerline\ 14

    "runtime ftplugin/man.vim
    "nnoremap K :Man <cword><CR>
    if !exists("g:vimrcloaded")
        winpos 0 0
        if ! &diff
            winsize 130 90
        else
            winsize 227 90
        endif
        let g:vimrcloaded = 1
    endif

    "Color scheme {{{
    "colorscheme solarized
    "let g:solarized_visibility='low'
    ""let g:solarized_italic = 0
    "set background=light
    "let g:airline_theme='solarized'
    "}}}
    colorscheme badwolf
    let g:airline_theme='badwolf'

else
  colorscheme badwolf
  let g:airline_theme='badwolf'

endif


match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Addisu's settings

set linespace=0 " Pixels of space between lines
set cindent
set cinoptions=i-s
" Follow google c++ style guide
set cinoptions=g1,h1-s,N-s

nnoremap <silent> <leader>hx :%!xxd <CR>
nnoremap <silent> <leader>nhx :%!xxd -r <CR>
nnoremap <silent> <leader>sb :set scrollbind<CR>

"Highlight or underline
nnoremap <silent> <leader>c :set cursorline! cursorcolumn! <CR>

" Clean trailing whitespace
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z

let g:showmarks_enable = 0
nnoremap <F3> :ShowMarksToggle<CR>
hi SignColumn guibg=NONE
nnoremap <F6> :TlistToggle<CR>

" Set the update time to 500ms so showmarks is more responsive
set updatetime=500

" default shiftwidth, softtabstop, and tabstop
set sw=4 sts=4 ts=4

"autocmd BufNewFile,BufRead *.mxml,*.as :nnoremap <C-B> :!bash ~/bin/fcshcmp.sh %:p
"autocmd BufNewFile,BufRead *.mxml,*.as :nnoremap <C-B> :!~/bin/fcshcmp.sh %:p run

autocmd FileType ruby set sw=2 sts=2 ts=2
autocmd FileType cpp set sw=2 sts=2 ts=2
autocmd FileType c set sw=4 sts=4 ts=4


" Display <tab>s etc...
set list
" Some cool display variants for tabs (which will almost certainly break if
" your gvim/terminal is not unicode-aware).
" If you want to make your own I recommend look up the unicode table 2500 on
" the web (or any other that includes your desired characters).
" Inserting the unicode character 2500 is done by pressing: Ctrl-V Ctrl-U 2500

" Depending on your encoding the following lines might be broken for you, in
" that case try to view this in utf-8 encoding or just make your own lcs
" string as described above.

"set lcs=tab:│\ ,trail:·,extends:>,precedes:<,nbsp:&
"set lcs=tab:└─,trail:·,extends:>,precedes:<,nbsp:&
"set lcs=tab:│┈,trail:·,extends:>,precedes:<,nbsp:&
"set lcs=tab:│┈,trail:·,extends:>,precedes:<,nbsp:&
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
" formatoptions:
" c - autowrap COMMENTS using textwidth
" r - insert comment leader (?) on <enter>
" o - insert comment leader on 'o' or 'O'
" q - gq formats comments (?)
" n - recon numbered lists
" v - wrap on blanks
" t - autowrap TEXT using textwidth
set formatoptions=crqnvt

function! SwitchSourceHeader()
  "update!
  if (expand ("%:t") == expand ("%:t:r") . ".cpp")
    find %:t:r.h
  else
    find %:t:r.cpp
  endif
endfunction

nnoremap <leader>h :call SwitchSourceHeader()<CR>

function! s:Ctag(dir)
    echomsg "!ctags -R --c++-kinds=+p --c-kinds=+p --fields=+iaSl --extra=+q " . a:dir
    exec "!ctags -R --c++-kinds=+p --c-kinds=+p --fields=+iaSl --extra=+q --langmap=c++:+.inl " . a:dir
endfunction
command! -nargs=1 -complete=dir Ctag call s:Ctag('<args>')

noremap <silent> <F12> :Ctag '.'<CR>

inoremap jj <Esc>
cnoremap <C-K> <Up>
cnoremap <C-J> <Down>
"nnoremap ; :
nnoremap ci; ciw;
nnoremap ciw; diwct;
nnoremap caw; dawct;

set csto=1
set cst

" Make supertab not colide with endwise
"let g:SuperTabCrMapping = 0
let g:SuperTabDefaultCompletionType = "context"
let g:SvnVimDiffStyle=""

let ropevim_vim_completion=1
let ropevim_extended_complete=1


set undofile
set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups
set noswapfile                    " It's 2012, Vim

"Convert unix epoch time to datetime.  Removes the last 3 digits assuming that they are milliseconds
nnoremap <leader>e :echo system("date +%c -u -d @" . <C-r><C-w><del><del><del>)<CR>
nnoremap <leader>ec :echo system("date +%c -d @" . <C-r><C-w>)<CR>

" Don't move on *
nnoremap * *<c-o>
nnoremap g* g*<c-o>
" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv
" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

" Open a Quickfix window for the last search.
nnoremap <silent> <leader>? :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Agfor the last search.
"nnoremap <silent> <leader>/ :execute "Ag '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>
nnoremap <silent> <leader>/ :execute "Ag '" . substitute(substitute(substitute(@/, "\\\\<", "", ""), "\\\\>", "", ""), "\\\\v", "", "") . "'"<CR>
" Resize splits when the window is resized
au VimResized * :wincmd =

" Plugin Settings ----------------------------------------------------------------- {{{
" Line Return {{{

" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Amit
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" }}}
" Airline {{{
let g:airline_powerline_fonts = 1

" }}}
" CtrlP {{{
nnoremap <c-b> :<C-U>CtrlPBuffer<CR>
nnoremap <leader>m :<C-U>CtrlPMRU<CR>
"nnoremap <c-m> :<C-U>CtrlPMRU<CR>
let g:ctrlp_map = '<c-f>'
"let g:ctrlp_cmd = '<C-U>CtrlPMRU<CR>'
let g:ctrlp_mruf_relative = 1
let g:ctrlp_working_path_mode = 'a'
"}}}
" Scratch {{{

command! ScratchToggle call ScratchToggle()

function! ScratchToggle()
    if exists("w:is_scratch_window")
        unlet w:is_scratch_window
        exec "q"
    else
        exec "normal! :Sscratch\<cr>\<C-W>J:resize 13\<cr>"
        let w:is_scratch_window = 1
    endif
endfunction

nnoremap <silent> <leader><tab> :ScratchToggle<cr>

" }}}
" Python-Mode {{{
"let g:pymode_doc = 1
"let g:pymode_doc_key = '<leader>ds'
"let g:pydoc = 'pydoc'
"let g:pymode_syntax = 1
"let g:pymode_syntax_all = 0
"let g:pymode_syntax_builtin_objs = 1
"let g:pymode_syntax_print_as_function = 0
"let g:pymode_syntax_space_errors = 0
"let g:pymode_run = 0
"let g:pymode_lint = 0
"let g:pymode_breakpoint = 0
"let g:pymode_utils_whitespaces = 0
"let g:pymode_virtualenv = 0
"let g:pymode_folding = 1

"let g:pymode_options_indent = 0
"let g:pymode_options_other = 0

let g:pymode_rope = 0
" }}}
" Yankring {{{
"nnoremap <silent> <F11> :YRShow<CR>
let g:yankring_history_dir = $HOME . '/.vim'
" }}}
" Slimv {{{
  let g:slimv_leader = ';'
  let g:paredit_leader = ';'
" }}}
" Vim-Ipython {{{
let g:ipy_perform_mappings=0
" }}}
" Pandoc {{{
let g:pandoc_use_hard_wraps = 1
let g:pandoc_auto_format = 0
" }}}
" Tlist {{{
let tlist_nesc_settings='nesC;b:configuration;c:command;d:definition;e:event;f:function;i:interface;m:module;r:result;t:task'
" }}}
" Cscope {{{
nnoremap <C-\> :cs find 0 <C-R>=expand("<cword>")<CR><CR>
noremap g<C-]> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
"}}}
" CamelCaseMotion {{{
    "map w <Plug>CamelCaseMotion_w
    "map b <Plug>CamelCaseMotion_b
    "map e <Plug>CamelCaseMotion_e
    "sunmap w
    "sunmap b
    "sunmap e
    ""Replace default |iw| text-object and define |ib| and  |ie| motions: >
    "omap iw <Plug>CamelCaseMotion_iw
    "xmap iw <Plug>CamelCaseMotion_iw
    "omap ib <Plug>CamelCaseMotion_ib
    "xmap ib <Plug>CamelCaseMotion_ib
    "omap ie <Plug>CamelCaseMotion_ie
    "xmap ie <Plug>CamelCaseMotion_ie
"}}}
" NERDTree {{{
" Toggle the NERD Tree on an off with F7
nnoremap <F7> :NERDTreeToggle<CR>

" Close the NERD Tree with Shift-F7
nnoremap <S-F7> :NERDTreeClose<CR>

" Store the bookmarks file in perforce
let NERDTreeBookmarksFile=$HOME . "/.vim/.NERDTreeBookmarks"

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.ncb$', '\.suo$', '\.vcproj\.RIMNET', '\.obj$',
            \ '\.ilk$', '^BuildLog.htm$', '\.pdb$', '\.idb$',
            \ '\.embed\.manifest$', '\.embed\.manifest.res$',
            \ '\.intermediate\.manifest$', '^mt.dep$' ]

"}}}
" Syntastic {{{

nnoremap <F5> :SyntasticToggleMode<CR>
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_checkers = ["cpplint"]
let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_enable_highlighting = 0
let g:syntastic_enable_signs = 0

" }}}
" Gundo {{{
"Gundo mapping
nnoremap <F4> :GundoToggle<CR>
" }}}
" BufExplorer {{{
"map to bufexplorer
nnoremap <leader>b :BufExplorer<cr>
" }}}
" ManpageViewer {{{
let g:manpageview_pgm_py = "pydoc"
let g:manpageview_options_py= ";-f;-q"

let g:manpageview_pgm_rb = "ri"
let g:manpageview_options_rb= ";-f;-q"
" }}}
" Ultisnips {{{
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" }}}
" YouCompleteMe {{{
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_always_populate_location_list = 0
let g:ycm_enable_diagnostic_highlighting = 1
" let g:ycm_show_diagnostics_ui = 0
" }}}
" Vim-Racer {{{
let $RUST_SRC_PATH=expand("~/downloads/src/rustc-1.4.0/src/")
" }}}
"}}}

" Folding ----------------------------------------------------------------- {{{

set foldlevelstart=0

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" "Refocus" folds
nnoremap <leader>z zMzvzz

" Make zO recursively open whatever top level fold we're in, no matter where the
" cursor happens to be.
nnoremap zO zCzO

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" }}}

" Use the surround plugin to create markers

let g:surround_99 = "<!--{{{--> \r <!--}}}-->"

" Filetype-specific ------------------------------------------------------- {{{
" Binary {{{
augroup Binary
    au!
    au BufReadPre   *.bin let &bin=1
    au BufReadPost  *.bin if &bin | %!xxd
    au BufReadPost  *.bin set filetype=xxd | endif
    au BufWritePre  *.bin if &bin | %!xxd -r
    au BufWritePre  *.bin endif
    au BufWritePost *.bin if &bin | %!xxd
    au BufWritePost *.bin set nomod | endif
augroup END

"" }}}
" C and C++ {{{

augroup ft_c
    au!
    au FileType c setlocal foldmethod=syntax
augroup END

augroup ft_cpp
    au!
    au FileType cpp setlocal foldmethod=syntax sw=2 sts=2 ts=2 tw=80
    au FileType cpp let NERDSpaceDelims=1
augroup END
" }}}
" QuickFix {{{

augroup ft_quickfix
    au!
    au Filetype qf setlocal colorcolumn=0 nolist nocursorline nowrap tw=0
augroup END

" }}}
" Ruby {{{

augroup ft_ruby
    au!
    au Filetype ruby setlocal foldmethod=syntax
augroup END

" }}}
" Vim {{{

augroup ft_vim
    au!

    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
    "au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END
" }}}
" Ag {{{

nnoremap <leader>a :Ag<space>

" }}}
" Python {{{
augroup ft_python
    au!

    "au FileType python setlocal omnifunc=pysmell#Complete
    au FileType python setlocal sw=4 sts=4 ts=4
    au FileType python set textwidth=79
    au Filetype python setlocal foldmethod=expr
    " Use the same mapping as slimv for vim-ipython
    au Filetype python map ;s <C-s>
    au FileType python let g:ultisnips_python_style = "numpy"
augroup END
" }}}
" Lisp {{{
augroup ft_lisp
    au!

    au FileType lisp setlocal sw=2 sts=2 ts=2
    au FileType lisp set textwidth=80
    au Filetype lisp setlocal foldmethod=indent
augroup END
" }}}
" Markdown {{{
augroup ft_mkd
    au!
    " Bolden a word
    au Filetype mkd let b:surround_45 = "**\r**"
    au Filetype mkd nnoremap <leader>b ysw-
augroup END
" }}}
" Pandoc {{{
augroup ft_pandoc
    au!
    " Bolden a word
    au Filetype pandoc let b:surround_45 = "**\r**"
    au Filetype pandoc nnoremap <leader>b ysw-
    au Filetype pandoc vmap <leader>b S-
    au Filetype pandoc set tw=120
    au Filetype pandoc nnoremap <F2>:PandocPdf<CR>:bd<CR>
    "au Filetype pandoc PandocRegisterExecutor PdcPdf <leader>d pdf 'pandoc -V geometry:margin=1in -o %:r.pdf %%'
    au Filetype pandoc nnoremap<silent> <leader>h :!pandoc -t html5 -Ss --mathjax -c ~/css/default.css -c %:p:h/style.css -o %:r.html % <CR><CR>
augroup END
" }}}
" Latex {{{
augroup ft_latex
    au!
    au Filetype latex set ts=2 sts=2 sw=2
    "au Filetype latex set makeprg scons
    au Filetype latex map <F2> make<CR>
    au Filetype tex set ts=2 sts=2 sw=2
    au Filetype tex map <F2> :make<CR>
    au Filetype tex let g:Tex_ViewRule_pdf='zathura'
    au Filetype tex let g:latex_viewer='zathura'
    au Filetype tex set iskeyword+=:
    au Filetype tex set formatoptions-=at
    au Filetype tex set nojoinspaces
    au Filetype tex set synmaxcol=0
    au Filetype tex set tw=0 wm=0

    au Filetype tex vnoremap j gj
    au Filetype tex vnoremap k gk
    au Filetype tex vnoremap 4 g$
    au Filetype tex vnoremap 6 g^
    au Filetype tex vnoremap 0 g^
    au Filetype tex nnoremap j gj
    au Filetype tex nnoremap k gk
    au Filetype tex nnoremap 4 g$
    au Filetype tex nnoremap 6 g^
    au Filetype tex nnoremap 0 g^

    au Filetype tex set wrap nolist linebreak

augroup END
" }}}
" Launch (ROS) {{{
augroup ft_launch
    au!
    au BufNewFile,BufRead *.launch set ft=xml ts=2 sts=2 sw=2
augroup END
" }}}
" TinyOS (nesc) {{{
augroup ft_nc
    au!
    au BufNewFile,BufRead *.nc setlocal ft=nc ts=2 sts=2 sw=2
augroup END
" }}}
" Scons {{{
augroup ft_scons
    au!
    au BufNewFile,BufRead SCons* setf scons
augroup END
"}}}
" Restructured Text {{{
  au BufNewFile,BufRead *.rst   set filetype=pandoc
" }}}

"augroup trailing
"   au!
"   au InsertEnter * :set listchars-=trail:⌴
"   au InsertLeave * :set listchars+=trail:⌴
"augroup END

" }}}

" Use clipboard
if !has('nvim')
    set clipboard=unnamedplus
endif

