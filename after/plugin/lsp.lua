require('lsp-zero')

local lspconfig = require("lspconfig")
lspconfig.gopls.setup({})
lspconfig.lua_ls.setup{}

require("luasnip.loaders.from_vscode").lazy_load()

lspconfig.lua_ls.setup{
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}

local luasnip = require 'luasnip'

vim.keymap.set({"i", "s"}, "<Tab>", function() luasnip.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<S-Tab>", function() luasnip.jump(-1) end, {silent = true})

local cmp = require('cmp')

cmp.setup({
    completion = {
        completeopt = 'menu,menuone,noinsert',
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.confirm({select = false}),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
})

