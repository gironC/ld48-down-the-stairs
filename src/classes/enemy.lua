wormClass = {}
wormClass.new = function(x, y, t)
  local self = {}
  self.type = 0 -- 0:worm 1:xd 2:xdd
  self.turn = t
  self.life = 1
  self.initx = x
  self.inity = y
  self.x = x
  self.y = y
  self.quads = {}
  self.animfile = 0
  self.animframe = 1
  self.animtime = 0
  self.path = {}
  self.pathmove = {}
  self.movecount = 0 --worm:3 xd:5 xd2:2

  for a = 1, 5 do
    for b = 1, 8 do
      table.insert(self.quads, love.graphics.newQuad((b-1)*16, (a-1)*16, 16, 16, wormimg:getDimensions()))
    end
  end

  self.update = function(dt,player)
    if turn == 8 and enemyturn == self.turn then
      self.movecount = 0
      self.path = aStar(self,player)
      for a = 1, #self.path do
        self.movecount = self.movecount + 1
        table.insert(self.pathmove, self.path[a])
        if self.movecount == 4 then break end
      end
      self.animfile = 1
      turn = 9
    elseif turn == 9 and enemyturn == self.turn then
      if self.animframe == 4 and self.animtime == 0 then
        if #self.pathmove > 0 then
          self.x = self.pathmove[1].x
          self.y = self.pathmove[1].y
          table.remove(self.pathmove, 1)
        else
          self.animfile = 0
          if self.x > 1 and self.x-1 == player.x and self.y == player.y then turn = 10
          elseif self.x < 7 and self.x+1 == player.x and self.y == player.y then turn = 10
          elseif self.y > 1 and self.y-1 == player.y and self.x == player.x then turn = 10
          elseif self.y < 7 and self.y+1 == player.y and self.x == player.x then turn = 10
          else
            self.animfile = 0
            enemyturn = enemyturn + 1
            turn = 8
          end
          if turn == 10 then
            player.life = player.life - 1
            player.animfile = 3
            player.animtime = 0
            player.animframe = 1
            self.animfile = 2
            self.animtime = 0
            self.animframe = 1
          end
        end
      end
    elseif turn == 10 and enemyturn == self.turn then
      if self.animframe == 8 and self.animtime >= 0.05 then
        player.animfile = 0
        self.animfile = 0
        enemyturn = enemyturn + 1
        turn = 8
      end
    elseif turn == 11 then
      if self.life <= 0 then
        self.animtime = 0
        self.animfile = 4
        self.animframe = 1
      end
    end
  end
  self.animation = function(dt)
    self.animtime = self.animtime + dt
    if self.animtime >= 0.07 then
      self.animtime = 0
      self.animframe = self.animframe + 1
      if self.animframe > 8 then self.animframe = 1 end
    end
  end
  return self
end