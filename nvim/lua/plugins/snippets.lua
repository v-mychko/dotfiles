return {
  "L3MON4D3/LuaSnip",
  config = function()
    local luasnip = require("luasnip")
    local pyblock = {
      luasnip.snippet("pyblock", {
        luasnip.text_node({ "```{python}", "" }),
        luasnip.insert_node(0),
        luasnip.text_node({ "", "```" }),
      })
    }

    for _, ft in ipairs({ "quarto", "markdown" }) do
      luasnip.add_snippets(ft, pyblock)
    end
  end,
}
