---@type LazySpec
return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = true,
  config = function(opts)
    ---@type CatppuccinOptions
    ---@diagnostic disable missing-fields
    local def_opts = {
      auto_integrations = true,
      transparent_background = true,
      integrations = {
        colorful_winsep = { color = "lavender" },
        snacks = {
          indent_scope_color = "lavender",
        },
      },
      highlight_overrides = {
        all = {
          FloatBorder = {
            fg = "#585b70",
            bg = "NONE",
          },
        },
      },
    }

    opts = require("astrocore").extend_tbl(def_opts, opts)
    local catp = require "catppuccin"
    catp.setup(opts)
    catp.options.integrations.bufferline = nil
  end,
  specs = {
    {
      "akinsho/bufferline.nvim",
      optional = true,
      opts = function(_, opts)
        return require("astrocore").extend_tbl(opts, {
          highlights = require("catppuccin.groups.integrations.bufferline").get_theme(),
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
}
