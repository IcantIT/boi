local awful = require("awful")
local _M = {}
local l = awful.layout.suit  -- Just to save some typing: use an alias.
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
function _M.get ()
  local tags = {}
  local tagpairs = {
    names  = { "1", "2", "3", "4", "5", "6", "7" },
    layouts = { l.tile, l.tile, l.tile, l.tile, l.tile, l.tile.bottom, l.floating }
  }

  awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tagpairs.names, s, tagpairs.layouts)
  end)
  
  return tags
end
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
