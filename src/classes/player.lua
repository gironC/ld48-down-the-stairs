playerClass = {}
playerClass.new = function(x, y)
  local self = {}
  self.img = love.graphics.newImage('src/media/imgs/player.png')
  self.diceimg = love.graphics.newImage('src/media/imgs/dices.png')
  self.btnimg = love.graphics.newImage('src/media/imgs/btns.png')
  self.atkimg = love.graphics.newImage('src/media/imgs/atks.png')
  self.barimg = love.graphics.newImage('src/media/imgs/bars.png')
  self.quads = {}
  self.x = x
  self.y = y
  self.animtime = 0
  self.animframe = 1
  self.animfile = 0
  self.movepos = {}
  self.movenew = ''
  self.movecount = 0
  self.dice = 1
  self.dicetime = 0
  self.dicequads = {}
  self.btnquads = {}
  self.atkquads = {}
  self.barquads = {}
  self.tx = 0
  self.ty = 0
  self.life = 1
  self.move = 3
  self.atk = 3
  self.path = {}
  self.pathpos = 1

  for a = 1, 5 do
    for b = 1, 8 do
      table.insert(self.quads,love.graphics.newQuad((b-1)*16, (a-1)*16, 16, 16, self.img:getDimensions()))
    end
  end
  for a = 1, 6 do
    table.insert(self.dicequads, love.graphics.newQuad((a-1)*16, 0, 16, 16, self.diceimg:getDimensions()))
  end
  for a = 1, 2 do
    table.insert(self.btnquads, love.graphics.newQuad((a-1)*48, 0, 48, 16, self.btnimg:getDimensions()))
  end
  for a = 1, 6 do
    table.insert(self.btnquads, love.graphics.newQuad((a-1)*16, 16, 16, 16, self.btnimg:getDimensions()))
  end
  for a = 1, 8 do
    table.insert(self.atkquads, love.graphics.newQuad((a-1)*16, 0, 16, 16, self.atkimg:getDimensions()))
  end
  table.insert(self.barquads, love.graphics.newQuad(0, 0, 16, 16, self.barimg:getDimensions()))
  table.insert(self.barquads, love.graphics.newQuad(16, 0, 8, 16, self.barimg:getDimensions()))
  table.insert(self.barquads, love.graphics.newQuad(24, 0, 8, 16, self.barimg:getDimensions()))
  
  self.update = function(dt, enemies)
    if turn == 2 then
      self.dicetime = self.dicetime + dt
      if self.dicetime >= 0.2 then
        self.dicetime = 0
        self.dice = math.random(1,6)
      end
    elseif turn == 4 then
      if self.animframe == 4 and self.animtime == 0 then
        if self.movecount > 0 then
          if self.movenew == 'r' and self.x < 7 and grid[self.y][self.x+1] == 1 then
            self.x = self.x + 1
            self.movecount = self.movecount - 1
          elseif self.movenew == 'l' and self.x > 1 and grid[self.y][self.x-1] == 1 then
            self.x = self.x - 1
            self.movecount = self.movecount - 1
          elseif self.movenew == 'u' and self.y > 1 and grid[self.y-1][self.x] == 1 then
            self.y = self.y - 1
            self.movecount = self.movecount - 1
          elseif self.movenew == 'd' and self.y < 7 and grid[self.y+1][self.x] == 1 then
            self.y = self.y + 1
            self.movecount = self.movecount - 1
          else
            self.movecount = 0
            if self.atk == 0 then turn = 7 else turn = 5 end
            self.animfile = 0
          end
        else
          if self.atk == 0 then turn = 7 else turn = 5 end
          self.animfile = 0
        end
      end
    elseif turn == 6 then
      if self.animframe == 8 and self.animtime >= 0.06 then
        self.animfile = 0
        turn = 7
      end
    elseif turn == 11 then
      if self.life <= 0 then
        self.animframe = 1
        self.animtime = 0
        self.animfile = 4
        bannerpos = -144
        bannerstate = 0
        bannertime = 0
        curtainpos = -320
        curtaintime = 0
        curtainstate = 0
        turn = 12
        nextscreen = {'title', 0}
      elseif #enemies == 0 then turn = 13
      else
        self.movepos = {}
        bannerpos = -144
        bannerstate = 0
        bannertime = 0
        local moven = true
        if self.x > 1 and grid[self.y][self.x-1] == 1 then
          for a = 1, #enemies do
            if enemies[a].x == self.x-1 and enemies[a].y == self.y then moven = false break end
          end
          if moven == true then table.insert(self.movepos, {y=self.y,x=self.x-1,d='l'}) end
        end
        moven = true
        if self.x < 7 and grid[self.y][self.x+1] == 1 then
          for a = 1, #enemies do
            if enemies[a].x == self.x+1 and enemies[a].y == self.y then moven = false break end
          end
          if moven == true then table.insert(self.movepos, {y=self.y,x=self.x+1,d='r'}) end
        end
        moven = true
        if self.y > 1 and grid[self.y-1][self.x] == 1 then
          for a = 1, #enemies do
            if enemies[a].x == self.x and enemies[a].y == self.y-1 then moven = false break end
          end
          if moven == true then table.insert(self.movepos, {y=self.y-1,x=self.x,d='u'}) end
        end
        moven = true
        if self.y < 7 and grid[self.y+1][self.x] == 1 then
          for a = 1, #enemies do
            if enemies[a].x == self.x and enemies[a].y == self.y+1 then moven = false break end
          end
          if moven == true then table.insert(self.movepos, {y=self.y+1,x=self.x,d='d'}) end
        end
        turn = 0
      end
    elseif turn == 14 then
      self.path = aStar({x=self.x, y=self.y}, {x=7, y=6})
      table.insert(self.path,{x=7, y=6})
      table.insert(self.path,{x=7, y=7})
      self.animfile = 1
      self.animframe = 1
      self.animtime = 0
      turn = 15
    elseif turn == 15 then
      if self.animframe == 4 and self.animtime == 0 then
        if #self.path > 0 then
          self.x = self.path[1].x
          self.y = self.path[1].y
          table.remove(self.path, 1)
        else
          curtainpos = -320
          curtaintime = 0
          curtainstate = 0
          turn = 16
          level = level + 1
          nextscreen = {'level', level + 1}
        end
      end
    end
  end
  self.animation = function(dt)
    self.animtime = self.animtime + dt
    if self.animtime >= 0.07 then
      self.animtime = 0
      self.animframe = self.animframe + 1
      if self.animframe > 8 then
        self.animframe = 1
        self.tx = 0
        self.ty = 0
        if self.life <= 0 and turn > 11 then self.animframe = 7 end
      end
      if turn == 6 then
        if self.animframe > 3 then
          self.tx = math.random(-2, 2)
          self.ty = math.random(-2, 2)
        end
      end
    end
  end
  self.keypressed = function(key)
  end
  self.mousepressed = function(mx, my, button, istouch, enemies)
    if button == 1 then
      if turn == 1 then
        for a = 1, #self.movepos do
          if mousex >= self.movepos[a].x*16 and mousex <= (self.movepos[a].x+1)*16 and mousey >= self.movepos[a].y*16 and mousey <= (self.movepos[a].y+1)*16 then
            self.movenew = self.movepos[a].d
            self.movepos = {}
            self.animtime = 0
            self.move = self.move - 1
            turn = 2
            break
          end
        end
        if mousex >= 16 and mousex <= 64 and mousey >= 144 and mousey <= 160 then turn = 5 end
      elseif turn == 5 then
        if mousex >= 56 and mousex <= 72 and mousey >= 144 and mousey <= 160 then
          turn = 6
          self.animframe = 1
          self.animfile = 2
          self.animtime = 0
          self.movepos = {}
          self.atk = self.atk - 1
          if self.x > 1 and grid[self.y][self.x-1] == 1 then table.insert(self.movepos, {y=self.y,x=self.x-1}) end
          if self.x < 7 and grid[self.y][self.x+1] == 1 then table.insert(self.movepos, {y=self.y,x=self.x+1}) end
          if self.y > 1 and grid[self.y-1][self.x] == 1 then table.insert(self.movepos, {y=self.y-1,x=self.x}) end
          if self.y < 7 and grid[self.y+1][self.x] == 1 then table.insert(self.movepos, {y=self.y+1,x=self.x}) end
          for a = 1, #enemies do
            for b = 1, #self.movepos do
              if self.movepos[b].x == enemies[a].x and self.movepos[b].y == enemies[a].y then
                enemies[a].animframe = 1
                enemies[a].animfile = 3
                enemies[a].animtime = 0
                enemies[a].life = enemies[a].life - 1
                break
              end
            end
          end
        elseif mousex >= 80 and mousex <= 96 and mousey >= 144 and mousey <= 160 then
          turn = 7
        end
      end
    end
  end
  return self
end