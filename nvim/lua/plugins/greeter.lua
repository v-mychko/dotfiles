return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
    }

    dashboard.section.buttons.val = {
      dashboard.button("e", "  > New file", "<cmd>ene<CR>"),
      dashboard.button("SPC sf", "  > [S]earch [F]ile", "<cmd>Telescope find_files<CR>"),
      dashboard.button("SPC sg", "  > [S]earch [G]rep", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("SPC wr", "󰁯  > [W]orkspace [R]estore", "<cmd>SessionRestore<CR>"),
      dashboard.button("q", "  > Quit Neovim", "<cmd>qa<CR>"),
    }

    require("alpha").setup(dashboard.opts)
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
