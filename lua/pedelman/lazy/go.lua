return {
	"ray-x/go.nvim",
	name = "go-support",
	config = function()
		require("go").setup({})
		local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				require("go.format").goimports()
			end,
			group = format_sync_grp,
		})

		vim.keymap.set("n", "<leader>gs", require("go.reftool").fillstruct, {})
	end,
	event = { "CmdlineEnter" },
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()',
}
