"" neovim-config

"" Vim settings and mappings {{{
"" ============================================================================
"" Vim settings and mappings

"" no vi-compatible
set nocompatible

"" allow plugins by file type (required for plugins!)
filetype plugin on
filetype indent on

"" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

"" tab length exceptions on some file types
autocmd Filetype gitcommit setlocal spell textwidth=72
autocmd FileType html setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType htmldjango setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4

"" Highlight words to avoid in tech writing
"" http://css-tricks.com/words-avoid-educational-writing/
highlight TechWordsToAvoid ctermbg=red ctermfg=white
match TechWordsToAvoid /\cobviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however\|so,\|easy/
autocmd BufWinEnter * match TechWordsToAvoid /\cobviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however,\|so,\|easy/
autocmd InsertEnter * match TechWordsToAvoid /\cobviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however,\|so,\|easy/
autocmd InsertLeave * match TechWordsToAvoid /\cobviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however,\|so,\|easy/
autocmd BufWinLeave * call clearmatches()

"" Close all folds when opening a new buffer
autocmd BufRead * setlocal foldmethod=marker
autocmd BufRead *.py setlocal foldmethod=indent

"" always show status bar
set laststatus=2

"" UTF encoding
set encoding=utf-8

"" incremental search
set incsearch

"" highlighted search results
set hlsearch

"" syntax highlight on
syntax on

"" show line numbers
set number

"" relative number
set relativenumber

"" Highlight the current line
set cursorline

"" Ensure Vim doesn't beep at you every time you make a mistype
set visualbell

"" highlight a matching [{()}] when cursor is placed on start/end character
set showmatch

"" Set built-in file system explorer to use layout similar to the NERDTree plugin
let g:netrw_liststyle=7

"" Comment this line to enable autocompletion preview window
"" (displays documentation related to the selected completion option)
"" Disabled by default because preview makes the window flicker
set completeopt-=preview

"" Auto indent
set autoindent

"" Smart indent
set smartindent

"" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=7

"" autocompletion of files and commands behaves like shell
"" (complete only the common part, list the options that match)
set wildmode=list:longest

"" better backup, swap and undos storage
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo

"" Always highlight column 80 so it's easier to see where
"" cutoff appears on longer screens
autocmd BufWinEnter * highlight ColorColumn ctermbg=darkred
set colorcolumn=90

"" Add a bit extra marging to the left
set foldcolumn=1

"" Highlight tailing whitespace
"set listchars=tab:>-,trail:·,extends:>,precedes:<,space:·
    "set list

"" With a map leader it's possible to do extra key combinations
"" like `<leader>w` to save the current file.
let mapleader = ','
let g:mapleader = ','

"" Fast saving
nmap <Leader>w :w!<cr>
nmap <Leader>q :q<cr>

"" tab navigation mappings
map <Leader>tn :tabn<CR>
map <Leader>tp :tabp<CR>
map <Leader>tm :tabm
map <Leader>tt :tabnew
map <Leader>ts :tab split<CR>
map <C-S-Right> :tabn<CR>
imap <C-S-Right> <ESC>:tabn<CR>
map <C-S-Left> :tabp<CR>
imap <C-S-Left> <ESC>:tabp<CR>

"" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
"" navigate windows with meta+arrows
"map <M-Right> <c-w>l
"map <M-Left> <c-w>h
"map <M-Up> <c-w>k
"map <M-Down> <c-w>j
"imap <M-Right> <ESC><c-w>l
"imap <M-Left> <ESC><c-w>h
"imap <M-Up> <ESC><c-w>k
"imap <M-Down> <ESC><c-w>j

"" old autocomplete keyboard shortcut
imap <C-J> <C-X><C-O>

"" save as sudo
ca w!! w !sudo tee "%"

"" Remap VIM to 0 to first non-blank character
map 0 ^

"" simple recursive grep
nmap <Leader>r :Ack
nmap <Leader>R :Ack <cword><CR>

"" use 256 colors when possible
let &t_Co = 256
"colorscheme solarized
set background=dark
let g:solarized_termcolors=256
let g:solarized_visibility='high'

"" store yankring history file there too
let g:yankring_history_dir = '~/.vim/dirs/'

"" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

"" NeoVim settings and mappings

"" map <Esc> to exit terminal-mode: >
tnoremap <Esc> <C-\><C-n>

"" }}}

