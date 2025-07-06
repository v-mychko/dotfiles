return {
  "folke/trouble.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    require("trouble").setup({
      focus = true,
    })

    vim.keymap.set("n", "<leader>td", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "[T]rouble [D]ocument" })
    vim.keymap.set("n", "<leader>tw", "<cmd>Trouble diagnostics toggle<CR>", { desc = "[T]rouble [W]orkspace" })
    vim.keymap.set("n", "<leader>tq", "<cmd>Trouble quickfix toggle<CR>", { desc = "[T]rouble [Q]uickfix" })
    vim.keymap.set("n", "<leader>tl", "<cmd>Trouble loclist toggle<CR>", { desc = "[T]rouble [L]ocations" })
  end,
}
