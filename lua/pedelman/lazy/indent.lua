return {
    {
        "lukas-reineke/indent-blankline.nvim",
        name = "indent-blankline",
        config = function()
            require("ibl").setup {
                exclude = {
                    filetypes = { "dashboard" }
                }
            }
        end
    },
}

