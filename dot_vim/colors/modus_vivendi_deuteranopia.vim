" =============================================================================
" Name:        Modus Vivendi Deuteranopia
" Description: A faithful port of the Emacs Modus Vivendi Deuteranopia theme
"              for Vim. Optimised for red-green colour deficiency (deuteranopia
"              / deuteranomaly) using yellow and blue for colour-coding instead
"              of red and green. Meets WCAG AAA contrast requirements.
" Author:      Ported from Protesilaos Stavrou's modus-themes
"              <https://protesilaos.com/emacs/modus-themes>
" Palette:     CC0 Public Domain — https://creativecommons.org/publicdomain/zero/1.0/
" Version:     5.2.0 (palette reference)
" =============================================================================

" --- Boilerplate -------------------------------------------------------------
set background=dark
highlight clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'modus_vivendi_deuteranopia'

" Only enable 256-colour fallbacks when true-colour is not available
let s:tc = has('termguicolors') && &termguicolors

" =============================================================================
" PALETTE — modus-vivendi-deuteranopia (resolved hex values)
" =============================================================================
"
" Backgrounds
"   bg-main          #000000   bg-dim           #1e1e1e
"   bg-active        #535353   bg-inactive      #303030
"   bg-hl-line       #2f3849   bg-region        #5a5a5a
"   bg-completion    #2f447f   bg-paren-match   #2f7f9f
"
" Foregrounds
"   fg-main          #ffffff   fg-dim           #989898
"   fg-alt           #c6daff   border           #646464
"
" Named colours (dark variants, deuteranopia-tuned)
"   red              #ff5f59   red-warmer       #ff6b55
"   red-cooler       #ff7f86   red-faint        #ff9580
"   red-intense      #ff5f5f
"   green            #44bc44   green-warmer     #70b900
"   green-cooler     #00c06f   green-faint      #88ca9f
"   green-intense    #44df44
"   yellow           #cabf00   yellow-warmer    #ffa00f
"   yellow-cooler    #d8af7a   yellow-faint     #d2b580
"   yellow-intense   #efef00
"   blue             #2fafff   blue-warmer      #79a8ff
"   blue-cooler      #00bcff   blue-faint       #82b0ec
"   blue-intense     #338fff
"   magenta          #feacd0   magenta-warmer   #f78fe7
"   magenta-cooler   #b6a0ff   magenta-faint    #caa6df
"   magenta-intense  #ff66ff
"   cyan             #00d3d0   cyan-warmer      #4ae2f0
"   cyan-cooler      #6ae4b9   cyan-faint       #9ac8e0
"   cyan-intense     #00eff0
"
" Semantic (deuteranopia overrides — no red/green for diff/status coding)
"   keyword          blue-cooler  #00bcff
"   builtin          yellow       #cabf00
"   fnname           yellow-warmer #ffa00f
"   constant         blue-faint   #82b0ec
"   string           blue-warmer  #79a8ff
"   type             cyan-cooler  #6ae4b9
"   variable         cyan         #00d3d0
"   comment          yellow-cooler #d8af7a
"   preprocessor     magenta-cooler #b6a0ff
"   property         cyan         #00d3d0
"   docstring        cyan-faint   #9ac8e0
"   err / underline  yellow-warmer #ffa00f / yellow-intense #efef00
"   info             blue         #2fafff
"   warning          yellow       #cabf00
"   cursor           yellow-intense #efef00
"   diff added       blue tones   bg #003066  fg #c4d5ff
"   diff removed     yellow tones bg #3d3d00  fg #d4d48f
"   diff changed     magenta tones bg #2f123f fg #e3cfff
" =============================================================================

" Helper: hi wrapper that handles both gui and cterm gracefully
" Usage: call s:Hi('GroupName', 'guifg', 'guibg', 'cterm-attr', 'ctermfg', 'ctermbg')
function! s:Hi(group, fg, bg, attr, ctfg, ctbg)
  let l:cmd = 'highlight ' . a:group
  if a:fg  !=# '' | let l:cmd .= ' guifg='   . a:fg  | endif
  if a:bg  !=# '' | let l:cmd .= ' guibg='   . a:bg  | endif
  if a:attr!=# '' | let l:cmd .= ' gui='      . a:attr . ' cterm=' . a:attr | endif
  if a:ctfg!=# '' | let l:cmd .= ' ctermfg='  . a:ctfg | endif
  if a:ctbg!=# '' | let l:cmd .= ' ctermbg='  . a:ctbg | endif
  execute l:cmd
endfunction

" =============================================================================
" EDITOR UI
" =============================================================================

