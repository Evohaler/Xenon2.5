
--require "player"
-- this pulls in the test.lua file
local Player = require("player")

function love.load()
  love.window.setTitle('Xenon Republic')
  love.graphics.setDefaultFilter('nearest', 'nearest')
--Animation
  animation = newAnimation(love.graphics.newImage("Sprites/powerup.png"), 30, 30, 0.5)
  animThrust = newAnimation(love.graphics.newImage("Sprites/RocketPlume.png"), 30, 30, 0.5)

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
  Player.load()
  anim = 0
--Baddie1
  baddie1 = {}
  baddie1.speed = 0
  baddie1.x = 200
  baddie1.y = 100
  baddie1.width = 30
  baddie1.height =30
  baddie1.img = love.graphics.newImage('Sprites/Baddie1.png')
  baddie1.explosion = love.graphics.newImage('Sprites/Explosion.png')
  baddie1.scrollSpeed = 100
  baddie1.scrollLoop = 620
  anim = 0
--UI
  User_interface = love.graphics.newImage('Sprites/XenonUI.png')
--Bolt
  bolt = {}
  bolt.x = Player.getX()
  bolt.y = -Player.getY()
  bolt.width = 10
  bolt.height =10
  bolt.scroll = 0
  bolt.img = love.graphics.newImage('Sprites/Bolt.png')
  bolt.speed = 1000
  bolt.flying = false
  bolt.collision =false
end

function love.keypressed(key)
    if key == 'escape' then
      love.event.quit()
    end
end

function love.update(dt)
  --Animation
  animation.currentTime = animation.currentTime + dt
  if animation.currentTime >= animation.duration then
      animation.currentTime = animation.currentTime - animation.duration
  end
  -- collision

--Bolt collision
  if (bolt.x+bolt.width >= baddie1.x) and (bolt.x <= baddie1.x+baddie1.width) then
      if (bolt.y+bolt.height >= baddie1.y) and (bolt.y <= baddie1.y+baddie1.height) then
        bolt.collision = true
      end
  else bolt.collision = false
  end
-- Parallex
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
      % BACKGROUND_LOOP
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED *dt)
      % BACKGROUND_LOOP
--Baddie Scroll
    baddie1.y = (baddie1.y + baddie1.scrollSpeed * dt)
      % baddie1.scrollLoop
--World Colission
  Player.update(dt)
--slows background
      if love.keyboard.isDown('down') then
           GROUND_SCROLL_SPEED = 10
           BACKGROUND_SCROLL_SPEED =10
      else GROUND_SCROLL_SPEED = 60
           BACKGROUND_SCROLL_SPEED =30
      end
-- player shoot
      if bolt.y <= 0 then
         bolt.y = Player.getY()
         bolt.flying = false
       end
      if bolt.flying == true then
         bolt.y = bolt.y - bolt.speed * dt
       end
      if love.keyboard.isDown('space') then
        bolt.flying = true
        bolt.x = Player.getX()
      end
end
function love.draw()

        love.graphics.draw(background,0,backgroundScroll,0,1,1,0,600)
        Player.draw()
    if bolt.collision == true then
        love.graphics.draw(baddie1.explosion, baddie1.x, baddie1.y, 0,1.5,1.5,0, 0)
    else
        love.graphics.draw(baddie1.img, baddie1.x,baddie1.y, 0,1.5,1.5,0,0)
    end
        love.graphics.draw(ground,0,groundScroll,0,1,1,0,600)
    if bolt.flying == true then
        love.graphics.draw(bolt.img, bolt.x+20,bolt.y,0,1,1,0,0)
    end
        love.graphics.draw(User_interface,0,0,0,1,1,0,0)
    local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
        love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], 200, 200, 0, 1)

    local spriteNum = math.floor(animation.currentTime / animation.duration * #animThrust.quads) + 1
        love.graphics.draw(animThrust.spriteSheet, animThrust.quads[spriteNum], Player.getX()+8, Player.getY()+40, 0, 1)
end


function newAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};

    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end

    animation.duration = duration or 1
    animation.currentTime = 0

    return animation
end
