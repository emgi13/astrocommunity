-- INFO: Making according to (This Issue)[https://github.com/akinsho/bufferline.nvim/issues/836]
-- -- local mocha = require("catppuccin.palettes").get_palette "mocha"
-- local black = false
--
-- local sel_bg = mocha.base
-- local unsel_bg = mocha.crust
--
-- local sel_fg = mocha.red
-- local unsel_fg = mocha.blue
--
-- local active_set = { fg = sel_fg, bg = sel_bg }
-- local inactive_set = { fg = unsel_fg, bg = unsel_bg }
--
-- ---@type table<string, bufferline.HLGroup>
-- local hls = {
--   fill = { bg = black },
--   buffer_selected = active_set,
--
--   numbers = inactive_set,
--   numbers_selected = active_set,
--
--   separator = { fg = black, bg = unsel_bg },
--   separator_selected = { fg = black, bg = sel_bg },
--
--   modified = { fg = mocha.red, bg = unsel_bg },
--   modified_selected = { fg = mocha.red, bg = sel_bg },
-- }

local symbols = {
  warning = "?",
  error = "!",
  hint = "'",
}

return {
  "akinsho/bufferline.nvim",
  event = "User AstroFile",
  ---@type bufferline.UserConfig
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      separator_style = { "", "" },
      diagnostics_indicator = function(count, level, _diagnostics_dict, _context)
        return (count or "") .. (symbols[level] or level)
      end,
      show_buffer_close_icons = false,
      show_close_icon = false,
    },
  },
  dependencies = {
    { import = "astrocommunity.recipes.disable-tabline" }, -- dependency before loading rest of the spec
    {
      "AstroNvim/astrocore",
      opts = {
        options = { opt = { showtabline = 2 } },
        mappings = {
          n = {
            ["]b"] = { function() require("bufferline.commands").cycle(vim.v.count1) end, desc = "Next buffer" },
            ["[b"] = { function() require("bufferline.commands").cycle(-vim.v.count1) end, desc = "Previous buffer" },
            [">b"] = {
              function() require("bufferline.commands").move(vim.v.count1) end,
              desc = "Move buffer tab right",
            },
            ["<b"] = {
              function() require("bufferline.commands").move(-vim.v.count1) end,
              desc = "Move buffer tab left",
            },
            ["<Leader>bb"] = {
              function() require("bufferline.commands").pick() end,
              desc = "Navigate to buffer tab with interactive picker",
            },
            ["<Leader>bc"] = {
              function() require("bufferline.commands").close_others() end,
              desc = "Close all buffers except the current",
            },
            ["<Leader>bd"] = {
              function() require("bufferline.commands").close_with_pick() end,
              desc = "Delete a buffer tab with interactive picker",
            },
            ["<Leader>bl"] = {
              function() require("bufferline.commands").close_in_direction "left" end,
              desc = "Close all buffers to the left of the current",
            },
            ["<Leader>br"] = {
              function() require("bufferline.commands").close_in_direction "right" end,
              desc = "Close all buffers to the right of the current",
            },
            ["<Leader>bp"] = { "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin buffer" },
            ["<Leader>bse"] = {
              function() require("bufferline.commands").sort_by "extension" end,
              desc = "Sort buffers by extension",
            },
            ["<Leader>bsi"] = {
              function() require("bufferline.commands").sort_by "id" end,
              desc = "Sort buffers by buffer number",
            },
            ["<Leader>bsm"] = {
              function()
                require("bufferline.commands").sort_by(function(a, b) return a.modified and not b.modified end)
              end,
              desc = "Sort buffers by last modification",
            },
            ["<Leader>bsp"] = {
              function() require("bufferline.commands").sort_by "directory" end,
              desc = "Sort buffers by directory",
            },
            ["<Leader>bsr"] = {
              function() require("bufferline.commands").sort_by "relative_directory" end,
              desc = "Sort buffers by relative directory",
            },
            ["<Leader>b\\"] = {
              function()
                require("bufferline.pick").choose_then(function(id)
                  vim.cmd "split"
                  vim.cmd("buffer " .. id)
                end)
              end,
              desc = "Open a buffer tab in a new horizontal split with interactive picker",
            },
            ["<Leader>b|"] = {
              function()
                require("bufferline.pick").choose_then(function(id)
                  vim.cmd "vsplit"
                  vim.cmd("buffer " .. id)
                end)
              end,
              desc = "Open a buffer tab in a new vertical split with interactive picker",
            },
          },
        },
      },
    },
  },
}
