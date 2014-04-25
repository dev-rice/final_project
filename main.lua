require('Ball')
require('BoxCollider')

function love.load()
	canvas_width = love.graphics.getWidth()
	canvas_height = love.graphics.getHeight()

	paddle_x = 50
	paddle_y = 10

	ball = Ball.create(canvas_width / 2, canvas_height / 2)
	box = BoxCollider.create(0, 0, canvas_width, canvas_height)
	paddle_collider = BoxCollider.create(paddle_x, paddle_y, paddle_x, paddle_y + 100)

	boxes = {box, paddle_collider}

end

function love.update(dt)

	ball:move(dt, boxes)

	if love.keyboard.isDown("up") then
		paddle_y = paddle_y - 300 * dt
	elseif love.keyboard.isDown("down") then
		paddle_y = paddle_y + 300 * dt
	end

	paddle_collider:move(paddle_x, paddle_y)

end

function love.draw()
	box:draw()
	paddle_collider:draw()
	ball:draw()
end

