return {
  "echasnovski/mini.nvim",
  version = false,
  highlight_duration = 500,

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    add = "csa", -- Add surrounding in Normal and Visual modes
    delete = "csd", -- Delete surrounding
    find = "csf", -- Find surrounding (to the right)
    find_left = "csF", -- Find surrounding (to the left)
    highlight = "csh", -- Highlight surrounding
    replace = "csr", -- Replace surrounding
    update_n_lines = "csn", -- Update `n_lines`

    suffix_last = "l", -- Suffix to search with "prev" method
    suffix_next = "n", -- Suffix to search with "next" method
  },

  -- Number of lines within which surrounding is searched
  n_lines = 20,

  -- Whether to respect selection type:
  -- - Place surroundings on separate lines in linewise mode.
  -- - Place surroundings on each line in blockwise mode.
  respect_selection_type = false,

  -- How to search for surrounding (first inside current line, then inside
  -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
  -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
  -- see `:h MiniSurround.config`.
  search_method = "cover",
}
