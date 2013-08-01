".vimrc
"Author: Addisu Taddese
"Source: http://github.com/azeey/dotfiles/vimrc
"
"Preamble ------------------------------------------------------------{{{
"
"Initialize vundle
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'

Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'

" From vim-scripts
Bundle 'LaTeX-Suite-aka-Vim-LaTeX'
Bundle 'scratch.vim'
Bundle 'YankRing.vim'
Bundle 'Gundo'
Bundle 'taglist.vim'
Bundle 'camelcasemotion'

" All others
Bundle 'altercation/vim-colors-solarized'
Bundle 'austintaylor/vim-commaobject'
Bundle 'coderifous/textobj-word-column.vim'
Bundle 'edsono/vim-matchit'
Bundle 'ervandew/supertab'
Bundle 'godlygeek/tabular'
Bundle 'harleypig/ShowMarks'
Bundle 'ivanov/vim-ipython'
Bundle 'kana/vim-smartinput'
Bundle 'kana/vim-textobj-user'
Bundle 'kien/ctrlp.vim'
Bundle 'klen/python-mode'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'markabe/bufexplorer'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'mileszs/ack.vim'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'othree/xml.vim'
Bundle 'plasticboy/vim-markdown'
Bundle 'SirVer/ultisnips'
Bundle 'sjl/badwolf'
Bundle 'Source-Explorer-srcexpl.vim'
Bundle 'vim-pandoc/vim-pandoc'
Bundle 'NesC-Syntax-Highlighting'

"Testing
"Bundle 'quickfixsigns'
"Bundle 'tlib'
"Bundle 'neocomplcache'
"Bundle 'neocomplcache-snippets_complete'

filetype plugin indent on     " required!
"}}}

let mapleader = ","
let maplocalleader = "\\"

"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

"allow backspacing over everything in insert mode
set backspace=indent,eol,start


set history=1000 " store lots of :cmdline history
set showcmd      " show incomplete cmds down the bottom
set noshowmode   " Don't show current mode down the bottom
set incsearch    " find the next match as we type the search
set hlsearch     " hilight searches by default
set nowrap       " dont wrap lines
set linebreak    " wrap lines at convenient points

set encoding=utf-8
set modelines=0
set autoindent
"set visualbell
set ttyfast
set ruler
set number
set undoreload=10000
set shell=/bin/zsh
set matchtime=3
set showbreak=↪
set splitbelow
set splitright
set fillchars=diff:⣿,vert:│
"set autowrite
"set autoread
set shiftround
set title
set dictionary=/usr/share/dict/words
set spellfile=~/.vim/custom-dictionary.utf-8.add
set colorcolumn=+1

" Don't try to highlight lines longer than 800 characters.
set synmaxcol=800

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing


"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

"tell the term has 256 colors
set t_Co=256

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"map to bufexplorer
nnoremap <leader>b :BufExplorer<cr>


"map Q to something useful
"noremap Q gq

"make Y consistent with C and D
nnoremap Y y$

"mark syntax errors with :signs
let g:syntastic_enable_signs=1
let g:syntastic_python_checker_args="--good-names=x,y,z,i,j,k"
let g:syntastic_disabled_filetypes = ['c', 'cpp']
"let g:syntastic_auto_loc_list=1


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

"define :HighlightLongLines command to highlight the offending parts of
"lines that are longer than the specified length (defaulting to 80)
command! -nargs=? HighlightLongLines call s:HighlightLongLines('<args>')
function! s:HighlightLongLines(width)
    let targetWidth = a:width != '' ? a:width : 79
    if targetWidth > 0
        exec 'match Todo /\%>' . (targetWidth) . 'v/'
    else
        echomsg "Usage: HighlightLongLines [natural number]"
    endif
endfunction


" Tabstops are 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4

" set the search scan to wrap lines
set wrapscan

" set the search scan so that it ignores case when the search is all lower
" case but recognizes uppercase if it's specified
set ignorecase
set smartcase

" set the forward slash to be the slash of note.  Backslashes suck
set shellslash

" Make command line two lines high
set ch=2

