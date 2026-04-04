-- my very own typst module
-- three main functions: watch file, show preview, enforce nice layout

local M = {}

-- STATE

local edit_win = nil
local term_win = nil
local term_buf = nil
-- desired width in chars
local EDIT_WIN_WIDTH = 90

-- GETTERS

function M.edit_win()
  return edit_win
end

function M.term_win()
  return term_win
end

function M.term_buf()
  return term_buf
end

-- PRIVATE UTILITY FUNCTIONS

-- get the git root directory
local function git_root()
  local git_dir = vim.fn.finddir('.git', ';')

  if git_dir == '' then
    return nil
  end

  return vim.fn.fnamemodify(git_dir, ':h')
end

local function is_term_alive()
  return term_buf --
    and vim.api.nvim_buf_is_valid(term_buf)
    and vim.bo[term_buf].buftype == 'terminal'
end

-- PUBLIC FUNCTIONS

-- Preview PDF file inside an external ZATHURA window.
function M.preview()
  local pdf = vim.fn.expand '%:p:r' .. '.pdf'
  vim.cmd('silent !zathura --fork ' .. pdf)
end

-- Find the window in which typst is currently edited and resize it to 80 chars (+ 10 for numbers on the side and stuff)
-- Won't change cursor position.
function M.enforce_layout()
  if not edit_win or not vim.api.nvim_win_is_valid(edit_win) then
    return
  end

  local current_win = vim.api.nvim_get_current_win()

  -- exclude floating windows
  local cfg = vim.api.nvim_win_get_config(current_win)
  if cfg.relative ~= '' then
    return
  end

  vim.api.nvim_set_current_win(edit_win)
  vim.cmd('vertical resize ' .. EDIT_WIN_WIDTH)

  if vim.api.nvim_win_is_valid(current_win) then
    vim.api.nvim_set_current_win(current_win)
  end
end

function M.watch()
  -- if terminal already exist
  if is_term_alive() then
    if term_win and vim.api.nvim_win_is_valid(term_win) then
      -- jump here is unnecessarry, but it reminds the user that the 'watch
      -- terminal' already exists
      vim.api.nvim_set_current_win(term_win)
    else
      -- reopen that buffer
      vim.cmd('sb ' .. term_buf)
    end
    return
  end

  -- store which file is being watched
  edit_win = vim.api.nvim_get_current_win()

  -- create split
  vim.cmd 'vsp'
  vim.cmd 'wincmd l'

  -- open terminal
  local root = git_root() or vim.fn.getcwd()
  local cmd = string.format( --
    'typst watch --root %s %s',
    root,
    vim.fn.expand '%:'
  )
  vim.cmd('terminal ' .. cmd)

  -- track terminal
  term_win = vim.api.nvim_get_current_win()
  term_buf = vim.api.nvim_get_current_buf()

  -- initial layout
  M.enforce_layout()

  -- autocommands

  -- resize on window change
  local group = vim.api.nvim_create_augroup('TypstWatchResize', { clear = true })
  vim.api.nvim_create_autocmd({
    'VimResized',
    'WinNew',
    'WinClosed',
    'WinEnter',
    'BufWinEnter',
  }, {
    group = group,
    callback = function()
      vim.schedule(M.enforce_layout)
    end,
  })

  -- cleanup on term exit
  vim.api.nvim_create_autocmd('TermClose', {
    group = group,
    buffer = term_buf,
    callback = function()
      term_buf = nil
      term_win = nil
    end,
  })
end

return M
