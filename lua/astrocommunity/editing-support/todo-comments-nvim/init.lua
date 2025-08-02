---@type LazySpec
return {
  "folke/todo-comments.nvim",
  opts = {},
  dependencies = { "folke/snacks.nvim" },
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>fT"] = {
              function()
                if not package.loaded["todo-comments"] then -- make sure to load todo-comments
                  require("lazy").load { plugins = { "todo-comments.nvim" } }
                end
                require("snacks").picker.todo_comments()
              end,
              desc = "Todo Comments",
            },
          },
        },
      },
    },
  },
  event = "User AstroFile",
  cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
}