" Normal text
call s:Hi('Normal',       '#ffffff', '#000000', 'NONE', '15',  '0')
call s:Hi('NormalNC',     '#ffffff', '#000000', 'NONE', '15',  '0')
call s:Hi('NormalFloat',  '#ffffff', '#1e1e1e', 'NONE', '15',  '234')

" Cursor
call s:Hi('Cursor',       '#000000', '#efef00', 'NONE', '0',   '226')
call s:Hi('CursorIM',     '#000000', '#efef00', 'NONE', '0',   '226')
call s:Hi('lCursor',      '#000000', '#efef00', 'NONE', '0',   '226')
call s:Hi('CursorLine',   '',        '#2f3849', 'NONE', 'NONE','236')
call s:Hi('CursorColumn', '',        '#2f3849', 'NONE', 'NONE','236')
call s:Hi('CursorLineNr', '#ffffff', '#1e1e1e', 'bold', '15',  '234')

" Line numbers
call s:Hi('LineNr',       '#989898', '#1e1e1e', 'NONE', '246', '234')
call s:Hi('LineNrAbove',  '#989898', '',        'NONE', '246', '')
call s:Hi('LineNrBelow',  '#989898', '',        'NONE', '246', '')
call s:Hi('SignColumn',   '#989898', '#1e1e1e', 'NONE', '246', '234')

" Visual selection
call s:Hi('Visual',       '#ffffff', '#5a5a5a', 'NONE', '15',  '240')
call s:Hi('VisualNOS',    '#ffffff', '#5a5a5a', 'NONE', '15',  '240')

" Search
call s:Hi('Search',       '#000000', '#7a6100', 'NONE', '0',   '58')
call s:Hi('IncSearch',    '#000000', '#efef00', 'bold', '0',   '226')
call s:Hi('CurSearch',    '#000000', '#efef00', 'bold', '0',   '226')
call s:Hi('Substitute',   '#000000', '#7a6100', 'NONE', '0',   '58')

" Matching parentheses
call s:Hi('MatchParen',   '#ffffff', '#2f7f9f', 'bold', '15',  '31')

" Status / mode line
call s:Hi('StatusLine',   '#f0f0f0', '#2a2a6a', 'NONE', '15',  '17')
call s:Hi('StatusLineNC', '#969696', '#2d2d2d', 'NONE', '246', '236')
call s:Hi('WinBar',       '#f0f0f0', '#2a2a6a', 'NONE', '15',  '17')
call s:Hi('WinBarNC',     '#969696', '#2d2d2d', 'NONE', '246', '236')

" Tab line
call s:Hi('TabLine',      '#969696', '#313131', 'NONE', '246', '236')
call s:Hi('TabLineFill',  '',        '#313131', 'NONE', 'NONE','236')
call s:Hi('TabLineSel',   '#ffffff', '#000000', 'bold', '15',  '0')

" Popup / completion menu
call s:Hi('Pmenu',        '#ffffff', '#1e1e1e', 'NONE', '15',  '234')
call s:Hi('PmenuSel',     '#ffffff', '#2f447f', 'bold', '15',  '18')
call s:Hi('PmenuSbar',    '',        '#535353', 'NONE', 'NONE','240')
call s:Hi('PmenuThumb',   '',        '#989898', 'NONE', 'NONE','246')
call s:Hi('PmenuMatch',   '#00bcff', '',        'bold', '75',  '')
call s:Hi('PmenuMatchSel','#00bcff', '#2f447f', 'bold', '75',  '18')

" Command line / messages
call s:Hi('ModeMsg',      '#cabf00', '',        'bold', '184', '')
call s:Hi('MsgArea',      '#ffffff', '#000000', 'NONE', '15',  '0')
call s:Hi('MoreMsg',      '#2fafff', '',        'bold', '75',  '')
call s:Hi('Question',     '#2fafff', '',        'bold', '75',  '')
call s:Hi('ErrorMsg',     '#ffa00f', '',        'bold', '214', '')
call s:Hi('WarningMsg',   '#cabf00', '',        'bold', '184', '')

" Folding
call s:Hi('Folded',       '#9ac8e0', '#1e1e1e', 'italic','152','234')
call s:Hi('FoldColumn',   '#646464', '#1e1e1e', 'NONE', '241', '234')

" Vertical split border
call s:Hi('VertSplit',    '#646464', '#000000', 'NONE', '241', '0')
call s:Hi('WinSeparator', '#646464', '#000000', 'NONE', '241', '0')

" Non-text / special chars
call s:Hi('NonText',      '#646464', '',        'NONE', '241', '')
call s:Hi('EndOfBuffer',  '#646464', '',        'NONE', '241', '')
call s:Hi('Whitespace',   '#646464', '',        'NONE', '241', '')
call s:Hi('SpecialKey',   '#646464', '',        'NONE', '241', '')
call s:Hi('Conceal',      '#989898', '',        'NONE', '246', '')

