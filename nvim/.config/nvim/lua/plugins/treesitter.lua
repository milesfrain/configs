-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    if not opts.ensure_installed then opts.ensure_installed = {} end
    if type(opts.ensure_installed) == "table" then
      table.insert(opts.ensure_installed, "flatbuffers")
    end
    return opts
  end,
  config = function(_, opts)
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.flatbuffers = {
      install_info = {
        url = "https://github.com/demfabris/tree-sitter-flatbuffers",
        files = { "src/parser.c" },
        branch = "main",
        revision = "6dc0eb4dde1677aba9fb8eae963642ea56bed575",
        queries = "queries",
      },
      filetype = "fbs",
    }
    require("nvim-treesitter.configs").setup(opts)
  end,
}
