# run.nvim

Set run commands for each project and run them with ease.

## Installation

Install the plugin with your preferred plugin manager.

```lua
{
    'rafaelcl292/run.nvim',
    config = true,
    event = 'VeryLazy',
    keys = {
        { '<leader>r', '<cmd>Run<cr>' },
        { '<leader>R', '<cmd>RunSet<cr>' },
    },
}
```

The run commands you set are persistent and are stored in `stdpath("data")` in a file named `run.json`.

## Commands

- `:Run` - Run the command set for the current project.
- `:RunSet` - Set the command for the current project.
- `:RunClearAll` - Clear all data from the plugin.
