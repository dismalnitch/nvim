-- Formatting configuration for Neovim 0.11

-- Disable LSP formatting to prevent conflicts with external formatters
-- vim.lsp.buf.format will be called only manually via <leader>f

-- Custom formatting commands for specific file types
local function setup_formatters()
  -- Prettier for JS/TS/JSON/CSS/HTML/Markdown
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {
      "*.js",
      "*.jsx",
      "*.ts",
      "*.tsx",
      "*.json",
      "*.css",
      "*.html",
      "*.md",
    },
    callback = function()
      local prettier_cmd = vim.fn.executable("prettier") == 1 and "prettier"
        or vim.fn.expand("~/.local/share/nvim/mason/bin/prettier")

      if vim.fn.executable(prettier_cmd) == 1 then
        vim.fn.system(
          string.format("%s --write %s", prettier_cmd, vim.fn.expand("%:p"))
        )
        vim.cmd("checktime")
      end
    end,
  })

  -- gofumpt for Go files
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
      local gofumpt_cmd = vim.fn.executable("gofumpt") == 1 and "gofumpt"
        or vim.fn.expand("~/.local/share/nvim/mason/bin/gofumpt")

      if vim.fn.executable(gofumpt_cmd) == 1 then
        vim.fn.system(
          string.format("%s -w %s", gofumpt_cmd, vim.fn.expand("%:p"))
        )
        vim.cmd("checktime")
      end
    end,
  })
end

setup_formatters()

-- Manual format command
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format document" })

