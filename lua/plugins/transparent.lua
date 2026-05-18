-- Lets the kitty background show through nvim. Pairs well with a subtly
-- transparent terminal (`background_opacity 0.95` in kitty.conf).
--
-- Pre-clears the most common UI groups. If a colorscheme sneaks an
-- opaque background back in (kanso/tokyonight sometimes do for popups),
-- add the group name to `extra_groups`.
--
-- Toggle on/off at runtime: `:TransparentToggle`
return {
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    priority = 999, -- after colorscheme (1000) so we override its bg
    opts = {
      extra_groups = {
        -- Popups / floats
        "NormalFloat",
        "FloatBorder",
        "FloatTitle",
        -- Telescope / pickers
        "TelescopeNormal",
        "TelescopeBorder",
        "TelescopePromptNormal",
        "TelescopePromptBorder",
        "TelescopeResultsNormal",
        "TelescopeResultsBorder",
        "TelescopePreviewNormal",
        "TelescopePreviewBorder",
        -- Neo-tree / explorer
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "NeoTreeEndOfBuffer",
        -- Which-key
        "WhichKeyFloat",
        -- Noice
        "NoiceCmdlinePopup",
        "NoiceCmdlinePopupBorder",
        "NoicePopup",
        "NoicePopupBorder",
        -- Snacks
        "SnacksDashboardNormal",
        "SnacksNotifierHistory",
        "SnacksPicker",
        "SnacksPickerBorder",
        -- Diagnostics / signs
        "SignColumn",
        "LineNr",
        "CursorLineNr",
        "StatusLine",
        "StatusLineNC",
      },
      exclude_groups = {
        -- If you want certain things to stay solid for readability,
        -- list them here. Empty by default.
      },
    },
  },
}
