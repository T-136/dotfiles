local M = {}

function M.setup()
  vim.pack.add({
    'https://github.com/stevearc/conform.nvim',
  })

  vim.cmd.packadd('conform.nvim')

  require('conform').setup({
    formatters_by_ft = {
      python = { 'black' },
      lua = { 'stylua' },
      rust = { 'rustfmt' },
      zig = { 'zigfmt' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      typescriptreact = { 'prettier' },
      javascriptreact = { 'prettier' },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
  })
end

return M
