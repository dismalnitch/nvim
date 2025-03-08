-- bootstrap lazy.nvim, LazyVim and your plugins

require("config.lazy")
require("config.autocmds")

vim.o.mouse = "a"

-- Ensure your custom keybinding is set after all plugins are loaded
-- And by that, I of course mean that copilot is scooping my keybindings. So here's a hack.
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = function()
    vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
  end,
})

require("mini.pairs").setup({
  -- Disable all auto-pairing
  disable = true,
})

require("nvim-ts-autotag").setup({
  enable = false,
})

-- cmp_ai config was moved to plugins/cmp.lua

vim.g.copilot_no_tab_map = false

local nvim_lsp = require("lspconfig")
-- Enable godot lsp
nvim_lsp.gdscript.setup({
  name = "godot",
  cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
})
local api = require("typescript-tools.api")
require("typescript-tools").setup({
  onAttach = function(client, bufnr)
    require("typescript-tools").on_attach(client, bufnr)
    require("nvim-lsp-ts-utils").setup({
      eslint = true,
      import = true,
      eslint_enable_diagnostics = true,
      update_imports_on_move = true,
      require_confirmation_on_move = true,
      filter_out_diagnostics_by_code = { 80001 },
    })
  end,
  settings = {
    separate_diagnostic_group = true,
    jsx_close_tag = {
      enable = true,
      filetypes = { "typescriptreact" },
    },
  },
  -- handlers = {
  --   ["textDocument/publishDiagnostics"] = api.filter_diagnostics({
  --     { 80006 },
  --   }),
  -- },
})
-- Example for configuring the tsserver (TypeScript) LSP
-- nvim_lsp.tsserver.setup({
--   on_attach = function(client, bufnr)
--     -- Custom handler to filter out specific diagnostics
--     client.handlers["textDocument/inlayHint"] = function(_, result, ctx, config)
--       local diagnostics = result.diagnostics
--       local filtered_diagnostics = {}
--
--       for _, diagnostic in ipairs(diagnostics) do
--         -- Filter out diagnostics with specific codes or messages
--         if
--           diagnostic.code ~= "-32603"
--           and not diagnostic.message:match("<semantic> (.+)")
--         then
--           table.insert(filtered_diagnostics, diagnostic)
--         end
--       end
--
--       result.diagnostics = filtered_diagnostics
--       vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
--     end
--   end,
--   flags = {
--     debounce_text_changes = 150,
--   },
-- })

-- dap
local dap = require("dap")
dap.adapters.godot = {
  type = "server",
  host = "127.0.0.1",
  port = 6006,
}

dap.configurations.gdscript = {
  {
    type = "godot",
    request = "launch",
    name = "Launch scene",
    project = "${workspaceFolder}",
    launch_scene = true,
  },
}

-- listen to godothost if we're trying to open a godot project
-- local projectfile = vim.fn.getcwd() .. "/project.godot"
-- if projectfile then
--   vim.fn.serverstart("./godothost")
-- end
local port = os.getenv("GDScript_Port") or "6005"
local portNum = tonumber(port)
local cmd = vim.lsp.rpc.connect("127.0.0.1", portNum)
local pipe = "/path/to/godot.pipe" -- I use /tmp/godot.pipe

-- vim.lsp.start({
--   name = "Godot",
--   cmd = cmd,
--   root_dir = vim.fs.dirname(
--     vim.fs.find({ "project.godot", ".git" }, { upward = true })[1]
--   ),
--   on_attach = function(client, bufnr)
--     vim.api.nvim_command('echo serverstart("' .. pipe .. '")')
--   end,
-- })