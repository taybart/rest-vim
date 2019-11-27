setlocal commentstring=#%s

"""
" Get a rest option. Use the given default value if option not found.
"
" @param  string a:opt
" @param  mixed  a:defVal
" @return mixed
"
function! s:GetOpt(opt, defVal)
  if exists('b:' . a:opt)
    return eval('b:' . a:opt)
  endif
  if exists('g:' . a:opt)
    return eval('g:' . a:opt)
  endif
  return a:defVal
endfunction

"""
" Do the key map.
"
function! RestMap()
  let triggerKey = s:GetOpt('rest_trigger', '<C-e>')
  execute 'vnoremap <buffer> ' . triggerKey . ' :!rest -nc -f %<CR>'
  execute 'nnoremap <buffer> ' . triggerKey . ' :!rest -nc -f %<CR>'
  execute 'inoremap <buffer> ' . triggerKey . ' <Esc>:!rest -nc -f %<CR>'
endfunction

if s:GetOpt('rest_set_default_mapping', 1)
  call RestMap()
endif
