gs = require 'lib/gamestate'
timer = require 'lib/timer'

local Cells = require 'cells'
local sim = {}

function sim:init()
  -- green background
  love.graphics.setBackgroundColor(72/255,244/255,66/255)

  -- initialize 5x5 2d array with dead cells
  main = Cells(5, 5, 50)
  main:setCheckered()

  -- timer.every(3, function () sim:tick() end)
end

function sim:enter()
  -- debug
  print('run test')
  for i, v in ipairs(main.board) do
    for j,w in ipairs(v) do
      print(i, j,w)
    end
  end
end

function sim:update(dt)
  timer.update(dt)
end

function sim:draw()
  main:draw()
end

function sim:mousepressed(x, y, button, istouch)
  if button == 1 then
    main:click(x, y)
  end
end

-- Controls all transitions
function sim:tick()
  for row, rows in ipairs(main.board) do
    for col, cell in ipairs(rows) do
      local neighbors = main:getNeighbors(row, cell)
      -- TODO: how do i want to keep track of previous iterations, check hump

    end
  end
end

return sim
