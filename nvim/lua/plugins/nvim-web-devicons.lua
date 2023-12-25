return {
  "nvim-tree/nvim-web-devicons",
  config = function()
    require("nvim-web-devicons").set_icon({
      astro = {
        icon = "",
        color = "#d18770",
        name = "Astro",
      },
      sol = {
        icon = "",
        color = "#638EF6",
        name = "Solidity",
      },
    })
  end,
}
