return {
  "xiyaowong/transparent.nvim",
  opts = {
    extra_groups = {
      "NormalFloat",
      "NvimTreeNormal",
      "FloatBorder",
    },
  },
  config = function(_, opts)
    local transparent = require "transparent"
    transparent.setup(opts)
    transparent.clear_prefix "BufferLine"
    transparent.clear_prefix "NeoTree"
    transparent.clear_prefix "lualine"
  end,
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        opts.mappings.n["<Leader>uT"] = {
          function()
            _G.resetup_catppuccin {
              transparent_background = not vim.g.transparent_enabled,
            }
            vim.cmd "TransparentToggle"
          end,
          desc = "Toggle transparency",
        }
        if vim.tbl_get(opts, "autocmds", "heirline_colors") then
          table.insert(opts.autocmds.heirline_colors, {
            event = "User",
            pattern = "TransparentClear",
            desc = "Refresh heirline colors",
            callback = function()
              if package.loaded["heirline"] then require("astroui.status.heirline").refresh_colors() end
            end,
          })
        end
      end,
    },
  },
}
