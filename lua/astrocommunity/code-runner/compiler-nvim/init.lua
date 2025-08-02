---@type LazySpec
return {
  "Zeioth/compiler.nvim",
  dependencies = {
    {
      "stevearc/overseer.nvim",
      opts = {
        task_list = { -- this refers to the window that shows the result
          direction = "bottom",
          min_height = 25,
          max_height = 25,
          default_detail = 1,
          bindings = {
            ["q"] = function() vim.cmd "OverseerClose" end,
          },
        },
      },
      config = function(_, opts) require("overseer").setup(opts) end,
    },
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["<LocalLeader>c"] = { desc = "Compiler.nvim" },
            ["<LocalLeader>cr"] = { "<CMD>CompilerOpen<CR>", desc = "Compiler Open" },
            ["<LocalLeader>cc"] = { "<CMD>CompilerStop<CR><CMD>CompilerRedo<CR>", desc = "Compiler Redo" },
            ["<LocalLeader>cv"] = { "<CMD>CompilerToggleResults<CR>", desc = "Compiler Show Results" },
          },
        },
      },
    },
  },
  cmd = { "CompilerOpen", "CompilerToggleResults" },
  opts = {},
}
