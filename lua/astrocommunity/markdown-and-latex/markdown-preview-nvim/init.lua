---@type LazySpec
return {
  "iamcco/markdown-preview.nvim",
  build = function(plugin)
    local package_manager = vim.fn.executable "yarn" and "yarn" or vim.fn.executable "npx" and "npx -y yarn" or false

    --- HACK: Use `yarn` or `npx` when possible, otherwise throw an error
    ---@see https://github.com/iamcco/markdown-preview.nvim/issues/690
    ---@see https://github.com/iamcco/markdown-preview.nvim/issues/695
    if not package_manager then error "Missing `yarn` or `npx` in the PATH" end

    local cmd = string.format(
      "!cd %s && cd app && COREPACK_ENABLE_AUTO_PIN=0 %s install --frozen-lockfile",
      plugin.dir,
      package_manager
    )

    vim.cmd(cmd)
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
