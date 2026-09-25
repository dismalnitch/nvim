-- Swift / Xcode projects. LazyVim has no lang.swift extra, so it lives here.
--
-- Editing happens in nvim; Xcode stays open side-by-side for signing, assets,
-- Instruments and the like (it reloads files changed on disk).
--
-- External tools (brew): xcode-build-server, xcbeautify. `xcodebuild`, `xcrun`,
-- `sourcekit-lsp` and `swift format` all ship with Xcode. Run :checkhealth
-- xcodebuild to see what's missing.
--
-- Per project, once: open a .swift file, run :XcodebuildSetup (<leader>Xs) and
-- pick project/scheme/device. That writes buildServer.json, which is what makes
-- sourcekit-lsp understand an Xcode app target instead of red-underlining every
-- import.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "swift", "objc" })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Not on Mason: use the toolchain's copy so it always matches Xcode's
        -- Swift version. lspconfig's default root_dir already looks for
        -- buildServer.json / *.xcodeproj / Package.swift.
        sourcekit = {
          mason = false,
          cmd = { "xcrun", "sourcekit-lsp" },
          -- Default also claims c/cpp, which would fight clangd.
          filetypes = { "swift", "objc", "objcpp" },
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = { swift = { "swift" } },
      formatters = {
        -- `swift format` (Swift 6+). Its default style is 2-space, Xcode's is
        -- 4, so only format-on-save when the project opts in with a config.
        swift = {
          condition = function(_, ctx)
            return vim.fs.find({ ".swift-format" }, { path = ctx.dirname, upward = true })[1] ~= nil
          end,
        },
      },
    },
  },

  {
    "wojciech-kulik/xcodebuild.nvim",
    ft = { "swift", "objc", "objcpp" },
    cmd = { "XcodebuildSetup", "XcodebuildPicker" },
    dependencies = {
      "folke/snacks.nvim",
      "MunifTanjim/nui.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      integrations = {
        -- Use the snacks picker. Loading telescope here trips the refactoring
        -- extra's telescope hook ("'refactoring' extension doesn't exist").
        telescope_nvim = { enabled = false },
        fzf_lua = { enabled = false },
      },
    },
    config = function(_, opts)
      require("xcodebuild").setup(opts)
      -- Xcode 16+ ships lldb-dap, so no codelldb download needed.
      require("xcodebuild.integrations.dap").setup()
    end,
    keys = {
      { "<leader>XX", "<cmd>XcodebuildPicker<cr>", desc = "Xcodebuild actions" },
      { "<leader>Xs", "<cmd>XcodebuildSetup<cr>", desc = "Setup project" },
      { "<leader>Xb", "<cmd>XcodebuildBuild<cr>", desc = "Build" },
      { "<leader>Xr", "<cmd>XcodebuildBuildRun<cr>", desc = "Build & run" },
      { "<leader>XR", "<cmd>XcodebuildRun<cr>", desc = "Run (no build)" },
      { "<leader>X.", "<cmd>XcodebuildCancel<cr>", desc = "Cancel" },
      { "<leader>Xt", "<cmd>XcodebuildTest<cr>", desc = "Test all" },
      { "<leader>Xn", "<cmd>XcodebuildTestNearest<cr>", desc = "Test nearest" },
      { "<leader>Xc", "<cmd>XcodebuildTestClass<cr>", desc = "Test class" },
      { "<leader>XT", "<cmd>XcodebuildTestExplorerToggle<cr>", desc = "Test explorer" },
      { "<leader>Xl", "<cmd>XcodebuildToggleLogs<cr>", desc = "Toggle logs" },
      { "<leader>Xd", "<cmd>XcodebuildSelectDevice<cr>", desc = "Select device" },
      { "<leader>XS", "<cmd>XcodebuildSelectScheme<cr>", desc = "Select scheme" },
      { "<leader>Xq", "<cmd>XcodebuildQuickfixLine<cr>", desc = "Quickfix line" },
      { "<leader>Xa", "<cmd>XcodebuildCodeActions<cr>", desc = "Code actions" },
      { "<leader>Xx", "<cmd>XcodebuildOpenInXcode<cr>", desc = "Open in Xcode" },
      { "<leader>XD", "<cmd>XcodebuildBuildDebug<cr>", desc = "Build & debug" },
    },
  },
}
