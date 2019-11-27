if exists('b:current_syntax')
    finish
endif

if !exists('b:rest_schema')
  if exists('g:rest_schema')
    let b:rest_schema = g:rest_schema
  else
    let b:rest_schema = 'core'
  endif
endif

syn keyword restTodo            contained TODO NOTE
hi def link restTodo                     Todo

syn region  restComment         display oneline start='\%\(^\|\s\)#' end='$'
            \                   contains=restTodo
hi def link restComment         Comment


syn region restFlowString matchgroup=restFlowStringDelimiter start='"' skip='\\"' end='"'
            \ contains=restEscape
            \ nextgroup=restKeyValueDelimiter
syn region restFlowString matchgroup=restFlowStringDelimiter start="'" skip="''"  end="'"
            \ contains=restSingleEscape
            \ nextgroup=restKeyValueDelimiter
hi def link restFlowString               String

syn match   restInteger '0\|-\=[1-9][0-9]*'

syn match  restEscape contained '\\\%([\\"abefnrtv\^0_ NLP\n]\|x\x\x\|u\x\{4}\|U\x\{8}\)'
syn match  restSingleEscape contained "''"

syn match restBlockScalarHeader contained '\s\+\zs[|>]\%([+-]\=[1-9]\|[1-9]\=[+-]\)\='


syn cluster restFlow contains=restFlowString,restFlowMapping,restFlowCollection
syn cluster restFlow      add=restFlowMappingKey,restFlowMappingMerge
" syn cluster restFlow      add=@restConstant,restPlainScalar,restFloat
" syn cluster restFlow      add=restTimestamp,Number,restMappingKeyStart
syn cluster restFlow      add=restInteger,restMappingKeyStart
syn cluster restFlow      add=restComment
syn region restFlowMapping    matchgroup=restFlowIndicator start='{' end='}' contains=@restFlow
syn region restFlowCollection matchgroup=restFlowIndicator start='\[' end='\]' contains=@restFlow


syn match restDocumentStart '^---\ze\%(\s\|$\)'
hi def link restDocumentStart            PreProc

" syn match restDocumentEnd   '^\.\.\.\ze\%(\s\|$\)'
" hi def link restDocumentEnd              PreProc

syntax match restHost '\c\v^\s*HTTPS?\://\S+$'
highlight link restHost Label

hi def link restFlowStringDelimiter      String
hi def link restEscape                   SpecialChar
hi def link restSingleEscape             SpecialChar

hi def link restBlockCollectionItemStart Label
hi def link restBlockMappingKey          Identifier
hi def link restBlockMappingMerge        Special

hi def link restFlowMappingKey           Identifier
hi def link restFlowMappingMerge         Special

hi def link restMappingKeyStart          Special
hi def link restFlowIndicator            Special
hi def link restKeyValueDelimiter        Special

hi def link restAnchor                   Type
hi def link restAlias                    Type
hi def link restNodeTag                  Type

hi def link restInteger                  Number
hi def link restFloat                    Float
hi def link restTimestamp                Number


syntax match restKeyword '\c\v^\s*(GET|POST|PUT|DELETE|HEAD|PATCH|OPTIONS|TRACE)\s'
highlight link restKeyword Macro


syn match HeaderType '\v^[a-zA-Z-]+: '
hi HeaderType ctermfg=yellow

syn keyword VariableType set nextgroup=VarName skipwhite
syn match VarName '\i\+' contained
hi VariableType ctermfg=darkgreen
hi VarName ctermfg=darkblue

let b:current_syntax = 'rest'

