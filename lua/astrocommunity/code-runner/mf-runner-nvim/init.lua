return {
  "burgr033/mf-runner.nvim",
  cmd = { "MFROpen", "MFRRun", "MFREdit" },
  dependencies = {
    { "folke/snacks.nvim" },
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>MM"] = { "<Cmd>MFROpen<CR>", desc = "mf-runner: open" },
            ["<Leader>Me"] = { "<Cmd>MFREdit<CR>", desc = "mf-runner: edit Makefile" },
          },
        },
      },
    },
  },
  opts = {},
}
