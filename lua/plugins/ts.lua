-- TypeScript LSP: vtsls (installed by LazyVim's `lang.typescript` extra via Mason).
-- These settings tune tsserver's behavior for big monorepos.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Keep ts_ls disabled — vtsls replaces it.
        ts_ls = { enabled = false },

        vtsls = {
          settings = {
            -- vtsls passes these through to tsserver. Shape mirrors
            -- the VSCode TypeScript extension settings (since vtsls
            -- is API-compatible with it).
            typescript = {
              tsserver = {
                -- Cap memory so a single tsserver instance can't run
                -- away. 4096 MB is plenty for either half (native or
                -- api) loaded on its own.
                maxTsServerMemory = 4096,
              },
              -- Don't index every package.json across the workspace
              -- for auto-imports. Biggest single cause of tsserver
              -- bloat in monorepos.
              preferences = {
                includePackageJsonAutoImports = "off",
              },
              -- Inlay hints off — re-enable individually if you find
              -- you want them.
              inlayHints = {
                parameterNames = { enabled = "none" },
                parameterTypes = { enabled = false },
                variableTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = false },
                functionLikeReturnTypes = { enabled = false },
                enumMemberValues = { enabled = false },
              },
            },
            -- Same knobs for JS files (vtsls handles both).
            javascript = {
              preferences = {
                includePackageJsonAutoImports = "off",
              },
              inlayHints = {
                parameterNames = { enabled = "none" },
                parameterTypes = { enabled = false },
                variableTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = false },
                functionLikeReturnTypes = { enabled = false },
                enumMemberValues = { enabled = false },
              },
            },
          },
        },
      },
    },
  },

  -- Remove typescript-tools.nvim entirely — vtsls is doing the work.
  -- Leaving both attached doubles tsserver memory and CPU for no benefit.
  { "pmizio/typescript-tools.nvim", enabled = false },
}