" set visual bell -- i hate that damned beeping
"set vb

" Make sure that unsaved buffers that are to be put in the background are
" allowed to go in there (ie. the "must save first" error doesn't come up)
set hidden

" Make the 'cw' and like commands put a $ at the end instead of just deleting
" the text and replacing it
"set cpoptions=ces$

" tell VIM to always put a status line in, even if there is only one window
set laststatus=2

" Don't update the display while executing macros
set lazyredraw

" Show the current command in the lower right corner
set showcmd


" Switch on syntax highlighting.
syntax on

" Hide the mouse pointer while typing
set mousehide

" Set up the gui cursor to look nice
set guicursor=n-v-c:block-Cursor-blinkon0
set guicursor+=ve:ver35-Cursor
set guicursor+=o:hor50-Cursor
set guicursor+=i-ci:ver25-Cursor
set guicursor+=r-cr:hor20-Cursor
set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

" set the gui options the way I like
"set guioptions=aic

" This is the timeout used while waiting for user input on a multi-keyed macro
" or while just sitting and waiting for another key to be pressed measured
" in millisecons.
"
" i.e. for the ",d" command, there is a "timeoutlen" wait period between the
"      "," key and the "d" key.  If the "d" key isn't pressed before the
"      timeout expires, one of two things happens: The "," command is executed
"      if there is one (which there isn't) or the command aborts.
set timeoutlen=500

" Keep some stuff in the history
set history=100

" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" When the page starts to scroll, keep the cursor 8 lines from the top and 8
" lines from the bottom
set scrolloff=8

" Allow the cursor to go in to "invalid" places
"set virtualedit=all

" These things start comment lines
set comments=sl:/*,mb:\ *,ex:\ */,O://,b:#,:%,:XCOMM,n:>,fb:-

" Disable encryption (:X)
set key=

" Make the command-line completion better
set wildmenu

" Same as default except that I remove the 'u' option
set complete=.,w,b,t

" When completing by tag, show the whole tag, not just the function name
set showfulltag

" Set the textwidth to be 120 chars
set textwidth=120

" Turn tabs into spaces
set expandtab

" Add ignorance of whitespace to diff
set diffopt+=iwhite

" Enable search highlighting
set hlsearch

" Incrementally match the search
set incsearch

" Initial path seeding
set path=.
"set path+=/usr/include/**

" Set the tags files to be the following
set tags=./tags,tags

" Let the syntax highlighting for Java files allow cpp keywords
let java_allow_cpp_keywords = 1

" Toggle paste mode
nmap <silent> ,p :set invpaste<CR>:set paste?<CR>

" cd to the directory containing the file in the buffer
nmap <silent> ,cd :lcd %:h<CR>
nmap <silent> ,md :!mkdir -p %:p:h<CR>

" Turn off that stupid highlight search
nmap <silent> ,n :set invhls<CR>:set hls?<CR>

" put the vim directives for my file editing settings in
nmap <silent> ,vi
     \ ovim:set ts=4 sts=4 sw=4:<CR>vim600:fdm=marker fdl=1 fdc=0:<ESC>

" Show all available VIM servers
nmap <silent> ,ss :echo serverlist()<CR>

" The following beast is something i didn't write... it will return the
" syntax highlighting group that the current "thing" under the cursor
" belongs to -- very useful for figuring out what to change as far as
" syntax highlighting goes.
nmap <silent> <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
     \ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
     \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
     \ . ">"<CR>

" set text wrapping toggles
nmap <silent> ,w :set invwrap<CR>:set wrap?<CR>

" Run the command that was just yanked
nmap <silent> ,rc :@"<cr>

" Maps to make handling windows a bit easier
noremap <silent> <C-F9>  :vertical resize -10<CR>
noremap <silent> <C-F10> :resize +10<CR>
noremap <silent> <C-F11> :resize -10<CR>
noremap <silent> <C-F12> :vertical resize +10<CR>
noremap <silent> ,s8 :vertical resize 83<CR>
noremap <silent> ,s1 :vertical resize 123<CR>

" Buffer commands
noremap <silent> ,bd :bd<CR>

