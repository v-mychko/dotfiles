return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local gitsigns = require("gitsigns")
    gitsigns.setup({})

    vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { desc = "[H]unk [S]tage" })
    vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, { desc = "[H]unk [R]eset" })
    vim.keymap.set("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "[H]unk [U]nstage" })
    vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, { desc = "[H]unk [P]review" })
    vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, { desc = "[H]unk [D]iff" })
    vim.keymap.set("n", "<leader>hn", gitsigns.next_hunk, { desc = "[H]unk [N]ext" })
    vim.keymap.set("n", "<leader>hN", gitsigns.prev_hunk, { desc = "[H]unk [N]ext backwards" })
    vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer, { desc = "[H]unk [S]tage buffer" })
    vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer, { desc = "[H]unk [R]eset buffer" })
    vim.keymap.set("n", "<leader>hU", gitsigns.reset_buffer_index, { desc = "[H]unk [R]estore buffer" })
  end,
}
