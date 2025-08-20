return {
  "rose-pine/neovim",
  name = "rose-pine",
  opts = {
    variant = "moon",
    extend_background_behind_borders = true,
    styles = {
      transparency = true,
    },
  },
  config = function()
    require("rose-pine").setup({
      variant = "moon",
      extend_background_behind_borders = true,
      styles = {
        transparency = true,
      },
    })
    vim.cmd("colorscheme rose-pine")
  end,
}
