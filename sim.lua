gs = require 'lib/gamestate'
timer = require 'lib/timer'

local Cells = require 'cells'
local Sim = Class{}

function Sim:init()
  -- green background
  love.graphics.setBackgroundColor(72/255,244/255,66/255)

  -- initialize 5x5 2d array with dead cells
  self.main = Cells(10,10,25)
  self.prev = nil
  self.main:setCheckered()

  timer.every(0.5, function () Sim:tick() end)
end

function Sim:enter()
  -- debug
  print('run test')
  for i, v in ipairs(self.main.board) do
    for j,w in ipairs(v) do
      print(i, j,w)
    end
  end
end

function Sim:update(dt)
  timer.update(dt)
end

function Sim:draw()
  self.main:draw()
end

function Sim:mousepressed(x, y, button, istouch)
  if button == 1 then
    self.main:click(x, y)
  end
end

-- Controls all transitions
function Sim:tick()
  local next = self.main:clone()

  for row, rows in ipairs(self.main.board) do
    for col, cell in ipairs(rows) do
      local neighbors = self.main:getNumLiveNeighbors(row, col)

      if cell then  -- if cell is alive
        if neighbors < 2 or neighbors > 3 then next:setDead(row, col) end -- death cases
      else  -- if cell is dead
        if neighbors == 3 then next:setAlive(row, col) end -- live case
      end

    end
  end
  self.prev = self.main
  self.main = next
end

return Sim
