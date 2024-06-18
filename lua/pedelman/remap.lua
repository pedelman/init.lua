
vim.g.mapleader = "\\"

vim.keymap.set("", "<CR>", ":noh <CR>")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>o", vim.cmd.NvimTreeOpen)
vim.keymap.set("n", "<leader>I", vim.cmd.PackerSync)

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", ";", ":")

vim.keymap.set("n", "<leader>A", "ggvG")
vim.keymap.set("n", "<leader>=", "ggvG=")

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
