return {
  "jpalardy/vim-slime",
  config = function()
    vim.g.slime_target = "wezterm"
    vim.g.slime_no_mappings = 1
    vim.g.slime_bracketed_paste = 1
    vim.g.slime_default_config = {
      pane_direction = "right",
    }

    vim.keymap.set("n", "<leader>rl", "<Plug>SlimeLineSend", { desc = "[R]un [L]ine" })
    vim.keymap.set("v", "<leader>rl", "<Plug>SlimeRegionSend", { desc = "[R]un [L]ines (visual)" })
    vim.keymap.set("n", "<leader>r", "<Plug>SlimeMotionSend", { desc = "[R]un + motion" })
  end,
}
