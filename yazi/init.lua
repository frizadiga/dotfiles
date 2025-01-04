local _ = { ui = ui } -- diagnostics hack

require("full-border"):setup {
  type = _.ui.Border.ROUNDED, -- ui.Border.PLAIN | ui.Border.ROUNDED
}
