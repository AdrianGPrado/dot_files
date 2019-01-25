"" neovim-config

"" Vim settings and mappings {{{
"" ============================================================================
"" Vim settings and mapping s

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

"" Always highlight column 90 so it's easier to see where
"" cutoff appears on longer screens
"" http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
autocmd BufWinEnter * highlight ColorColumn ctermbg=36
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
imap <C-J> <C-n>

"" save as sudo
ca w!! w !sudo tee "%"

"" Remap VIM to 0 to first non-blank character
map 0 ^

"" simple recursive grep
nmap <Leader>r :Ack
nmap <Leader>R :Ack <cword><CR>

"" use 256 colors when possible

colorscheme onedark
set background=dark
if has("termguicolors")
    set termguicolors
endif
syntax enable

let base16colorspace=256

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

"" Editor Panes and Windows {{{
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

" Tagbar -----------------------------
Plug 'majutsushi/tagbar'
" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1

" TabMan ------------------------------
" Tab list panel
Plug 'kien/tabman.vim'
" mappings to toggle display, and to focus on it
let g:tabman_toggle = 'tl'
let g:tabman_focus  = 'tf'

" Window Chooser ------------------------------
Plug 't9md/vim-choosewin'
" mapping
nmap  \-  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1
"" }}}

" Color Layout: {{{
" ColorThemes
"
" Solarized theme
Plug 'altercation/vim-colors-solarized'
let g:solarized_termcolors=256
let g:solarized_visibility='high'
" Terminal Vim with 256 colors colorscheme
Plug 'fisadev/fisa-vim-colorscheme'
" Terminal Vim base-16 256 colorscheme
Plug 'chriskempson/base16-vim'
" Tomorrow colorscheme
Plug 'chriskempson/tomorrow-theme'
" Gvim colorscheme
Plug 'vim-scripts/Wombat'
" Vim One
Plug 'rakr/vim-one'
" Vim OneDark Atom based colorscheme
" https://github.com/joshdick/onedark.vim
Plug 'joshdick/onedark.vim'
let g:onedark_termcolors=256
""


"" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'onedark'
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
let g:airline_symbols.linenr = '|'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
"" }}}

" Code Navigation: {{{
"
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
let g:ctrlp_working_path_mode = 1
" ignore these files and folders on file finder
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|node_modules)$',
  \ 'file': '\.pyc$\|\.pyo$',
  \ }
" CtrlP -> use Ag for searching instead of VimScript
" (might not work with ctrlp_show_hidden and ctrlp_custom_ignore)
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ackprg = 'ag --nogroup --nocolor --column'

" Silver Searcher: https://github.com/gabesoft/vim-ags -----------------------------
Plug 'gabesoft/vim-ags'
let g:ags_enable_async = 1

" Delimitmate: https://github.com/raimondi/delimitmate
Plug 'raimondi/delimitmate'

"" Autoclose ------------------------------
"Plug 'Townk/vim-autoclose'
"" Fix to let ESC work as espected with Autoclose plugin
"let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

"" Version Control
" GitGutter ------------------------------
Plug 'airblade/vim-gitgutter'

" Signify ------------------------------
" Git/mercurial/others diff icons on the side of the file lines
Plug 'mhinz/vim-signify'
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

" Ack code search (requires ack installed in the system)
Plug 'mileszs/ack.vim'

" Search results counter
"Plug 'vim-scripts/IndexedSearch'
" XML/HTML tags navigation
"Plug 'vim-scripts/matchit.zip'
"" Yank history navigation
"Plug 'vim-scripts/YankRing.vim'
"" Indent line
"Plug 'yggdroot/indentline'
"" }}}

"" Code Languages {{{

" Syntastic ------------------------------
Plug 'vim-syntastic/syntastic'
" show list of errors and warnings on the current file
nmap <leader>E :Errors<CR>
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
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
let g:syntastic_python_checkers = ['pylint']

"" Vim Deoplete Completion ------------------------------
"" Installation instructions
""  - https://github.com/Shougo/deoplete.nvim
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

"" Language Python {{{
"" Installation instructions
let g:python_host_prog = '/Users/adriangarciapradions/neovim27/bin/python'
let g:python3_host_prog = '/Users/adriangarciaprado/.pyenv/versions/neovim36/bin/python'
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd BufRead *.py setlocal foldmethod=syntax

"" Python autocompletion, go to definition.
"" Installation instructions
"" Autocompletion Jedi: https://github.com/davidhalter/jedi-vim
""   Requirements: `pip install jedi` in nvim_py37 virtual env
Plug 'davidhalter/jedi-vim', {'for': 'python'}
"let g:jedi#use_splits_not_buffers = "right"
let g:jedi#show_call_signatures = "1"
"" All these mappings work only for python code:
let g:jedi#goto_command = "gd"
"let g:jedi#goto_assignments_command = "<leader>g"
"let g:jedi#goto_definitions_command = ""
"let g:jedi#documentation_command = "K"
"let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
"let g:jedi#rename_command = "<leader>r"
"" Go to definition in new tab
nmap <leader>D :tab split<CR>:call jedi#goto()<CR>
" use deoplete-jedi for completions
let g:jedi#completions_enabled = 0

"" Python Mode:
" https://github.com/klen/python-mode
Plug 'klen/python-mode', {'for': 'python'}


"" Deoplete Jedi: https://github.com/zchee/deoplete-jedi
""   - https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
Plug 'zchee/deoplete-jedi', {'for': 'python'}
let g:deoplete#_python_version_check = 3
let g:deoplete#sources#jedi#show_docstring = 1

" Black: https://github.com/ambv/black
""   Requirements: `pip install black` in nvim_py37 virtual env
Plug 'ambv/black', {'for': 'python'}
"let g:black_virtualenv = '/Users/adriangarciaprado/.pyenv/versions/neovim36/bin/python'
let g:black_linelength = 89
autocmd BufWritePre *.py execute ':Black'

" Isort ------------------------------
""   Requirements: `pip install isort` in nvim_py37 virtual env
Plug 'fisadev/vim-isort', {'for': 'python'}
"let g:isort_virtualenv = '/Users/adriangarciaprado/.pyenv/versions/neovim36/bin/python'
autocmd BufWritePre *.py execute ':Isort'
""  " ends Language Python
"" }}}

" Language Golang {{{
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }
Plug 'stamblerre/gocode', { 'rtp': 'vim', 'do': '~/.config/nvim/gocode/vim/symlink.sh' }
Plug 'rjohnsondev/vim-compiler-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }
let g:golang_goroot = '/usr/local/Cellar/go/1.11.4/libexec'
" To disable calling Golang every time a buffer is saved, put into .vimrc file:
let g:golang_onwrite = 0
Plug 'vim-jp/vim-go-extra'
Plug 'zchee/deoplete-go', { 'do': 'make'}

autocmd BufRead *.go setlocal syntax=go
autocmd BufRead *.go setlocal foldmethod=syntax
autocmd BufWritePre *.go execute ':GoImports'
autocmd BufWritePre *.go execute ':GoFmt'

let g:go_fold_enable = ['block', 'import', 'varconst', 'package_comment']
let g:go_highlight_extra_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
""  " ends Language Golang
"" }}}

"" Language CSS {{{
Plug 'lilydjwg/colorizer' " Paint css colors with the real color
""  " ends Language CSS }}}

""  " ends Languages }}}

"" Tell vim-plug we finished declaring plugins, so it can load them
cal plug#end()

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

