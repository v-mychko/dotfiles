return {
  "lukas-reineke/virt-column.nvim",
  config = function()
    require("virt-column").setup({
      char = '▕',
      virtcolumn = "100",
    })
    end,
}
