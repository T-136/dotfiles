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
  vim.lsp.enable('zls')
  vim.lsp.config('rust_analyzer', {
    cmd = { vim.fn.expand('~/.rustup/toolchains/stable-aarch64-apple-darwin/bin/rust-analyzer') },
  })
  vim.lsp.enable('rust_analyzer')
  vim.lsp.enable('vtsls')

  vim.cmd.packadd('blink.cmp')

  -- Blink
  require('blink.cmp').setup({
    keymap = {
      preset = 'enter',
      ['<CR>'] = {
        function(cmp)
          cmp.accept()
          vim.schedule(function() vim.api.nvim_feedkeys('\n', 'n', false) end)
        end,
        'fallback',
      },
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
      ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
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

      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
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

      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)

      vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '<leader>sd', function()
        vim.diagnostic.setqflist(); vim.cmd('copen')
      end, opts)
      vim.keymap.set('n', '<leader>ss', vim.lsp.buf.document_symbol, opts)
      vim.keymap.set('n', '<leader>sS', vim.lsp.buf.workspace_symbol, opts)
    end,
  })
end

return M
