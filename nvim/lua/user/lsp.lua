local lspconfig = require('lspconfig')
local capabilities = require("cmp_nvim_lsp").default_capabilities()


lspconfig.clangd.setup({
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = lspconfig.util.root_pattern(".git", ".clangd", "compile_commands.json"),
})


-- Lua
lspconfig.lua_ls.setup({ capabilities = capabilities })

-- Python
lspconfig.pyright.setup({ capabilities = capabilities })
