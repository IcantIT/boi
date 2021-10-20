local gears    = require("gears")
local awful    = require("awful")
local wibox    = require("wibox")
local lain     = require("lain")
local deco = {
  wallpaper = require("deco.wallpaper"),
  taglist   = require("deco.taglist"),
  tasklist  = require("deco.tasklist"),
}
local taglist_buttons  = deco.taglist()
local tasklist_buttons = deco.tasklist()
local _M    = {}
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Wibar
local os       = os
dir = os.getenv("HOME") .. "/.config/awesome/themes/icons"
widget_ac                                 = dir .. "/ac.png"
widget_battery                            = dir .. "/battery.png"
widget_battery_low                        = dir .. "/battery_low.png"
widget_battery_empty                      = dir .. "/battery_empty.png"
widget_mem                                = dir .. "/mem.png"
widget_cpu                                = dir .. "/cpu.png"
widget_music                              = dir .. "/note.png"
widget_music_on                           = dir .. "/note_on.png"
widget_vol                                = dir .. "/vol.png"
widget_vol_low                            = dir .. "/vol_low.png"
widget_vol_no                             = dir .. "/vol_no.png"
widget_vol_mute                           = dir .. "/vol_mute.png"

local fnt      = "Terminus 9"
local markup   = lain.util.markup
local separators = lain.util.separators

-- Textclock
local clock = awful.widget.watch(
    "date +'%g %b %d %a %R'", 60,
    function(widget, stdout)
        widget:set_markup(" " .. markup.font(fnt, stdout))
    end
)

-- MEM
local memicon = wibox.widget.imagebox(widget_mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(fnt, " " .. mem_now.used .. "MB "))
    end
})

-- CPU
local cpuicon = wibox.widget.imagebox(widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(fnt, " " .. cpu_now.usage .. "% "))
    end
})

-- Battery
local baticon = wibox.widget.imagebox(widget_battery)
local bat = lain.widget.bat({
    settings = function()
        if bat_now.status and bat_now.status ~= "N/A" then
            if bat_now.ac_status == 1 then
                baticon:set_image(widget_ac)
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
                baticon:set_image(widget_battery_empty)
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
                baticon:set_image(widget_battery_low)
            else
                baticon:set_image(widget_battery)
            end
            widget:set_markup(markup.font(fnt, " " .. bat_now.perc .. "% "))
        else
            widget:set_markup(markup.font(fnt, " AC "))
            baticon:set_image(widget_ac)
        end
    end
})

-- ALSA volume
local volicon = wibox.widget.imagebox(widget_vol)
local volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            volicon:set_image(widget_vol_mute)
        elseif tonumber(volume_now.level) == 0 then
            volicon:set_image(widget_vol_no)
        elseif tonumber(volume_now.level) <= 50 then
            volicon:set_image(widget_vol_low)
        else
            volicon:set_image(widget_vol)
        end

        widget:set_markup(markup.font(fnt, " " .. volume_now.level .. "% "))
    end
})

-- MPD
local mpdicon = wibox.widget.imagebox(widget_music)
mpd = lain.widget.mpd({
    settings = function()
        mpd_notification_preset = {
            text = string.format("%s\n%s [%s]", mpd_now.title,
                   mpd_now.artist, mpd_now.album)
        }
	if mpd_now.state == "play" then
            artist = " " .. mpd_now.artist .. " "
            title  = mpd_now.title  .. " "
            mpdicon:set_image(widget_music_on)
        elseif mpd_now.state == "pause" then
            artist = " mpd "
            title  = "paused "
        else
            artist = ""
            title  = ""
            mpdicon:set_image(widget_music)
        end

        widget:set_markup(markup.font(fnt, markup("#EA6F81", artist) .. title))
    end
})

-- Separators
local spr     = wibox.widget.textbox(' ')
local arrl_dl = separators.arrow_left("#313131", "alpha")
local arrl_ld = separators.arrow_left("alpha", "#313131")

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)
  ))
  -- Create a taglist widget
   s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons
  }
  -- Create a tasklist widget
   s.mytasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons
  } 
  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s, bg = "#1A1A1A", fg = "#DDDDFF" })
  
  -- Add widgets to the wibox
    s.mywibox:setup {
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
	    spr,
      },
      s.mytasklist, -- Middle widget
      { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            spr,
            arrl_ld,
	    wibox.container.background(mpdicon, "#313131"),
            wibox.container.background(mpd.widget, "#313131"),
            arrl_dl,
            memicon,
            mem.widget,
            arrl_ld,
            wibox.container.background(cpuicon, "#313131"),
            wibox.container.background(cpu.widget, "#313131"),
            arrl_dl,
            volicon, 
            volume.widget,
            arrl_ld,
            wibox.container.background(baticon, "#313131"),
            wibox.container.background(bat.widget, "#313131"),
            arrl_dl,
            clock,
	    spr,
	    arrl_ld,
            wibox.container.background(s.mylayoutbox, "#313131"),
      },
     }
end)
