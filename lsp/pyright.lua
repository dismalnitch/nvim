return {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    ".git",
    ".venv",
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
  -- Point pyright at the project's virtualenv. Priority: an activated
  -- $VIRTUAL_ENV wins, then <root>/.venv, then <root>/venv. Without a
  -- match pyright falls back to whatever `python` is on PATH.
  before_init = function(_, config)
    local candidates = {}
    if vim.env.VIRTUAL_ENV then
      table.insert(candidates, vim.env.VIRTUAL_ENV .. "/bin/python")
    end
    if config.root_dir then
      table.insert(candidates, config.root_dir .. "/.venv/bin/python")
      table.insert(candidates, config.root_dir .. "/venv/bin/python")
    end
    for _, python in ipairs(candidates) do
      if vim.uv.fs_stat(python) then
        -- Mutate settings in place: client.settings shares this table,
        -- so replacing it (tbl_deep_extend) would have no effect.
        config.settings = config.settings or {}
        config.settings.python = config.settings.python or {}
        config.settings.python.pythonPath = python
        break
      end
    end
  end,
}
