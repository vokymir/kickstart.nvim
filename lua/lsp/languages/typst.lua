-- my very own typst module
-- three main functions: watch file, show preview, enforce nice layout
--
-- The functionality is here and at the end of file is exported with keymaps and
-- everything needed.

-- module... well... not really
local M = {}

-- CONFIG

local function left_gutter_width()
  local width = 0

  -- number column
  if vim.wo.number or vim.wo.relativenumber then
    width = width + vim.wo.numberwidth
  end

  -- sign column
  if vim.wo.signcolumn ~= "no" then
    width = width + 3
  end

  -- fold column
  width = width + vim.wo.foldcolumn

  return width
end

local EDIT_WIN_WIDTH = vim.o.textwidth + left_gutter_width()
local DEBUG = true

local function log(msg)
  if DEBUG then
    print("[typst] " .. msg)
  end
end

-- STATE

local edit_buf = nil
local term_buf = nil

-- UTIL

-- find window for that buffer
local function find_win(buf)
  if not buf or not vim.api.nvim_buf_is_valid(buf) then
    return nil
  end

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == buf then
      return win
    end
  end

  return nil
end

local function git_root()
  local path = vim.fs.find('.git', {
    upward = true,
    type = 'directory',
  })[1]

  if not path then return nil end
  return vim.fs.dirname(path)
end

local function is_term_alive()
  return term_buf
      and vim.api.nvim_buf_is_valid(term_buf)
      and vim.bo[term_buf].buftype == 'terminal'
end

-- PUBLIC

function M.preview()
  local pdf = vim.fn.expand('%:p:r') .. '.pdf'
  vim.cmd('silent !zathura --fork ' .. pdf)
end

function M.enforce_layout()
  if not (edit_buf and term_buf) then
    log("skip layout: missing buffers")
    return
  end

  local edit_win = find_win(edit_buf)
  local term_win = find_win(term_buf)

  if not edit_win then
    log("skip layout: edit window not found")
    return
  end

  if not term_win then
    log("skip layout: term window not found")
    return
  end

  local edit_tab = vim.api.nvim_win_get_tabpage(edit_win)
  local term_tab = vim.api.nvim_win_get_tabpage(term_win)

  if edit_tab ~= term_tab then
    log("skip layout: different tabs")
    return
  end

  local total_width = vim.o.columns
  local term_width = total_width - EDIT_WIN_WIDTH

  vim.api.nvim_win_set_width(edit_win, EDIT_WIN_WIDTH)
  vim.api.nvim_win_set_width(term_win, term_width)

  log("layout enforced (edit=" .. EDIT_WIN_WIDTH .. ", term=" .. term_width .. ")")
end

function M.watch()
  -- reuse existing terminal buffer
  if is_term_alive() then
    local term_win = find_win(term_buf)

    if term_win then
      vim.api.nvim_set_current_win(term_win)
      log("focused existing terminal window")
    else
      vim.cmd("vsp")
      vim.cmd("wincmd l")
      vim.cmd("buffer " .. term_buf)
      log("reopened terminal buffer")

      vim.schedule(M.enforce_layout)
    end

    return
  end

  -- create new session
  edit_buf = vim.api.nvim_get_current_buf()

  vim.cmd("vsp")
  vim.cmd("wincmd l")

  local root = git_root() or vim.fn.getcwd()

  local cmd = string.format(
    "typst watch --root %s %s",
    vim.fn.shellescape(root),
    vim.fn.shellescape(vim.fn.expand('%:p'))
  )

  vim.cmd("terminal " .. cmd)

  term_buf = vim.api.nvim_get_current_buf()

  log("started typst watch")

  -- initial layout
  M.enforce_layout()

  -- autocmd group (safe re-init)
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

  vim.api.nvim_create_autocmd('TermClose', {
    group = group,
    buffer = term_buf,
    callback = function()
      log("terminal closed")
      term_buf = nil
    end,
  })
end

-- =========================================================
-- =========================================================
-- =========================================================
-- =========================================================

return {
  lsp = "tinymist",
  mason = "tinymist",

  config = {
    filetype = { "typst" },

    on_attach = function(_, bufnr)
      local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
      end

      map("<leader>tw", M.watch, "[t]ypst [w]atch")
      map("<leader>tl", M.enforce_layout, "[t]ypst fix [l]ayout")
      map("<leader>tp", M.preview, "[t]ypst [p]review PDF")
    end,
  },
}
