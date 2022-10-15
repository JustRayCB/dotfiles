"Map escape to jj
"imap -> Insert mode , map -> Normal mode
"Map jj to escape and `^ is to not move the cursor to the left
imap jj <Esc>`^
map s <Nop>
" Syntax highlighting
syntax enable

packadd! termdebug
"CODI is the plugin that update the line of code according to the cod

"Autoindent
"autocmd FileType cpp, py setlocal noexpandtab tabstop=4 sw=4 sts=4
"filetype off
"filetype plugin indent on
"filetype indent on 
" show existing tab with 4 spaces width
"set tabstop=4
" when indenting with '>', use 4 spaces width
"set shiftwidth=4
" On pressing tab, insert 4 spaces
"set expandtab
"set spell
set spelllang+=fr
"Windows setup for termdebug
let g:termdebug_wide=1


" Set FZF Default to Ripgrep (must install ripgrep) --> this command just made
" my fzf not working
"let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --no-ignore-vcs'

" Options viewable by using :options
" Set options viewable by using :set all
" Or help for individual configs can be accessed :help <name>
set nocompatible
set redrawtime=20000

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
"set notimeout
"set ttimeout
"set ttimeoutlen=5

set background=dark
set laststatus=2
set noerrorbells
"set tabstop=2 softtabstop=2
"set shiftwidth=2
set expandtab
"set smartindent
set nu
set nowrap
set nobackup
set undodir=~/.vim/undordir
set undofile 
set incsearch
"set relativenumber moving numbers
set cursorline
"set noswapfile to disable swap files

"One more space behind the last char in the line
set virtualedit+=onemore

"To use mouse in VIM
set mouse=a

" Column set to column 100
set colorcolumn=100

"Manage  Split Panes popup 
set splitbelow splitright

" Column color set to grey
"highlight ColorColumn ctermbg=1
"Make that when I press y to yank the text is in the windows clipboard
" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

"Sumatra setup 
"let g:vimtex_view_general_viewer = "/mnt/c/Users/Craya/Desktop/SumatraPDF.exe"
let g:vimtex_view_general_viewer = "/mnt/c/Users/Craya/AppData/Local/SumatraPDF/SumatraPDF.exe"
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 -interaction=nonstopmode $*'
"let g:Tex_ViewRule_pdf='sumatraPDF'
"let g:vimtex_view_method = "sumatraPDF"
autocmd VimEnter *.tex VimtexCompile

"Compile Latex
autocmd FileType tex nmap <buffer> <C-T> \ll<CR>
set expandtab ts=4 sw=4 ai


" Plugins
call plug#begin('~/.vim/plugged')

"Colorscheme
"set background=dark
"
Plug 'metakirby5/codi.vim'

Plug 'tpope/vim-fugitive'
" Make your Vim/Neovim as smart as VSCode
Plug 'neoclide/coc.nvim'

" Formatter
"Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Comment and uncomment lines
Plug 'preservim/nerdcommenter'

" A light and configurable statusline/tabline plugin for Vim
Plug 'itchyny/lightline.vim'

" Directory tree
Plug 'scrooloose/nerdtree'

" Visualize undo history tree (in vim undo is not linear)
Plug 'mbbill/undotree'

" Syntax highlighting for languages
Plug 'sheerun/vim-polyglot'

" Fzf is a general-purpose command-line fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" This plugin adds Go language support for Vim, with many features
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Python code formatter
Plug 'ambv/black'

" Gruvbox color theme
Plug 'morhetz/gruvbox'

" Vim-monokai-tasty color theme
Plug 'patstockwell/vim-monokai-tasty'

"Vim nighfly colorscheme
Plug 'bluz71/vim-nightfly-guicolors'

"Vim spector
Plug 'puremourning/vimspector'
"Autopairs
"Plug 'jiangmiao/auto-pairs'

"Vimtex
Plug 'lervag/vimtex'

" Track the engine.
"Plug 'SirVer/ultisnips'

"" Snippets are separated from the engine. Add this if you want them:
"Plug 'honza/vim-snippets'

call plug#end()

" Set mapleader to space
let mapleader = " "

"Autopairs
inoremap { {}<ESC>ha
inoremap [ []<ESC>ha
inoremap $ $$<ESC>ha
"inoremap ( ()<ESC>ha

"Select  a word
map <leader><leader><leader> ciw

"Close a current tab
nmap <S-tab> :tabclose<CR>

"Go to the first line
map <leader><leader>s :1<cr>

"Go to end File
map <leader><leader>e :%<cr>
"Go to end line
map <leader><leader>a A

"Go to start line
map <leader><leader>i I

"Open a new tab 
nmap <tab><tab> :tabnew<CR>

"Add the nasm extension when creating/opening a .asm file
autocmd VimEnter *.asm set ft=nasm
autocmd BufNew,BufRead *.asm set ft=nasm

"Skeleton of a file in asm when entering in a .asm file
if has("autocmd")
  augroup templates
    autocmd BufNewFile *.asm 0r ~/.vim/templates/skeleton.asm
  augroup END
endif


"Skeleton of a file in cpp when entering in a .cpp file
if has("autocmd")
  augroup templates
    autocmd BufNewFile *.cpp 0r ~/.vim/templates/skeleton.cpp
  augroup END
endif

"Execute Python code
"DISPLAY PROBLEM WHEN SAVING AND EXECUTING FILE
autocmd FileType python map <buffer> <F2> :w <CR>: exec '!python3' shellescape(@%, 1) <CR>
autocmd FileType python imap <buffer> <F2> <esc> :w <CR> :exec '!python3' shellescape(@%, 1)<CR>
"Execute Python code with a doctest
"And delete the pycache folder
autocmd FileType python map <buffer> <F3> :exec '!python3 -m doctest -v' shellescape(@%, 1)<CR>:! rm -R __pycache__<CR>
autocmd FileType python imap <buffer> <F3> <esc> :exec '!python3 -m doctest -v' shellescape(@%, 1)<CR>
"autocmd FileType python map <buffer> <F2> :w !python %<CR>
"autocmd FileType python imap <buffer> <F2> :w !python3 %<CR>

"Open a vertical panes with the python console and resize it
nmap <leader><leader>y :w <CR>:vertical  botright term ipython <CR> <C-w>:vertical resize 65 <CR> %clear<CR>
tnoremap <Left> <Nop>
tnoremap <Right> <Nop>
tnoremap <Up> <Nop>
tnoremap <down> <nop>


autocmd FileType markdown :call CocDisable()

"Execute C++ code
autocmd FileType cpp map <buffer> <F2> :w <CR> :!g++ -std=c++20 -Wall -Wextra -pedantic % -o %< && ./%<<CR>
autocmd FileType cpp map <buffer> <F4> :w <CR> :!g++ -std=c++20 -Wall -Wextra -pedantic % -o %< `fltk-config --ldflags` && ./%<<CR>
"autocmd FileType cpp map <buffer> <F3> :w <CR> :!g++ -std=c++2a -Wall -Wextra -pedantic % -o %< -lfltk  && ./%< <CR>
autocmd FileType cpp map <buffer> <F3> :w <CR> :!make && ./main<CR>
autocmd FileType java map <buffer> <F2> :w <CR> :!javac % && java %<<CR>

" Maps
nmap <leader>hk :vsplit ~/.vim/hotkeys<cr>
nmap <leader>lt :vsplit ~/.vim/latex<cr>
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>t :NERDTree<cr>
nmap <leader><leader>p :Prettier<cr>
"Set NERDTree windows size 
:let g:NERDTreeWinSize=17
"Open NERDTree when opening vim
"autocmd VimEnter (*cpp,*py,*h,*hpp)  NERDTree | wincmd p
autocmd VimEnter *.c,*.h,*.cpp,*hpp,*.py,*.txt  NERDTree | wincmd p
"Close NERDTree when quit vim 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nmap <leader><leader>g :GoFmt<cr>
nmap <leader><leader>b :Black<cr>
nmap <leader><leader>u :UndotreeToggle<cr>
" Files (runs $FZF_DEFAULT_COMMAND if defined)
nmap <leader><leader>f :Files<cr>
nmap <leader><leader><leader>g :GoMetaLinter<cr>
nnoremap <C-p> :GFiles<CR>
"nnoremap <leader><leader>c :call NERDComment(0,"toggle")<CR>
"vnoremap <leader><leader>c :call NERDComment(0,"toggle")<CR>
nnoremap <leader><leader>c :call nerdcommenter#Comment(0,"toggle")<CR>
vnoremap <leader><leader>c :call nerdcommenter#Comment(0,"toggle")<CR>
nnoremap <leader><Tab> :bnext<CR>
nnoremap <leader><Tab><Tab> :bprevious<CR>

"Vimspector window layout settings 
let g:vimspector_sidebar_width = 35
"Uncomment next line if you want the output console under script section
"let g:vimspector_bottombar_height = 5
"If you want to reduce the script section
let g:vimspector_code_minwidth = 70


"auto save mode between buf and :update put silent! if u don't want any message
noremap <C-F5> :au! CursorHoldI,CursorHold,BufLeave <buffer> :update<CR>

"vimspector Maps
let g:vimspector_enable_mappings = 'HUMAN'
nnoremap <leader>la :call vimspector#Launch()<CR> 
nnoremap <leader>dx :call vimspector#Reset()<CR>
nnoremap <leader><leader>so :call vimspector#StepOut()<CR>
nnoremap <leader>si :call vimspector#StepInto()<CR>
noremap <leader>so :call vimspector#StepOver()<CR>
nnoremap <leader>d_ :call vimspector#Restart()<CR>
nnoremap <leader>co :call vimspector#Continue()<CR>
nnoremap <leader>drc :call vimspector#RunToCursor()<CR>
nnoremap <leader>bp :call vimspector#ToggleBreakpoint()<CR>
nnoremap <leader>df :call vimspector#ToggleConditionalBreakpoint()<CR>
nnoremap <leader>nb :call vimspector#JumpToNextBreakpoint()<CR>
nmap <leader>de :VimspectorEval
nmap <leader>dw :VimspectorWatch
nmap <leader>>do :VimspectorShowOutput

" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval

"terminal mode
tnoremap <ESC> <C-w>:q!<CR>
tnoremap jj <C-w>N 
"exit the terminal in insert mode
tnoremap :q <C-w>:q!<CR>



"map ctrl-c as yank
vnoremap <C-c> y

"Remap splits navigation to just CTRL hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"Adjust split panes size more friendly
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

"Adjust split terminal panes size more friendly
tnoremap <silent> <C-Left> :vertical resize +3<CR>
tnoremap <silent> <C-Right> :vertical resize -3<CR>
tnoremap <silent> <C-Up> :resize +3<CR>
tnoremap <silent> <C-Down> :resize -3<CR>
"Open terminal inside vim
"map <leader>tm :vs|:terminal<CR>

"Open split panes
map <leader><leader>= :vs<CR>
map <leader><leader>- :sp<CR>



"Utlisnips setup
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
"let g:UltiSnipsExpandTrigger="<s-tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
"let g:UltiSnipsListSnippets="<c-m>"
""" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"


""""""""""""""""""""""""coc nvim settings start""""""""""""""""""""""""

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
"set nobackup
"set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

"autocmd FileType markdown let b:coc_suggest_disable = 1
autocmd FileType markdown :call CocDisable()

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
" Recently vim can merge signcolumn and number column into one
set signcolumn=number
else
set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" UPDATE AFTER 0.082 I THINK THIS IS USEFULL
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"-----

function! s:check_back_space() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
inoremap <silent><expr> <c-space> coc#refresh()
else
inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
" UPDATE AFTER 0.082 I THINK THIS IS USEFULL
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                          \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
"custom pop up menu 0.082 coc nvim
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
" remap for complete to use tab and <cr>
inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1):
        \ <SID>check_back_space() ? "\<Tab>" :
        \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
"end of default settings coc nvim pop up menu
hi CocSearch ctermfg=12 guifg=#18A3FF
hi CocMenuSel ctermbg=109 guibg=#13354A
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

"let g:prettier#config#single_quote = 'true'
"let g:prettier#config#trailing_comma = 'all'

"Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

let g:lightline = {
      \ 'colorscheme': 'deus',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
"nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

""""""""""""""""""""""""coc nvim settings end""""""""""""""""""""""""

" Set the prettier CLI executable path
"let g:prettier#exec_cmd_path = "~/.vim/plugged/vim-prettier/node_modules/prettier"
" Max line length that prettier will wrap on: a number or 'auto'
"let g:prettier#config#print_width = 100 " default is 'auto'
"----------------------------------COLORSCHEME-----------------------------------------------
set background=dark
set termguicolors
augroup nightfly_override
    autocmd!
    " I like green statements
    autocmd ColorScheme nightfly hi Statement guifg=#5FD75F ctermfg=green
    " I like transparent background for terminals
    autocmd ColorScheme nightfly hi Normal ctermbg=NONE
    " I like italic comments
    autocmd ColorScheme nightfly hi Comment cterm=italic guifg=#76b5ef
    autocmd Colorscheme nightfly hi ColorColumn guibg=Red
    autocmd Colorscheme nightfly hi Variable  guifg=Blue
    "autocmd Colorscheme nightfly hi ErrorMsg  guibg=Red
    " etc ...
augroup END
" Colorscheme (For gruvbox $TERM env var needs to be xterm-256color)
"autocmd vimenter * ++nested colorscheme default
"colorscheme vim-monokai-tasty
colorscheme nightfly
let g:nightflyCursorColor = v:true
let g:nightflyNormalFloat = v:true
let g:nightflyWinSeparator = 2
"--------------------------------------------------------------------------------------------

" Returns true if the color hex value is light
"augroup project
  "autocmd!
  "autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
"augroup END
"Set .h file for c language 
let g:c_syntax_for_h = 1

"Save cursor last edit position
"source $VIMRUNTIME/vimrc_example.vim
"" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
"Disable highlighting when searching 
set nohlsearch

set tabstop=4
syntax on " Syntax highlighting
set showmatch " Shows matching brackets
set ruler " Always shows location in file (line#)
set smarttab " Autotabs for certain code
set shiftwidth=4
filetype plugin indent on
let g:coc_snippet_next = '<Tab>'
nnoremap sh :w <CR>:!chmod +x % && source %<CR>
"Make indent right
map <F7> gg=G<C-o><C-o>
autocmd FileType python setl tabstop=4|setl shiftwidth=4|setl softtabstop=4
autocmd FileType cpp setl tabstop=4|setl shiftwidth=4|setl softtabstop=4
autocmd FileType html setl tabstop=2|setl shiftwidth=2|setl softtabstop=2
autocmd FileType javascript setl tabstop=2|setl shiftwidth=2|setl softtabstop=2
autocmd FileType css setl tabstop=2|setl shiftwidth=2|setl softtabstop=2
autocmd Filetype ruby setlocal tabstop=2|setl shiftwidth=2|setl softtabstop=2

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Backups {{{

set backup                        " enable backups
"set noswapfile                    " it's 2013, Vim.

set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" }}}
