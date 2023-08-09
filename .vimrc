syntax on

"autocmd filetype cpp nnoremap <F4> :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR> :split out.txt  -> this worked for me! But I needed it to run the make command

"autocmd filetype cpp nnoremap <F4> :w <bar> exec '!make -B f= '.shellescape('%').' && ./'.shellescape('run')<CR> :split out.txt -> so I tried to modify the command but I failed in it!!


" Finally this link helped me: https://vi.stackexchange.com/questions/39995/how-can-i-create-mappings-to-execute-specific-vim-commands-depending-on-if-a-ma   and the function below has been copied from this link

func! MakeOrGcc()
	:write
	" check in the current working directory 
	
	if filereadable('Makefile')
		:!make -B f=%
	else
		:!g++ % -o %< && ./&<
	endif

endfunc

func! Executable()
	:write
	" check in the current working directory

	if filereadable('run') " if the 'run' file exists
		:!./run
		:split out.txt
		:vsplit errors.txt
		:!make clean
	else
		:split errors.txt

	endif
endfunc

"the below keymaps work perfectly!!

"nnoremap <C-c> :call MakeOrGcc()<CR> :!./run<CR> :split out.txt<CR> :vsplit errors.txt<CR>

"---These two are important for running C++ programs---
"nnoremap <C-c> :call MakeOrGcc()<CR> :call Executable()<CR><CR><CR><CR><CR>
"nnoremap <F4> :Ex<CR>



"colorscheme noir2

filetype indent on


"set nocompatible  "set compatibility with vi
set number

set relativenumber


"set guifont=Ac437\ ATI\ 8x8\ 13   " this font must exist first
set guicursor=i:hor20,a:blinkwait50-blinkoff50-blinkon50 " this is by default applied to gvim

set autoindent

" Show the status bar

"set laststatus=2

"Wrap text

set wrap

"Call the .vimrc.plug file

"if filereadable(expand("~/.vimrc.plug"))
	"source ~/.vimrc.plug
"endif

"cursor shape control options while using vim in terminal

"let &t_SI = "\<esc>[3 q"  " blinking underline in insert mode
"let &t_SR = "\<esc>[ q"  " default cursor(blinking block) in replace mode
"let &t_EI = "\<esc>[ q"  " block cursor in normal mode

"let &t_EI = "\<esc>[5 q"  " blinking I-beam cursor (usually blinking) in normal mode

if has('gui_running')
	"Use this colorscheme when using gvim
	"set guifont=Terminus\(\TTF\)\ Bold\ 22
	"set guifont=Input\ Mono\ Regular\ 18
	set guifont=JetBrains\ Mono\ Regular\ 18
	colo codeForces
	set laststatus=2

	"This mapping is for the keybinding used to paste something which was copied via mouse...
	"...this operation can be performed using the command: CTRL+SHIFT+V in vi/vim in terminal
	nnoremap <C-B> "+gp
	nnoremap <C-Tab> :call MakeOrGcc()<CR> :call Executable()<CR><CR><CR><CR><CR>
	nnoremap <F3> :Ex<CR>
else
	"if gui is not running
	colo abstract
	nnoremap <C-c> :call MakeOrGcc()<CR> :call Executable()<CR><CR><CR><CR><CR>
	nnoremap <F4> :Ex<CR>

	" the character used in listchars is a unicode character
	set listchars=tab:\│\ 
	set list

endif
