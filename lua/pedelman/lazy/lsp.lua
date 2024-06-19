return {
	{
		"VonHeikemen/lsp-zero.nvim",
		lazy = true,
		config = false,
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = true,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				run = "make install_jsregexp",
				dependencies = {
					"hrsh7th/cmp-buffer",
					"rafamadriz/friendly-snippets",
					"saadparwaiz1/cmp_luasnip",
				},
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
		},
		config = function()
			-- Here is where you configure the autocompletion settings.
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_cmp()

			-- And you can configure cmp even more, if you want to.
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			vim.keymap.set({ "i", "s" }, "<Tab>", function()
				if luasnip.choice_active() then
					return "<cmd>lua require'luasnip'.jump(1)<Cr>"
				elseif luasnip.locally_jumpable(1) then
					return "<cmd>lua require'luasnip'.jump(1)<Cr>"
				else
					return "<Tab>"
				end
			end, {
				silent = true,
				expr = true,
			})

			vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
				if luasnip.choice_active() then
					return "<cmd>lua require'luasnip'.jump(-1)<Cr>"
				elseif luasnip.locally_jumpable(-1) then
					return "<cmd>lua require'luasnip'.jump(1)<Cr>"
				else
					return "<S-Tab>"
				end
			end, {
				silent = true,
				expr = true,
			})

			cmp.setup({
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping.confirm({ select = false }),
				}),
				sources = {
					{ name = "buffer" },
					{ name = "luasnip" },
					{ name = "nvim_lsp" },
				},
			})
		end,
	},
	{
		"scalameta/nvim-metals",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		ft = { "scala", "sbt", "java" },
		opts = function()
			local metals_config = require("metals").bare_config()
			metals_config.on_attach = function(_, bufnr)
				local opts = { buffer = bufnr, remap = false }

				vim.keymap.set("n", "gd", function()
					vim.lsp.buf.definition()
				end, opts)
				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover()
				end, opts)
			end

			metals_config.settings = {
				showImplicitArguments = true,
				showImplicitConversionsAndClasses = true,
				showInferredType = true,
				superMethodLensesEnabled = true,
			}
			metals_config.init_options.statusBarProvider = "on"
			metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

			return metals_config
		end,
		config = function(self, metals_config)
			local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = self.ft,
				callback = function()
					require("metals").initialize_or_attach(metals_config)
				end,
				group = nvim_metals_group,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			lsp_zero.on_attach(function(_, bufnr)
				local opts = { buffer = bufnr, remap = false }

				vim.keymap.set("n", "gd", function()
					vim.lsp.buf.definition()
				end, opts)
				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover()
				end, opts)
			end)

			local lspconfig = require("lspconfig")

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"gopls",
					"terraformls",
					"bashls",
				},
				handlers = {
					function(server_name)
						lspconfig[server_name].setup({})
					end,

					lua_ls = function()
						lspconfig.lua_ls.setup({
							on_init = function(client)
								local path = client.workspace_folders[1].name
								if
									vim.loop.fs_stat(path .. "/.luarc.json")
									or vim.loop.fs_stat(path .. "/.luarc.jsonc")
								then
									return
								end

								client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
									runtime = {
										version = "LuaJIT",
									},
									-- Make the server aware of Neovim runtime files
									workspace = {
										checkThirdParty = false,
										library = {
											vim.env.VIMRUNTIME,
											"${3rd}/luv/library",
										},
									},
								})
							end,
							settings = {
								Lua = {},
							},
						})
					end,

					gopls = function()
						lspconfig.gopls.setup({})
					end,

					terraformls = function()
						lspconfig.terraformls.setup({})
					end,

					bashls = function()
						lspconfig.bashls.setup({})
					end,
				},
			})
		end,
	},
}
