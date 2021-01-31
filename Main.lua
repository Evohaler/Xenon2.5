
player = {}

function love.load()

love.window.setMode(400,600)
love.graphics.setDefaultFilter('nearest', 'nearest')
--space
background = love.graphics.newImage('Sprites/space_1200.png')
backgroundScroll = 0
BACKGROUND_SCROLL_SPEED = 30
BACKGROUND_LOOP = 595
--wall
ground = love.graphics.newImage('Sprites/Xenon_wall1200.png')
groundScroll = 0
GROUND_SCROLL_SPEED = 60
--player
player.speed = 200
player.x = love.graphics.getWidth() / 2
player.y = love.graphics.getHeight() / 2
player.img = love.graphics.newImage('Sprites/XenonShip.png')
anim = 0
end

function love.keypressed(key)
    if key == 'escape' then
      love.event.quit()
end
end

function love.update(dt)
  --World Colission
  if player.y > 590 then
     player.y = 580
  end
  if player.x >= 350 then
     player.x = 340
  end
  if player.x < 10 then
     player.x = 20
  end
-- Parallex
  backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
    % BACKGROUND_LOOP
  groundScroll = (groundScroll + GROUND_SCROLL_SPEED *dt)
    % BACKGROUND_LOOP
-- player movement
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

      if love.keyboard.isDown('down') then
           GROUND_SCROLL_SPEED = 10
           BACKGROUND_SCROLL_SPEED =10
      else GROUND_SCROLL_SPEED = 60
           BACKGROUND_SCROLL_SPEED =30
      end
      end
    end
end

function love.draw()

  love.graphics.draw(background,0,backgroundScroll,0,1,1,0,600)
  love.graphics.draw(player.img, player.x, player.y, 0, 1.5, 1.5, 0, 32)
  love.graphics.draw(ground,0,groundScroll,0,1,1,0,600)

end
