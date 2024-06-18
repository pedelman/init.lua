local lsp = require('lsp-zero')

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

lsp.on_attach(function(_, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
end)

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

