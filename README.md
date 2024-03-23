# run.nvim

Set run commands for each project and run them with a ease.

## Installation

Install the plugin with your preferred plugin manager.

```lua
{
    'rafaelcl292/run.nvim',
    config = function()
        require('run').setup({
            -- Will run :RunSet if no command is set after :Run
            auto_set_cmd = true,
        })
    end,
}
```

## Commands

- `:Run` - Run the command set for the current project.
- `:RunSet` - Set the command for the current project.
- `:RunClearAll` - Clear all data from the plugin.

## Remaps

```lua
local run = require('run')
vim.keymap.set('n', '<leader>rr', run.run)
vim.keymap.set('n', '<leader>rs', run.set_cmd)
```