"" Plugins {{{
"" ============================================================================
"" Vim-plug initialization
"" Avoid modify this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.config/nvim/autoload
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

"" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

"" Obscure hacks done, you can now modify the rest of the .vimrc as you wish :)

"" ============================================================================
"" Active plugins
"" You can disable or add new ones here:

"" this needs to be here, so vim-plug knows we are declaring the plugins we
"" want to use
"call plug#begin('~/.vim/plugged')
call plug#begin('~/.local/share/nvim/plugged')

"" Plugins from github repos:

"" Override configs by directory -----------------------------
"Plug 'arielrossanigo/dir-configs-override.vim'

" NERDTree -----------------------------
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Code commenter
Plug 'scrooloose/nerdcommenter', { 'on':  'NERDTreeToggle' }
" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap <leader>t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" DevIcons -----------------------------
Plug 'ryanoasis/vim-devicons'

" Tagbar -----------------------------
Plug 'majutsushi/tagbar'
" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1

" CtrlP ------------------------------
" Code and files fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'
" Extension to ctrlp, for fuzzy command finder
Plug 'fisadev/vim-ctrlp-cmdpalette'
" file finder mapping
let g:ctrlp_map = ',e'
" tags (symbols) in current file finder mapping
nmap \g :CtrlPBufTag<CR>
" tags (symbols) in all files finder mapping
nmap \G :CtrlPBufTagAll<CR>
" general code finder in all files mapping
nmap \f :CtrlPLine<CR>
" recent files finder mapping
nmap \m :CtrlPMRUFiles<CR>
" commands finder mapping
nmap \c :CtrlPCmdPalette<CR>
" to be able to call CtrlP with default search text
function! CtrlPWithSearchText(search_text, ctrlp_command_end)
    execute ':CtrlP' . a:ctrlp_command_end
    call feedkeys(a:search_text)
endfunction
" same as previous mappings, but calling with current word as default text
nmap \wg :call CtrlPWithSearchText(expand('<cword>'), 'BufTag')<CR>
nmap \wG :call CtrlPWithSearchText(expand('<cword>'), 'BufTagAll')<CR>
nmap \wf :call CtrlPWithSearchText(expand('<cword>'), 'Line')<CR>
nmap \we :call CtrlPWithSearchText(expand('<cword>'), '')<CR>
nmap \pe :call CtrlPWithSearchText(expand('<cfile>'), '')<CR>
nmap \wm :call CtrlPWithSearchText(expand('<cword>'), 'MRUFiles')<CR>
nmap \wc :call CtrlPWithSearchText(expand('<cword>'), 'CmdPalette')<CR>
" don't change working directory
let g:ctrlp_working_path_mode = 0
" ignore these files and folders on file finder
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|node_modules)$',
  \ 'file': '\.pyc$\|\.pyo$',
  \ }
" CtrlP -> use Ag for searching instead of VimScript
" (might not work with ctrlp_show_hidden and ctrlp_custom_ignore)
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ackprg = 'ag --nogroup --nocolor --column'

" GitGutter ------------------------------
Plug 'airblade/vim-gitgutter'

" Zen coding ------------------------------
Plug 'mattn/emmet-vim'

" Git integration ------------------------------
Plug 'motemen/git-vim'

" TabMan ------------------------------
" Tab list panel
Plug 'kien/tabman.vim'
" mappings to toggle display, and to focus on it
let g:tabman_toggle = 'tl'
let g:tabman_focus  = 'tf'

" ColorThemes ------------------------------
" Solarized theme
Plug 'altercation/vim-colors-solarized'
" Terminal Vim with 256 colors colorscheme
Plug 'fisadev/fisa-vim-colorscheme'
" Terminal Vim base-16 256 colorscheme
Plug 'chriskempson/base16-vim'
" Tomorrow colorscheme
Plug 'chriskempson/tomorrow-theme'
" Gvim colorscheme
Plug 'vim-scripts/Wombat'

" Airline ------------------------------
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline_theme = 'dark'
let g:airline#extensions#whitespace#enabled = 0
" to use fancy symbols for airline, uncomment the following lines and use a
" patched font (more info on the README.rst)
if !exists('g:airline_symbols')
   let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" Consoles as buffers ------------------------------
Plug 'rosenfeld/conque-term'

" Tasklist ------------------------------
Plug 'fisadev/FixedTaskList.vim'
map <F2> :TaskList<CR>

" Surround ------------------------------
Plug 'tpope/vim-surround'

"" Autoclose ------------------------------
"Plug 'Townk/vim-autoclose'
"" Fix to let ESC work as espected with Autoclose plugin
"let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" Indent text object ------------------------------
Plug 'michaeljsmith/vim-indent-object'
" Indentation based movements
Plug 'jeetsukumaran/vim-indentwise'

"" Snippets manager (SnipMate), dependencies, and snippets repo
"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'tomtom/tlib_vim'
"Plug 'honza/vim-snippets'
"Plug 'garbas/vim-snipmate'

" Signify ------------------------------
" Git/mercurial/others diff icons on the side of the file lines
Plug 'mhinz/vim-signify'
" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = ['git']
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

"" DragVisuals ------------------------------
"" Drag visual blocks arround
"Plug 'fisadev/dragvisuals.vim'
"" mappings to move blocks in 4 directions
"vmap <expr> <S-M-LEFT> DVB_Drag('left')
"vmap <expr> <S-M-RIGHT> DVB_Drag('right')
"vmap <expr> <S-M-DOWN> DVB_Drag('down')
"vmap <expr> <S-M-UP> DVB_Drag('up')
"" mapping to duplicate block
"vmap <expr> D DVB_Duplicate()

" Window Chooser ------------------------------
Plug 't9md/vim-choosewin'
" mapping
nmap  \-  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1

"" Python and other languages code checker ------------------------------

"" NeoComplCache ------------------------------
"" Better autocompletion
"Plug 'Shougo/neocomplcache.vim'
"" most of them not documented because I'm not sure how they work
"" (docs aren't good, had to do a lot of trial and error to make
"" it play nice)
"let g:neocomplcache_enable_at_startup = 1
"let g:neocomplcache_enable_ignore_case = 1
"let g:neocomplcache_enable_smart_case = 1
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_enable_fuzzy_completion = 1
"let g:neocomplcache_enable_camel_case_completion = 1
"let g:neocomplcache_enable_underbar_completion = 1
"let g:neocomplcache_fuzzy_completion_start_length = 1
"let g:neocomplcache_auto_completion_start_length = 1
"let g:neocomplcache_manual_completion_start_length = 1
"let g:neocomplcache_min_keyword_length = 1
"let g:neocomplcache_min_syntax_length = 1
"" complete with workds from any opened file
"let g:neocomplcache_same_filetype_lists = {}
"let g:neocomplcache_same_filetype_lists._ = '_'

"" Deoplete
"if has('nvim')
"  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
"  Plug 'Shougo/deoplete.nvim'
"  Plug 'roxma/nvim-yarp'
"  Plug 'roxma/vim-hug-neovim-rpc'
"endif
"let g:deoplete#enable_at_startup = 1
"let g:python_host_prog = '/Users/adriangarciaprado/.pyenv/versions/neovim2/bin/python'
"let g:python3_host_prog = '/Users/adriangarciaprado/.pyenv/versions/neovim/bin/python3'
""let g:deoplete#_python_version_check = 3

" Syntastic ------------------------------
Plug 'scrooloose/syntastic'
" show list of errors and warnings on the current file
nmap <leader>E :Errors<CR>
" check also when just opened the file
let g:syntastic_check_on_open = 1
" don't put icons on the sign column (it hides the vcs status icons of signify)
let g:syntastic_enable_signs = 0
" custom icons (enable them if you use a patched font, and enable the previous
" setting)
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'

" Paint css colors with the real color
Plug 'lilydjwg/colorizer'
" Ack code search (requires ack installed in the system)
Plug 'mileszs/ack.vim'

"" Vim Completion Manager 2 ------------------------------
"Plug 'ncm2/ncm2'
"Plug 'roxma/nvim-yarp'
"" enable ncm2 for all buffers
"autocmd BufEnter * call ncm2#enable_for_buffer()
"" IMPORTANTE: :help Ncm2PopupOpen for more information
"set completeopt=noinsert,menuone,noselect

" Jedi-vim ------------------------------
" Python autocompletion, go to definition.
Plug 'davidhalter/jedi-vim', {'for': 'python'}
" Vim splits
let g:jedi#use_splits_not_buffers = "left"
" All these mappings work only for python code:
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
" Go to definition in new tab
nmap <leader>D :tab split<CR>:call jedi#goto()<CR>
" use deoplete-jedi for completions
"let g:jedi#completions_enabled = 0
" Python async autocompletion.
"Plug 'zchee/deoplete-jedi', {'for': 'python'}
"let g:deoplete#sources#jedi#show_docstring = 1

" Black -----------------------------
" Python formater
Plug 'ambv/black', {'for': 'python'}
autocmd BufWritePre *.py execute ':Black'

" Automatically sort python imports ------------------------------
Plug 'fisadev/vim-isort', {'for': 'python'}

"Plug 'fatih/vim-go', {'for': 'go'}
"Plug 'ncm2/ncm2-go', {'for': 'go'}
"Plug 'mdempsky/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }

" Search results counter
"Plug 'vim-scripts/IndexedSearch'
" XML/HTML tags navigation
"Plug 'vim-scripts/matchit.zip'
"" Yank history navigation
"Plug 'vim-scripts/YankRing.vim'
"" Indent line
"Plug 'yggdroot/indentline'

"" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

"" ============================================================================
"" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif
"" }}}

"" Functions {{{
"
"" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

fun! StripTrailingWhitespace()
  "" don't strip on these filetypes
  if &ft =~ 'markdown'
    return
  endif
  %s/\s\+$//e
endfun
autocmd BufWritePre * call StripTrailingWhitespace()
"" }}}

