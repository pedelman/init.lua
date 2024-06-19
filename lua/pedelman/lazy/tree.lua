return {
	{
		"nvim-tree/nvim-tree.lua",
		name = "tree",
		config = function()
			require("nvim-tree").setup({
				filters = {
					dotfiles = false,
				},
			})
		end,
	},
}
