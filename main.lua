require 'src.classes.player'
require 'src.classes.selector'
require 'src.classes.door'
require 'src.classes.enemy'
require 'src.functions.grid'
require 'src.functions.loads'
require 'src.functions.draws'
require 'src.functions.updates'
require 'src.functions.astar'

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest', 1)
  love.graphics.setBackgroundColor(0,0.03529,0.098)
  mousex = 0
  mousey = 0
  screen = 'game'
  level = 1
  turn = 11 -- 0:banner 1:dir 2:dice 3:banner 4:mv 5:quest-atk 6:atk 7:banner 8:enemy-a* 9:enemy-move 10:enemy-atk 11:damage-count 12:game-over 13:banner 14:a* 15:walk 16:curtain
  gridselect = 0
  grid = {}
  gridimgs = {}
  bannerpos = -144
  bannertime = 0
  bannerstate = 0
  curtainpos = - 320
  curtaintime = 0
  curtainstate = 0
  nextscreen = {'menu',1}
  bannerquads = {}
  enemies = {}
  enemyturn = 1
  loadImages()
  player = playerClass.new(1,1)
  selector = selectorClass.new()
  door = doorClass.new()
  createGrid(1,10)
  createEnemies(level, player, 1)
  --createEnemies(level, player, 2)
end

function love.update(dt)
  mousex = math.floor(love.mouse.getX() / 3)
  mousey = math.floor(love.mouse.getY()/ 3)
  if screen == 'game' then gameUpdate(dt) end
end

function love.keypressed(key)
end

function love.mousepressed(x, y, button, istouch)
  player.mousepressed(x, y, button, istouch, enemies)
  if button == 2 then
    if door.animfile == 0 then
      door.animfile = 1
      door.animframe = 1
      door.animtime = 0
    end
  end
end

function love.draw()
  love.graphics.scale(3, 3)
  love.graphics.setColor(1,1,1)
  drawGame()
end