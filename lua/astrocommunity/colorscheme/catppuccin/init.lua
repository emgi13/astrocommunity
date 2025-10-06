---@type LazySpec
return {
  "catppuccin/nvim",
  name = "catppuccin",
  config = function(opts)
    local catp = require "catppuccin"
    local opts_transp = require("astrocore").extend_tbl(opts, { transparent_background = vim.g.transparent_enabled })
    catp.setup(opts_transp)
    catp.options.integrations.bufferline = nil
  end,
  specs = {
    {
      "akinsho/bufferline.nvim",
      optional = true,
      opts = function(_, opts)
        return require("astrocore").extend_tbl(opts, {
          highlights = require("catppuccin.special.bufferline").get_theme(),
        })
      end,
    },
    {
      "nvim-telescope/telescope.nvim",
      optional = true,
      opts = {
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      },
    },
  },
  dependencies = { "xiyaowong/transparent.nvim" },
}
