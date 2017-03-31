" Leader
let mapleader = " "
" ; is easier than :
noremap ; :
noremap : ;

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set iskeyword+=$,%

set undodir=~/.vim/tmp/undo//     " undo files
set undofile
set undolevels=1000         "maximum number of changes that can be undone
set undoreload=10000        "maximum number lines to save for undo on a buffer reload

" Encoding
set enc=utf-8
set fenc=utf-8 " default fileencoding
set fencs=ucs-bom,utf-8,gb18030,gbk,gb2312,cp936,big5,euc-jp,euc-kr,latin1


" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" formatoptions
" o - insert command leader in o or O
" t - autowrap text
" c - autowrap comments
" r - insert comment leader
" mM - useful for Chinese characters, q - gq
" j - remove comment leader when joining lines
autocmd! FileType * setlocal formatoptions-=t

" Softtabs, 4 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:⌴,conceal:…,extends:❯,precedes:❮,nbsp:_

" set tag location
set tags=./tags;/
set tags+=gems.tags

" Color scheme
set background=dark
colorscheme hybrid
" set guifont=Menlo\ Regular:h13
set guifont=Source\ Code\ Pro\ Semibold:h14

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
set wildignore+=*.dll,*.o,*.obj,*.bak,*.exe,*.zip
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.bmp
set wildignore+=*~,*.sw?,*.DS_Store
set wildignore+=*$py.class,*.class,*.gem,*.pyc,*.aps,*.vcxproj.*
set wildignore+=.git,.gitkeep,.hg,.svn,.tmp,.coverage,.sass-cache
set wildignore+=log/**,tmp/**,node_modules/**,build/**,_site/**,dist/**
set wildignore+=vendor/bundle/**,vendor/cache/**,vendor/gems/**


" Always use vertical diffs
set diffopt+=vertical

set scrolloff=5

" Remove trailing whitespaces when saving
" Wanna know more? http://vim.wikia.com/wiki/Remove_unwanted_spaces
autocmd BufWritePre * :%s/\s\+$//e

set nofoldenable
set foldlevel=1
set foldmethod=indent

" Automatically fitting a quickfix window height: min=3, max=40
au FileType qf call AdjustWindowHeight(3, 40)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Mappings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" tabs and windows {{{
  " Switch between tab 1 ~ 9
  for i in range(1, 9)
      exec "nnoremap \\".i." ".i."gt"
  endfor

  nnoremap \( :tabprevious<cr>
  nnoremap \) :tabnext<cr>
  nnoremap \t :tab split<CR>
  nnoremap \T :tabnew<CR>
  nnoremap \w :tabclose<CR>

  " splitting
  set splitright
  set splitbelow

  " Smart way to move btw. windows
  nmap <C-j> <C-W>j
  nmap <C-k> <C-W>k
  nmap <C-h> <C-W>h
  nmap <C-l> <C-W>l
" }}}

" Function keys {{{
  " F1
  " F2    Insert date and time
  inoremap <F2> <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>
  " F3    Toggle NERDTree
  " F4
  " nnoremap <F4> :TagbarToggle<cr>
  " inoremap <F4> <ESC>:TagbarToggle<cr>
  " F5    Toggle Tagbar
  " F6    Toggle Paste mode
  set pastetoggle=<F6>
  " F7    Tigger Syntastic manual check
  " F8
  nnoremap <silent> <F8> :call DiffToggle()<CR>
  " F9    Toggle iTerm 2
  " F10
  " F11   Toggle Goyo
  " F12   Toggle ZoomWin

  function! DiffToggle()
    if &diff
      windo diffoff
    else
      windo diffthis
    endif
  :endfunction
" }}}

" Special keys {{{
  " Use <Tab> and <S-Tab> to indent
  nnoremap <tab>    %
  vnoremap <s-tab>  %

  " Move a line of text using <up><down>
  " http://vim.wikia.com/wiki/Moving_lines_up_or_down
  nnoremap <up>   :m .-2<CR>==
  nnoremap <down> :m .+1<CR>==
  vnoremap <up>   :m '<-2<CR>gv=gv
  vnoremap <down> :m '>+1<CR>gv=gv

  " Move to prev/next buffer
  nnoremap <left>  <ESC>:bN<CR>
  nnoremap <right> <ESC>:bn<CR>

  " press Backspace to toggle the current fold open/closed. However, if the cursor is not in a fold, move to the right
  nnoremap <silent> <BS> @=(foldlevel('.')?'za':"\<BS>")<CR>
" }}}

" Characters (Normal Mode) {{{
  " <~>       Switch character case
  " <0>       Go to first non-blank character
  nnoremap 0 ^
  " <!>
  " <@>       Register
  " <#>       Search word under cursor backwards
  " <$>       To the end of the line
  " <%>       Move between open/close tags
  " *<%>      Move to percentage of file
  " <^>       To the first non-blank character of the line.
  " <&>       Synonym for `:s` (repeat last substitute)
  " <*>       Search word under cursor forwards
  " <(>       Sentences backward
  " <)>       Sentences forward
  " <_>       Quick Horizonal split
  nnoremap _ :sp<cr>
  " <==>      Format current line
  " <+>       Switch
  " <q>*      Record Macro
  " <Q>       Repeat last recorded Macro
  " nnoremap Q @@
  " <w>       Word forwards
  " <W>       Word forwards
  " <e>       Forwards to the end of word
  " <E>       Forwards to the end of word
  " <r>       Replace character
  " <R>       Continous replace
  " <t>       find to left (exclusive)
  " <T>       find to left (inclusive)
  " <y>       Yank into register
  " <Y>       Yanking to the end of line
  nnoremap Y y$
  " <u>       Undo
  inoremap uu _
  inoremap hh -
  inoremap ii =
  inoremap kk ->
  inoremap jk =>
  " <U>       Undo all latest changes on last changed line
  " <i>       Insert
  " <I>       Insert at beginning of line
  " <o>       Open new line below
  " <O>       Open new line above
  " <p>       Paste yank after, keep cursor position
  nnoremap p p`[
  " <p>       Paste yank before, keep cursor position
  nnoremap P P`[
  " <[>       tpope/unimpaired
  " <{>       Paragraphs backward
  " <]>       tpope/unimpaired
  " <}>       Paragraphs forward
  " <\>       Toggle folding
  " <|>       Quick vertical split
  nnoremap <bar> :vsp<cr>
  " <a>       Append insert
  " <A>       Append at end of line
  " <s>       EasyMotion
  " <S>       Substitue, don't update default register
  nnoremap S "_s
  " <d>       Delete
  " <D>       Delete to end of line
  " <f>       find to right (exclusive)
  " <F>       find to right (inclusive)
  " <g>       Go and Unite mappings
  " <G>       Go to end of file
  " *<G>      Go to specific line number
  " <h>       Left
  " <H>       Go to beginning of line. Goes to previous line if repeated
  nnoremap <expr> H getpos('.')[2] == 1 ? 'k' : '^'
  " <j>       Down
  nnoremap j gj
  inoremap jj <Esc>
  " <J>       Join Sentences
  " <k>       Up
  nnoremap k gk
  " <K>
  " <l>       Right
  " <L>       Go to end of line. Goes to next line if repeated
  nnoremap <expr> L <SID>end_of_line()
    function! s:end_of_line()
      let l = len(getline('.'))
      if (l == 0 || l == getpos('.')[2])
          return 'jg_'
      else
          return 'g_'
    endfunction
  " <;>       Repeat last find f,t,F,T
  " <:>       Input Command
  " <'>*      Move to {a-zA-Z} mark
  " <z>*      Folding
  " <x>       Delete char under cursor
  " <X>       Delete char before cursor
  " <c>       Change, don't update default register
  nnoremap c "_c
  " <C>       Change to end of line, don't update register
  nnoremap C "_C
  " <v>       Visual
  " <V>       Visual line
  " <b>       Words backwards
  " <B>       Words backwards
  " <n>       Next search
  " <N>       Previous search
  " <m>*      Set mark {a-zA-Z}
  " <M>       Move cursor to centre of screen
  " <,>       Leader
  " [<]       Left Indent
  " vnoremap < <gv
  " <.>       Repeat last command
  " [>]       Right Indent
  " vnoremap > >gv
  " </>       Search
  " nnoremap / /\v
  " vnoremap / /\v
  " <?>       Search backwards
  " nnoremap ? ?\v
  " vnoremap ? ?\v
  " <space>   Enter <space> used as Leader
  nnoremap <leader><leader> <c-^>
  " <Enter>   Insert New Line without going into insert mode
  nnoremap <Enter> o<ESC>
  nnoremap tn :tnext<CR>
  nnoremap tp :tprevious<CR>
" }}}

" <leader>* {{{
  " <leader>1 add a '====' line above/after current line
  " nnoremap <leader>1 :normal "lyy"lpwv$r=^"lyyk"lP<cr>
  " <leader>2
  " nnoremap <leader>2 :normal "lyy"lpwv$r-^"lyyk"lP<cr>
  " <leader>3
  " nnoremap <leader>3 :normal "lyy"lpwv$r#^"lyyk"lP<cr>
  " <leader>4
  " nnoremap <leader>4 80A=<Esc>d80<Bar>
  " <leader>5
  " Markdown headings
  " nnoremap <leader>11 m`yypVr=``
  " nnoremap <leader>22 m`yypVr-``
  nnoremap <leader>11 m`^i# <esc>``2l
  nnoremap <leader>22 m`^i## <esc>``3l
  nnoremap <leader>33 m`^i### <esc>``4l
  nnoremap <leader>44 m`^i#### <esc>``5l
  nnoremap <leader>55 m`^i##### <esc>``6l
  " <leader>6
  " <leader>7
  " <leader>8
  " <leader>9
  " <leader>0 Edit vimrc
  " <leader>) Edit gvimrc
  " <leader>-
  " <leader>=
  " <leader>q Quick Quit without save
  nnoremap <leader>q :q!<CR>
  " <leader>w vim-choosewin
  " nnoremap <leader>W :call ToggleWrap()<CR>
  " function! ToggleWrap()
  "   nnoremap <buffer> j gj
  "   nnoremap <buffer> k gk
  "   nnoremap <buffer> 0 g0
  "   nnoremap <buffer> $ g$
  "   nnoremap <buffer> ^ g^
  " endfunction
  " <leader>e Show yank list
  " for ctrlp plugin
  " nnoremap <leader>b :CtrlPBuffer<CR>
  " nnoremap <leader>h :CtrlPMRU<CR>
  " nnoremap <leader>e :CtrlPRegister<CR>
  " nnoremap <leader>m :CtrlPMark<CR>
  " nnoremap <leader>g :CtrlPTag<CR>
  " nnoremap <leader>f :CtrlPFunky<Cr>
  " nnoremap <Leader>u :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
  " for fzf plugin
  nnoremap <C-p> :GitFiles<CR>
  " nnoremap <leader>f :Files<CR>
  nnoremap <leader>b :Buffers<CR>
  nnoremap <leader>h :History<CR>
  nnoremap <leader>m :Marks<CR>
  nnoremap <leader>bc :BCommits<CR>
  " nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>

  imap <c-x><c-k> <plug>(fzf-complete-word)
  imap <c-x><c-f> <plug>(fzf-complete-path)
  imap <c-x><c-j> <plug>(fzf-complete-file-ag)
  imap <c-x><c-l> <plug>(fzf-complete-line)

  nmap <leader><tab> <plug>(fzf-maps-n)
  xmap <leader><tab> <plug>(fzf-maps-x)
  omap <leader><tab> <plug>(fzf-maps-o)

  " <leader>t vim-test mappings
  nnoremap <leader>s :TestNearest<CR>
  nnoremap <leader>t :TestFile<CR>
  nnoremap <leader>l :TestLast<CR>
  " nnoremap <leader>a :TestSuite<CR>
  " nnoremap <leader>g :TestVisit<CR>

  " <leader>y Yank content in OS's clipboard
  vnoremap <leader>y "*y
  " <leader>u
  " <leader>i
  " <leader>o
  " <leader>p Paste content from OS's clipboard
  nnoremap <leader>p "*p
  " <leader>a
  " <leader>s Spell checkings
  " nnoremap <leader>ss :setlocal spell!<CR>
  " nnoremap <leader>sn ]s
  " nnoremap <leader>sp [s
  " nnoremap <leader>sa zg
  " nnoremap <leader>s? z=
  " <leader>S Clear trailing whitespace
  nnoremap <leader>S :%s/\s\+$//ge<CR>:nohl<CR>
  " <leader>d Close buffer with leave window intact
  nnoremap <leader>d :BD<CR>
  " <leader>D Close buffer
  nnoremap <leader>D :bd<CR>
  " <leader>f Format file
  nnoremap <leader>fj :%!js-beautify -s=2 -q -f -<CR>
  nnoremap <leader>fs :%!css-beautify -s=2 -q -L -N -f -<CR>
  nnoremap <leader>ff :%!html-beautify -s=2 -q -f -<CR>
  " <leader>F Format file
  nnoremap <leader>F gg=G''
  " <leader>g
  " <leader>h
  " <leader>j
  " Ranger File Manager
  nnoremap <leader>j :Ranger<CR>
  nnoremap <leader>e :RangerWorkingDirectory<CR>
  " <leader>k
  nmap <leader>k <Plug>DashSearch
  " <leader>l
  " <leader>L Reduce a sequence of blank lines into a single line
  nnoremap <leader>L GoZ<Esc>:g/^[ <Tab>]*$/.,/[^ <Tab>]/-j<CR>Gdd
  " <leader>z
  " <leader>x
  " <leader>c

  " <leader>v Select the just pasted text
  nnoremap <leader>v V`]
  " <leader>b
  " <leader>n
  " <leader>m
  " <leader>M Remove ^M
  nnoremap <leader>M mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm
  " <leader>, Run Eval
  noremap <leader>; m`A;<Esc>``
" }}}

" <C-*> (Normal Mode) {{{
  " <C-1> Mac Desktop Switch
  " <C-2> Mac Desktop Switch
  " <C-3> Mac Desktop Switch
  " <C-4> Mac Desktop Switch
  " <C-5> Mac Desktop Switch
  " <C-6>
  " <C-7>
  " <C-8>
  " <C-9>
  " <C-0> Jump back tap
  " <C-->
  " <C-=>
  " <C-q> Multiple select
  " <C-w>
  " <C-e>
  " <C-r>
  " <C-t>
  " <C-y> Emmet Expand
  " <C-u> Page up
  " <C-u> Switch word case
  " inoremap <C-u> <esc>mzg~iw`za
  " <C-i>
  " <C-o>
  " <C-p>
  " <C-]> Jump tag
  " <C-a>
  " <C-s>
  " <C-d> Page Down
  " <C-f> Easymotion
  " <C-g>
  " <C-h> Move to left window
  " <C-j> Move to down window
  " <C-k> Move to up window
  " <C-l> Move to right window
  " <C-;>
  " <C-'>
  " <C-z>
  " <C-x>
  " <C-c>
  " <C-v>
  " <C-b> Switch Buffers
  " <C-n>
  " <C-m>
  " <C-,>
  " <C-.>
" }}}

" <C-*> (Insert Mode) {{{
  " inoremap <expr> <C-j> pumvisible() ? "\<C-e>\<Down>" : "\<Down>"
  " inoremap <expr> <C-k> pumvisible() ? "\<C-e>\<Up>" : "\<Up>"
  " inoremap <C-H>  <S-Left>
  " inoremap <C-L>  <S-Right>
  " inoremap <C-B>  <Left>
  " inoremap <C-F>  <Right>
  inoremap <C-A>  <C-O>^
  inoremap <C-E>  <End>
  " inoremap <C-D>  <C-R>=AutoPairsDelete()<CR>
  " inoremap <C-BS> <C-W>
  " inoremap <D-BS> <S-Right><C-W>
" }}}

" <C-*> (Command Mode) {{{
  cnoremap <C-A> <Home>
  cnoremap <C-E> <End>
  " cnoremap <C-F> <Right>
  " cnoremap <C-B> <Left>
  " cnoremap <C-N> <Down>
  " cnoremap <C-P> <Up>
  cnoremap <C-K> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>
  " cnoremap <C-D> <Del>
  cnoremap <C-Y> <C-r>*
  cnoremap %% <C-R>=expand('%:h').'/'<cr>
" }}}
" ----------------------------------------------------------------------------
" ?ie | entire object
" ----------------------------------------------------------------------------
xnoremap <silent> ie gg0oG$
onoremap <silent> ie :<C-U>execute "normal! m`"<Bar>keepjumps normal! ggVG<CR>
" ----------------------------------------------------------------------------
" ?il | inner line
" ----------------------------------------------------------------------------
xnoremap <silent> il <Esc>^vg_
onoremap <silent> il :<C-U>normal! ^vg_<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Additional Settings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Source vimrc after saving it {{{
autocmd! BufWritePost .vimrc source $MYVIMRC

" Quick edit _vimrc template
" noremap <leader>0 :tabe $MYVIMRC<CR>
" noremap <leader>) :tabe $MYGVIMRC<CR>
" }}}

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" Update diff after save {{{
autocmd! InsertLeave,BufWritePost * if &l:diff | diffupdate | endif
" }}}

" Snippets {{{
autocmd! FileType neosnippet,snippet set noexpandtab
" }}}

" Ruby Mappings {{{
autocmd! FileType ruby,eruby,rdoc :call s:RubyDef()
function! s:RubyDef()
  setlocal shiftwidth=2
  setlocal tabstop=2

  " Surround % to %
  let b:surround_37 = "<% \r %>"
  xmap % S%
  " Surround = to %=
  let b:surround_61 = "<%= \r %>"
  xmap _ S=
  " Surround # to #{}
  let b:surround_35 = "#{ \r }"
  xmap # S#

  " Correct typos
  iab elseif     elsif
  iab ~=         =~
endfunction
" }}}

" CoffeeScript Mappings {{{
autocmd! FileType coffee :call s:CoffeeDef()
function! s:CoffeeDef()
  setlocal shiftwidth=2
  setlocal tabstop=2
endfunction
" }}}

" Javascript Mappings {{{
autocmd! FileType javascript :call s:JavascriptDef()
" Format using Prettier
autocmd FileType javascript set formatprg=prettier\ --single-quote\ --trailing-comma\ es5\ --stdin
autocmd BufWritePre *.js :normal gggqG
autocmd BufWritePre *.js exe "normal! gggqG\<C-o>\<C-o>"
function! s:JavascriptDef()
  setlocal shiftwidth=2
  setlocal tabstop=2
endfunction
" }}}

" Html/Xml Mappings {{{
autocmd! FileType xhtml,html,slim,jade,xml,yaml :call s:WebDef()
function! s:WebDef()
  setlocal shiftwidth=2
  setlocal tabstop=2
  setlocal foldmethod=indent
  setlocal foldlevel=1

  " Surround % to {{
  let b:surround_37 = "{{ \r }}"
  xmap % S%
  " Surround = to {{=
  let b:surround_61 = "{{= \r }}"
  xmap _ S=
  " Surround * to <!--
  let b:surround_42 = "<!-- \r -->"
  xmap 8 S*

  " Delete surround tag
  nmap <Del> dst

  " Special characters
  iab ->> →
  iab <<- ←
  iab >>  »
  iab ^^  ↑
  iab VV  ↓
endfunction
" }}}

" Markdown Mappings {{{
autocmd! FileType markdown :call s:MarkdownDef()
function! s:MarkdownDef()
  setlocal shiftwidth=2
  setlocal tabstop=2
  setlocal nospell
  setlocal wrap

  " Surround _ to _
  let b:surround_95 = "_\r_"
  xmap _ S_
  " Surround * to **
  let b:surround_42 = "**\r**"
  xmap 8 S*
  " Surround - to ~~
  let b:surround_45 = "~~\r~~"
  xmap - S-

  " Add more parentheses
  let b:AutoPairs = { '(':')',   '[':']',  '{':'}',
                  \   "'":"'",   '"':'"',  '`':'`',
                  \   '“':'”',   '‘':'’', '《':'》',
                  \  '「':'」', '（':'）'}

  " Insert date and time in Jekyll
  inoremap <buffer> <F2>  <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>
  " Hard wrap current paragraph
  nnoremap <buffer> <D-w> gwip
  " Unwrap current paragraph
  nnoremap <buffer> <D-W> vipJ
  " Format all paragraphs in buffer
  nnoremap <buffer> <D-e> ggVGgq
  " Unformat all paragraphs in buffer
  nnoremap <buffer> <D-E> :%norm vipJ<CR>
  " Insert headings
  nnoremap <buffer> <M-1> I# <ESC>
  nnoremap <buffer> <M-2> I## <ESC>
  nnoremap <buffer> <M-3> I### <ESC>
  nnoremap <buffer> <M-4> I#### <ESC>
  " Insert inline link
  vmap <buffer> <D-k> [f]a(
  " Insert inline image
  vmap <buffer> <D-i> [i!<ESC>f]a(

  " Wrap text
  nnoremap <buffer> j gj
  nnoremap <buffer> k gk
  nnoremap <buffer> 0 g0
  nnoremap <buffer> $ g$
  nnoremap <buffer> ^ g^
endfunction

augroup vimrc
  autocmd!
  au FileType ruby,coffee IndentLinesEnable
augroup END
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

