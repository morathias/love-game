function love.load()
	player = {
		x = 50,
		y = 250,
		speed = 100,
		width = 30, 
		height = 100
	}

	enemy = {
		x = 725,
		y = 250,
		speed = 100,
		width = 30, 
		height = 100
	}

	ball = {
		x = 400,
		y = 300,
		speedX = 50,
		speedY = 50,
		width = 20,
		height = 20
	}

end

function love.update(dt)
	movePlayer(dt)
	moveBall(dt)

	if checkCollision(player, ball) then
		ball.speedX = ball.speedX + 100

		ball.speedX = ball.speedX * (-1)
		ball.speedY = ball.speedY * (-1)
	end

	if checkCollision(enemy, ball) then
		ball.speedX = ball.speedX + 100

		ball.speedX = ball.speedX * (-1)
		ball.speedY = ball.speedY * (-1)
	end

	enemy.y = ball.y - (enemy.height / 2)

	if enemy.y >= love.graphics.getHeight() - enemy.height then
		enemy.y = love.graphics.getHeight() - enemy.height
	elseif enemy.y <= 0 then
		enemy.y = 0
	end

end

function love.draw()
	love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
	love.graphics.rectangle("fill", enemy.x, enemy.y, enemy.width, enemy.height)
	love.graphics.circle("fill", ball.x, ball.y, ball.width / 2)
end

function movePlayer(dt)
	if love.keyboard.isDown("w") then
		player.y = player.y - (player.speed * dt)
	elseif love.keyboard.isDown("s") then
		player.y = player.y + (player.speed * dt)
	end

	if player.y >= love.graphics.getHeight() - player.height then
		player.y = love.graphics.getHeight() - player.height
	elseif player.y <= 0 then
		player.y = 0
	end

end

function moveBall(dt)
	ball.x = ball.x + (ball.speedX * dt)
	ball.y = ball.y + (ball.speedY * dt)

	if ball.x >= love.graphics.getWidth() - 10 then
		ball.speedX = ball.speedX * (-1)
	elseif ball.x <= 5 then 
		ball.speedX = ball.speedX * (-1)
	end

	if ball.y >= love.graphics.getHeight() - 10 then
		ball.speedY = ball.speedY * (-1)
	elseif ball.y <= 5 then
		ball.speedY = ball.speedY * (-1)
	end	
end

function checkCollision(a, b)
    --With locals it's common usage to use underscores instead of camelCasing
    local a_left = a.x
    local a_right = a.x + a.width
    local a_top = a.y
    local a_bottom = a.y + a.height

    local b_left = b.x
    local b_right = b.x + b.width
    local b_top = b.y
    local b_bottom = b.y + b.height

    --If Red's right side is further to the right than Blue's left side.
    if a_right > b_left and
    --and Red's left side is further to the left than Blue's right side.
    a_left < b_right and
    --and Red's bottom side is further to the bottom than Blue's top side.
    a_bottom > b_top and
    --and Red's top side is further to the top than Blue's bottom side then..
    a_top < b_bottom then
        --There is collision!
        return true
    else
        --If one of these statements is false, return false.
        return false
    end
end