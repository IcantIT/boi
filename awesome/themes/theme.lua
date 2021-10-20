---------------------------
--     Awesome theme     --
---------------------------

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local dpi   = require("beautiful.xresources").apply_dpi
local os = os

local theme = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/icons"
theme.wallpaper                                 = "/home/yz/Pictures/rain1.jpg"
theme.font                                      = "Terminus 9"
theme.useless_gap                               = dpi(3)
theme.fg_normal                                 = "#DDDDFF"
theme.fg_focus                                  = "#EA6F81"
theme.fg_urgent                                 = "#CC9393"
theme.bg_normal                                 = "#1A1A1A"
theme.bg_focus                                  = "#313131"
theme.bg_urgent                                 = "#1A1A1A"
theme.border_width                              = dpi(3)
theme.border_normal                             = "#3F3F3F"
theme.border_focus                              = "#7F7F7F"
theme.border_marked                             = "#CC9393"
theme.tasklist_bg_focus                         = "#1A1A1A"
theme.layout_tile                               = theme.dir .. "/tile.png"
theme.layout_tileleft                           = theme.dir .. "/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/tiletop.png"
theme.layout_spiral                             = theme.dir .. "/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/dwindle.png"
theme.layout_floating                           = theme.dir .. "/floating.png"
theme.layout_termfair                         = theme.dir .. "/centerfair.png"
theme.layout_centerwork                         = theme.dir .. "/centerwork.png"
theme.layout_centerworkh                        = theme.dir .. "/centerworkh.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
return theme
