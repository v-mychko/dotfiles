return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    conform.setup({
      format_on_save = function(...) end,
      formatters_by_ft = {
        python = { "ruff_organize_imports", "ruff_format" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        yaml = { "yamlfmt" },
        json = { "deno_fmt" },
      },
    })

    conform.formatters["clang-format"] = {
      prepend_args = { "--style=Google" },
    }

    local format = function()
      conform.format({
        async = true,
        lsp_format = "fallback",
        timeout_ms = 500,
      })
    end

    vim.keymap.set({ "n", "v" }, "<leader>fb", format, { desc = "[F]ormat [B]uffer" })
  end,
}
