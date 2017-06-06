function love.load()
	playerX, playerY = 50, 250
	speed = 100
end

function love.update(dt)
	if love.keyboard.isDown("w") then
		playerY = playerY - (speed * dt)
	elseif love.keyboard.isDown("s") then
		playerY = playerY + (speed * dt)
	end
end

function love.draw()
	love.graphics.rectangle("fill", playerX, playerY, 30, 100)
	love.graphics.rectangle("fill", 725, 250, 30, 100)
	love.graphics.circle("fill", 400, 300, 10, 32)
end