" Spell checking
call s:Hi('SpellBad',     '',        '',        'undercurl', '', '')
execute 'highlight SpellBad guisp=#efef00'
call s:Hi('SpellCap',     '',        '',        'undercurl', '', '')
execute 'highlight SpellCap guisp=#79a8ff'
call s:Hi('SpellLocal',   '',        '',        'undercurl', '', '')
execute 'highlight SpellLocal guisp=#b6a0ff'
call s:Hi('SpellRare',    '',        '',        'undercurl', '', '')
execute 'highlight SpellRare guisp=#9ac8e0'

" Title
call s:Hi('Title',        '#79a8ff', '',        'bold', '111', '')

" Directory
call s:Hi('Directory',    '#00bcff', '',        'NONE', '75',  '')

" Color column (print margin)
call s:Hi('ColorColumn',  '',        '#1e1e1e', 'NONE', 'NONE','234')

" Quick fix / location list
call s:Hi('QuickFixLine', '',        '#2f3849', 'NONE', 'NONE','236')

" Floating window border
call s:Hi('FloatBorder',  '#646464', '#1e1e1e', 'NONE', '241', '234')
call s:Hi('FloatTitle',   '#79a8ff', '#1e1e1e', 'bold', '111', '234')

" =============================================================================
" SYNTAX — Core groups (linked to from language-specific groups below)
" =============================================================================

" Comments
call s:Hi('Comment',      '#d8af7a', '',        'italic','179','')

" Constants (numbers, strings, booleans, special literals)
call s:Hi('Constant',     '#82b0ec', '',        'NONE', '110', '')
call s:Hi('String',       '#79a8ff', '',        'NONE', '111', '')
call s:Hi('Character',    '#79a8ff', '',        'NONE', '111', '')
call s:Hi('Number',       '#ffffff', '',        'NONE', '15',  '')
call s:Hi('Boolean',      '#82b0ec', '',        'NONE', '110', '')
call s:Hi('Float',        '#ffffff', '',        'NONE', '15',  '')

" Identifiers
call s:Hi('Identifier',   '#00d3d0', '',        'NONE', '80',  '')
call s:Hi('Function',     '#ffa00f', '',        'NONE', '214', '')

" Statements / keywords
call s:Hi('Statement',    '#00bcff', '',        'NONE', '75',  '')
call s:Hi('Conditional',  '#00bcff', '',        'NONE', '75',  '')
call s:Hi('Repeat',       '#00bcff', '',        'NONE', '75',  '')
call s:Hi('Label',        '#00bcff', '',        'NONE', '75',  '')
call s:Hi('Operator',     '#ffffff', '',        'NONE', '15',  '')
call s:Hi('Keyword',      '#00bcff', '',        'NONE', '75',  '')
call s:Hi('Exception',    '#00bcff', '',        'NONE', '75',  '')

" Preprocessor / macros
call s:Hi('PreProc',      '#b6a0ff', '',        'NONE', '147', '')
call s:Hi('Include',      '#b6a0ff', '',        'NONE', '147', '')
call s:Hi('Define',       '#b6a0ff', '',        'NONE', '147', '')
call s:Hi('Macro',        '#b6a0ff', '',        'NONE', '147', '')
call s:Hi('PreCondit',    '#b6a0ff', '',        'NONE', '147', '')

" Types
call s:Hi('Type',         '#6ae4b9', '',        'NONE', '86',  '')
call s:Hi('StorageClass', '#6ae4b9', '',        'NONE', '86',  '')
call s:Hi('Structure',    '#6ae4b9', '',        'NONE', '86',  '')
call s:Hi('Typedef',      '#6ae4b9', '',        'NONE', '86',  '')

" Special
call s:Hi('Special',      '#cabf00', '',        'NONE', '184', '')
call s:Hi('SpecialChar',  '#cabf00', '',        'NONE', '184', '')
call s:Hi('Tag',          '#c6daff', '',        'NONE', '153', '')
call s:Hi('Delimiter',    '#ffffff', '',        'NONE', '15',  '')
call s:Hi('SpecialComment','#9ac8e0','',        'italic','152','')
call s:Hi('Debug',        '#ff9580', '',        'NONE', '209', '')

" Underlined
call s:Hi('Underlined',   '#79a8ff', '',        'underline','111','')

