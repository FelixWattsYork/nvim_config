-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- Snippets Configuration
require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/LuaSnip" } })
require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/LuaSnip/tex" } })
-- Require LuaSnip
local luasnip = require("luasnip")

luasnip.setup({
  enable_autosnippets = true,
})

-- Configure key mappings
vim.keymap.set({ "i", "s" }, "<Tab>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    return "<Tab>"
  end
end, { silent = true, expr = true })

vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    return "<S-Tab>"
  end
end, { silent = true, expr = true })

-- Setup nvim-cmp.
local cmp = require("cmp")

cmp.setup({
  mapping = {
    -- Use <Tab> to expand snippets
    ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback() -- fall back to normal tab functionality
      end
    end, { "i", "s" }),

    -- Use <S-Tab> to jump backward in snippets
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
})
vim.g.tex_conceal = "abdgm"

-- Enable spell check for specific file types
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "markdown", "tex", "text" }, -- List the file types here
  callback = function()
    vim.opt.spell = true
  end,
})

vim.opt.spelllang = "en_uk"

-- Use <localleader>c to trigger continuous compilation
vim.keymap.set("n", "<localleader>c", "<Plug>(vimtex-compile)")