" Edit the vimrc file
nmap <silent> ,ev :e $MYVIMRC<CR>
nmap <silent> ,sv :so $MYVIMRC<CR>

" Make horizontal scrolling easier
"nmap <silent> <C-o> 10zl
"nmap <silent> <C-i> 10zh

"Insert the string under the cursor to the search bar
":nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" Highlight all instances of the current word under the cursor
"nmap <silent> ^ :setl hls<CR>:let @/="<C-r><C-w>"<CR>

" Eclim mapping
"nnoremap <silent> <buffer> <cr> :CSearchContext<cr>

" Search the current file for what's currently in the search
" register and display matches
nmap <silent> ,gs
     \ :vimgrep /<C-r>// %<CR>:ccl<CR>:cwin<CR><C-W>J:set nohls<CR>

" Search the current file for the word under the cursor and display matches
nmap <silent> ,gw
     \ :vimgrep /<C-r><C-w>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:set nohls<CR>

" Search the current file for the WORD under the cursor and display matches
nmap <silent> ,gW
     \ :vimgrep /<C-r><C-a>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:set nohls<CR>

" Swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

" Underline the current line with '='
nmap <silent> ,ul :t.\|s/./=/g\|set nohls<cr>

" Delete all buffers
nmap <silent> ,da :exec "1," . bufnr('$') . "bd"<cr>


" I don't like it when the matching parens are automatically highlighted
"let loaded_matchparen = 1

"-----------------------------------------------------------------------------
" MiniBufExplorer Plugin Settings
"-----------------------------------------------------------------------------
" Yup, I don't like this one either
"let loaded_minibufexplorer = 1

"-----------------------------------------------------------------------------
" Source Explorer Plugin Settings
"-----------------------------------------------------------------------------
" The switch of the Source Explorer
nmap <silent> <F5> :SrcExplToggle<CR>

" Set the height of Source Explorer window
let g:SrcExpl_winHeight = 16

" Set 10 ms for refreshing the Source Explorer
let g:SrcExpl_refreshTime = 10

" In order to Avoid conflicts, the Source Explorer should know what plugins
" are using buffers. And you need add their bufname into the list below
" according to the command ":buffers!"
let g:SrcExpl_pluginList = [
            \ "_NERD_tree_",
            \ "Source_Explorer"
            \ ]
" Enable/Disable the local definition searching, and note that this is not
" guaranteed to work, the Source Explorer doesn't check the syntax for now.
" It only searches for a match with the keyword according to command 'gd'
let g:SrcExpl_searchLocalDef = 1

" Do not let the Source Explorer update the tags file when opening
let g:SrcExpl_isUpdateTags = 0


" Set "<F9>" key for updating the tags file artificially
let g:SrcExpl_updateTagsKey = "<F9>"

"-----------------------------------------------------------------------------
" NERD Tree Plugin Settings
"-----------------------------------------------------------------------------
" Toggle the NERD Tree on an off with F7
nmap <F7> :NERDTreeToggle<CR>

" Close the NERD Tree with Shift-F7
nmap <S-F7> :NERDTreeClose<CR>

" Store the bookmarks file in perforce
let NERDTreeBookmarksFile="/home/addisu/.NERDTreeBookmarks"

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.ncb$', '\.suo$', '\.vcproj\.RIMNET', '\.obj$',
            \ '\.ilk$', '^BuildLog.htm$', '\.pdb$', '\.idb$',
            \ '\.embed\.manifest$', '\.embed\.manifest.res$',
            \ '\.intermediate\.manifest$', '^mt.dep$' ]


"-----------------------------------------------------------------------------
" SnipMate Settings
"-----------------------------------------------------------------------------

function! ListKnownSnippetLanguageTypes(A, L, P)
    let filesanddirs = split(globpath(g:snippets_dir, a:A . "*"), "\n")
    let dirsonly = []
    for f in filesanddirs
        if isdirectory(f)
            let each = split(f, '/')
            let dirsonly = add(dirsonly, each[-1])
        end
    endfor
    return dirsonly
endfunction

