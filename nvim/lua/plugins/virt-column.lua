return {
  "lukas-reineke/virt-column.nvim",
  config = function()
    require("virt-column").setup({
      char = '▕',
      virtcolumn = "88",
    })
    end,
}
