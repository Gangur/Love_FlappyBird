require("vector")
require("background")
require("bird")
require("score")
require("pipes")

function love.load()
    background = BackgroundImage:create()
    score = Score:create()

    hello = love.graphics.newImage('sprites/message.png')

    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    location = Vector:create(width / 2 - 34 / 2, height/ 2 - 24 / 2)
    velocity = Vector:create(0, 0)

    bird = Bird:create(location, velocity);
    pipes = Pipes:create(width+52, 150)
    

    game = false
    restart = false
end

function love.update(dt)
    if game then
        background:update(dt)
        pipes:update()
    end
    bird:update(dt, nil)
end

function love.draw()
    background:draw()
    pipes:draw()
    if not(game) then
        if not(restart) then
            love.graphics.draw(hello, 52, 75)
        else
            location = Vector:create(width / 2 - 34 / 2, height/ 2 - 24 / 2)
            velocity = Vector:create(0, 0)
            bird = Bird:create(location, velocity);
            pipes = Pipes:create(width+52, 150)
            score = Score:create()
            restart = false
        end
    else
        bird.game = true
        score:draw()
    end

    bird:draw()
end

function love.keypressed(key, scancode, isrepeat)
    isrepeat = false
    if not(game) then
        game = true
    else
        bird:keypressed(key, scancode, isrepeat)
    end
end

