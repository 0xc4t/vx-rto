-- Core configurations
require("user.options")
require("user.keymaps")
vim.opt.ignorecase = true

-- Plugin management (Lazy.nvim)
require("user.plugins")

-- Theme Configuration
-- Memastikan theme diload setelah plugin manager siap
local ok_theme, _ = pcall(require, "user.theme")
if not ok_theme then
  -- Fallback jika catppuccin gagal load (misal belum terinstall)
  vim.cmd.colorscheme("default")
end
