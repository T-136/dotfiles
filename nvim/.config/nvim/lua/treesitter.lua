local M = {}

function M.setup()
  vim.pack.add({
    "https://github.com/nvim-treesitter/nvim-treesitter",
  })

  vim.cmd.packadd("nvim-treesitter")

  require("nvim-treesitter").setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
  })

  -- Install the parsers we want.
  require("nvim-treesitter").install({
    "lua",
    "python",
    "rust",
    "zig",
    "javascript",
    "typescript",
    "tsx",
    "jsx",
  })

  -- Enable Treesitter highlighting.
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua", "python", "rust", "zig", "javascript", "typescript", "typescriptreact", "javascriptreact" },
    callback = function(ev)
      vim.bo[ev.buf].syntax = ""
      vim.treesitter.start(ev.buf)
    end,
  })
end

return M
