-- Simple LSP setup using lspconfig
local lspconfig = require('lspconfig')

-- Setup TypeScript language server
lspconfig.ts_ls.setup({
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "typescript",
    "typescriptreact", 
    "javascript",
    "javascriptreact",
  },
  root_dir = function(fname)
    local util = require("lspconfig.util")
    return util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")(fname)
  end,
})
