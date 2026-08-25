local M = {}

function M.setup()
  -- Plugins
  vim.pack.add({
    'https://github.com/neovim/nvim-lspconfig',
    {
      src = 'https://github.com/saghen/blink.cmp',
      version = 'v1.10.2',
    },
  })

  vim.cmd.packadd('nvim-lspconfig')

  -- LSP configuration
  vim.lsp.config('lua_ls', {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim', 'require' },
        },
      },
    },
  })

  -- Enable servers
  vim.lsp.enable('lua_ls')
  vim.lsp.enable('pyright')

  vim.cmd.packadd('blink.cmp')

  -- Blink
  require('blink.cmp').setup({
    keymap = {
      preset = 'default',
    },
    sources = {
      default = {
        'lsp',
        'path',
        'buffer',
      },
    },

    completion = {
      trigger = {
        show_on_keyword = true,
        show_on_trigger_character = true,
      },

      menu = {
        auto_show = true,
      },

      documentation = {
        auto_show = true,
        delay_ms = 200,
      },
    },
  })

  -- LSP keymaps
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
      local opts = { buffer = ev.buf }

      vim.keymap.set('n', 'grd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'grr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, opts)

      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    end,
  })
end

return M
