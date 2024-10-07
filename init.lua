-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("luasnip").config.set_config({ -- Setting LuaSnip config

  -- Enable autotriggered snippets
  enable_autosnippets = true,
})
local ls = require("luasnip")

vim.cmd([[
" Expand or jump in insert mode
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 

" Jump forward through tabstops in visual mode
smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'
]])

require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/LuaSnip/" } })
