Class = require 'lib/class'

Cells = Class{}

-- Initializes [rows] x [cols] cell matrix with dead cells
function Cells:init(rows, cols, scale)
  self.scale = scale
  self.length = rows
  self.board = {}

  for i=1,rows do
    self.board[i] = {}
    for j=1,cols do
      self.board[i][j] = false
    end
  end
end

-- Returns the pixel position of the top left corner of a cell
function Cells:getPos(row, col)
  return row * self.scale, col * self.scale
end

-- Sets alive status of cell at [row, col] to true
function Cells:setAlive(row, col)
  self.board[row][col] = true
end

-- Sets alive status of cell at [row, col] to false
function Cells:setDead(row, col)
  self.board[row][col] = false
end

-- Toggles status of cell
function Cells:toggle(row, col)
  self.board[row][col] = not self.board[row][col]
end

-- Toggles status of cell on click
function Cells:click(mouseX, mouseY)
  for row, rows in ipairs(self.board) do
    for col, _ in ipairs(rows) do
      local cellX, cellY = self:getPos(row, col)
      if mouseX >= cellX and
         mouseY >= cellY and
         mouseX <= cellX + self.scale and
         mouseY <= cellY + self.scale
      then
        self.board[row][col] = not self.board[row][col]
      end
    end
  end
end

-- Creates a checkerboard pattern
function Cells:setCheckered()
  local isAlive = true
  for row, rows in ipairs(self.board) do
    if (#rows % 2 == 0) then isAlive = not isAlive end
    for col, cell in ipairs(rows) do
      if isAlive then
        self:setAlive(row, col) else
        self:setDead(row, col)
      end
      isAlive = not isAlive
    end
  end
end

-- Returns the number of live neighbors of the cell at [row, col]
function Cells:getNumLiveNeighbors(row, col)
  local neighbors = 0
  for i=row-1,row+1 do
    for j=col-1,col+1 do
      if i > 0 and j > 0 and i <= self.length and j <= self.length then
        neighbors = neighbors + (self.board[i][j] and 1 or 0)
      end
    end
  end
  return neighbors - (self.board[row][col] and 1 or 0) -- kinda janky
end

-- Draws matrix of cells
function Cells:draw()
  for row, rows in ipairs(self.board) do
    for col, cell in ipairs(rows) do
      -- draw cell fill
      if cell then
          love.graphics.setColor(0.2,0.2,0.2) else
          love.graphics.setColor(1,1,1)
      end
      
      local x, y = self:getPos(row, col)
      love.graphics.rectangle('fill', x, y, self.scale, self.scale)

      -- draw cell outline
      love.graphics.setColor(0.8,0.8,0.8)
      love.graphics.rectangle('line', x, y, self.scale, self.scale)
    end
  end
end

return Cells
