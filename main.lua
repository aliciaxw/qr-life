gs = require 'lib/gamestate'

local sim = require 'sim'

function love.load()
  gs.registerEvents()
  gs.switch(sim)
end
