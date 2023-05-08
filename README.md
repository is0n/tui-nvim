[![GitHub Stars](https://img.shields.io/github/stars/is0n/tui-nvim.svg?style=social&label=Star&maxAge=2592000)](https://github.com/is0n/tui-nvim/stargazers/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)
[![Last Commit](https://img.shields.io/github/last-commit/is0n/tui-nvim)](https://github.com/is0n/tui-nvim/pulse)
[![GitHub Open Issues](https://img.shields.io/github/issues/is0n/tui-nvim.svg)](https://github.com/is0n/tui-nvim/issues/)
[![GitHub Closed Issues](https://img.shields.io/github/issues-closed/is0n/tui-nvim.svg)](https://github.com/is0n/tui-nvim/issues?q=is%3Aissue+is%3Aclosed)
[![GitHub License](https://img.shields.io/github/license/is0n/tui-nvim?logo=GNU)](https://github.com/is0n/tui-nvim/blob/master/LICENSE)
[![Lua](https://img.shields.io/badge/Lua-2C2D72?logo=lua&logoColor=white)](https://github.com/is0n/fm-nvim/search?l=lua)

<h1 align='center'>tui-nvim</h1>

`tui-nvim` is [fm-nvim's](https://github.com/is0n/fm-nvim) successor that allows for much more customization.
tui-nvim's goal is to allow you to use your favorite terminal programs. Some examples are [zsh](https://www.zsh.org/), [lf](https://github.com/gokcehan/lf/), and [glow](https://github.com/charmbracelet/glow)

## Demo:
https://user-images.githubusercontent.com/57725322/167266328-fc6f8e57-c90f-4342-a2e8-813163cc9ec8.mp4

## Installation:

- [packer.nvim](https://github.com/wbthomason/packer.nvim):
  ```lua
  use {'is0n/tui-nvim'}
  ```

## Configuration:
```lua
 require("tui-nvim").setup ({
  -- File that is read from
  -- useful for file managers
  temp     = "/tmp/tui-nvim",

  -- Command used to open files
  method   = "edit",

  -- Example of a mapping
  mappings = {
    { "<ESC>", "<C-\\><C-n>:q<CR>" }
  },

  -- Execute functions
  -- upon open/exit
  on_open  = {},
  on_exit  = {},

  -- Window border (see ':h nvim_open_win')
  border   = "rounded",

  -- Highlight group for window/border (see ':h winhl')
  borderhl = "Normal",
  winhl    = "Normal",

  -- Window transparency (see ':h winblend')
  winblend = 0,

  -- Num from '0 - 1' for measurements
  height   = 0.8,
  width    = 0.8,
  y        = 0.5,
  x        = 0.5
})
```

## Usage:
tui-nvim does not come with any builtin support any terminal programs.
Intead, the user supports their own terminal programs.

If an option such as `height` is not provided, it will fallback to the defaults or the configuration found in `require("tui-nvim").setup()`

### Open [ranger](https://github.com/ranger/ranger) with the current file selected:
```lua
function Ranger()
  require("tui-nvim"):new {
    -- Write selected files to '/tmp/tui-nvim'
    cmd = "ranger --choosefiles=/tmp/tui-nvim --selectfile=" .. vim.fn.fnameescape(vim.fn.expand("%:p")),

    -- Read and open files from '/tmp/tui-nvim'
    temp = "/tmp/tui-nvim",

    -- Open files in splits
    method = "split",
  }
end

vim.cmd [[ command! Ranger :lua Ranger()<CR> ]]
```

### Open [lazygit](https://github.com/jesseduffield/lazygit) with the cwd:
```lua
function Lazygit()
  require("tui-nvim"):new {
    cmd      = "lazygit -w " .. vim.fn.fnameescape(vim.fn.expand("%:p:h"))
  }
end

vim.cmd [[ command! Lazygit :lua Lazygit()<CR> ]]
```
