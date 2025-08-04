return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astroui.status"

    opts.statusline[1] =
      status.component.mode { mode_text = { padding = { left = 1, right = 1 } }, hl = { fg = "black", bold = true } } -- add the mode text
  end,
}
