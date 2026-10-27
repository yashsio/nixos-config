local themes = {}

-- Active theme
table.insert(themes, require("plugins.colorschemes.gruvbox-material"))

-- LazyVim colorscheme configuration
table.insert(themes, {
  "LazyVim/LazyVim",
  opts = {
    colorscheme = "gruvbox-material",
  },
})

return themes
