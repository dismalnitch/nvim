-- iamcco/markdown-preview.nvim
--
-- Live browser preview for markdown files, with mermaid + math + PlantUML
-- + sequence diagrams supported out of the box. Lazy-loaded on `ft = markdown`
-- and the cmd list, so startup cost is zero outside markdown buffers.
--
-- First open after install: lazy will run the build function which downloads
-- the prebuilt preview server binary (no system-wide node/yarn needed).
return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
  ft = { "markdown" },
  -- Run install.sh directly. The vim-side `mkdp#util#install()` helpers
  -- open an async terminal split that lazy doesn't wait on — you end up
  -- with a "build complete" message before the prebuilt server has finished
  -- downloading, and the first :MarkdownPreview blows up with MODULE_NOT_FOUND.
  -- The shell form blocks lazy until the download is done.
  build = "cd app && ./install.sh",
  init = function()
    vim.g.mkdp_auto_close = 1
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  keys = {
    {
      "<leader>mp",
      "<cmd>MarkdownPreviewToggle<cr>",
      desc = "Markdown preview (toggle)",
      ft = "markdown",
    },
  },
}
