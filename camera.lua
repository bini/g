require 'utils'

camera = {}
camera._x = 0
camera._y = 0
camera.scaleX = 1
camera.scaleY = 1
camera.rotation = 0

camera.layers = {}

function camera:set()
    love.graphics.push()
    love.graphics.rotate(-self.rotation)
    love.graphics.scale(1/self.scaleX, 1/self.scaleY)
    love.graphics.translate(-self._x, -self._y)
end

function camera:unset()
    love.graphics.pop()
end

function camera:move(dx, dy)
    self._x = self._x + (dx or 0)
    self._y = self._y + (dy or 0)
end

function camera:rotate(dr)
    self.rotation = self.rotation + (dr or 0)
end

function camera:scale(sx, sy)
    self.scaleX = self.scaleX * (sx or 0)
    self.scaleY = self.scaleY * (sy or sx)
end

function camera:setX(value)
    if self._bounds then
        self._x = math.clamp(value, self._bounds.x1, self._bounds.x2)
    else
        self._x = value
    end
end

function camera:setY(value)
    if self._bounds then
        self._y = math.clamp(value, self._bounds.y1, self._bounds.y2)
    else
        self._y = value
    end
end

function camera:setPosition(x, y)
    if x then self:setX(x) end
    if y then self:setY(y) end
end

function camera:setScale(sx, sy)
    self.scaleX = sx or self.scaleX
    self.scaleY = sy or self.scaleY
end

function camera:newLayer(scale, func)
    table.insert(self.layers, {draw = func, scale = scale})
    table.sort(self.layers, function(a, b) return a.scale < b.scale end)
end

function camera:draw()
    local bx, by = self._x, self._y

    for _, v in ipairs(self.layers) do
        self._x = bx * v.scale
        self._y = by * v.scale
        camera:set()
        v.draw()
        camera:unset()
    end
end

function camera:getBounds()
    return unpack(self._bounds)
end

function camera:setBounds(x1, y1, x2, y2)
    self._bounds = {x1 = x1, y1 = y1, x2 = x2, y2 = y2}
end

