function aStar(target, point)
  local finished = false
  local qs = {}
  local openanalize = {}
  local actualpos = 1
  local isinopen = false
  local isinclose = false
  local newh = 0
  local newg = 0
  local newf = 0
  local openpos = 0
  local mincost = 0
  local openposmin = 0
  local opentoclose = {}
  local actualpatern = {}
  path = {}
  open = {}
  close = {}
  table.insert(close, {q={y=target.y, x=target.x}, p=nil, g=0, h=0, f=0})
  table.insert(qs,{y=target.y-1, x=target.x})
  table.insert(qs,{y=target.y+1, x=target.x})
  table.insert(qs,{y=target.y, x=target.x+1})
  table.insert(qs,{y=target.y, x=target.x-1})
  while finished == false do
    finished = false
    openanalize = {}
    for i = 1, 4 do
      if qs[i].y < 1 or qs[i].x < 1 or qs[i].y > 7 or qs[i].x > 7 then
        goto continue
      else
        if grid[qs[i].y][qs[i].x] == 1 then
          isinopen = false isinclose = false
          for a = 1, #close do
            if qs[i].y == close[a].q.y and qs[i].x == close[a].q.x then isinclose = true break end
          end
          if isinclose == true then goto continue end
          if #open > 0 then
            for a = 1, #open do
              if qs[i].y == open[a].q.y and qs[i].x == open[a].q.x then
                openpos = a
                isinopen = true
                break end
            end
          end
          if isinopen == true then
            newg = close[actualpos].g + 10
            if newg < open[openpos].g then
              if point.x > open[openpos].q.x then newh = open[openpos].q.x - qs[i].x
              else newh = qs[i].x - open[openpos].q.x end
              if open[openpos].q.y > qs[i].y then newh = newh + (open[openpos].q.y - qs[i].y)
              else newh = newh + (qs[i].y - open[openpos].q.x) end
              newf = newg + newh
              open[openpos].p = close[actualpos].q
              open[openpos].g = newg
              open[openpos].h = newh
              open[openpos].f = newf
              table.insert(openanalize,open[openpos])
            end
          else
            if point.x > qs[i].x then newh = point.x - qs[i].x
            else newh = qs[i].x - point.x end
            if point.y > qs[i].y then newh = newh + (point.y - qs[i].y)
            else newh = newh + (qs[i].y - point.y) end
            newg = close[actualpos].g + 10
            newf = newg + newh
            table.insert(open,{q={y=qs[i].y, x=qs[i].x}, p=close[actualpos].q, g=newg, h=newh, f=newf})
            table.insert(openanalize,open[#open])
          end
        end
      end
      ::continue::
    end
    if #openanalize > 0 then
      mincost = 0
      for i = 1, #openanalize do
        if openanalize[i].q.y == point.y and openanalize[i].q.x == point.x then
          openposmin = i
          finished = true
          break
        end
        if mincost == 0 then
          mincost = openanalize[i].f
          openposmin = i
        else
          if openanalize[i].f < mincost then
            mincost = openanalize[i].f
            openposmin = i
          end
        end
      end
      for a = 1, #open do
        if open[a].q.y == openanalize[openposmin].q.y and open[a].q.x == openanalize[openposmin].q.x then
          table.insert(close,open[a])
          actualpos = actualpos + 1
          table.remove(open,a)
          break
        end
      end
    else finished = true end
    qs = {}
    table.insert(qs,{y=close[actualpos].q.y-1, x=close[actualpos].q.x})
    table.insert(qs,{y=close[actualpos].q.y+1, x=close[actualpos].q.x})
    table.insert(qs,{y=close[actualpos].q.y, x=close[actualpos].q.x+1})
    table.insert(qs,{y=close[actualpos].q.y, x=close[actualpos].q.x-1})
  end
  print(#close)
  for a = actualpos, 1, -1 do
    if a == actualpos then
      table.insert(path,close[a].q)
      actualpatern = close[a].p
    else
      if close[a].q.y == actualpatern.y and close[a].q.x == actualpatern.x then
        table.insert(path,close[a].q)
        actualpatern = close[a].p
      end
    end
  end
  local rutatemp = {}
  for a = #path, 1, -1 do
    table.insert(rutatemp,path[a])
  end
  path = rutatemp
  local pointdelete = 1
  for a = 1, #path do
    if path[a].x == point.x and path[a].y == point.y then pointdelete = a end
  end 
  table.remove(path, pointdelete)
  return path
end