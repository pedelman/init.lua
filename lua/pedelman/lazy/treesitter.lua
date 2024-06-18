return {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    init = function(plugin)
        require("lazy.core.loader").add_to_rtp(plugin)
        require("nvim-treesitter.query_predicates")
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts_extend = { "ensure_installed" },
    opts = {
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
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
        },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
