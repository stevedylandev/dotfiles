
let s:base00 = [ '#121113', '233' ] " background
let s:base01 = [ '#121212', '233' ]
let s:base02 = [ '#222222', '235' ]
let s:base03 = [ '#333333', '236' ]
let s:base04 = [ '#999999', '246' ]
let s:base05 = [ '#c1c1c1', '251' ]
let s:base08 = [ '#5f8787', '66'  ] " teal
let s:base0A = [ '#e78a53', '209' ] " orange
let s:base0B = [ '#fbcb97', '223' ] " sand
let s:base0F = [ '#444444', '238' ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left     = [ [ s:base00, s:base0B ], [ s:base05, s:base02 ] ]
let s:p.normal.middle   = [ [ s:base04, s:base01 ] ]
let s:p.normal.right    = [ [ s:base00, s:base04 ], [ s:base05, s:base02 ], [ s:base04, s:base01 ] ]
let s:p.normal.error    = [ [ s:base00, s:base0A ] ]
let s:p.normal.warning  = [ [ s:base00, s:base0B ] ]

let s:p.insert.left     = [ [ s:base00, s:base0A ], [ s:base05, s:base02 ] ]
let s:p.replace.left    = [ [ s:base00, s:base08 ], [ s:base05, s:base02 ] ]
let s:p.visual.left     = [ [ s:base00, s:base05 ], [ s:base05, s:base02 ] ]

let s:p.inactive.left   = [ [ s:base03, s:base00 ], [ s:base03, s:base00 ] ]
let s:p.inactive.middle = [ [ s:base03, s:base00 ] ]
let s:p.inactive.right  = [ [ s:base03, s:base00 ], [ s:base03, s:base00 ] ]

let s:p.tabline.left    = [ [ s:base04, s:base02 ] ]
let s:p.tabline.tabsel  = [ [ s:base00, s:base0A ] ]
let s:p.tabline.middle  = [ [ s:base03, s:base01 ] ]
let s:p.tabline.right   = [ [ s:base00, s:base0F ] ]

let g:lightline#colorscheme#darkmatter#palette = lightline#colorscheme#flatten(s:p)
