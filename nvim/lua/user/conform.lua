local ok, conform = pcall(require, "conform")
if not ok then
  vim.notify("conform.nvim not found", vim.log.levels.WARN)
  return
end

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black", "isort" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    rust = { "rustfmt" },
    go = { "gofmt", "goimports" },
    sh = { "shfmt" },
    bash = { "shfmt" },
  },

  -- Format on save (optional, disable if you prefer manual only)
  format_on_save = {
    timeout_ms = 1000,
    lsp_format = "fallback",
  },

  -- Notify when no formatter is available
  notify_on_error = true,
})

-- Keymap for manual format
vim.keymap.set({ "n", "v" }, "<leader>fm", function()
  conform.format({
    lsp_format = "fallback",
    async = false,
    timeout_ms = 1000,
  })
end, { desc = "Format file or range (conform)" })
