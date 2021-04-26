doorClass = {}
doorClass.new = function()
  local self = {}
  self.animtime = 0
  self.animframe = 1
  self.animfile = 0
  self.img = love.graphics.newImage('src/media/imgs/door.png')
  self.quads = {}

  for a = 1, 3 do
    for b = 1, 8 do
      table.insert(self.quads,love.graphics.newQuad((b-1)*16, (a-1)*16, 16, 16, self.img:getDimensions()))
    end
  end

  self.animation = function(dt)
    self.animtime = self.animtime + dt
    if self.animtime >= 0.08 then
      self.animtime = 0
      self.animframe = self.animframe + 1
      if self.animframe > 8 then
        self.animframe = 1
        if self.animfile == 1 then self.animfile = 2 end
      end
    end
  end
  return self
end