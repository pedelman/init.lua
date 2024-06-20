return {
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>G", ":Git<CR>", {})
			vim.keymap.set("n", "<leader>GA", ":Git add .<CR>", {})
			vim.keymap.set("n", "<leader>GB", ":Git blame<CR>", {})
			vim.keymap.set("n", "<leader>GC", ":Git commit<CR>", {})
			vim.keymap.set("n", "<leader>GD", ":Git diff<CR>", {})
			vim.keymap.set("n", "<leader>GL", ":Git log<CR>", {})
			vim.keymap.set("n", "<leader>GP", ":Git push origin ", {})
			vim.keymap.set("n", "<leader>GS", ":Git<CR>", {})
		end,
	},
}
