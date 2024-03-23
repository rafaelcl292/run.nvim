local M = {}

local dir = vim.fn.stdpath('data')
local json_path = string.format('%s/run.json', dir)
local path = require('plenary.path'):new(json_path)

---@param data table{string, string}
local function write_data(data) path:write(vim.fn.json_encode(data), 'w') end

---@return table{string, string}
local function read_data()
    if not path:exists() then return {} end

    local out_data = path:read()

    if not out_data or out_data == '' then
        write_data({})
        return {}
    end

    return vim.fn.json_decode(out_data)
end

function M.set_cmd(cmd)
    local proj_path = vim.fn.getcwd()
    if not path:exists() then
        write_data({ [proj_path] = cmd })
        return
    end

    local data = read_data()
    data[proj_path] = cmd
    write_data(data)
end

function M.get_cmd()
    local proj_path = vim.fn.getcwd()
    if not path:exists() then return nil end
    local data = read_data()
    return data[proj_path]
end

function M.clear_data() write_data({}) end

return M
