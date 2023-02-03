-- Chadrc overrides this file

local M = {}

M.options = {
  nvChad = {
    update_url = "https://github.com/NvChad/NvChad",
    update_branch = "main",
  },
}

M.ui = {
  -- hl = highlights
  hl_add = {},
  hl_override = {},
  changed_themes = {},
  theme_toggle = { "onedark", "one_light" },
  theme = "onedark", -- default theme
  transparency = false,
}

M.plugins = {}

M.lsp = {
  servers = {
    tsserver = true, -- typescript
    vuels = true, -- vue2
    cssls = true, -- css
    cssmodules_ls = true, -- css module
    jsonls = true, -- json
    html = true, -- html
    eslint = true, -- eslint
    sumneko_lua = false, -- lua
    tailwindcss = true, -- tailwindcss
    rust_analyzer = false, -- rust
    volar = true, -- vue3
    emmet_ls = false, -- emmet
    marksman = false, -- markdown
  },
}

-- check core.mappings for table structure
M.mappings = require "core.mappings"

return M
