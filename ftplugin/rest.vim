setlocal commentstring=#%s

"""
" Do the key map.
"
function! VrcMap()
  let triggerKey = s:GetOpt('rest_trigger', '<C-j>')
  execute 'vnoremap <buffer> ' . triggerKey . ' :!rest -f %s<CR>'
  execute 'nnoremap <buffer> ' . triggerKey . ' :!rest -f %s<CR>'
  execute 'inoremap <buffer> ' . triggerKey . ' <Esc>:!rest -f %s<CR>'
endfunction
