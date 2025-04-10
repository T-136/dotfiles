return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- Enable filetype plugin and indent detection
      -- This is necessary for VimTeX to load properly.
      vim.cmd("filetype plugin indent on")

      -- Enable syntax highlighting
      -- This enables Neovim's syntax-related features.
      vim.cmd("syntax enable")

      -- Viewer options
      -- Specify the built-in viewer method
      vim.g.vimtex_view_method = "skim"

      -- Alternatively, configure a generic viewer interface
      -- vim.g.vimtex_view_general_viewer = "okular"
      -- vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"

      -- Compiler backend
      -- VimTeX uses latexmk as the default compiler backend, but this changes it to latexrun.
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        aux_dir = "./.aux_dir",
        pdf,
      }

      -- Set the local leader key for VimTeX mappings
      vim.g.maplocalleader = ","

      vim.keymap.set("n", "<localleader>r", function()
        vim.cmd("w") -- Save the current file

        -- Find the main file (default to main.tex)
        local main_file = vim.fn.findfile("main.tex", ".;")
        if main_file == "" then
          print("Main file not found (main.tex)")
          return
        end

        -- Get the line number in the current file
        local current_line = vim.fn.line(".")

        -- Get the file name of the current buffer
        local current_file = vim.fn.expand("%")

        -- Resolve the main file path without the extension
        local main_file_root = vim.fn.fnamemodify(main_file, ":r")

        -- Build the Skim command
        local cmd = string.format(
          "/Applications/Skim.app/Contents/SharedSupport/displayline %d %s.pdf %s",
          current_line,
          main_file_root,
          current_file
        )

        -- Run the Skim command silently
        vim.fn.system(cmd)

        -- Adjust Skim window size and position using AppleScript
        local applescript = [[
        tell application "System Events"
            -- Get the screen resolution from system_profiler
            set screenResolution to do shell script "system_profiler SPDisplaysDataType | awk \'/Resolution/ {print}\' | head -1"

            -- Split the resolution string into width and height
            set screenWidth to word 2 of screenResolution as integer
            set screenHeight to word 4 of screenResolution as integer
        end tell

        tell application "Skim"
            activate
            -- Move and resize Skim window to the right half of the screen
            set bounds of front window to {screenWidth / 2, 0, screenWidth, screenHeight}
            -- Ensure Skim is not in full-screen mode
            set mode of front window to normal
        end tell
    ]]

        -- Run the AppleScript to adjust Skim's window position and size
        vim.fn.system("osascript -e '" .. applescript .. "'")
      end, { silent = true, desc = "View PDF at current line with adjusted height" })

      -- -- Enable conceal in general
      -- vim.o.conceallevel = 2 -- Set conceal level (1 = hide only, 2 = replace with symbols)
      -- vim.o.concealcursor = "n" -- Conceal only in normal mode (not insert mode)
      --
      -- Enable vimtex conceal
      vim.g.vimtex_syntax_conceal = {
        accents = 1, -- Conceal accents like \'
        cites = 1, -- Conceal citations (\cite{})
        -- fancy = 1, -- Use fancy replacements (e.g., arrows)
        greek = 1, -- Conceal Greek letters (\alpha → α)
        math_bounds = 1, -- Conceal boundaries (\[ \] → nothing)
        math_delimiters = 1, -- Conceal inline math ($...$ → nothing)
        -- sections = 1, -- Disable conceal for sections
        styles = 1, -- Conceal styles (\textbf{} → bold text)
        -- envs = 1, -- \begin{figure} -> not working
      }

      vim.g.vimtex_fold_enabled = 1
      vim.g.vimtex_fold_types = {
        envs = {
          whitelist = { "enumerate", "figure", "table" },
        },
        sections = {
          enabled = 0, -- Disable folding for sections
        },
      }
    end,
  },
}
