function createGrid(level, player)
  player.life = 4
  player.atk = 3
  player.move = 3
  grid = {}
  math.randomseed(os.time())
  local gridnum = math.floor(level / 2)
  gridnum = gridnum + 2
  local enemynum = math.floor(level / 2)
  enemynum = enemynum + 2
  gridselect = math.random(1, gridnum)
  if gridselect > 10 then gridselect = 10 end
  if gridselect == 1 then
    table.insert(grid,{1,1,1,1,1,1,1})
    table.insert(grid,{1,1,1,1,1,1,1})
    table.insert(grid,{1,1,1,1,1,1,1})
    table.insert(grid,{1,1,1,0,1,1,1})
    table.insert(grid,{1,1,1,1,1,1,1})
    table.insert(grid,{1,1,1,1,1,1,1})
    table.insert(grid,{1,1,1,1,1,1,2})
  elseif gridselect == 2 then
    table.insert(grid,{1,1,1,1,1,1,1})
    table.insert(grid,{1,1,1,1,1,1,1})
    table.insert(grid,{1,1,1,0,1,1,1})
    table.insert(grid,{1,1,0,0,0,1,1})
    table.insert(grid,{1,1,1,0,1,1,1})
    table.insert(grid,{1,1,1,1,1,1,1})
    table.insert(grid,{1,1,1,1,1,1,2})
  elseif gridselect == 3 then
    table.insert(grid,{1,1,1,1,1,1,1})
    table.insert(grid,{1,1,0,1,1,1,1})
    table.insert(grid,{1,0,0,1,1,1,1})
    table.insert(grid,{1,1,1,1,1,1,1})
    table.insert(grid,{1,1,1,1,0,0,1})
    table.insert(grid,{1,1,1,1,0,0,1})
    table.insert(grid,{1,1,1,1,1,1,2})
  elseif gridselect == 4 then
    table.insert(grid,{1,1,1,1,1,1,1})
    table.insert(grid,{1,1,1,0,0,0,1})
    table.insert(grid,{1,1,1,1,1,0,1})
    table.insert(grid,{1,0,1,1,1,0,1})
    table.insert(grid,{1,0,1,1,1,1,1})
    table.insert(grid,{1,0,0,0,1,1,1})
    table.insert(grid,{1,1,1,1,1,1,2})
  elseif gridselect == 5 then
    table.insert(grid,{1,1,1,1,1,1,1})
    table.insert(grid,{1,1,1,1,1,1,1})
    table.insert(grid,{1,1,0,0,0,1,1})
    table.insert(grid,{1,1,0,0,0,1,1})
    table.insert(grid,{1,1,0,0,0,1,1})
    table.insert(grid,{1,1,1,1,1,1,1})
    table.insert(grid,{1,1,1,1,1,1,2})
  elseif gridselect == 6 then
    table.insert(grid,{1,1,1,1,1,1,1})
    table.insert(grid,{1,0,1,1,1,0,1})
    table.insert(grid,{1,1,0,1,0,1,1})
    table.insert(grid,{1,1,1,0,1,1,1})
    table.insert(grid,{1,1,0,1,0,1,1})
    table.insert(grid,{1,0,1,1,1,0,1})
    table.insert(grid,{1,1,1,1,1,1,2})
  elseif gridselect == 7 then
    table.insert(grid,{1,1,1,1,1,1,1})
    table.insert(grid,{1,0,0,0,1,1,1})
    table.insert(grid,{1,0,0,1,1,1,1})
    table.insert(grid,{1,0,1,1,1,0,1})
    table.insert(grid,{1,1,1,1,0,0,1})
    table.insert(grid,{1,1,1,0,0,0,1})
    table.insert(grid,{1,1,1,1,1,1,2})
  elseif gridselect == 8 then
    table.insert(grid,{1,1,1,1,1,1,1})
    table.insert(grid,{1,1,0,0,0,0,1})
    table.insert(grid,{1,1,1,1,1,0,1})
    table.insert(grid,{1,0,1,0,1,0,1})
    table.insert(grid,{1,0,1,1,1,1,1})
    table.insert(grid,{1,0,0,0,0,1,1})
    table.insert(grid,{1,1,1,1,1,1,2})
  elseif gridselect == 9 then
    table.insert(grid,{1,1,1,1,1,1,1})
    table.insert(grid,{1,1,1,0,0,1,1})
    table.insert(grid,{1,0,0,0,0,1,1})
    table.insert(grid,{1,0,0,0,0,0,1})
    table.insert(grid,{1,1,0,0,0,0,1})
    table.insert(grid,{1,1,0,0,1,1,1})
    table.insert(grid,{1,1,1,1,1,1,2})
  elseif gridselect == 10 then
    table.insert(grid,{1,0,0,1,1,1,1})
    table.insert(grid,{1,0,0,1,0,0,1})
    table.insert(grid,{1,0,0,1,0,0,1})
    table.insert(grid,{1,1,1,1,1,1,1})
    table.insert(grid,{0,0,1,1,0,0,1})
    table.insert(grid,{0,0,0,1,0,0,1})
    table.insert(grid,{1,1,1,1,1,1,2})
  end
  for a = 1, enemynum do
    createEnemies(level, player, 1)
  end
end