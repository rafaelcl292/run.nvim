local data = require('data')

local M = {}

local auto_set_cmd

function M.setup(opts)
    opts = opts or { auto_set_cmd = true }
    auto_set_cmd = opts.auto_set_cmd
end

M.clear_data = data.clear_data

function M.set_cmd()
    local cmd = vim.fn.input('Enter command: ')
    data.set_cmd(cmd)
    return cmd
end

function M.run()
    local cmd = data.get_cmd()
    if cmd == '' or cmd == nil then
        if not auto_set_cmd then
            print('No command set. Run :RunSet to set a command.')
            return
        end
        cmd = M.set_cmd()
    end
    print('Running...')

    vim.fn.jobstart(cmd, {
        stdout_buffered = true,
        on_stdout = function(_, out, _)
            local allLines = ''
            for _, line in ipairs(out) do
                allLines = allLines .. line .. '\n'
            end
            vim.notify(allLines)
        end,
    })
end

vim.api.nvim_create_user_command('Run', M.run, { nargs = 0 })
vim.api.nvim_create_user_command('RunSet', M.set_cmd, { nargs = 0 })
vim.api.nvim_create_user_command('RunClearAll', M.clear_data, { nargs = 0 })

return M
