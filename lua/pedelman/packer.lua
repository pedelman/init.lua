vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use({
        "rose-pine/neovim",
        as = "rose-pine",
        config = function()
            vim.cmd('colorscheme rose-pine')
        end

    })

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
    use('lukas-reineke/indent-blankline.nvim')
    use('lewis6991/gitsigns.nvim')
    use('nvim-tree/nvim-tree.lua')

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            {'neovim/nvim-lspconfig'},
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {
                'L3MON4D3/LuaSnip',
                tag = "v2.*",
                run = "make install_jsregexp",
                requires = {
                    "rafamadriz/friendly-snippets",
                    "saadparwaiz1/cmp_luasnip",
                },
            },
        }
    }

    use('ray-x/go.nvim')
    use('ray-x/guihua.lua')

    use {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                theme = 'hyper',
                config = {
                    week_header = {
                        enable = true,
                    },
                    footer = {
                        "",
                        "Be excellent to each other!",
                    },
                    shortcut = {
                        { desc = '󰊳 Update', group = '@property', action = 'PackerSync', key = 'u' },
                        {
                            icon = ' ',
                            icon_hl = '@variable',
                            desc = 'Files',
                            group = 'Label',
                            action = 'Telescope find_files',
                            key = 'f',
                        },
                    },
                },
            }
        end,
        requires = {'nvim-tree/nvim-web-devicons'}
    }
end)
