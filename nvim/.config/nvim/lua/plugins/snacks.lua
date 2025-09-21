-- lua/plugins/snacks.lua
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      layout = {
        preset = "ivy_split", -- <- valid preset
      },
    },
  },
}
