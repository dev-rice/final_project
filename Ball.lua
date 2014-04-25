Ball = {}
Ball.__index = Ball

function Ball.create(x, y)	
	local ball = {}
	setmetatable(ball, Ball)

	ball.dx = math.random(100, 150)
	ball.dy = math.random(100, 150)
	
	ball.image = love.graphics.newImage("res/zany.jpg")
	ball.sound = love.audio.newSource("res/wall_hit.wav", "static")

	ball.width = ball.image:getWidth()
	ball.height = ball.image:getHeight()

	ball.x1 = x
	ball.y1 = y
	ball.x2 = x + ball.width
	ball.y2 = y + ball.height

	return ball
end

function Ball:move(dt, colliders)
	self.x1 = self.x1 + self.dx * dt
	self.y1 = self.y1 + self.dy * dt
	self.x2 = self.x1 + ball.width
	self.y2 = self.y1 + ball.height

	for collider in list_iter(colliders) do
		if (collider:hit_vertical(self.x1, self.y1, self.x2, self.y2)) then
			self:bounce_x()
		elseif (collider:hit_horizontal(self.x1, self.y1, self.x2, self.y2)) then
			self:bounce_y()
		end
	end
end

function Ball:draw()
	width = self.x2 - self.x1
	height = self.y2 - self.y1

	r, g, b, a = love.graphics.getColor()

	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.rectangle("line", self.x1, self.y1, width, height)

	love.graphics.setColor(r, g, b, a)

	love.graphics.draw(self.image, self.x1, self.y1)
end

function Ball:bounce_x()
	self.dx = -self.dx
	--self.sound:play()
end

function Ball:bounce_y()
	self.dy = -self.dy
	--self.sound:play()
end

function list_iter (t)
	local i = 0
	local n = table.getn(t)
	return function ()
	i = i + 1
	if i <= n then return t[i] end
	end
end
