local M = {}

function M.setup()
  vim.pack.add({
    'https://github.com/echasnovski/mini.files',
  })

  vim.cmd.packadd('mini.files')

  require('mini.files').setup({
    mappings = {
      go_in_plus = 'l',
    },
  })
end

return M
