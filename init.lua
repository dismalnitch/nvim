-- bootstrap lazy.nvim, LazyVim and your plugins

require("config.lazy")
require("config.autocmds")

-- require("plugins.surround")
require("catppuccin")
-- require("coc.nvim")
-- require("plugins.dashboard")
--
--
--

local nvim_lsp = require("lspconfig")

-- Example for configuring the tsserver (TypeScript) LSP
nvim_lsp.tsserver.setup({
  on_attach = function(client, bufnr)
    -- Custom handler to filter out specific diagnostics
    client.handlers["textDocument/inlayHint"] = function(_, result, ctx, config)
      local diagnostics = result.diagnostics
      local filtered_diagnostics = {}

      for _, diagnostic in ipairs(diagnostics) do
        -- Filter out diagnostics with specific codes or messages
        if
          diagnostic.code ~= "-32603"
          and not diagnostic.message:match("<semantic> (.+)")
        then
          table.insert(filtered_diagnostics, diagnostic)
        end
      end

      result.diagnostics = filtered_diagnostics
      vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
    end
  end,
  flags = {
    debounce_text_changes = 150,
  },
})

vim.api.nvim_set_var("coc_user_config", {
  ["coc.preferences.snippets.enable"] = true,
  ["coc.preferences.snippets.extends"] = { "ts", "javascript" },
  ["coc.preferences.snippets.autoTrigger"] = "always",
  ["coc.preferences.formatOnType"] = true,
  ["coc.preferences.formatOnSaveFiletypes"] = { "typescript", "javascript" },
  ["coc.preferences.autoImportOnCompletion"] = true,
  ["coc.preferences.autoTrigger"] = "always",
  ["coc.preferences.useQuickfixForLocations"] = true,
  ["coc.preferences.jumpCommand"] = "drop",
  ["coc.preferences.colorSupport"] = true,
  ["coc.preferences.enableHoverHighlight"] = true,
  ["coc.preferences.enableInvisibleCharacters"] = true,
  ["coc.preferences.enableMessageTooltip"] = true,
  ["coc.preferences.enableSemanticHighlight"] = true,
  ["coc.preferences.enableSign"] = true,
  ["coc.preferences.errorSign"] = "✖",
  ["coc.preferences.hintSign"] = "➤",
  ["coc.preferences.infoSign"] = "ℹ",
  ["coc.preferences.warningSign"] = "⚠",
  ["coc.preferences.maxCompleteItemCount"] = 10,
  ["coc.preferences.maxCompleteItemLength"] = 30,
  ["coc.preferences.maxDiagnosticErrorBufferSize"] = 5000,
  ["coc.preferences.maxDiagnosticWarningBufferSize"] = 5000,
  ["coc.preferences.maxFrequentBufferSize"] = 5000,
  ["coc.preferences.maxJumpHistory"] = 100,
  ["coc.preferences.maxOutputBufferSize"] = 5000,
  ["coc.preferences.maxPreviewBufferSize"] = 5000,
  ["coc.preferences.maxSignatureHelpWidth"] = 80,
  ["coc.preferences.noSelect"] = false,
  ["coc.preferences.previewMaxHeight"] = 12,
  ["coc.preferences.previewMaxWidth"] = 80,
  ["coc.preferences.quickSuggestionsDelay"] = 10,
  ["coc.preferences.rootPatterns"] = { ".git", "package.json" },
  ["coc.preferences.scrollback"] = 5000,
  ["coc.preferences.semanticTokensHighlights"] = true,
  ["coc.preferences.showHiddenDiagnostics"] = false,
  ["coc.preferences.showUnresolvedSymbols"] = true,
  ["coc.preferences.snippetIndicator"] = "✂",
  ["coc.preferences.suggest.floatEnable"] = true,
  ["coc.preferences.suggest.maxPreviewWidth"] = 50,
  ["coc.preferences.suggest.noselect"] = false,
  ["coc.preferences.suggest.snippetIndicator"] = "✂",
  ["coc.preferences.suggest.statusItemKindMaxLength"] = 20,
  ["coc.preferences.suggest.statusItemMaxLength"] = 100,
  ["coc.preferences.suggest.timeout"] = 500,
  ["coc.preferences.suggest.triggerCompletionWait"] = 100,
  ["coc.preferences.suggest.triggerKindMinimumLength"] = 2,
  ["coc.preferences.suggestActionsMenu"] = true,
  ["coc.preferences.suggestCompletionItemKindLabels"] = {
    ["keyword"] = "⚡",
    ["variable"] = "🔮",
    ["value"] = "🔖",
    ["class"] = "📦",
    ["type"] = "📚",
    ["snippet"] = "✂",
    ["color"] = "🌈",
    ["file"] = "📂",
    ["reference"] = "🔗",
    ["folder"] = "📁",
    ["enumMember"] = "📝",
    ["constant"] = "📏",
    ["struct"] = "🏗️",
    ["event"] = "🎈",
    ["operator"] = "➕",
    ["typeParameter"] = "🎁",
  },
  ["coc.preferences.suggestDetailMaxLength"] = 50,
  ["coc.preferences.suggestInsertMode"] = "replace",
  ["coc.preferences.suggestLineWrapLength"] = 80,
  ["coc.preferences.suggestMaxVisibleItemCount"] = 10,
  ["coc.preferences.suggestRemoveInsertSpace"] = true,
  ["coc.preferences.suggestSelection"] = "always",
  ["coc.preferences.suggestSortChanges"] = false,
  ["coc.preferences.suggestTriggerCharacters"] = {
    ".",
    '"',
    "'",
    "`",
    "/",
    "@",
    "<",
    "#",
    "$",
    "(",
    "[",
    "{",
  },
  ["coc.preferences.tabNine.enable"] = false,
  ["coc.preferences.tsserver.enableJavascript"] = true,
  ["coc.preferences.tsserver.npm"] = "yarn",
  ["coc.preferences.tsserver.trace.server"] = "off",
  ["coc.preferences.useInternalDiff"] = true,
  ["coc.preferences.virtualText"] = true,
  ["coc.preferences.virtualTextPrefix"] = "⚠",
  ["coc.preferences.willSaveHandlerTimeout"] = 5000,
  ["coc.preferences.workspace.autoRestart"] = true,
  ["coc.preferences.workspace.showStatusLineWarnings"] = true,
  ["coc.preferences.workspaceStatusTextDocument"] = "📝",
  ["coc.preferences.workspaceStatusTextExtension"] = "📦",
  ["coc.preferences.workspaceStatusTextGit"] = "🌿",
  ["coc.preferences.workspaceStatusTextProject"] = "📂",
  ["coc.preferences.workspaceStatusTextRoot"] = "🏠",
  ["coc.preferences.workspaceStatusTextSymbol"] = "🔍",
  ["coc.preferences.workspaceStatusTextWorkspace"] = "🚀",
  ["coc.preferences.workspaceStatusTextSeparator"] = " | ",
})
