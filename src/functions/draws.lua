function drawTitle()
  love.graphics.draw(titleimg, 0, 0)
  love.graphics.print('INSTRUCTIONS:', 16, 80)
  love.graphics.print('THIS IS YOUR LIFE BAR', 32, 96)
  love.graphics.print('EVERY TIME YOU MOVE,\nYOU WILL LOSE A\nMOVEMENT POINT', 32, 128)
  love.graphics.print('EVERY TIME YOU ATTACK,\nYOU WILL LOSE AN\nATTACK POINT', 32, 160)
  love.graphics.draw(curtainimg, 0, curtainpos)
end

function drawGame()
  love.graphics.translate(player.tx, player.ty)
  love.graphics.draw(interface,0,0)
  for a = 1, player.life do
    love.graphics.draw(player.barimg, player.barquads[1], (a*16)+16, 176)
  end
  for a = 1, player.atk do
    love.graphics.draw(player.barimg, player.barquads[2], (a*8)+24, 192)
  end
  for a = 1, player.move do
    love.graphics.draw(player.barimg, player.barquads[3], (a*8)+24, 208)
  end
  love.graphics.draw(gridimgs[gridselect],16,16)
  love.graphics.draw(door.img, door.quads[(door.animfile*8)+door.animframe], 112, 112)
  for a = 1, 7 do
    for b = 1, 7 do
      if grid[a][b] == 1 then love.graphics.rectangle('line', b*16, a*16, 16, 16) end
    end
  end
  if turn == 1 then
    for a = 1, #player.movepos do
      love.graphics.draw(selector.img, selector.quads[selector.animframe+8], player.movepos[a].x*16, player.movepos[a].y*16)
    end
    for a = 1, #player.movepos do
      if mousex >= player.movepos[a].x*16 and mousex <= (player.movepos[a].x+1)*16 and mousey >= player.movepos[a].y*16 and mousey <= (player.movepos[a].y+1)*16 then
        love.graphics.draw(selector.img, selector.quads[selector.animframe], player.movepos[a].x*16, player.movepos[a].y*16)
        break
      end
    end
  end

  for a = 1, #enemies do
    if enemies[a].type == 0 then love.graphics.draw(wormimg, enemies[a].quads[(enemies[a].animfile*8)+enemies[a].animframe], enemies[a].x*16, (enemies[a].y*16)-7) end
  end
  love.graphics.draw(player.img, player.quads[(player.animfile*8)+player.animframe], player.x*16, (player.y*16)-7)
  love.graphics.print('CAVE',112, 176)
  love.graphics.print(level, 112, 184)
  if turn == 0 then
    love.graphics.draw(banners, bannerquads[1], bannerpos, 120)
  elseif turn == 1 then
    if mousex >= 16 and mousex <= 64 and mousey >= 144 and mousey <= 160 then love.graphics.draw(player.btnimg, player.btnquads[2], 16, 144)
    else love.graphics.draw(player.btnimg, player.btnquads[1], 16, 144) end
  elseif turn == 2 or turn == 3 then
    love.graphics.draw(banners, bannerquads[5], bannerpos, 120)
    love.graphics.draw(player.diceimg, player.dicequads[player.dice], bannerpos+64, 124)
  elseif turn == 5 then
    love.graphics.print('ATTACK?', 16, 148)
    if mousex >= 56 and mousex <= 72 and mousey >= 144 and mousey <= 160 then love.graphics.draw(player.btnimg, player.btnquads[4], 56, 144)
    else love.graphics.draw(player.btnimg, player.btnquads[3], 56, 144) end
    if mousex >= 80 and mousex <= 96 and mousey >= 144 and mousey <= 160 then love.graphics.draw(player.btnimg, player.btnquads[6], 80, 144)
    else love.graphics.draw(player.btnimg, player.btnquads[5], 80, 144) end
  elseif turn == 6 then
    for a = 1, #player.movepos do
      love.graphics.draw(player.atkimg, player.atkquads[player.animframe], player.movepos[a].x*16, (player.movepos[a].y*16)-7)
    end
  elseif turn == 7 then
    love.graphics.draw(banners, bannerquads[2], bannerpos, 120)
  elseif turn == 12 then
    love.graphics.draw(banners, bannerquads[4], bannerpos, 120)
  elseif turn == 13 then
    love.graphics.draw(banners, bannerquads[3], bannerpos, 120)
  elseif turn == 16 then
    love.graphics.draw(curtainimg, 0, curtainpos)
  end
end