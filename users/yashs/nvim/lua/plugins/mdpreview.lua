return {
  {
    "yashsio/mdpreview.nvim",
    ft = { "markdown" },
    opts = {},
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Markdown preview" },
      { "<leader>mc", "<cmd>MarkdownPreviewClose<cr>", desc = "Close markdown preview" },
      { "<leader>mt", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle markdown preview" },
    },
  },
}
