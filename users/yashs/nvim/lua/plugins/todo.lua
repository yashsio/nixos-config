return {
  {
    "yashsio/todo.nvim",
    config = function()
      require("todo").setup({ file = "~/.todos.txt" })
    end,
  },
}
