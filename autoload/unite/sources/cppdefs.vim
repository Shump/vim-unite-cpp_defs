

let s:save_cpo = &cpo
set cpo&vim

let s:script_folder = expand("<sfile>:p:h:h:h:h")
let s:bin_folder = s:script_folder . "/bin/"

let s:unite_source = {
  \ 'name': 'cpp_defs',
  \ 'description': 'Lists definitions in current c++ file.',
  \ }

function! s:generate_cantidate(word, line)
  let path = expand('%:p')
  return {
        \ 'word': a:word,
        \ 'source': 'cpp_defs',
        \ 'kind': 'jump_list',
        \ 'action__path': path,
        \ 'action__line': a:line,
        \}
endfunction

function! s:parse_line(line)
  let splitted = split(a:line)
  let node_type = splitted[0]
  let location = splitted[1]
  let line_nr = str2nr(split(location, ":")[1])
  return s:generate_cantidate(node_type, line_nr)
endfunction

function! s:unite_source.gather_candidates(args, context)
  let path = expand('%:p')
  let result = split(system(s:bin_folder . 'run_clang-query.sh ' . path), '\n')
  return [ s:parse_line(result[0]), s:parse_line(result[1]) ]
endfunction

"call unite#define_source(s:unite_source)
"unlet s:unite_source

function! unite#sources#cppdefs#define()
  return s:unite_source
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo


