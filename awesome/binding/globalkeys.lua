local gears         = require("gears")
local awful         = require("awful")
local lain          = require("lain")
local beautiful     = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
local _M = {}
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
function _M.get()
  local globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Tag browsing
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey            }, "j", function()
      awful.client.focus.bydirection("down")
        if client.focus then client.focus:raise() end end),
    awful.key({ modkey            }, "k", function()
      awful.client.focus.bydirection("up")
        if client.focus then client.focus:raise() end end),
    awful.key({ modkey            }, "h", function()
      awful.client.focus.bydirection("left")
        if client.focus then client.focus:raise() end end),
    awful.key({ modkey            }, "l", function()
      awful.client.focus.bydirection("right")
        if client.focus then client.focus:raise() end end),
    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),
    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- On-the-fly useless gaps change
    awful.key({ altkey, "Control" }, "Up", function () lain.util.useless_gaps_resize(1) end,
              {description = "increment useless gaps", group = "tag"}),
    awful.key({ altkey, "Control" }, "Down", function () lain.util.useless_gaps_resize(-1) end,
              {description = "decrement useless gaps", group = "tag"}),
    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "apps"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Control" }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Layout manipulation
    awful.key({ modkey,  "Shift"  }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "`", function () awful.layout.inc( 1)                    end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "`", function () awful.layout.inc(-1)                    end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),
    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Toogle wibox
    awful.key({ modkey }, "b",
          function ()
              myscreen = awful.screen.focused()
              myscreen.mywibox.visible = not myscreen.mywibox.visible
          end,
          {description = "toggle statusbar", group = "client"}
    ),
    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Volume Keys
    awful.key({}, "XF86AudioLowerVolume", function ()
      awful.util.spawn("amixer -q sset Master 5%-", false) end),
    awful.key({}, "XF86AudioRaiseVolume", function ()
      awful.util.spawn("amixer -q sset Master 5%+", false) end),
    awful.key({}, "XF86AudioMute", function ()
      awful.util.spawn("amixer -q set Master 1+ toggle", false) end),
    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Media Keys
    awful.key({}, "XF86AudioPlay", function()
      awful.util.spawn("playerctl play-pause", false) end),
    awful.key({}, "XF86AudioNext", function()
      awful.util.spawn("playerctl next", false) end),
    awful.key({}, "XF86AudioPrev", function()
      awful.util.spawn("playerctl previous", false) end),   
    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Brightness
    awful.key({ }, "XF86MonBrightnessDown", function ()
        awful.util.spawn("xbacklight -dec 10") end),
    awful.key({ }, "XF86MonBrightnessUp", function ()
        awful.util.spawn("xbacklight -inc 10") end),
    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- MPD control
    awful.key({ altkey, }, "Up",
        function ()
            awful.spawn.with_shell("mpc toggle")
        end,
        {description = "mpc toggle", group = "widgets"}),
    awful.key({ altkey, }, "Down",
        function ()
            awful.spawn.with_shell("mpc stop")
        end,
        {description = "mpc stop", group = "widgets"}),
    awful.key({ altkey, }, "Left",
        function ()
            awful.spawn.with_shell("mpc prev")
        end,
        {description = "mpc prev", group = "widgets"}),
    awful.key({ altkey, }, "Right",
        function ()
            awful.spawn.with_shell("mpc next")
        end,
        {description = "mpc next", group = "widgets"}),
    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Applications
    awful.key({ modkey }, "r", function ()
       awful.util.spawn("rofi -combi-modi drun,window -show combi") end,
        {description = "run rofi", group = "apps"}),
    awful.key({ modkey }, "w", function () awful.spawn(browser) end,
        {description = "launch browser", group = "apps"}),
    awful.key({ modkey }, "e", function ()
       awful.spawn(terminal.." -e lf") end,
        {description = "launch file manager", group = "apps"}),
    awful.key({ modkey }, "p", function ()
       awful.spawn(terminal.." -e ncmpcpp") end,
        {description = "launch ncmpcpp", group = "apps"}),
    awful.key({ }, "Print", function () 
       awful.util.spawn("scrot -e 'mv $f ~/Pictures/Screenshots/ 2>/dev/null'", false) end,
        {description = "take screenshot", group = "apps"})
   )

  return globalkeys
end
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
