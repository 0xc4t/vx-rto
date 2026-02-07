require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua", "javascript", "python", "cpp", "c", "bash", "json", "markdown", "markdown_inline", "vim", "vimdoc"
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
})
