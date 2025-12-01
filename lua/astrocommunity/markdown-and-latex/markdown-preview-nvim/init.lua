---@type LazySpec
return {
  "iamcco/markdown-preview.nvim",
  build = function()
    require("lazy").load { plugins = { "markdown-preview.nvim" } }
    vim.fn["mkdp#util#install"]()
  end,
  ft = { "markdown", "markdown.mdx" },
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  init = function()
    local plugin = require("lazy.core.config").spec.plugins["markdown-preview.nvim"]
    vim.g.mkdp_filetypes = require("lazy.core.plugin").values(plugin, "ft", true)
  end,
  dependencies = {
    { "AstroNvim/astroui", opts = { icons = { Markdown = "" } } },
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        autocmds = {
          buffer_enable_markdownpreview = {
            {
              event = "FileType",
              pattern = { "markdown", "markdown.mdx" },
              desc = "Enable MarkdownPreview buffer local",
              callback = function(opts)
                local ac = require "astrocore"
                local prefix = "<LocalLeader>"
                local icon = require("astroui").get_icon("Markdown", 1, true)
                ac.set_mappings({
                  n = {
                    [prefix] = { desc = icon .. "Markdown" },
                    [prefix .. "p"] = { "<CMD>MarkdownPreview<CR>", desc = "Preview" },
                    [prefix .. "s"] = { "<CMD>MarkdownPreviewStop<CR>", desc = "Stop preview" },
                    [prefix .. "t"] = { "<CMD>MarkdownPreviewToggle<CR>", desc = "Toggle preview" },
                  },
                }, { buffer = opts.buf })
              end,
            },
          },
        },
      },
    },
  },
}
