require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "javascript", "python", "cpp" },
  highlight = { enable = true },
  indent = { enable = true },
})