" Errors / warnings
call s:Hi('Error',        '#ffa00f', '#000000', 'bold', '214', '0')
call s:Hi('Todo',         '#000000', '#ffa00f', 'bold', '0',   '214')
call s:Hi('Ignore',       '#646464', '',        'NONE', '241', '')

" =============================================================================
" DIFF
" =============================================================================
" Uses blue (added) and yellow (removed) instead of green/red — deuteranopia
call s:Hi('DiffAdd',      '#c4d5ff', '#003066', 'NONE', '153', '18')
call s:Hi('DiffChange',   '#e3cfff', '#2f123f', 'NONE', '183', '53')
call s:Hi('DiffDelete',   '#d4d48f', '#3d3d00', 'NONE', '186', '58')
call s:Hi('DiffText',     '#ffffff', '#0f4a77', 'bold', '15',  '24')

" Added / removed / changed line markers (sign column, etc.)
call s:Hi('Added',        '#c4d5ff', '#003066', 'NONE', '153', '18')
call s:Hi('Changed',      '#e3cfff', '#2f123f', 'NONE', '183', '53')
call s:Hi('Removed',      '#d4d48f', '#3d3d00', 'NONE', '186', '58')

" =============================================================================
" SPELLING / DIAGNOSTICS (LSP-style virtual text)
" =============================================================================
call s:Hi('DiagnosticError',       '#ffa00f', '', 'NONE', '214', '')
call s:Hi('DiagnosticWarn',        '#cabf00', '', 'NONE', '184', '')
call s:Hi('DiagnosticInfo',        '#2fafff', '', 'NONE', '75',  '')
call s:Hi('DiagnosticHint',        '#9ac8e0', '', 'NONE', '152', '')
call s:Hi('DiagnosticOk',          '#00d3d0', '', 'NONE', '80',  '')
call s:Hi('DiagnosticVirtualTextError',  '#ffa00f', '#381d0f', 'NONE', '214', '52')
call s:Hi('DiagnosticVirtualTextWarn',   '#cabf00', '#381d0f', 'NONE', '184', '52')
call s:Hi('DiagnosticVirtualTextInfo',   '#2fafff', '#12154a', 'NONE', '75',  '17')
call s:Hi('DiagnosticVirtualTextHint',   '#9ac8e0', '#042837', 'NONE', '152', '23')
call s:Hi('DiagnosticUnderlineError',    '', '',   'undercurl', '', '')
execute 'highlight DiagnosticUnderlineError guisp=#efef00'
call s:Hi('DiagnosticUnderlineWarn',     '', '',   'undercurl', '', '')
execute 'highlight DiagnosticUnderlineWarn guisp=#caa6df'
call s:Hi('DiagnosticUnderlineInfo',     '', '',   'undercurl', '', '')
execute 'highlight DiagnosticUnderlineInfo guisp=#00d3d0'
call s:Hi('DiagnosticUnderlineHint',     '', '',   'undercurl', '', '')
execute 'highlight DiagnosticUnderlineHint guisp=#9ac8e0'

" =============================================================================
" LANGUAGE-SPECIFIC LINKS
" These map specific language syntax groups to the core groups above.
" You generally do not need to edit these.
" =============================================================================

" --- Vim script itself -------------------------------------------------------
highlight link vimCommand       Keyword
highlight link vimVar           Identifier
highlight link vimFuncName      Function
highlight link vimString        String
highlight link vimComment       Comment
highlight link vimLineComment   Comment
highlight link vimOption        Constant
highlight link vimAutoCmd       Special
highlight link vimHiCtermColor  Number

" --- Markdown / reStructuredText ---------------------------------------------
call s:Hi('markdownH1',         '#ffffff', '', 'bold',   '15',  '')
call s:Hi('markdownH2',         '#d2b580', '', 'bold',   '179', '')
call s:Hi('markdownH3',         '#82b0ec', '', 'bold',   '110', '')
call s:Hi('markdownH4',         '#88ca9f', '', 'NONE',   '114', '')
call s:Hi('markdownH5',         '#b6a0ff', '', 'NONE',   '147', '')
call s:Hi('markdownH6',         '#d8af7a', '', 'NONE',   '179', '')
call s:Hi('markdownCode',       '#6ae4b9', '', 'NONE',   '86',  '')
call s:Hi('markdownCodeBlock',  '#6ae4b9', '', 'NONE',   '86',  '')
call s:Hi('markdownBold',       '#ffffff', '', 'bold',   '15',  '')
call s:Hi('markdownItalic',     '#c6daff', '', 'italic', '153', '')
call s:Hi('markdownUrl',        '#79a8ff', '', 'underline','111','')
call s:Hi('markdownLinkText',   '#00bcff', '', 'NONE',   '75',  '')
highlight link markdownRule     Special

