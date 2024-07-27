-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr) require("astronvim.utils.buffer").close(bufnr) end)
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    
    -- Control-Tab to cycle through buffers
    -- Works in alacritty, but not in standard terminals
    -- https://old.reddit.com/r/neovim/comments/qemfx5/why_do_ctab_cstab_only_work_in_guis/
    ["<C-Tab>"] = { ":bnext<cr>", desc = "Next buffer" },
    ["<C-S-Tab>"] = { ":bprev<cr>", desc = "Previous buffer" },
    -- Note that this can be improved to work with other buffers (e.g. tree)
    -- There's also a V3 to V4 migration consideration:
    -- https://discord.com/channels/939594913560031363/1225452277775732796
    -- ["<C-Tab>"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
    -- ["<C-S-Tab>"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

    -- Existing (slow) bindings to cycle through buffers:
    -- ]b
    -- [b
    
    -- Existing bindings to jump to a buffer:
    --   <leader>bb
    --   <leader>fb
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
