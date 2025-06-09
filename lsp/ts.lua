return {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "typescript",
    "typescriptreact",
    "javascript",
    "javascriptreact",
  },
  root_markers = {
    "package.json",
    "tsconfig.json",
    "jsconfig.json",
    ".git",
  },
  -- Force full document sync to avoid Neovim 0.11 change tracking bugs
  capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
    textDocument = {
      synchronization = {
        change = vim.lsp.protocol.TextDocumentSyncKind.Full,
      },
    },
  }),
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "literals",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = false, -- Often too long
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
      preferences = {
        includePackageJsonAutoImports = "auto",
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "literals",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = false, -- Often too long
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
      preferences = {
        includePackageJsonAutoImports = "auto",
      },
    },
  },
  -- Custom handlers to fix TypeScript server bugs and truncate hints
  handlers = {
    ["textDocument/inlayHint"] = function(err, hints, ctx, config)
      if err then
        return
      end

      -- Truncate hints that are too long
      for _, hint in ipairs(hints or {}) do
        if hint.label and type(hint.label) == "string" then
          if #hint.label > 25 then
            hint.label = hint.label:sub(1, 22) .. "..."
          end
        elseif hint.label and type(hint.label) == "table" then
          -- Handle complex label structures
          for _, part in ipairs(hint.label) do
            if part.value and #part.value > 25 then
              part.value = part.value:sub(1, 22) .. "..."
            end
          end
        end
      end

      vim.lsp.handlers["textDocument/inlayHint"](err, hints, ctx, config)
    end,

    -- Disable document highlight to prevent TypeScript server crashes
    ["textDocument/documentHighlight"] = function(err, result, ctx, config)
      -- Silently ignore document highlight errors
      if err then
        return
      end
      vim.lsp.handlers["textDocument/documentHighlight"](
        err,
        result,
        ctx,
        config
      )
    end,
  },
}

