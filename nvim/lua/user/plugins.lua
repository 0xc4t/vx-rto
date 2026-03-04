local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- Theme
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- Icons
  { "nvim-tree/nvim-web-devicons" },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("user.telescope")
    end
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("user.treesitter")
    end
  },

  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        view = { side = "left", width = 30 },
        renderer = { indent_markers = { enable = true } }
      })
    end
  },

  -- Status Line
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          globalstatus = true,
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
        }
      })
    end
  },

  -- Dashboard
  {
    "goolord/alpha-nvim",
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
        dashboard.button("s", "  Settings", ":e $MYVIMRC<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }
      dashboard.section.footer.val = "Emulate. Exploit. Evade. Pivot"
      alpha.setup(dashboard.opts)
    end
  },

  -- LSP & Mason (Konfigurasi digabung di sini)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", build = ":MasonUpdate" },
      { "williamboman/mason-lspconfig.nvim" },
      { "hrsh7th/cmp-nvim-lsp" },
    },
    config = function()
      require("user.lsp").setup()
    end
  },

  -- Autocomplete
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function() require("user.cmp") end
  },

  -- Helpers
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  { "numToStr/Comment.nvim", opts = {} },
  { "andweeb/presence.nvim", event = "VeryLazy", config = function() require("user.presence") end },
  { "utilyre/barbecue.nvim", dependencies = { "SmiteshP/nvim-navic" }, opts = {} },
  { "folke/which-key.nvim", event = "VeryLazy", opts = {} },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}, config = function() require("user.indentline") end },
  {
    "VonHeikemen/fine-cmdline.nvim",
    dependencies = {
      {"MunifTanjim/nui.nvim"}
    },
    config = function()
      require("user.fine-cmdline")
    end
  },
}

require("lazy").setup(plugins)
