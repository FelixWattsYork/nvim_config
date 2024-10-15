local ls = require("luasnip")
-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

ls.add_snippets(nil, {
  all = {
    snip({
      trig = "date",
      name = "Date", -- Fixed typo here
      dscr = "Date in the form of YYYY-MM-DD",
    }, {
      text(os.date("%Y-%m-%d")),
    }),
  },
})
