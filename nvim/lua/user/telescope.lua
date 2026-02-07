local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    path_display = { "truncate " },
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
    },
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
  },
})

-- Custom Highlights for Telescope
local colors = {
  mauve = "#b4befe",
}

vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = colors.mauve, bg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = colors.mauve, bg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = colors.mauve, bg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = colors.mauve, bg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = colors.mauve, bg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = colors.mauve, bg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = colors.mauve, bg = "NONE" })
