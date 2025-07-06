return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = function()
    cmp = require("cmp")
    cmp_autopairs = require("nvim-autopairs.completion.cmp")

    require("nvim-autopairs").setup({
      check_ts = true,
      ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
        java = false,
      },
    })

    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
