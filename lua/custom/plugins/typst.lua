return {
  'windwp/nvim-autopairs',
  config = function()
    local npairs = require 'nvim-autopairs'
    local Rule = require 'nvim-autopairs.rule'
    local cond = require 'nvim-autopairs.conds'

    -- 1. Initialize the plugin first!
    npairs.setup {
      check_ts = true, -- optional: use treesitter to check for pairs
    }

    -- 2. NOW add your custom Typst rules
    npairs.add_rules {
      Rule('$', '$', 'typst')
        -- Don't pair if the next character is already a $
        :with_pair(cond.not_after_text '$')
        -- Allow deleting both if they are empty
        :with_del(cond.after_text '$'),
    }
  end,
}
