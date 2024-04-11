local data = require('data')

local M = {}

local auto_set_cmd

function M.setup(opts)
    opts = opts or { auto_set_cmd = true }
    auto_set_cmd = opts.auto_set_cmd
end

local clear_data = data.clear_data

local function set_cmd()
    local old_cmd = data.get_cmd()
    if old_cmd == nil then old_cmd = '' end
    local cmd = vim.fn.input('Enter command: ', old_cmd)
    data.set_cmd(cmd)
    return cmd
end

local function run()
    local cmd = data.get_cmd()
    if cmd == '' or cmd == nil then
        if not auto_set_cmd then
            print('No command set. Run :RunSet to set a command.')
            return
        end
        cmd = M.set_cmd()
        if cmd == '' then return end
    end

    -- Open a new terminal window at the bottom
    vim.cmd.new()
    vim.cmd.wincmd('J')
    vim.api.nvim_win_set_height(0, math.floor(vim.o.lines * 0.30))
    vim.cmd.terminal()
    vim.wait(150)

    -- Send the command to the terminal
    vim.fn.chansend(vim.bo.channel, { cmd .. '\r\n' })
end

vim.api.nvim_create_user_command('Run', run, { nargs = 0 })
vim.api.nvim_create_user_command('RunSet', set_cmd, { nargs = 0 })
vim.api.nvim_create_user_command('RunClearAll', clear_data, { nargs = 0 })

return M
