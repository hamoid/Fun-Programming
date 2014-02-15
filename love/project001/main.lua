function love.load()
    world = love.physics.newWorld(0, 200, true)
        world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    ball = {}
        ball.b = love.physics.newBody(world, 400,200, "dynamic")
        ball.b:setMass(10)
        ball.s = love.physics.newCircleShape(50)
        ball.f = love.physics.newFixture(ball.b, ball.s)
        ball.f:setRestitution(0.4)    -- make it bouncy
        ball.f:setUserData("Ball")
    static = {}
        static.b = love.physics.newBody(world, 400,400, "static")
        static.s = love.physics.newRectangleShape(200,50)
        static.f = love.physics.newFixture(static.b, static.s)
        static.f:setUserData("Block")

    text       = ""   -- we'll use this to put info text on the screen later
    persisting = 0    -- we'll use this to store the state of repeated callback calls
end

function love.update(dt)
    world:update(dt)

    if love.keyboard.isDown("right") then
        ball.b:applyForce(1000, 0)
    elseif love.keyboard.isDown("left") then
        ball.b:applyForce(-1000, 0)
    end
    if love.keyboard.isDown("up") then
        ball.b:applyForce(0, -5000)
    elseif love.keyboard.isDown("down") then
        ball.b:applyForce(0, 1000)
    end

    if string.len(text) > 768 then    -- cleanup when 'text' gets too long
        text = ""
    end
end

function love.draw()
    love.graphics.circle("line", ball.b:getX(),ball.b:getY(), ball.s:getRadius(), 20)
    love.graphics.polygon("line", static.b:getWorldPoints(static.s:getPoints()))

    love.graphics.print(text, 10, 10)
end

function beginContact(a, b, coll)
    x,y = coll:getNormal()
    text = text.."\n"..a:getUserData().." colliding with "..b:getUserData().." with a vector normal of: "..x..", "..y
end

function endContact(a, b, coll)
    persisting = 0
    text = text.."\n"..a:getUserData().." uncolliding with "..b:getUserData()
end

function preSolve(a, b, coll)
    if persisting == 0 then    -- only say when they first start touching
        text = text.."\n"..a:getUserData().." touching "..b:getUserData()
    elseif persisting < 20 then    -- then just start counting
        text = text.." "..persisting
    end
    persisting = persisting + 1    -- keep track of how many updates they've been touching for
end

function postSolve(a, b, coll)
end