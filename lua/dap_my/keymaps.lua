local dap = require("dap")

local map = function(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { desc = desc })
end

map("<leader>db", dap.toggle_breakpoint, "[d]ebug: toggle [b]reakpoint")
map("<leader>dc", dap.continue, "[d]ebug: [c]ontinue / start")
map("<leader>di", dap.step_into, "[d]ebug: step [i]nto")
map("<leader>do", dap.step_over, "[d]ebug: step [o]ver")
map("<leader>dO", dap.step_out, "[d]ebug: step [O]ut")
map("<leader>dr", dap.repl.toggle, "[d]ebug: toggle [r]epl")
map("<leader>dt", dap.terminate, "[d]ebug: [t]erminate")

map("<C-S-b>", dap.toggle_breakpoint, "debug: toggle [B]reakpoint")
map("<F5>", dap.continue, "debug: continue / start")
