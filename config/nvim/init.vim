set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

if (has("termguicolors"))
  set termguicolors
  colorscheme forest-night
endif

set inccommand=nosplit

tnoremap jj <C-\><C-n>

" FZF Floating Window {{{
" 让输入上方，搜索列表在下方
" let $FZF_DEFAULT_OPTS = '--layout=reverse --border'

" 打开 fzf 的方式选择 floating window
" let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }
"
" function! CreateCenteredFloatingWindow()
"     let width = float2nr(&columns * 0.8)
"     let height = float2nr(&lines * 0.8)
"     let opts = {
"           \ 'relative': 'editor',
"           \ 'row': (&lines - height) / 2,
"           \ 'col': (&columns - width) / 2,
"           \ 'width': width,
"           \ 'height': height,
"           \ 'style': 'minimal'
"           \ }
"     set winhl=Normal:Floating
"     call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
" endfunction

" OLD APPROACH, FLOATING WINDOW IS TOO SMALL!
" let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }
" function! OpenFloatingWin()
"   let height = &lines - 3
"   let width = float2nr(&columns - (&columns * 2 / 10))
"   let col = float2nr((&columns - width) / 2)
"
"   " 设置浮动窗口打开的位置，大小等。
"   " 这里的大小配置可能不是那么的 flexible 有继续改进的空间
"   let opts = {
"         \ 'relative': 'editor',
"         \ 'row': height * 0.3,
"         \ 'col': col + 30,
"         \ 'width': width * 2 / 3,
"         \ 'height': height / 2
"         \ }
"
"   let buf = nvim_create_buf(v:false, v:true)
"   let win = nvim_open_win(buf, v:true, opts)
"
"   " 设置浮动窗口高亮
"   call setwinvar(win, '&winhl', 'Normal:Pmenu')
"
"   setlocal
"         \ buftype=nofile
"         \ nobuflisted
"         \ bufhidden=hide
"         \ nonumber
"         \ norelativenumber
"         \ signcolumn=no
" endfunction
" }}}
