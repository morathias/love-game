function love.load()
	player = {
		x = 50,
		y = 250,
		speed = 100,
		width = 30, 
		height = 100,
		direction = 1
	}

	enemy = {
		x = 725,
		y = 250,
		speed = 1,
		width = 30, 
		height = 100
	}

	ball = {
		x = 400,
		y = 300,
		speedX = 1,
		speedY = 1,
		width = 20,
		height = 20,
		directionX = 50,
		directionY = 50
	}

	scorePlayer = 0
	scoreEnemy = 0
	gameFinished = false

end

function love.update(dt)
	

	if checkCollision(player, ball) then
		ball.speedY = love.math.random(1, 2 * ball.speedX)
		if ball.speedX < 1.8 then
			ball.speedX = ball.speedX + 0.1
			
			ball.directionX = (ball.directionX * (-1)) * ball.speedX 
			ball.directionY = (ball.directionY * (player.direction)) * ball.speedY
			player.speed = player.speed + 50 * ball.speedX
		else
			ball.directionX = (ball.directionX * (-1)) 
			ball.directionY = (ball.directionY * (player.direction))
		end
	end

	if checkCollision(enemy, ball) then
		ball.speedY = love.math.random(1, 2 * ball.speedX)
		if ball.speedX < 1.8 then
			ball.speedX = ball.speedX + 0.1
			
			enemy.speed = enemy.speed + 2.5
			ball.directionX = (ball.directionX * (-1)) * ball.speedX 
			ball.directionY = (ball.directionY * (-1)) * ball.speedY
		else
			ball.directionX = (ball.directionX * (-1))
			ball.directionY = (ball.directionY * (-1))
		end
	end

	movePlayer(dt)
	moveBall(dt)
	enemy.y = lerp(enemy.y, ball.y - enemy.height / 2,  enemy.speed * dt)

	if enemy.y >= love.graphics.getHeight() - enemy.height then
		enemy.y = love.graphics.getHeight() - enemy.height
	elseif enemy.y <= 0 then
		enemy.y = 0
	end

	if scorePlayer == 5 or scoreEnemy == 5 then
		gameFinished = true 
		player.speed = 0
		ball.speedX = 0
		ball.speedY = 0
	end

	if gameFinished == true and love.keyboard.isDown("r") then
		gameFinished = false 
		player.speed = 100
		ball.speedX = 1
		ball.speedY = 1
		scorePlayer = 0
		scoreEnemy = 0
	end
end

function love.draw()
	love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
	love.graphics.rectangle("fill", enemy.x, enemy.y, enemy.width, enemy.height)
	love.graphics.circle("fill", ball.x, ball.y, ball.width / 2)
	love.graphics.print(scorePlayer .. "|" .. scoreEnemy, love.graphics.getWidth() / 2 - 50, 50,0,5,5);

	if gameFinished == true then
		if scorePlayer == 5 then
			love.graphics.print("You Win, R to Restart", love.graphics.getWidth() / 2 - 30, love.graphics.getHeight() / 2 , 0, 3, 3);
		elseif scoreEnemy == 5 then
			love.graphics.print("You Lose, R to Restart", love.graphics.getWidth() / 2 - 30, love.graphics.getHeight() / 2 , 0, 3, 3);
		end
	end
end

function movePlayer(dt)
	if love.keyboard.isDown("w") then
		player.y = player.y - (player.speed * dt)
		player.direction = 1
	elseif love.keyboard.isDown("s") then
		player.y = player.y + (player.speed * dt)
		player.direction = -1
	end

	if player.y >= love.graphics.getHeight() - player.height then
		player.y = love.graphics.getHeight() - player.height
	elseif player.y <= 0 then
		player.y = 0
	end

end

function moveBall(dt)
	ball.x = ball.x + (ball.directionX * dt)
	ball.y = ball.y + (ball.directionY * dt)

	if ball.x >= love.graphics.getWidth() - 10 then
		ball.x = love.graphics.getWidth() / 2
		ball.y = love.graphics.getHeight() / 2
		scorePlayer = scorePlayer + 1
		ball.speedX = 1.0
		ball.speedY = 1.0
		ball.directionX = 50
		ball.directionY = 50
		player.speed = 100
		enemy.speed = 1

	elseif ball.x <= 5 then 
		ball.x = love.graphics.getWidth() / 2
		ball.y = love.graphics.getHeight() / 2
		ball.speedX = 1.0
		ball.speedY = 1.0
		ball.directionX = 50
		ball.directionY = 50
		player.speed = 100
		scoreEnemy = scoreEnemy + 1
		enemy.speed = 1
	end

	if ball.y >= love.graphics.getHeight() - 10 then
		ball.directionY = (ball.directionY * (-1))
	elseif ball.y <= 5 then
		ball.directionY = (ball.directionY * (-1))
	end	
end

function checkCollision(a, b)
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

function lerp(a, b, t)
	return (1 - t) * a + t * b
end