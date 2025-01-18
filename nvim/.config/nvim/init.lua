-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("gruvbox").setup({
  overrides = {
    variable = { bg = "#ff9900" },
  },
})
require("gruvbox").setup({
  overrides = {
    ["@variable"] = { link = "Identifier" },
    ["@keyword"] = { link = "GruvboxPurple" },
    ["@keyword.conditional"] = { link = "GruvboxPurple" },
    ["@keyword.debug"] = { link = "GruvboxPurple" },
    ["@keyword.directive"] = { link = "GruvboxPurple" },
    ["@keyword.directive.define"] = { link = "GruvboxPurple" },
    ["@keyword.exception"] = { link = "GruvboxPurple" },
    ["@keyword.function"] = { link = "GruvboxPurple" },
    ["@keyword.import"] = { link = "GruvboxPurple" },
    ["@keyword.operator"] = { link = "GruvboxPurple" },
    ["@keyword.repeat"] = { link = "GruvboxPurple" },
    ["@keyword.return"] = { link = "GruvboxPurple" },
    ["@keyword.storage"] = { link = "GruvboxPurple" },
    ["@function"] = { link = "GruvboxRed" },
    ["@function.builtin"] = { link = "GruvboxRed" },
    ["@function.call"] = { link = "GruvboxRed" },
    ["@function.macro"] = { link = "GruvboxRed" },
    ["@function.method"] = { link = "GruvboxRed" },
    ["@method"] = { link = "GruvboxRed" },
    ["@method.call"] = { link = "GruvboxRed" },
  },
})
vim.cmd("colorscheme gruvbox")