function! ReloadSnippets(type)
    call ResetSnippets()
    if a:type != ""
        call ExtractSnips(g:snippets_dir . a:type, a:type)
    else
        let alltypes = ListKnownSnippetLanguageTypes("", "", "")
        for type in alltypes
            call ExtractSnips(g:snippets_dir . type, type)
        endfor
    endif
endfunction

command! -complete=customlist,ListKnownSnippetLanguageTypes
         \ -nargs=? RS call ReloadSnippets("<args>")

"-----------------------------------------------------------------------------
" Functions
"-----------------------------------------------------------------------------

function! RunSystemCall(systemcall)
    let output = system(a:systemcall)
    let output = substitute(output, "\n", '', 'g')
    return output
endfunction

function! PrepForSimulator()
    %s/dev\/ttyS1/tmp\/rec0
    %s/dev\/ttyS2/tmp\/rec1
    %s/dev\/ttyS3/tmp\/rec2
    %s/dev\/ttyUSB0/tmp\/rec3
    %s/dev\/ttyUSB1/tmp\/rec4
    %s/dev\/ttyS0/tmp\/rec5
endfunction

function! FormatCalibration()
   %s/], /], /g
   normal gg=G
endfunction

function! WriteMode()
    setlocal background=light
    let g:solarized_visibility="low"    "default value is normal
    let g:solarized_contrast="normal"
    colorscheme solarized
    hi NonText guifg=bg
    setlocal guioptions=aic cc=0 statusline=""
    " Increase font size
    set guifont=Inconsolata-dz\ for\ Powerline\ 14
    "Change the colorscheme for Powerline
    let g:Powerline_colorscheme='solarized256_light'
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

endfunction

nmap <Leader>wm :call WriteMode()<CR>
"-----------------------------------------------------------------------------
" Auto commands
"-----------------------------------------------------------------------------

au BufNewFile,BufRead *.mxml set filetype=mxml
au BufNewFile,BufRead *.as set filetype=actionscript

au BufNewFile,BufRead *.mxml set filetype=mxml | execute "compiler ant"
au BufNewFile,BufRead *.as set filetype=actionscript | execute "compiler ant"
augroup derek_scons
    au!
    au BufNewFile,BufRead SCons* setf scons
augroup END

augroup derek_xsd
    au!
    au BufEnter *.xsd,*.wsdl,*.xml setl tabstop=4 | setl shiftwidth=4
    au BufEnter *.xsd,*.wsdl,*.xml setl formatoptions=crq | setl textwidth=80
augroup END

augroup trailing
   au!
   au InsertEnter * :set listchars-=trail:⌴
   au InsertLeave * :set listchars+=trail:⌴
augroup END

"-----------------------------------------------------------------------------
" Fix constant spelling mistakes
"-----------------------------------------------------------------------------

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

    "set guifont=Monaco\ 12
    "set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 13
    "set guifont=Inconsolata\ for\ Powerline\ 13
    set guifont=Inconsolata-dz\ for\ Powerline\ 12
    "set guifont=Source\ Code\ Pro\ for\ Powerline\ 13

    "runtime ftplugin/man.vim
    "nmap K :Man <cword><CR>
    if !exists("g:vimrcloaded")
        winpos 0 0
        if ! &diff
            winsize 130 90
        else
            winsize 227 90
        endif
        let g:vimrcloaded = 1
    endif
  colors solarized
  let g:solarized_visibility='low'
  let g:solarized_italic = 0
  set background=light
  let g:Powerline_colorscheme='solarized16_light'
  "colors badwolf
else
  colors badwolf
endif

match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Addisu's settings

set linespace=0 " Pixels of space between lines
set cindent
"let loaded_matchit = 1

nmap <silent> ,hx :%!xxd <CR>
nmap <silent> ,nhx :%!xxd -r <CR>
nmap <silent> ,sb :set scb<CR>
nmap <silent> ,x "_x
"Highlight or underline
nmap <silent> ,c :set cursorline! cursorcolumn! <CR>

" Clean trailing whitespace
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z

"set grepprg=ack
"set grepformat=%f:%l:%c:%m

