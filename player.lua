module(player)
function love.load()
  --player
    player = {}
    player.speed = 200
    player.x = 200
    player.y = 520
    player.width = 30
    player.height =30
    player.img = love.graphics.newImage('Sprites/XenonShip.png')
    player.explosion = love.graphics.newImage('Sprites/Explosion.png')
    player.collision = false
    anim = 0
end

function love.update(dt)
  -- player collision
  if (player.x+player.width >= baddie1.x) and (player.x <= baddie1.x+baddie1.width) then
  if (player.y+player.height >= baddie1.y) and (player.y <= baddie1.y+baddie1.height) then
          player.collision = true
  end
  else player.collision = false
  end
  end
  if player.y > 590 then
     player.y = 580
  end
  if player.x >= 350 then
     player.x = 340
  end
  if player.x < 10 then
     player.x = 20
  end
  if love.keyboard.isDown('right') then
      player.x = player.x + (player.speed * dt)
  elseif love.keyboard.isDown('left') then
      player.x = player.x - (player.speed * dt)
  end
  if love.keyboard.isDown('down') then
      player.y = player.y + (player.speed * dt)
  elseif love.keyboard.isDown('up') then
       player.y = player.y - (player.speed * dt)
  end
  if love.keyboard.isDown('right') then
      player.img = love.graphics.newImage('Sprites/XenonShipR.png')
  else player.img = love.graphics.newImage('Sprites/XenonShip.png')

  if love.keyboard.isDown('left') then
      player.img = love.graphics.newImage('Sprites/XenonShipL.png')
  else player.img = love.graphics.newImage('Sprites/XenonShip.png')
     end
  end
  -- player shoot
  if bolt.y <= 0 then
      bolt.y = player.y
       bolt.flying = false
  end
  if bolt.flying == true then
      bolt.y = bolt.y - bolt.speed * dt
  end
  if love.keyboard.isDown('space') then
      bolt.flying = true
        bolt.x = player.x
  end
end
  function love.draw()
  if player.collision == true then
      love.graphics.draw(player.explosion, player.x, player.y, 0,1.5,1.5,0, 0)
  else
      love.graphics.draw(player.img, player.x, player.y, 0, 1.5,1.5, 0, 0)
  end
end
