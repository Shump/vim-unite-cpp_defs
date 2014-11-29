

let s:save_cpo = &cpo
set cpo&vim

let s:unite_source = {
  \ 'name': 'cpp_defs',
  \ 'description': 'Lists definitions in current c++ file.',
  \ }

function! s:generate_cantidate(word, line)
  let path = expand('%:p')
  return {
        \ 'word': word . ': ' . path,
        \ 'source': 'cpp_defs',
        \ 'kind': 'jump_list',
        \ 'action__path': path,
        \ 'action__line': line,
        \}
endfunction


function! s:unite_source.gather_candidates(args, context)
  return [ s:generate_cantidate('one', 1) ]
endfunction

call unite#define_source(s:unite_source)
unlet s:unite_source

let &cpo = s:save_cpo
unlet s:save_cpo


