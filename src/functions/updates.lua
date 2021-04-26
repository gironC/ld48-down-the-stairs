function titleUpdate(dt)
  if turn > 0 then
    if curtainstate == 0 then
      if curtainpos < -40 then curtainpos = curtainpos + (400 * dt)
      else
        curtainpos = -32
        curtainstate = 1
      end
    elseif curtainstate == 1 then
      curtaintime = curtaintime + dt
      if curtaintime >= 1 then
        if nextscreen[1] == 'game' then
          screen = 'game'
          level = 1
          player.animfile = 0
          player.life = 4
          player.atk = 2
          player.move = 2
          player.x = 1
          player.y = 1
          turn = 11
          curtaintime = 0
          curtainstate = 2
        else
          curtaintime = 0
          curtainstate = 2
          screen = 'title'
        end
      end
    else
      if curtainpos < 256 then curtainpos = curtainpos + (400 * dt)
      else
        curtainpos = -320
        curtainstate = 0
        if screen == 'title' then turn = 0 end
      end
    end
  end
end

function gameUpdate(dt)
  player.update(dt, enemies)
  player.animation(dt)
  selector.animation(dt)
  door.animation(dt)
  for a= 1, #enemies do
    enemies[a].update(dt, player)
    enemies[a].animation(dt)
  end
  if turn == 0 or turn == 7 then
    local toremove = {}
    for a = 1, #enemies do
      if enemies[a].life == 0 and enemies[a].animframe == 8 and enemies[a].animtime >= 0.06 then table.insert(toremove, a) end
    end
    for a = 1, #toremove do
      table.remove(enemies, toremove[a])
      player.atk = player.atk + 1
      player.move = player.move + 1
    end
    for a = 1, #enemies do
      enemies[a].turn = a
    end
    if bannerstate == 0 then
      if bannerpos < 0 then bannerpos = bannerpos + (400 * dt)
      else
        bannerpos = 0
        bannerstate = 1
      end
    elseif bannerstate == 1 then
      bannertime = bannertime + dt
      if bannertime >= 1 then
        bannertime = 0
        bannerstate = 2
      end
    else
      if bannerpos < 144 then bannerpos = bannerpos + (400 * dt)
      else
        bannerpos = -144
        bannerstate = 0
        if turn == 0 then
          if player.move > 0 then turn = 1
          else
            if player.atk == 0 then turn = 7 else turn = 5 end
          end
        elseif turn == 7 then
          if #enemies > 0 then turn = 8
          else
            turn = 13
            door.animfile = 1
            door.animframe = 1
            door.animtime = 0
          end
        end
      end
    end
  elseif turn == 2 then
    if bannerstate == 0 then
      if bannerpos < 0 then bannerpos = bannerpos + (400 * dt)
      else
        bannerpos = 0
        bannerstate = 1
      end
    elseif bannerstate == 1 then
      bannertime = bannertime + dt
      if bannertime >= 1 then
        bannertime = 0
        player.movecount = player.dice
        turn = 3
      end
    end
  elseif turn == 3 then
    if bannerstate == 1 then
      bannertime = bannertime + dt
      if bannertime >= 1 then
        bannertime = 0
        bannerstate = 2
      end
    elseif bannerstate == 2 then
      if bannerpos < 144 then bannerpos = bannerpos + (400 * dt)
      else
        bannerpos = -144
        bannerstate = 0
        turn = 4
        player.animfile = 1
      end
    end
  elseif turn == 8 then
    if enemyturn > #enemies then
      turn = 11
      enemyturn = 1
    end
  elseif turn == 12 or turn == 13 then
    if bannerstate == 0 then
      if bannerpos < 0 then bannerpos = bannerpos + (400 * dt)
      else
        bannerpos = 0
        bannerstate = 1
      end
    elseif bannerstate == 1 then
      bannertime = bannertime + dt
      if bannertime >= 1 then
        bannertime = 0
        bannerstate = 2
      end
    else
      if bannerpos < 144 then bannerpos = bannerpos + (400 * dt)
      else
        bannerpos = -144
        bannerstate = 0
        if turn == 12 then turn = 16
        elseif turn == 13 then turn = 14 end
      end
    end
  elseif turn == 16 then
    if curtainstate == 0 then
      if curtainpos < -40 then curtainpos = curtainpos + (400 * dt)
      else
        curtainpos = -32
        curtainstate = 1
      end
    elseif curtainstate == 1 then
      curtaintime = curtaintime + dt
      if curtaintime >= 1 then
        if nextscreen[1] == 'title' then
          curtaintime = 0
          curtainstate = 2
          screen = 'title'
          turn = 1
        elseif nextscreen[1] == 'level' then
          player.x = 1
          player.y = 1
          door.animfile = 0
          turn = 11
          createGrid(level, player)
        end
      end
    else
      if curtainpos < 256 then curtainpos = curtainpos + (400 * dt)
      else
        curtainpos = -320
        curtainstate = 0
      end
    end
  end
end