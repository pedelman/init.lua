return {
    "mfussenegger/nvim-dap",
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',
        'leoluz/nvim-dap-go',
    },
    config = function ()
        local dap = require 'dap'
        local dapui = require 'dapui'

        require('mason-nvim-dap').setup {
            automatic_installation = true,
            handlers = {},
            ensure_installed = {
                'delve',
            },
        }

        dapui.setup {}

        require('dap-go').setup {
            dap_configurations = {
                {
                    type = "go",
                    name = "Attach remote",
                    mode = "remote",
                    request = "attach",
                },
            },
            delve = {
                path = "dlv",
                initialize_timeout_sec = 20,
                port = "${port}",
                args = {},
                build_flags = "",
                detached = true,
                cwd = nil,
            },
        }

        vim.keymap.set('n', '<F1>', function() dap.continue() end)
        vim.keymap.set('n', '<F9>', function() dap.step_over() end)
        vim.keymap.set('n', '<F8>', function() dap.step_into() end)
        vim.keymap.set('n', '<F7>', function() dap.step_out() end)
        vim.keymap.set('n', '<Leader>d', function() dap.toggle_breakpoint() end)
        vim.keymap.set('n', '<Leader>D', function() dap.set_breakpoint() end)
        vim.keymap.set('n', '<Leader>dp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
        vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
        vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)
        vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
            require('dap.ui.widgets').hover()
        end)
        vim.keymap.set({'n', 'v'}, '<Leader>dw', function()
            require('dap.ui.widgets').preview()
        end)
        vim.keymap.set('n', '<Leader>df', function()
            local widgets = require('dap.ui.widgets')
            widgets.centered_float(widgets.frames)
        end)
        vim.keymap.set('n', '<Leader>ds', function()
            local widgets = require('dap.ui.widgets')
            widgets.centered_float(widgets.scopes)
        end)

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close
    end
}