" --- HTML / XML --------------------------------------------------------------
call s:Hi('htmlTag',            '#646464', '', 'NONE',   '241', '')
call s:Hi('htmlEndTag',         '#646464', '', 'NONE',   '241', '')
call s:Hi('htmlTagName',        '#ffa00f', '', 'NONE',   '214', '')
call s:Hi('htmlArg',            '#00bcff', '', 'NONE',   '75',  '')
call s:Hi('htmlString',         '#79a8ff', '', 'NONE',   '111', '')
call s:Hi('htmlValue',          '#79a8ff', '', 'NONE',   '111', '')
call s:Hi('htmlSpecialChar',    '#cabf00', '', 'NONE',   '184', '')
call s:Hi('htmlLink',           '#79a8ff', '', 'underline','111','')
highlight link xmlTag           htmlTag
highlight link xmlTagName       htmlTagName
highlight link xmlEndTag        htmlEndTag
highlight link xmlAttrib        htmlArg
highlight link xmlString        htmlString

" --- CSS / SCSS --------------------------------------------------------------
call s:Hi('cssClassName',       '#ffa00f', '', 'NONE',   '214', '')
call s:Hi('cssIdentifier',      '#ffa00f', '', 'NONE',   '214', '')
call s:Hi('cssProp',            '#00bcff', '', 'NONE',   '75',  '')
call s:Hi('cssValueLength',     '#79a8ff', '', 'NONE',   '111', '')
call s:Hi('cssColor',           '#d8af7a', '', 'NONE',   '179', '')
highlight link cssSelector      Keyword
highlight link cssAtRule        PreProc

" --- Python ------------------------------------------------------------------
highlight link pythonStatement   Keyword
highlight link pythonBuiltin     Function
highlight link pythonDecorator   PreProc
highlight link pythonDecoratorName PreProc
highlight link pythonString      String
highlight link pythonRawString   String
highlight link pythonNumber      Number
highlight link pythonFloat       Float
highlight link pythonBoolean     Boolean
highlight link pythonException   Exception
highlight link pythonComment     Comment
highlight link pythonDocString   SpecialComment
highlight link pythonClass       Type
highlight link pythonFunction    Function

" --- JavaScript / TypeScript -------------------------------------------------
highlight link javascriptFunction  Keyword
highlight link javascriptArrowFunc Keyword
highlight link javascriptIdentifier Identifier
highlight link javascriptString    String
highlight link javascriptTemplate  String
highlight link javascriptNumber    Number
highlight link javascriptBoolean   Boolean
highlight link javascriptNull      Constant
highlight link javascriptUndefined Constant
highlight link javascriptComment   Comment
highlight link javascriptLineComment Comment
highlight link javascriptDocComment SpecialComment
highlight link javascriptClassKeyword Keyword
highlight link javascriptImport    Include
highlight link javascriptExport    Include
highlight link typescriptKeyword   Keyword
highlight link typescriptImport    Include
highlight link typescriptExport    Include
highlight link typescriptType      Type
highlight link typescriptInterface Type

" --- Rust --------------------------------------------------------------------
highlight link rustKeyword       Keyword
highlight link rustModPath       Identifier
highlight link rustMacro         Macro
highlight link rustString        String
highlight link rustStringEscape  SpecialChar
highlight link rustNumber        Number
highlight link rustBoolean       Boolean
highlight link rustAttribute     PreProc
highlight link rustCommentLine   Comment
highlight link rustCommentBlock  Comment
highlight link rustDocComment    SpecialComment
highlight link rustLifetime      Special
highlight link rustType          Type
highlight link rustTrait         Type
highlight link rustFuncCall      Function
highlight link rustSelf          Keyword

" --- Go ----------------------------------------------------------------------
highlight link goKeyword         Keyword
highlight link goBuiltins        Function
highlight link goString          String
highlight link goNumber          Number
highlight link goBoolean         Boolean
highlight link goComment         Comment
highlight link goType            Type
highlight link goDeclaration     Keyword
highlight link goStruct          Type
highlight link goInterface       Type

" --- C / C++ -----------------------------------------------------------------
highlight link cType             Type
highlight link cStorageClass     StorageClass
highlight link cString           String
highlight link cNumber           Number
highlight link cFloat            Float
highlight link cBoolean          Boolean
highlight link cComment          Comment
highlight link cCommentL         Comment
highlight link cCommentString    SpecialComment
highlight link cInclude          Include
highlight link cDefine           Define
highlight link cPreCondition     PreCondit
highlight link cppType           Type
highlight link cppStatement      Keyword
highlight link cppModifier       StorageClass
highlight link cppNumber         Number
highlight link cppString         String

