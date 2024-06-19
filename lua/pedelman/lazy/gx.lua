return {
	{
		"chrishrb/gx.nvim",
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		cmd = { "Browse" },
		init = function()
			vim.g.netrw_nogx = 1 -- disable netrw gx
		end,
		dependencies = { "nvim-lua/plenary.nvim" },

		config = function()
			require("gx").setup({
				handlers = {
					plugin = true,
					github = true,
					package_json = true,
					search = true,
					go = true,
					jira = {
						name = "jira",
						handle = function(mode, line, _)
							local ticket = require("gx.helper").find(line, mode, "(%u+-%d+)")
							if ticket and #ticket < 20 then
								local jira_host = os.getenv("JIRA_HOST")
								return jira_host .. "/browse/" .. ticket
							end
						end,
					},
				},
				handler_options = {
					search_engine = "duckduckgo",
				},
			})
		end,
	},
}
