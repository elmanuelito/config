" Vim syntax file
" Language:	Typical input file for FAST
" Maintainer:	E. Branlard
" Last Change:	Sept 2018
" Installation: 
"  - Put this file in the syntax folder (e.g. ~/.vim/syntax) 
"  - Put the following lines in a file called custom.vim in
"   the folder ftdetect (e.g. ~/.vim/ftdetect/custom.vim)
"
"   au! BufNewFile,BufRead *.fst setf fast
"   au! BufNewFile,BufRead *.fstf setf fast
"   au! BufNewFile,BufRead *.ffsf setf fast
"   au! BufNewFile,BufRead *.fmas setf fast
"   au! BufNewFile,BufRead *.dvr setf fast
"   au! BufNewFile,BufRead *.dat setf fast
"   au! BufNewFile,BufRead *.inp setf fast
"   au! BufNewFile,BufRead *.sum setf fast
"
" URL: https://github.com/ebranlard/config/dotfiles/vim/syntax

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case match

"Todos keywords
syn keyword fastTodo TODO Todo todo FIXME FixMe XXX NOTE Note HACK Hack hack
"Author !XXXXX
syn match fastAUTHOR "\v![a-zA-Z]+"
"Keywords
syn keyword fastKeyword True False true false TRUE FALSE FATAL default END 
syn match fastKeyword  "^[a-zA-Z].*:"
" Preproc (NOT USED YET)
syn match   fastPreproc	"^#.*"  contains=fastTodo
" Comment
syn match   fastComment	"^--.*" contains=fastTodo
syn match   fastComment	"^==.*"  contains=fastTodo
syn match   fastComment	"^![\ \.].*"  contains=fastTodo
" Units
syn region fastUnit start='(' end=')' contains=fastTodo
" Replace
syn region fastReplace start='{' end='}'  contains=fastTodo
" String
syn match  fastString	"\"[a-zA-Z0-9\-\/\_\.]*\""
" Regular int like number with - + or nothing in front
syn match fastNumber '\d\+' 
" Regular int like number with - + or nothing in front
syn match fastNumber '[-+]\d\+' 
" Floating point number with decimal no E or e (+,-)
syn match fastNumber '[-+]\d\+\.\d*' 
" Floating point like number with E and no decimal point (+,-)
syn match fastNumber '[-+\ ]\=\d[[:digit:]]*[eE][\-+]\=\d\+'
" Floating point like number with E and decimal point (+,-)
syn match fastNumber '[-+\ ]\=\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_fast_syntax_inits")
  if version < 508
    let did_fast_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink fastKeyword Keyword
  HiLink fastPreproc Preproc
  HiLink fastComment Comment
  HiLink fastUnit Comment
  HiLink fastReplace  Constant
  HiLink fastString  String
  HiLink fastTodo    Todo
  HiLink fastAUTHOR    Todo
  HiLink fastNumber    Number

  delcommand HiLink
endif
let b:current_syntax = "fast"
