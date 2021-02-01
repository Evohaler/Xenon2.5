
function love.load()
love.window.setTitle('Xenon Republic')
gameHeight = 600
gameWidth =500
love.window.setMode(500,600)
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
player = {}
player.speed = 200
player.x = 200
player.y = 520
player_width = 30
player_height =30
player.img = love.graphics.newImage('Sprites/XenonShip.png')
anim = 0
--Baddie1
baddie1 = {}
baddie1.speed = 0
baddie1.x = 300
baddie1.y = 100
baddie_width = 30
baddie_height =30
baddie1.img = love.graphics.newImage('Sprites/Baddie1.png')
BADDIE_SCROLL = 0
BADDIE_SCROLL_SPEED = 100
BADDIE_SCROLL_LOOP = 620
anim = 0
--UI
User_interface = love.graphics.newImage('Sprites/XenonUI.png')
--Bolt
bolt = {}
bolt.x = player.x
bolt.y = -player.y
bolt.width = 10
bolt.height =10
bolt.scroll = 0
bolt.img = love.graphics.newImage('Sprites/Bolt.png')
bolt.speed = 1000
bolt.flying = false
end

function love.keypressed(key)
    if key == 'escape' then
      love.event.quit()
end
end

function love.update(dt)

  -- Parallex
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
      % BACKGROUND_LOOP
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED *dt)
      % BACKGROUND_LOOP
  --Baddie Scroll

    BADDIE_SCROLL = (BADDIE_SCROLL + BADDIE_SCROLL_SPEED * dt)
      % BADDIE_SCROLL_LOOP
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
      end
      if love.keyboard.isDown('left') then
        player.img = love.graphics.newImage('Sprites/XenonShipL.png')
      else player.img = love.graphics.newImage('Sprites/XenonShip.png')
      end
--slows background
      if love.keyboard.isDown('down') then
           GROUND_SCROLL_SPEED = 10
           BACKGROUND_SCROLL_SPEED =10
      else GROUND_SCROLL_SPEED = 60
           BACKGROUND_SCROLL_SPEED =30
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

    love.graphics.draw(background,0,backgroundScroll,0,1,1,0,600)
    love.graphics.draw(player.img, player.x, player.y, 0, 1.5, 1.5, 0)
    love.graphics.draw(baddie1.img, baddie1.x,BADDIE_SCROLL, 0,1.5,1.5,20,30)
    love.graphics.draw(ground,0,groundScroll,0,1,1,0,600)
    if bolt.flying == true then
      love.graphics.draw(bolt.img, bolt.x+20,bolt.y,0,1,1,0,0)
    end
    love.graphics.draw(User_interface,0,0,0,1,1,0,0)


end
