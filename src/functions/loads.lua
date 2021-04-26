function loadImages()
  --GRIDS
  table.insert(gridimgs,love.graphics.newImage('src/media/imgs/grid-1.png'))
  table.insert(gridimgs,love.graphics.newImage('src/media/imgs/grid-2.png'))
  table.insert(gridimgs,love.graphics.newImage('src/media/imgs/grid-3.png'))
  table.insert(gridimgs,love.graphics.newImage('src/media/imgs/grid-4.png'))
  table.insert(gridimgs,love.graphics.newImage('src/media/imgs/grid-5.png'))
  table.insert(gridimgs,love.graphics.newImage('src/media/imgs/grid-6.png'))
  table.insert(gridimgs,love.graphics.newImage('src/media/imgs/grid-7.png'))
  table.insert(gridimgs,love.graphics.newImage('src/media/imgs/grid-8.png'))
  table.insert(gridimgs,love.graphics.newImage('src/media/imgs/grid-9.png'))
  table.insert(gridimgs,love.graphics.newImage('src/media/imgs/grid-10.png'))
  --OTHER
  interface = love.graphics.newImage('src/media/imgs/interface.png')
  banners = love.graphics.newImage('src/media/imgs/banners.png')
  wormimg = love.graphics.newImage('src/media/imgs/enemy-1.png')
  curtainimg = love.graphics.newImage('src/media/imgs/curtain.png')
  titleimg = love.graphics.newImage('src/media/imgs/title.png')

  for a = 1, 5 do
    table.insert(bannerquads,love.graphics.newQuad(0, (a-1)*24, 144, 24, banners:getDimensions()))
  end

  local font = love.graphics.newImageFont('src/media/font.png',' ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890¡!¿?()[]-_.,')
  love.graphics.setFont(font)
end

function createEnemies(level, player, t)
  local posgrid = {}
  local gridselect = 0
  for a = 1, 7 do
    for b = 1, 7 do
      if grid[a][b] == 1 then
        if grid[a] ~= player.y and grid[b] ~= player.x then table.insert(posgrid, {a,b}) end
      end
    end
  end
  gridselect = math.random(1,#posgrid)
  table.insert(enemies, wormClass.new(posgrid[gridselect][2], posgrid[gridselect][1], t))
end