local M = {}

M.setup = function()
  local ok_mason, mason = pcall(require, "mason")

  -- Sembunyikan warning deprecation dari lspconfig (khusus Neovim 0.11+)
  -- Warning ini muncul karena plugin upstream belum update, bukan karena config kita salah
  local old_notify = vim.notify
  vim.notify = function(...) end

  local ok_lspconfig, lspconfig = pcall(require, "lspconfig")
  local ok_mason_lsp, mason_lspconfig = pcall(require, "mason-lspconfig")

  -- Kembalikan notify
  vim.notify = old_notify

  if not (ok_mason and ok_lspconfig and ok_mason_lsp) then
    vim.notify("LSP setup failed: Mason or lspconfig not found", vim.log.levels.WARN)
    return
  end

  mason.setup()

  local servers = { "lua_ls", "clangd", "pyright" }

  mason_lspconfig.setup({
    ensure_installed = servers,
  })

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  local on_attach = function(_, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    local keymap = vim.keymap.set
    keymap('n', 'gD', vim.lsp.buf.declaration, opts)
    keymap('n', 'gd', vim.lsp.buf.definition, opts)
    keymap('n', 'K', vim.lsp.buf.hover, opts)
    keymap('n', 'gi', vim.lsp.buf.implementation, opts)
    keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)
    keymap('n', 'gr', vim.lsp.buf.references, opts)
    keymap('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    keymap('n', '[d', vim.diagnostic.goto_prev, opts)
    keymap('n', ']d', vim.diagnostic.goto_next, opts)
  end

  -- Manual setup loop: Robust and Explicit
  for _, server in ipairs(servers) do
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    if server == "lua_ls" then
      opts.settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        },
      }
    end

    -- Setup server safely and silently
    local status_ok, _ = pcall(function()
        -- Bungkus setup dengan silent notify lagi untuk jaga-jaga
        local silent_notify = vim.notify
        vim.notify = function(...) end
        lspconfig[server].setup(opts)
        vim.notify = silent_notify
    end)

    if not status_ok then
      -- Silently fail or log debug if needed, but don't crash
    end
  end
end

return M
