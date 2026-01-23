return {
  -- Use the "opts" key to modify the default LazyVim cmp config
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      
      -- Add bordered windows to the existing options
      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
      
      -- If you want to add/modify sources, you can do it here:
      -- table.insert(opts.sources, { name = "copilot" }) 
      -- (Note: The Copilot extra usually adds itself automatically)
    end,
  },
}
