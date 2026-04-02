-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    --  -- Configure core features of AstroNvim
    --  features = {
    --    large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
    --    autopairs = true, -- enable autopairs at start
    --    cmp = true, -- enable completion at start
    --    diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
    --    highlighturl = true, -- highlight URLs at start
    --    notifications = true, -- enable notifications at start
    --  },
    --  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    --  diagnostics = {
    --    virtual_text = true,
    --    underline = true,
    --  },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        fbs = "flatbuffers",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        -- Set completion to longest common match, then list, then cycle
        -- Note that lowercase matches won't complete if there's a similar uppercase option.
        -- This is because of smartcase, but we can't disable that just for command matching.
        -- Note that for these to work, blink must be disabled for commands.
        wildmode = "longest:list,full",
        wildoptions = "tagfile", -- remove "pum" to avoid popup menu and use native wildmenu
        --      relativenumber = true, -- sets vim.opt.relativenumber
        --      number = true, -- sets vim.opt.number
        --      spell = false, -- sets vim.opt.spell
        --      signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        --      wrap = false, -- sets vim.opt.wrap
      },
      --    g = { -- vim.g.<key>
      --      -- configure global vim variables (vim.g)
      --      -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
      --      -- This can be found in the `lua/lazy_setup.lua` file
      --    },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        --  -- navigate buffer tabs
        --  ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        --  ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        --  -- mappings seen under group name "Buffer"
        --  ["<Leader>bd"] = {
        --    function()
        --      require("astroui.status.heirline").buffer_picker(
        --        function(bufnr) require("astrocore.buffer").close(bufnr) end
        --      )
        --    end,
        --    desc = "Close buffer from tabline",
        --  },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,

        -- switch between source/header files (clangd)
        ["gh"] = { "<cmd>ClangdSwitchSourceHeader<CR>", desc = "Switch source/header (clangd)" },

        -- copy file reference to clipboard
        ["<C-n>"] = {
          function()
            local filepath = vim.fn.expand "%:."
            local line = vim.fn.line "."
            local reference = filepath .. ":" .. line
            vim.fn.setreg("+", reference)
            vim.notify("Copied: " .. reference, vim.log.levels.INFO)
          end,
          desc = "Copy file reference to clipboard",
        },
      },
      v = {
        -- copy file reference with line range in visual mode
        ["<C-n>"] = {
          function()
            local filepath = vim.fn.expand "%:."
            -- Get visual selection range
            local start_line = vim.fn.line "v"
            local end_line = vim.fn.line "."
            -- Ensure start is before end
            if start_line > end_line then
              start_line, end_line = end_line, start_line
            end
            local reference
            if start_line == end_line then
              reference = filepath .. ":" .. start_line
            else
              reference = filepath .. ":" .. start_line .. "-" .. end_line
            end
            vim.fn.setreg("+", reference)
            vim.notify("Copied: " .. reference, vim.log.levels.INFO)
            vim.cmd "normal! \27" -- ESC to exit visual mode
            -- vim.fn.cursor(start_line, 1) -- Jump to start_line
            -- vim.cmd "normal! ^" -- Jump to first non-blank character
          end,
          desc = "Copy file reference with line range to clipboard",
        },
      },
    },
  },
}
