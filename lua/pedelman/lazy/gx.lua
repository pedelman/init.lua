return {
	{
		"chrishrb/gx.nvim",
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		cmd = { "Browse" },
		init = function()
			vim.g.netrw_nogx = 1 -- disable netrw gx
		end,
		dependencies = { "nvim-lua/plenary.nvim" },

		-- you can specify also another config if you want
		config = function()
			require("gx").setup({
				handlers = {
					plugin = true, -- open plugin links in lua (e.g. packer, lazy, ..)
					github = true, -- open github issues
					package_json = true, -- open dependencies from package.json
					search = true, -- search the web/selection on the web if nothing else is found
					go = true, -- open pkg.go.dev from an import statement (uses treesitter)
					jira = { -- custom handler to open Jira tickets (these have higher precedence than builtin handlers)
						name = "jira", -- set name of handler
						handle = function(mode, line, _)
							local ticket = require("gx.helper").find(line, mode, "(%u+-%d+)")
							if ticket and #ticket < 20 then
								return "http://jira.bigcommerce.com/browse/" .. ticket
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
