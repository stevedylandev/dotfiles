" Enable diagnostics highlighting
let lspOpts = #{autoHighlightDiags: v:true}
autocmd User LspSetup call LspOptionsSet(lspOpts)
let lspServers = [
      \ #{
      \   name: 'rust-analyzer',
      \   filetype: ['rust'],
      \   path: 'rust-analyzer',
      \   args: []
      \ },
      \ #{
      \   name: 'lua-language-server',
      \   filetype: ['lua'],
      \   path: 'lua-language-server',
      \   args: [],
      \   rootSearch: ['.luarc.json', '.luarc.jsonc', '.luacheckrc',
      \                'stylua.toml', '.stylua.toml', 'selene.toml',
      \                'selene.yml', '.git'],
      \   workspaceConfig: #{
      \     Lua: #{
      \       diagnostics: #{ globals: ['vim'] }
      \     }
      \   }
      \ },
      \ #{
      \   name: 'tsserver',
      \   filetype: ['typescript', 'typescriptreact', 'typescript.tsx',
      \               'javascript', 'javascriptreact', 'javascript.jsx'],
      \   path: 'vtsls',
      \   args: ['--stdio'],
      \   rootSearch: ['tsconfig.json', 'jsconfig.json', 'package.json', '.git']
      \ },
      \ #{
      \   name: 'gopls',
      \   filetype: ['go', 'gomod', 'gowork',
      \               'gotmpl', 'gosum'],
      \   path: 'gopls',
      \   args: [],
      \   rootSearch: ['go.mod', 'go.work', '.git']
      \ },
      \ #{
      \   name: 'html',
      \   filetype: ['html'],
      \   path: 'vscode-html-language-server',
      \   args: ['--stdio'],
      \   rootSearch: ['index.html', 'package.json', '.git']
      \ },
      \ #{
      \   name: 'astro',
      \   filetype: ['astro'],
      \   path: 'astro-ls',
      \   args: ['--stdio'],
      \   rootSearch: ['package.json', 'tsconfig.json', 'jsconfig.json', '.git'],
      \   initializationOptions: #{
      \     typescript: #{
      \       tsdk: expand('~/.bun/install/global/node_modules/typescript/lib')
      \     }
      \   }
      \ }
      \ ]

autocmd User LspSetup call LspAddServer(lspServers)

" Key mappings
nnoremap gd :LspGotoDefinition<CR>
nnoremap gr :LspShowReferences<CR>
nnoremap K  :LspHover<CR>
nnoremap gl :LspDiag current<CR>
nnoremap <leader>nd :LspDiag next \| LspDiag current<CR>
nnoremap <leader>pd :LspDiag prev \| LspDiag current<CR>
inoremap <silent> <C-Space> <C-x><C-o>

" Set omnifunc for completion
autocmd FileType rust setlocal omnifunc=lsp#complete

" Custom diagnostic sign characters
autocmd User LspSetup call LspOptionsSet(#{
    \   diagSignErrorText: '✘',
    \   diagSignWarningText: '▲',
    \   diagSignInfoText: '»',
    \   diagSignHintText: '⚑',
    \ })
