return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            highlight = { enable = true },
            indent = { enable = true },
            auto_install = true,
            sync_install = false,
            ensure_installed = {
                "bash",
                "html",
                "go",
                "javascript",
                "jsdoc",
                "json",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "tsx",
                "typescript",
                "xml",
                "yaml",
                "hcl",
                "terraform",
                "scala",
            },
        })
    end,
}