let g:showmarks_enable = 0
nmap <F3> :ShowMarksToggle<CR>
hi SignColumn guibg=NONE
nmap <F6> :TlistToggle<CR>

" Set the update time to 500ms so showmarks is more responsive
set updatetime=500

"autocmd BufNewFile,BufRead *.mxml,*.as :nmap <C-B> :!bash ~/bin/fcshcmp.sh %:p
"autocmd BufNewFile,BufRead *.mxml,*.as :nmap <C-B> :!~/bin/fcshcmp.sh %:p run


"Manpageviewer extensions
let g:manpageview_pgm_py = "pydoc"
let g:manpageview_options_py= ";-f;-q"

let g:manpageview_pgm_rb = "ri"
let g:manpageview_options_rb= ";-f;-q"

autocmd FileType ruby set sw=2 sts=2 ts=2
autocmd FileType cpp set sw=4 sts=4 ts=4
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

nmap ,h :call SwitchSourceHeader()<CR>

map <silent> <F12> :!ctags -R --c++-kinds=+p --c-kinds=+p --fields=+iaS --extra=+q .<CR>
function! s:Ctag(dir)
    echomsg "!ctags -R --c++-kinds=+p --c-kinds=+p --fields=+iaS --extra=+q " . a:dir
    exec "!ctags -R --c++-kinds=+p --c-kinds=+p --fields=+iaS --extra=+q " . a:dir
endfunction
command! -nargs=1 -complete=dir Ctag call s:Ctag('<args>')

inoremap jj <Esc>
cnoremap <C-K> <Up>
cnoremap <C-J> <Down>
"nmap ; :
nmap ci; ciw;
nmap ciw; diwct;
nmap caw; dawct;

let g:syntastic_quiet_warnings=1
let g:syntastic_cpp_no_include_search=1
"let g:syntastic_auto_loc_list=1
let g:syntastic_cpp_remove_include_errors=1
"
"let g:syntastic_mode_map = { 'mode': 'passive'}

set csto=1
set cst

" Make supertab not colide with endwise
let g:SuperTabCrMapping = 0
let g:SvnVimDiffStyle=""

let ropevim_vim_completion=1
let ropevim_extended_complete=1

"Gundo mapping
nnoremap <F4> :GundoToggle<CR>

set undofile
set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups
set noswapfile                    " It's 2012, Vim

"Convert unix epoch time to datetime.  Removes the last 3 digits assuming that they are milliseconds
nnoremap <Leader>e :echo system("date +%c -u -d @" . <C-r><C-w><del><del><del>)<CR>
nnoremap <Leader>ec :echo system("date +%c -d @" . <C-r><C-w>)<CR>

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

" Ack for the last search.
"nnoremap <silent> <leader>/ :execute "Ack! '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>
nnoremap <silent> <leader>/ :execute "Ack! '" . substitute(substitute(substitute(@/, "\\\\<", "", ""), "\\\\>", "", ""), "\\\\v", "", "") . "'"<CR>
" Resize splits when the window is resized
au VimResized * :wincmd =

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
" Powerline {{{
python from powerline.vim import setup as powerline_setup
let g:Powerline_symbols = 'fancy'
let g:Powerline_cache_enabled = 1
"call Pl#Theme#InsertSegment('charcode', 'after', 'filetype')
python powerline_setup()
python del powerline_setup

" }}}
" Folding ----------------------------------------------------------------- {{{

set foldlevelstart=0

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" "Refocus" folds
nnoremap ,z zMzvzz

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
" CtrlP {{{
nnoremap <c-b> :<C-U>CtrlPBuffer<CR>
nnoremap <Leader>m :<C-U>CtrlPMRU<CR>
let g:ctrlp_map = '<c-f>'
let g:ctrlp_cmd = '<C-U>CtrlPMRU<CR>'
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
let g:pymode_doc = 1
let g:pymode_doc_key = '<leader>ds'
let g:pydoc = 'pydoc'
let g:pymode_syntax = 1
let g:pymode_syntax_all = 0
let g:pymode_syntax_builtin_objs = 1
let g:pymode_syntax_print_as_function = 0
let g:pymode_syntax_space_errors = 0
let g:pymode_run = 0
let g:pymode_lint = 0
let g:pymode_breakpoint = 0
let g:pymode_utils_whitespaces = 0
let g:pymode_virtualenv = 0
let g:pymode_folding = 1

