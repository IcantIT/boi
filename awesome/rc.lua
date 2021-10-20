pcall(require, "luarocks.loader")
local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local beautiful     = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
                      require("awful.hotkeys_popup.keys")
local lain          = require("lain")
RC                  = {} -- global namespace, on top before require any modules

-- Variable definitions
beautiful.init("/home/yz/.config/awesome/themes/theme.lua")
modkey   = "Mod4"
altkey   = "Mod1"
terminal = "alacritty"
browser  = "qutebrowser"
editor   = os.getenv("EDITOR") or "nvim"

-- Custom Local Library
local main = {
  tags    = require("main.tags"),
  rules   = require("main.rules"),
}

-- Custom Local Library: Keys and Mouse Binding
local binding = {
  globalbuttons = require("binding.globalbuttons"),
  clientbuttons = require("binding.clientbuttons"),
  globalkeys    = require("binding.globalkeys"),
  bindtotags    = require("binding.bindtotags"),
  clientkeys    = require("binding.clientkeys")
}

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.spiral,
    lain.layout.centerwork,
    lain.layout.centerwork.horizontal,
    lain.layout.termfair,
}
lain.layout.termfair.nmaster = 3
lain.layout.termfair.ncol    = 1

-- Tags
RC.tags = main.tags()

-- Mouse and Key bindings
RC.globalkeys = binding.globalkeys()
RC.globalkeys = binding.bindtotags(RC.globalkeys)

-- Statusbar: Wibar
require("deco.statusbar")

-- Set root
root.buttons(binding.globalbuttons())
root.keys(RC.globalkeys)

-- Error handling
require("main.error-handling")

-- Rules
awful.rules.rules = main.rules(
  binding.clientkeys(),
  binding.clientbuttons()
)

-- Signals
require("main.signals")
