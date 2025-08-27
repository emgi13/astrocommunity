if not vim.g.neovide then return {} end

---@param scale_factor number
---@return number
local function clamp_scale_factor(scale_factor)
  return math.max(math.min(scale_factor, vim.g.neovide_max_scale_factor), vim.g.neovide_min_scale_factor)
end

---@param scale_factor number
---@param clamp? boolean
local function set_scale_factor(scale_factor, clamp)
  vim.g.neovide_scale_factor = clamp and clamp_scale_factor(scale_factor) or scale_factor
end

local function reset_scale_factor() vim.g.neovide_scale_factor = vim.g.neovide_initial_scale_factor end

---@param increment number
---@param clamp? boolean
local function change_scale_factor(increment, clamp) set_scale_factor(vim.g.neovide_scale_factor + increment, clamp) end

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      g = {
        neovide_increment_scale_factor = vim.g.neovide_increment_scale_factor or 0.1,
        neovide_min_scale_factor = vim.g.neovide_min_scale_factor or 0.7,
        neovide_max_scale_factor = vim.g.neovide_max_scale_factor or 2.0,
        neovide_initial_scale_factor = vim.g.neovide_scale_factor or 1,
        neovide_scale_factor = vim.g.neovide_scale_factor or 1,
        -- transparency = 0.6,
        neovide_opacity = 0.6,
        -- neovide_background_color = "#00000099",
        neovide_no_multigrid = true,
        neovide_window_blurred = true,
        neovide_floating_blur_amount_x = 2,
        neovide_floating_blur_amount_y = 2,
        neovide_hide_mouse_when_typing = true,
        neovide_confirm_quit = false,
        neovide_detach_on_quit = "always_quit",
        neovide_fullscreen = true,
        neovide_input_ime = true,

        -- winblend = 80,
        -- pumblend = 80,
        -- terminal_color_0 = "#45475A", -- Black
        -- terminal_color_1 = "#F38BA8", -- Red
        -- terminal_color_2 = "#A6E3A1", -- Green
        -- terminal_color_3 = "#F9E2AF", -- Yellow
        -- terminal_color_4 = "#89B4FA", -- Blue
        -- terminal_color_5 = "#F5C2E7", -- Purple
        -- terminal_color_6 = "#94E2D5", -- Cyan
        -- terminal_color_7 = "#BAC2DE", -- White
        --
        -- terminal_color_8 = "#585B70", -- Bright Black
        -- terminal_color_9 = "#F38BA8", -- Bright Red
        -- terminal_color_10 = "#A6E3A1", -- Bright Green
        -- terminal_color_11 = "#F9E2AF", -- Bright Yellow
        -- terminal_color_12 = "#89B4FA", -- Bright Blue
        -- terminal_color_13 = "#F5C2E7", -- Bright Purple
        -- terminal_color_14 = "#94E2D5", -- Bright Cyan
        -- terminal_color_15 = "#A6ADC8", -- Bright White
      },
      opt = {
        guifont = "JetBrainsMono NF:h11",
      },
    },
    commands = {
      NeovideSetScaleFactor = {
        function(event)
          local scale_factor, option = tonumber(event.fargs[1]), event.fargs[2]

          if not scale_factor then
            vim.notify(
              "Error: scale factor argument is nil or not a valid number.",
              vim.log.levels.ERROR,
              { title = "Recipe: neovide" }
            )
            return
          end

          set_scale_factor(scale_factor, option ~= "force")
        end,
        nargs = "+",
        desc = "Set Neovide scale factor",
      },
      NeovideResetScaleFactor = {
        reset_scale_factor,
        desc = "Reset Neovide scale factor",
      },
    },
    mappings = {
      n = {
        ["<C-=>"] = {
          function() change_scale_factor(vim.g.neovide_increment_scale_factor * vim.v.count1, true) end,
          desc = "Increase Neovide scale factor",
        },
        ["<C-->"] = {
          function() change_scale_factor(-vim.g.neovide_increment_scale_factor * vim.v.count1, true) end,
          desc = "Decrease Neovide scale factor",
        },
        ["<C-0>"] = { reset_scale_factor, desc = "Reset Neovide scale factor" },
        ["<M-CR>"] = {
          function() vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen end,
          desc = "Neovide Fullscreen",
        },
      },
    },
  },
}
