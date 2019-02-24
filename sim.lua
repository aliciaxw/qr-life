gs = require 'lib/gamestate'

local cells = require 'cells'
local sim = {}

function sim:init()
  -- green background
  love.graphics.setBackgroundColor(72/255,244/255,66/255)

  -- initialize 5x5 2d array with dead cells
  cells:init(6, 6)
  cells:setCheckered()
end

function sim:enter()
  -- debug
  for i, v in ipairs(cells) do
    for j,w in ipairs(v) do
      print(i, j,w)
    end
  end
end

function sim:draw()
  cells:draw()
end

function sim:mousepressed(x, y, button, istouch)
  if button == 1 then
    cells:click(x, y)
  end
end

return sim
