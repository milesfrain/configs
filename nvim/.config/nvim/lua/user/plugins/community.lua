return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  -- { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.completion.copilot-lua-cmp" },
  { import = "astrocommunity.motion.nvim-surround" },

  -- To consider:
  -- multi-highlighter
  -- https://github.com/AstroNvim/astrocommunity/tree/main/lua/astrocommunity/color/vim-highlighter
  --
  -- Better matching (passive)
  -- https://github.com/AstroNvim/astrocommunity/tree/main/lua/astrocommunity/motion/vim-matchup
}
