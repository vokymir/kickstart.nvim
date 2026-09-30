require("basic")
require("load_plugins")

require("colorscheme")

require("plugins.oil")

require("lsp")
require("dap_my")
require("mason-cleanup").run() -- after both domains have called .want()

require("plugins.telescope")

require("git")