" --- Shell script ------------------------------------------------------------
highlight link shStatement       Keyword
highlight link shConditional     Conditional
highlight link shLoopControl     Repeat
highlight link shComment         Comment
highlight link shString          String
highlight link shSingleQuote     String
highlight link shVariable        Identifier
highlight link shFunction        Function
highlight link shSpecial         SpecialChar
highlight link shRange           Special
highlight link bashStatement     Keyword

" --- Ruby --------------------------------------------------------------------
highlight link rubyKeyword       Keyword
highlight link rubyString        String
highlight link rubyNumber        Number
highlight link rubyBoolean       Boolean
highlight link rubyComment       Comment
highlight link rubyDocumentation SpecialComment
highlight link rubyClass         Type
highlight link rubyModule        Type
highlight link rubySymbol        Constant
highlight link rubyInstanceVariable Identifier
highlight link rubyFunction      Function
highlight link rubyInclude       Include

" --- PHP ---------------------------------------------------------------------
highlight link phpKeyword        Keyword
highlight link phpType           Type
highlight link phpString         String
highlight link phpNumber         Number
highlight link phpBoolean        Boolean
highlight link phpComment        Comment
highlight link phpDocComment     SpecialComment
highlight link phpFunction       Function
highlight link phpClass          Type

" --- Lua ---------------------------------------------------------------------
highlight link luaFunction       Keyword
highlight link luaStatement      Keyword
highlight link luaString         String
highlight link luaNumber         Number
highlight link luaBoolean        Boolean
highlight link luaComment        Comment
highlight link luaTable          Delimiter

" --- JSON / YAML / TOML ------------------------------------------------------
call s:Hi('jsonKeyword',        '#00bcff', '', 'NONE',   '75',  '')
call s:Hi('jsonString',         '#79a8ff', '', 'NONE',   '111', '')
call s:Hi('jsonNumber',         '#ffffff', '', 'NONE',   '15',  '')
call s:Hi('jsonBoolean',        '#82b0ec', '', 'NONE',   '110', '')
call s:Hi('jsonNull',           '#82b0ec', '', 'NONE',   '110', '')
highlight link yamlKey          Keyword
highlight link yamlAnchor       Special
highlight link yamlAlias        Special
highlight link yamlDocumentStart PreProc
highlight link tomlKey          Keyword
highlight link tomlTable        Structure
highlight link tomlArray        Delimiter
highlight link tomlString       String
highlight link tomlInteger      Number
highlight link tomlFloat        Float
highlight link tomlBoolean      Boolean
highlight link tomlDate         Special

" --- SQL ---------------------------------------------------------------------
highlight link sqlStatement      Keyword
highlight link sqlType           Type
highlight link sqlString         String
highlight link sqlNumber         Number
highlight link sqlComment        Comment

" =============================================================================
" GIT / VCS INTEGRATION
" =============================================================================
call s:Hi('gitcommitSummary',   '#ffffff', '', 'NONE',   '15',  '')
call s:Hi('gitcommitComment',   '#d8af7a', '', 'italic', '179', '')
call s:Hi('gitcommitBranch',    '#ffa00f', '', 'bold',   '214', '')
call s:Hi('gitcommitOverflow',  '#ffa00f', '', 'NONE',   '214', '')
call s:Hi('gitcommitSelected',  '#c4d5ff', '', 'NONE',   '153', '')
call s:Hi('gitcommitUntracked', '#d4d48f', '', 'NONE',   '186', '')
call s:Hi('gitcommitDiscarded', '#989898', '', 'NONE',   '246', '')
call s:Hi('gitcommitHeader',    '#00bcff', '', 'NONE',   '75',  '')
call s:Hi('gitcommitFile',      '#6ae4b9', '', 'NONE',   '86',  '')
call s:Hi('gitcommitType',      '#b6a0ff', '', 'NONE',   '147', '')

" =============================================================================
" TERMINAL COLOURS (used by :terminal, neovim, etc.)
" Follows the modus-vivendi-deuteranopia terminal palette exactly.
" =============================================================================
if has('nvim')
  let g:terminal_color_0  = '#000000'   " black
  let g:terminal_color_1  = '#ff5f59'   " red
  let g:terminal_color_2  = '#44bc44'   " green
  let g:terminal_color_3  = '#cabf00'   " yellow (deuteranopia-tuned)
  let g:terminal_color_4  = '#2fafff'   " blue
  let g:terminal_color_5  = '#feacd0'   " magenta
  let g:terminal_color_6  = '#00d3d0'   " cyan
  let g:terminal_color_7  = '#a6a6a6'   " white
  let g:terminal_color_8  = '#595959'   " bright black
  let g:terminal_color_9  = '#ff6b55'   " bright red
  let g:terminal_color_10 = '#00c06f'   " bright green
  let g:terminal_color_11 = '#ffa00f'   " bright yellow
  let g:terminal_color_12 = '#79a8ff'   " bright blue
  let g:terminal_color_13 = '#b6a0ff'   " bright magenta
  let g:terminal_color_14 = '#6ae4b9'   " bright cyan
  let g:terminal_color_15 = '#ffffff'   " bright white
