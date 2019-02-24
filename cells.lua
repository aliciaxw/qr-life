local cells = {}
cells.length = 50

-- Initializes [rows] x [cols] cell matrix with dead cells
function cells.init(rows, cols)
  love.graphics.setColor(255,255,255)

  for i=1,rows do
    cells[i] = {}
    for j=1,cols do
      cells[i][j] = false
    end
  end
end

-- Returns the pixel position of the top left corner of a cell
function cells.getPos(row, col)
  return row * cells.length, col * cells.length
end

-- Sets alive status of cell at [row, col] to true
function cells.setAlive(row, col)
  cells[row][col] = true
end

-- Sets alive status of cell at [row, col] to false
function cells.setDead(row, col)
  cells[row][col] = false
end

-- Toggles status of cell
function cells.toggle(row, col)
  cells[row][col] = not cells[row][col]
end

-- Toggles status of cell on click
function cells.click(mouseX, mouseY)
  for row, rows in ipairs(cells) do
    for col, _ in ipairs(rows) do
      local cellX, cellY = cells.getPos(row, col)
      if mouseX >= cellX and
         mouseY >= cellY and
         mouseX <= cellX + cells.length and
         mouseY <= cellY + cells.length
      then
         cells[row][col] = not cells[row][col]
      end
    end
  end
end

-- Creates a checkerboard pattern
function cells.setCheckered()
  local isAlive = true
  for row, rows in ipairs(cells) do
    if (#rows % 2 == 0) then isAlive = not isAlive end
    for col, cell in ipairs(rows) do
      if isAlive then
        cells.setAlive(row, col) else
        cells.setDead(row, col)
      end
      isAlive = not isAlive
    end
  end
end

-- Draws matrix of cells
function cells.draw()
  for row, rows in ipairs(cells) do
    for col, cell in ipairs(rows) do
      -- draw cell fill
      if cell then
          love.graphics.setColor(0,0,0) else
          love.graphics.setColor(1,1,1)
      end
      
      local x, y = cells.getPos(row, col)
      love.graphics.rectangle('fill', x, y, cells.length, cells.length)

      -- draw cell outline
      love.graphics.setColor(0.2,0.2,0.2)
      love.graphics.rectangle('line', x, y, cells.length, cells.length)
    end
  end
end

return cells
