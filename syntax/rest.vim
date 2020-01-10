if exists('b:current_syntax')
    finish
endif


syn region restFlowString matchgroup=restFlowStringDelimiter start='"' skip='\\"' end='"'
            \ contains=restEscape
            \ nextgroup=restKeyValueDelimiter
syn region restFlowString matchgroup=restFlowStringDelimiter start="'" skip="''"  end="'"
            \ contains=restSingleEscape
            \ nextgroup=restKeyValueDelimiter


syn match restFlowInteger '0\|-\=[1-9][0-9]*' contained

syn cluster restFlow contains=restFlowString,restFlowMapping,restFlowCollection
syn cluster restFlow      add=restFlowMappingKey,restFlowMappingMerge
syn cluster restFlow      add=restFlowInteger,restMappingKeyStart
syn cluster restFlow      add=restComment
syn region restFlowMapping    matchgroup=restFlowIndicator start='{' end='}' contains=@restFlow
syn region restFlowCollection matchgroup=restFlowIndicator start='\[' end='\]' contains=@restFlow
hi def link restFlowStringDelimiter      String
hi def link restFlowString               String
hi def link restFlowMappingKey           Identifier
hi def link restFlowMappingMerge         Special
hi def link restFlowIndicator            Special
hi def link restFlowInteger              Number
syn region  restComment         display oneline start='\%\(^\|\s\)#' end='$'

syn match restDocumentStart '^---\ze\%(\s\|$\)'
syn match restHost '\c\v^\s*HTTPS?\://\S+$'

syn keyword restKeywords
      \ expect
      \ label
      \ skip

syntax match restMethod '\c\v^\s*(GET|POST|PUT|DELETE|HEAD|PATCH|OPTIONS|TRACE)\s'

syn match restHeader '\v^[a-zA-Z-]+: '

syn keyword variableKeyword set nextgroup=variableName skipwhite
syn match variableName '\i\+' contained

" For later when we need syntax highlighting in strings for variables
" syntax region  jsTemplateString   start=+`+  skip=+\\`+  end=+`+     contains=jsTemplateExpression,jsSpecial,@Spell extend
" syntax region  jsTemplateExpression contained matchgroup=jsTemplateBraces start=+${+ end=+}+ contains=@jsExpression keepend
syn match restVariable '\v\$\{[a-zA-Z0-9-]+\}'

syn keyword delayKeyword delay nextgroup=delayValue skipwhite
syn match delayValue '\d\+\(ns\|us\|µs\|ms\|s\|m\|h\)' contained


hi def link restComment                  Comment

hi def link restKeywords                 Keyword

hi def link restHost                     Underlined
hi def link restHeader                   Type
hi def link restDocumentStart            PreProc

hi def link variableKeyword              Typedef
hi def link variableName                 Identifier
hi def link restVariable                 Identifier

hi def link delayKeyword                 Typedef
hi def link delayValue                   Identifier

hi def link restEscape                   SpecialChar
hi def link restSingleEscape             SpecialChar

hi def link restBlockCollectionItemStart Label
hi def link restBlockMappingKey          Identifier
hi def link restBlockMappingMerge        Special

hi def link restMethod                   Macro





let b:current_syntax = 'rest'

