return {
  "mbbill/undotree",
  config = function()
    vim.keymap.set("n", "<leader>ts", "<cmd>UndotreeToggle<CR><cmd>UndotreeFocus<CR>", { desc = "Undo[T]ree [S]how" })
  end,
}
