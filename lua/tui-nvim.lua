local M = {}

local defaults = {
  temp     = "/tmp/tui-nvim",
  method   = "edit",
  border   = "rounded",
  borderhl = "Normal",
  winhl    = "Normal",
  winblend = 0,
  height   = 0.8,
  width    = 0.8,
  y        = 0.5,
  x        = 0.5,
}

local function dimensions(opts)
  local cl = vim.o.columns
  local ln = vim.o.lines

  local width = math.ceil(cl * opts.width)
  local height = math.ceil(ln * opts.height - 4)

  local col = math.ceil((cl - width) * opts.x)
  local row = math.ceil((ln - height) * opts.y - 1)

  return {
      width = width,
      height = height,
      col = col,
      row = row
  }
end

function M.setup(user_opts)
  defaults = vim.tbl_deep_extend("force", defaults, user_opts)
end

function M:new(opts)
  opts = vim.tbl_deep_extend("force", defaults, opts)

  local function on_exit()
    vim.api.nvim_win_close(M.win, true)
    vim.api.nvim_buf_delete(M.buf, {force = true})

    if not io.open(opts.temp, "r") then
      return
    end

    for line in io.lines(opts.temp) do
      vim.cmd(opts.method .. " " .. vim.fn.fnameescape(line))
    end

    os.remove(opts.temp)
  end

  local dim = dimensions(opts)
  M.buf = vim.api.nvim_create_buf(false, true)
  M.win = vim.api.nvim_open_win(M.buf, true, {
    style    = "minimal",
    relative = "editor",
    border   = opts.border,
    height   = dim.height,
    width    = dim.width,
    col      = dim.col,
    row      = dim.row
  })

  vim.api.nvim_win_set_option(M.win, "winhl", ("Normal:%s"):format(opts.winhl))
  vim.api.nvim_win_set_option(M.win, "winhl", ("FloatBorder:%s"):format(opts.borderhl))
  vim.api.nvim_win_set_option(M.win, "winblend", opts.winblend)

	vim.api.nvim_buf_set_option(M.buf, "filetype", "TUI")

  vim.fn.termopen(opts.cmd, {on_exit = on_exit})
  vim.cmd("startinsert")
end

return M
