require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  transparent_background = true,
  custom_highlights = function(colors)
    return {
      SnacksNormal = { fg = colors.text, bg = "NONE" },
      SnacksNormalNC = { fg = colors.text, bg = "NONE" },
      SnacksPicker = { fg = colors.text, bg = "NONE" },
      SnacksPickerBox = { fg = colors.text, bg = "NONE" },
      SnacksPickerInput = { fg = colors.text, bg = "NONE" },
      SnacksPickerList = { fg = colors.text, bg = "NONE" },
      SnacksPickerPreview = { fg = colors.text, bg = "NONE" },
      AlphaButtons = { fg = colors.text, bg = "NONE" },
      AlphaFooter = { fg = colors.lavender, bg = "NONE" },
      AlphaHeader = { fg = colors.lavender, bg = "NONE" },
      AlphaShortcut = { fg = colors.lavender, bg = "NONE" },
      SnacksPickerBorder = { fg = colors.lavender, bg = "NONE" },
      SnacksPickerBoxBorder = { fg = colors.lavender, bg = "NONE" },
      SnacksPickerInputBorder = { fg = colors.lavender, bg = "NONE" },
      SnacksPickerListBorder = { fg = colors.lavender, bg = "NONE" },
      SnacksPickerPreviewBorder = { fg = colors.lavender, bg = "NONE" },
      SnacksPickerTitle = { fg = colors.subtext0, bg = "NONE" },
      SnacksPickerBoxTitle = { fg = colors.subtext0, bg = "NONE" },
      SnacksPickerInputTitle = { fg = colors.subtext0, bg = "NONE" },
      SnacksPickerListTitle = { fg = colors.subtext0, bg = "NONE" },
      SnacksPickerPreviewTitle = { fg = colors.subtext0, bg = "NONE" },
    }
  end,
  integrations = {
    cmp = true,
    gitsigns = true,
    snacks = true,
    treesitter = true,
    notify = false,
    mini = {
      enabled = true,
      indentscope_color = "",
    },
  },
})

vim.cmd.colorscheme("catppuccin")
