function love.load()
	ball = love.graphics.newImage("ball.png")
	paddle = love.graphics.newImage("paddle.png")

	sound = love.audio.newSource("wall_hit.wav", "static")

	canvas_width = love.graphics.getWidth()
	canvas_height = love.graphics.getHeight()

	ball_width = ball:getWidth()
	ball_height = ball:getHeight()

	paddle_width = paddle:getWidth()
	paddle_height = paddle:getHeight()

	ballx = (canvas_width / 2) - (ball_width / 2)
	bally = (canvas_height / 2) - (ball_height / 2)

	dx = 0
	dy = 0

	setRandomDirection()

end

function love.update(dt)

	if ((ballx + ball_width) > canvas_width or ballx < 0) then
		dx = -dx
		sound:play()
	elseif ((bally + ball_height) > canvas_height or bally < 0) then
		dy = -dy
		sound:play()
	end

	ballx = ballx + dx * dt
	bally = bally + dy * dt
end

function love.draw()
	love.graphics.draw(ball, ballx, bally)
	love.graphics.draw(paddle, 0, canvas_height / 2 - paddle_height / 2)
	love.graphics.draw(paddle, canvas_width - paddle_width, canvas_height / 2 - paddle_width / 2)
end

function setRandomDirection()
	dx = math.random(100, 250)
	dy = math.random(100, 250)
end