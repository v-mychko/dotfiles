return {
  "rmagatti/auto-session",
  config = function()
    require("auto-session").setup({})

    vim.keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "[W]orkspace [S]ave" })
    vim.keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "[W]orkspace [R]estore" })
  end,
}
