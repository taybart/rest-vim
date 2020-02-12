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

function! ExecuteBlock()
  let s:c = []
  call map(getline(1, "."), { k,v -> substitute(v, '^---$', '\=add(s:c, v)[-1]', 'g')})
  execute '!rest -nc -b ' . len(s:c) . ' -f %'
endfunction
"""
" Do the key map.
"
function! RestMap()
  let triggerKey = s:GetOpt('rest_trigger', '<c-w>')
  exe 'nnoremap <buffer> ' . triggerKey . ' :!rest -nc -f %<CR>'
  exe 'vnoremap <buffer> ' . triggerKey . ' :!rest -nc -f %<CR>'
  exe 'inoremap <buffer> ' . triggerKey . ' <Esc>:!rest -nc -f %<CR>'

  let triggerBlockKey = s:GetOpt('rest_block_trigger', '<c-e>')
  exe 'nnoremap <buffer> ' . triggerBlockKey . ' :call ExecuteBlock()<CR>'
  exe 'vnoremap <buffer> ' . triggerBlockKey . ' :call ExecuteBlock()<CR>'
  exe 'inoremap <buffer> ' . triggerBlockKey . ' <Esc>:call ExecuteBlock()<CR>'

endfunction

if s:GetOpt('rest_set_default_mapping', 1)
  call RestMap()
endif

