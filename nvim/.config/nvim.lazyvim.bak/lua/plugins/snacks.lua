-- lua/plugins/snacks.lua
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      matcher = {
        frecency = true, -- <- activate frecency scoring
      },
      debug = {
        scores = true,
      },
      layout = {
        preset = "ivy_split", -- <- valid preset
      },
      win = {
        input = {
          keys = {
            -- use H J K L to scroll the preview
            ["H"] = { "preview_scroll_left", mode = { "n", "i" } },
            ["L"] = { "preview_scroll_right", mode = { "n", "i" } },
            ["K"] = { "preview_scroll_up", mode = { "n", "i" } },
            ["J"] = { "preview_scroll_down", mode = { "n", "i" } },
          },
        },
      },
    },
  },
}
