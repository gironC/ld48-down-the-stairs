selectorClass = {}
selectorClass.new = function()
  local self = {}
  self.quads = {}
  self.animframe = 1
  self.animtime = 0
  self.img = love.graphics.newImage('src/media/imgs/door.png')

  for a = 1, 2 do
    for b = 1, 8 do
      table.insert(self.quads, love.graphics.newQuad((b-1)*16, ((a-1)*16)+48, 16, 16, self.img:getDimensions()))
    end
  end
  
  self.update = function(dt)
  end
  self.animation = function(dt, player)
    self.animtime = self.animtime + dt
    if self.animtime >= 0.06 then
      self.animtime = 0
      self.animframe = self.animframe + 1
      if self.animframe > 8 then self.animframe = 1 end
    end
  end
  return self
end