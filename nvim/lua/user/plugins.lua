local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  { "catppuccin/nvim", name = "catppuccin", priority = 100000 },
  { "nvim-telescope/telescope.nvim", tag = "0.1.8", dependencies = { "nvim-lua/plenary.nvim" }},
  { "nvim-treesitter/nvim-treesitter", build= ":TSUpdate" },
  { "andweeb/presence.nvim",event = "VeryLazy",},
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },


  -- nvim-lualine 
{ 
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup({
      options = {
        theme = {
          normal = {
            a = { bg = '#89b4fa', fg = '#1e1e2e', gui = 'bold' },
            b = { bg = '#313244', fg = '#cdd6f4' },
            c = { bg = 'NONE', fg = '#cdd6f4' },
          },
          insert = { a = { bg = '#a6e3a1', fg = '#1e1e2e', gui = 'bold' } },
          visual = { a = { bg = '#cba6f7', fg = '#1e1e2e', gui = 'bold' } },
          replace = { a = { bg = '#89b4fa', fg = '#1e1e2e', gui = 'bold' } },
          inactive = {
            a = { bg = 'NONE', fg = '#6c7086' },
            b = { bg = 'NONE', fg = '#6c7086' },
            c = { bg = 'NONE', fg = '#6c7086' },
          },
        },
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
      },
    })
  end,
},


  -- nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        view = { side = "right", width = 30 },
        update_focused_file = { enable = true, update_cwd = false },

        renderer = {
          highlight_modified = "all",
          highlight_git = true,

          root_folder_label = false,

          icons = { webdev_colors = false, show = { folder_arrow = false } },
          indent_markers = { enable = true },
        },
      })
    end,
  },

  -- Barbecue
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = { create_autocmd = true, attach_navic = true },
  },

  -- Alpha
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "                         ",
        " ▗▄▖               ▗▄      ",
        " █▀█               ▟█  ▐▌  ",
        "▐▌ ▐▌ ▝█ █▘  ▟██▖ ▐▘█ ▐███ ",
        "▐▌█▐▌  ▐█▌  ▐▛  ▘▗▛ █  ▐▌  ",
        "▐▌ ▐▌  ▗█▖  ▐▌   ▐███▌ ▐▌  ",
        " █▄█   ▟▀▙  ▝█▄▄▌   █  ▐▙▄ ",
        " ▝▀▘  ▝▀ ▀▘  ▝▀▀    ▀   ▀▀ ",
        "                         ",
        "                         ",
      }


      dashboard.section.buttons.val = {
	dashboard.button("n", "  New file", ":ene <BAR> startinsert<CR>"),
        dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
        dashboard.button("g", "󰈞  Live grep", ":Telescope live_grep<CR>"),
        dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }

      dashboard.section.footer.val = "Emulate. Exploit. Evade. Pivot"
      dashboard.section.buttons.opts.spacing = 0	
      alpha.setup(dashboard.opts)
    end,
  },
  -- CMP + LSP
  { "hrsh7th/nvim-cmp", dependencies = {
      "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path", "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
  }},
  { "neovim/nvim-lspconfig" },
},


{
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup()
  end
}

require("lazy").setup(plugins, {})
