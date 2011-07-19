require 'camera'

dx, dy = 0, 0

math.randomseed(os.time())
math.random()
math.random()
math.random()

function love.load()
    bg = love.graphics.newImage('bg.png')
    width = bg:getWidth()
    height = bg:getHeight()
    wid = 3

    camera:setBounds(0, 0, ((wid-1)*width)/6, 0)

    camera.layers = {}
    camera:newLayer(2, function() for i = 1, wid do love.graphics.draw(bg, width*(i-1), 0) end end)
    camera:newLayer(2, function() love.graphics.rectangle('fill', 640, 0, 800, 100) end)
    camera:newLayer(4, function() love.graphics.rectangle('fill', 640, 200, 800, 100) end)
    camera:newLayer(6, function() love.graphics.rectangle('fill', 640, 400, 800, 100) end)

end

function love.update(dt)

    print(camera._x, camera._y)
    print(love.mouse.getX(), love.mouse.getY())

    if love.keyboard.isDown('left') then
        dx = dx - 1
    end

    if love.keyboard.isDown('up') then
        dy = dy - 1
    end

    if love.keyboard.isDown('right') then
        dx = dx + 1
    end

    if love.keyboard.isDown('down') then
        dy = dy + 1
    end
    
    camera:setPosition(dx, dy)
end

function love.draw()
    camera:draw()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.push('q')
    end
end