let g:pymode_options_indent = 0
let g:pymode_options_other = 0

let g:pymode_rope = 0
" }}}
" Yankring {{{
nnoremap <silent> <F11> :YRShow<CR>
" }}}
" Slimv {{{
  let g:slimv_leader = ';'
  let g:paredit_leader = ';'
" }}}
" Pandoc {{{
let g:pandoc_use_hard_wraps = 1
let g:pandoc_auto_format = 0
" }}}
" Tlist {{{
let tlist_nesc_settings='nesC;b:configuration;c:command;d:definition;e:event;f:function;i:interface;m:module;r:result;t:task'
" }}}
" Cscope {{{
nmap <C-\> :cs find 0 <C-R>=expand("<cword>")<CR><CR>
map g<C-]> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
"}}}
"CamelCaseMotion {{{
    map w <Plug>CamelCaseMotion_w
    map b <Plug>CamelCaseMotion_b
    map e <Plug>CamelCaseMotion_e
    sunmap w
    sunmap b
    sunmap e
    "Replace default |iw| text-object and define |ib| and  |ie| motions: >
    omap iw <Plug>CamelCaseMotion_iw
    xmap iw <Plug>CamelCaseMotion_iw
    omap ib <Plug>CamelCaseMotion_ib
    xmap ib <Plug>CamelCaseMotion_ib
    omap ie <Plug>CamelCaseMotion_ie
    xmap ie <Plug>CamelCaseMotion_ie
"}}}

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
" C {{{

augroup ft_c
    au!
    au FileType c setlocal foldmethod=syntax
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
" Ack {{{

nnoremap <leader>a :Ack!<space>

" }}}
" Python {{{
augroup ft_python
    au!

    au FileType python setlocal omnifunc=pysmell#Complete
    au FileType python setlocal sw=4 sts=4 ts=4
    au FileType python set textwidth=79
    au Filetype python setlocal foldmethod=expr
    " Use the same mapping as slimv for vim-ipython
    au Filetype python map ;s <C-s>
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
    au Filetype mkd let g:surround_45 = "**\r**"
    au Filetype mkd nmap <leader>b ysw-
augroup END
" }}}
" Pandoc {{{
augroup ft_pandoc
    au!
    " Bolden a word
    au Filetype pandoc let g:surround_45 = "**\r**"
    au Filetype pandoc nmap <leader>b ysw-
    au Filetype pandoc vmap <leader>b S-
    au Filetype pandoc set tw=120
    au Filetype pandoc nmap <F2>:PandocPdf<CR>:bd<CR>
    "au Filetype pandoc PandocRegisterExecutor PdcPdf <leader>d pdf 'pandoc -V geometry:margin=1in -o %:r.pdf %%'
    au Filetype pandoc nmap <leader>h :!pandoc -t html5 -Ss -c ~/css/default.css -c %:p:h/style.css -o %:r.html %<CR>
augroup END
" }}}
" Latex {{{
augroup ft_latex
    au!
    au Filetype latex set ts=2 sts=2 sw=2
    au Filetype latex set makeprg scons
    au Filetype latex map <F2> make<CR>
    au Filetype tex set ts=2 sts=2 sw=2
    au Filetype tex set makeprg=scons
    au Filetype tex map <F2> :make<CR>
    au Filetype tex let g:Tex_ViewRule_pdf='zathura'

augroup END
" }}}
"
" Launch (ROS) {{{
augroup ft_launch
    au!
    au BufNewFile,BufRead *.launch set ft=xml ts=2 sts=2 sw=2
augroup END
" }}}
" }}}
" TinyOS (nesc) {{{
augroup ft_nc
    au!
    au BufNewFile,BufRead *.nc set ft=nc ts=2 sts=2 sw=2
augroup END
" }}}
" }}}
"
