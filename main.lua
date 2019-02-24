local cells = require 'cells'

function love.load()
  -- green background
  love.graphics.setBackgroundColor(72/255,244/255,66/255)

  -- initialize 5x5 2d array with dead cells
  cells.init(6, 6)
  cells.setCheckered()

  -- debug
  for i, v in ipairs(cells) do
    for j,w in ipairs(v) do
      print(i, j,w)
    end
  end
  
end

function love.update()
end

function love.draw()
  cells.draw()
  -- love.graphics.print('hello world! yay', 0, 0)
end

function love.mousepressed(x, y, button, istouch)
  if button == 1 then
    cells.click(x, y)
  end
end
