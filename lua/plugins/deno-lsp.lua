-- Explicitly disable Deno LSP to prevent conflicts with TypeScript LSP
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      denols = false, -- Explicitly disable Deno LSP
    },
    setup = {
      denols = function()
        return true -- Skip setup completely
      end,
    },
  },
}