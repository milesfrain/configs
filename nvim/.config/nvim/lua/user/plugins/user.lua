return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {
    'tzachar/local-highlight.nvim',
    config = function()
      require('local-highlight').setup({
        file_types = {'lua'}, -- If this is given only attach to this
        -- OR attach to every filetype except:
        -- disable_file_types = {'tex'},
        hlgroup = 'Search',
        cw_hlgroup = nil,
        -- Whether to display highlights in INSERT mode or not
        insert_mode = false,
        disable_file_types = {},
      })
    end
  },
}
