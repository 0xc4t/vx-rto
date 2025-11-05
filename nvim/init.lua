vim.deprecate = function() end
require("user.options")
require("user.keymaps")
require("user.plugins")
require("user.lsp")
require("user.cmp")
require("user.telescope")
require("user.treesitter")
require("user.theme")
require("user.comment")
require("user.presence")
require("catppuccin").setup({
  transparent_background = true
})

