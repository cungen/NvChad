local present, lspconfig = pcall(require, "lspconfig")

if not present then
  return
end

require("base46").load_highlight "lsp"
require "nvchad_ui.lsp"

local M = {}
local utils = require "core.utils"

-- export on_attach & capabilities for custom lspconfigs

M.on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad_ui.signature").setup(client)
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local default_options = {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  flags = {
    debounce_text_changes = 500,
    allow_incremental_sync = false,
  },
}

local lsp_default_config = require("core.utils").load_config().lsp
local servers = lsp_default_config.servers

local install_lsp = function()
  local opts

  for server, enable in pairs(servers) do
    if enable then
      if server == 'tsserver' then
        opts = vim.tbl_deep_extend('force', default_options, require('plugins.configs.lspconfigs.tsserver'))
      elseif server == 'tailwindcss' then
        opts = vim.tbl_deep_extend('force', default_options, require('plugins.configs.lspconfigs.tailwindcss'))
      elseif server == 'volar' then
        opts = vim.tbl_deep_extend('force', default_options, require('plugins.configs.lspconfigs.volar'))
      elseif server == 'sumneko_lua' then
        opts = vim.tbl_deep_extend('force', default_options, require('plugins.configs.lspconfigs.sumneko_lua'))
      elseif server == 'jsonls' then
        opts = vim.tbl_deep_extend('force', default_options, require('plugins.configs.lspconfigs.jsonls'))
      else
        opts = default_options
      end

      lspconfig[server].setup(opts)
    end
  end
end

install_lsp()

return M
