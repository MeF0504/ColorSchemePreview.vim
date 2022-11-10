" ColorSchemePreview
" Version: 0.0.1
" Author: MeF
" License: MIT

if exists('g:loaded_csp')
  finish
endif
let g:loaded_csp = 1

let s:save_cpo = &cpo
set cpo&vim

command -nargs=? ColorSchemePreview call csp#csp(<f-args>)

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:
