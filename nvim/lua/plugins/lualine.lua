return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = false,
        component_separators = "",
        section_separations = "",
      },

      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "buffers" },
        lualine_x = {},
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
