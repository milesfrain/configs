-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {
  {
    "kevinhwang91/nvim-bqf",
    opts = {
      preview = {
        winblend = 0, -- Fully opaque preview window
      },
    },
    -- use fullscreen quickfix preview window by default
    -- toggle with 'zp'
    config = function(_, opts)
      require("bqf").setup(opts)
      local PreviewSession = require "bqf.preview.session"
      local old_new = PreviewSession.new
      PreviewSession.new = function(self, winid, focusable)
        local o = old_new(self, winid, focusable)
        o.full = true
        return o
      end
    end,
  },

  -- == Examples of Adding Plugins ==

  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function() require("lsp_signature").setup() end,
  -- },

  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  --  {
  --    "folke/snacks.nvim",
  --    opts = function(_, opts)
  --      -- customize the dashboard header
  --      opts.section.header.val = {}
  --      return opts
  --    end,
  --  },
}