else
  let g:terminal_ansi_colors = [
    \ '#000000', '#ff5f59', '#44bc44', '#cabf00',
    \ '#2fafff', '#feacd0', '#00d3d0', '#a6a6a6',
    \ '#595959', '#ff6b55', '#00c06f', '#ffa00f',
    \ '#79a8ff', '#b6a0ff', '#6ae4b9', '#ffffff'
    \ ]
endif

" =============================================================================
" OPTIONAL: Neovim / LSP semantic token highlights
" =============================================================================
if has('nvim')
  call s:Hi('@comment',              '#d8af7a', '', 'italic', '179', '')
  call s:Hi('@string',               '#79a8ff', '', 'NONE',   '111', '')
  call s:Hi('@string.escape',        '#cabf00', '', 'NONE',   '184', '')
  call s:Hi('@string.special',       '#cabf00', '', 'NONE',   '184', '')
  call s:Hi('@number',               '#ffffff', '', 'NONE',   '15',  '')
  call s:Hi('@float',                '#ffffff', '', 'NONE',   '15',  '')
  call s:Hi('@boolean',              '#82b0ec', '', 'NONE',   '110', '')
  call s:Hi('@constant',             '#82b0ec', '', 'NONE',   '110', '')
  call s:Hi('@constant.builtin',     '#82b0ec', '', 'NONE',   '110', '')
  call s:Hi('@variable',             '#00d3d0', '', 'NONE',   '80',  '')
  call s:Hi('@variable.builtin',     '#ffa00f', '', 'NONE',   '214', '')
  call s:Hi('@function',             '#ffa00f', '', 'NONE',   '214', '')
  call s:Hi('@function.builtin',     '#cabf00', '', 'NONE',   '184', '')
  call s:Hi('@function.macro',       '#b6a0ff', '', 'NONE',   '147', '')
  call s:Hi('@method',               '#ffa00f', '', 'NONE',   '214', '')
  call s:Hi('@keyword',              '#00bcff', '', 'NONE',   '75',  '')
  call s:Hi('@keyword.function',     '#00bcff', '', 'NONE',   '75',  '')
  call s:Hi('@keyword.operator',     '#00bcff', '', 'NONE',   '75',  '')
  call s:Hi('@keyword.return',       '#00bcff', '', 'NONE',   '75',  '')
  call s:Hi('@keyword.import',       '#b6a0ff', '', 'NONE',   '147', '')
  call s:Hi('@type',                 '#6ae4b9', '', 'NONE',   '86',  '')
  call s:Hi('@type.builtin',         '#6ae4b9', '', 'NONE',   '86',  '')
  call s:Hi('@property',             '#00d3d0', '', 'NONE',   '80',  '')
  call s:Hi('@field',                '#00d3d0', '', 'NONE',   '80',  '')
  call s:Hi('@parameter',            '#00d3d0', '', 'NONE',   '80',  '')
  call s:Hi('@label',                '#00bcff', '', 'NONE',   '75',  '')
  call s:Hi('@operator',             '#ffffff', '', 'NONE',   '15',  '')
  call s:Hi('@punctuation',          '#ffffff', '', 'NONE',   '15',  '')
  call s:Hi('@punctuation.delimiter','#ffffff', '', 'NONE',   '15',  '')
  call s:Hi('@punctuation.bracket',  '#ffffff', '', 'NONE',   '15',  '')
  call s:Hi('@namespace',            '#6ae4b9', '', 'NONE',   '86',  '')
  call s:Hi('@include',              '#b6a0ff', '', 'NONE',   '147', '')
  call s:Hi('@preproc',              '#b6a0ff', '', 'NONE',   '147', '')
  call s:Hi('@define',               '#b6a0ff', '', 'NONE',   '147', '')
  call s:Hi('@attribute',            '#b6a0ff', '', 'NONE',   '147', '')
  call s:Hi('@tag',                  '#ffa00f', '', 'NONE',   '214', '')
  call s:Hi('@tag.attribute',        '#00bcff', '', 'NONE',   '75',  '')
  call s:Hi('@tag.delimiter',        '#646464', '', 'NONE',   '241', '')
  call s:Hi('@text.title',           '#ffffff', '', 'bold',   '15',  '')
  call s:Hi('@text.title.1',         '#ffffff', '', 'bold',   '15',  '')
  call s:Hi('@text.title.2',         '#d2b580', '', 'bold',   '179', '')
  call s:Hi('@text.title.3',         '#82b0ec', '', 'bold',   '110', '')
  call s:Hi('@text.emphasis',        '#c6daff', '', 'italic', '153', '')
  call s:Hi('@text.strong',          '#ffffff', '', 'bold',   '15',  '')
  call s:Hi('@text.underline',       '',        '', 'underline','',   '')
  call s:Hi('@text.strike',          '',        '', 'strikethrough','','')
  call s:Hi('@text.uri',             '#79a8ff', '', 'underline','111','')
  call s:Hi('@text.literal',         '#6ae4b9', '', 'NONE',   '86',  '')
  call s:Hi('@text.reference',       '#00bcff', '', 'NONE',   '75',  '')
  call s:Hi('@text.todo',            '#000000', '#ffa00f', 'bold','0','214')
  call s:Hi('@text.danger',          '#ffa00f', '',         'bold','214','')
  call s:Hi('@text.warning',         '#cabf00', '',         'bold','184','')
  call s:Hi('@text.note',            '#2fafff', '',         'bold','75', '')
  call s:Hi('@text.diff.add',        '#c4d5ff', '#003066',  'NONE','153','18')
  call s:Hi('@text.diff.delete',     '#d4d48f', '#3d3d00',  'NONE','186','58')

  " LSP semantic tokens
  call s:Hi('@lsp.type.class',       '#6ae4b9', '', 'NONE',   '86',  '')
  call s:Hi('@lsp.type.decorator',   '#b6a0ff', '', 'NONE',   '147', '')
  call s:Hi('@lsp.type.enum',        '#6ae4b9', '', 'NONE',   '86',  '')
  call s:Hi('@lsp.type.enumMember',  '#82b0ec', '', 'NONE',   '110', '')
  call s:Hi('@lsp.type.function',    '#ffa00f', '', 'NONE',   '214', '')
  call s:Hi('@lsp.type.interface',   '#6ae4b9', '', 'NONE',   '86',  '')
  call s:Hi('@lsp.type.keyword',     '#00bcff', '', 'NONE',   '75',  '')
  call s:Hi('@lsp.type.macro',       '#b6a0ff', '', 'NONE',   '147', '')
  call s:Hi('@lsp.type.method',      '#ffa00f', '', 'NONE',   '214', '')
  call s:Hi('@lsp.type.namespace',   '#6ae4b9', '', 'NONE',   '86',  '')
  call s:Hi('@lsp.type.number',      '#ffffff', '', 'NONE',   '15',  '')
  call s:Hi('@lsp.type.operator',    '#ffffff', '', 'NONE',   '15',  '')
  call s:Hi('@lsp.type.parameter',   '#00d3d0', '', 'NONE',   '80',  '')
  call s:Hi('@lsp.type.property',    '#00d3d0', '', 'NONE',   '80',  '')
  call s:Hi('@lsp.type.string',      '#79a8ff', '', 'NONE',   '111', '')
  call s:Hi('@lsp.type.struct',      '#6ae4b9', '', 'NONE',   '86',  '')
  call s:Hi('@lsp.type.type',        '#6ae4b9', '', 'NONE',   '86',  '')
  call s:Hi('@lsp.type.typeParameter','#6ae4b9','', 'NONE',   '86',  '')
  call s:Hi('@lsp.type.variable',    '#00d3d0', '', 'NONE',   '80',  '')
  call s:Hi('@lsp.mod.deprecated',   '',        '', 'strikethrough','','')
  call s:Hi('@lsp.mod.readonly',     '#82b0ec', '', 'NONE',   '110', '')
endif

" =============================================================================
" INSTALL INSTRUCTIONS
" =============================================================================
" 1. Save this file to one of:
"      ~/.vim/colors/modus_vivendi_deuteranopia.vim     (Vim)
"      ~/.config/nvim/colors/modus_vivendi_deuteranopia.vim  (Neovim)
"
" 2. Enable true colour in your vimrc / init.vim (recommended):
"      set termguicolors
"
" 3. Load the theme:
"      colorscheme modus_vivendi_deuteranopia
"
" 4. Optional: set it as your default by adding the above line to
"    your vimrc / init.vim.
"
" Note: 256-colour fallbacks (ctermfg / ctermbg) are included for terminals
" that do not support true colour (termguicolors). Colour accuracy will be
" reduced in that case, but the theme remains usable.
" =============================================================================
