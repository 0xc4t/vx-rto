local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

-- warna border mauve
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#b4befe", bg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#b4befe", bg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#b4befe", bg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#b4befe", bg = "NONE" })
