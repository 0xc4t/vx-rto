local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General
keymap("n", "<C-z>", "u", { desc = "Undo" })
keymap("n", "<C-y>", "<C-r>", { desc = "Redo" })
keymap("n", "<C-l>", ":vsplit<CR>", { desc = "Vertical Split" })

-- Navigation (Windows-like)
keymap("n", "<C-Left>", "<C-w>h", opts)
keymap("n", "<C-Right>", "<C-w>l", opts)
keymap("n", "<C-Down>", "<C-w>j", opts)
keymap("n", "<C-Up>", "<C-w>k", opts)

-- Insert mode movements
keymap("i", "<C-z>", "<Esc>uA", opts)
keymap("i", "<C-y>", "<Esc><C-r>A", opts)
keymap({'n', 'i', 'v'}, '<M-Left>', '<S-Left>', { desc = 'Move word back' })
keymap({'n', 'i', 'v'}, '<M-Right>', '<S-Right>', { desc = 'Move word forward' })

-- Clipboard
keymap('v', '<C-c>', '"+y', opts)
keymap('n', '<C-v>', '"+p', opts)
keymap('i', '<C-v>', '<C-r>+', opts)
keymap('v', '<C-v>', '"+p', opts)

-- Indentation in Visual Mode
keymap("v", "<Tab>", ">gv", opts)
keymap("v", "<S-Tab>", "<gv", opts)

-- NvimTree
keymap("n", "<C-n>", ":NvimTreeToggle<CR>", opts)

-- Telescope (Moved from telescope.lua if necessary, but keep here for overview)
keymap("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })
