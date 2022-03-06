"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Important:
"       This requires that you install https://github.com/amix/vimrc !
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" => Load pathogen paths
""""""""""""""""""""""""""""""
let s:vim_runtime = expand('<sfile>:p:h')."/.."
call pathogen#infect(s:vim_runtime.'/sources_forked/{}')
call pathogen#infect(s:vim_runtime.'/sources_non_forked/{}')
call pathogen#infect(s:vim_runtime.'/my_plugins/{}')
call pathogen#helptags()


""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>
map <leader>nf :NERDTreeMirror<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => surround.vim config
" Annotate strings with gettext 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \}

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'relativepath', 'modified'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*Fugitive#head")?Fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*Fugitive#head") && ""!=Fugitive#head())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntastic (syntax checker)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python
let g:syntastic_python_checkers=['pyflakes']

" Javascript
let g:syntastic_javascript_checkers=['jshint']

" Go
let g:syntastic_auto_loc_list = 1
let g:syntastic_go_checkers=['go', 'golint', 'errcheck']

" C/C++
let g:syntastic_c_checkers=[]
let g:syntastic_cpp_checkers=[]

" Custom CoffeeScript SyntasticCheck
func! SyntasticCheckCoffeescript()
  let l:filename = substitute(expand("%:p"), '\(\w\+\)\.coffee', '.coffee.\1.js', '')
  execute "tabedit " . l:filename
  execute "SyntasticCheck"
  execute "Errors"
endfunc
nnoremap <silent> <leader>c :call SyntasticCheckCoffeescript()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git gutter (Git diff)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_enabled=0
nnoremap <silent> <leader>d :GitGutterToggle<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tag list (ctags)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
"let Tlist_Show_One_File = 1         " 不同时显示多个文件的tag，只显示当前文件的
"let Tlist_Exit_OnlyWindow = 1       " 如果taglist窗口是最后一个窗口，则推出vim
"let Tlist_Use_Right_Window = 0      " 在右侧窗口中显示taglist窗口
"let Tlist_Auto_Open = 1
"set tags=tags;
"set g:tagbar_ctags_bin = '/usr/local/bin/ctags'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-glaive: maktaba配置管理工具
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call glaive#Install()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-codefmt: 代码格式化工具
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup autoformat_settings
  "autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  "autocmd FileType dart AutoFormatBuffer dartfmt
  "autocmd FileType go AutoFormatBuffer gofmt
  "autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  "autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  "autocmd FileType vue AutoFormatBuffer prettier
augroup END
" 使用google风格来格式化c/c++代码
Glaive codefmt clang_format_style='google'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ultisnips: 代码块生成工具 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("python")
  let g:UltiSnipsUsePythonVersion = 2
elseif has("python3")
  let g:UltiSnipsUsePythonVersion = 3
else
  echom "Vim is not compiled with python"
endif
let g:snips_author='machaowei'
let g:snips_email='859040734@qq.com'
let g:snips_group='machaowei'
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim_runtime/my_plugins/snippets_config']
let g:ultisnips_python_style='google'

let g:UltiSnipsExpandTrigger="<C-o>"    " 触发键
let g:UltiSnipsJumpForwardTrigger="<C-b>"

" 自动插入文件注释
function GenDocsSnip()
  if count(['c','cpp','python'], &filetype)
    execute "normal idocs "
    execute "normal a"
    call UltiSnips#ExpandSnippet()
  endif
endfunction
autocmd BufNewFile * :call GenDocsSnip()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YouCompleteMe: 代码补全 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_autoclose_preview_window_after_completion = 1
let g:syntastic_python_checkers = ['python3']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => restore_view: 光标位置和折叠信息自动保存
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set viewoptions=cursor,folds,slash,unix
set viewdir=~/.vim_runtime/temp_dirs/viewdir
