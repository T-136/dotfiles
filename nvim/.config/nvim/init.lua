-- ========================================================================== --
-- 1. SETTINGS & OPTIONS
-- ========================================================================== --
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.g.mapleader = " "

-- ========================================================================== --
-- 2. NATIVE PLUGIN MANAGER (vim.pack)
-- ========================================================================== --
-- We bundle both the 'fff' search plugin and the 'gruvbox.nvim' theme repository
vim.pack.add({ 
  'https://github.com/dmtrKovalenko/fff',
  'https://github.com/ellisonleao/gruvbox.nvim',
})

-- Keep your fff download hook running smoothly
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'fff' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then vim.cmd.packadd('fff') end
      require('fff.download').download_or_build_binary()
    end
  end
})

-- ========================================================================== --
-- 3. FFF CONFIGURATION & KEYMAPS
-- ========================================================================== --
vim.g.fff = { lazy_sync = true, debug = { enabled = false, show_scores = true } }
vim.keymap.set('n', '<leader>ff', function() require('fff').find_files() end, { desc = 'FFF Find Files' })
vim.keymap.set('n', '<leader>fg', function() require('fff').live_grep() end, { desc = 'FFF Live Grep' })
vim.keymap.set('n', '<leader>fw', function() require('fff').live_grep_under_cursor() end, { desc = 'FFF Grep Under Cursor' })

-- ========================================================================== --
-- 4. YOUR GRUVBOX CUSTOMIZATIONS
-- ========================================================================== --
-- Combined your variables and treesitter color overrides into a single clean setup block
require("gruvbox").setup({
  overrides = {
    variable = { bg = "#ff9900" },
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

-- ========================================================================== --
-- 5. YOUR FILETYPE AUTO-COMMANDS
-- ========================================================================== --
-- Clean line wrapping configurations for JSON files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.list = false
  end,
})
require('lsp').setup()
require('treesitter').setup()
require('formatting').setup()

