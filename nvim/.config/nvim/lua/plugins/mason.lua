return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      handlers = {
        ["rust_analyzer"] = function()
          require("lspconfig").rust_analyzer.setup({
            settings = {
              ["rust-analyzer"] = {
                procMacro = {
                  enable = true,
                },
              },
            },
          })
        end,
      },
    },
  },
}
