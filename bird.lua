Bird = {}
Bird.__index = Bird

function Bird:create(location, velocity)
    local bird = {}
    setmetatable(bird, Bird)

    bird.location = location
    bird.velocity = velocity

    bird.sound_swoosh = love.audio.newSource('audio/swoosh.ogg', 'static')

    local rand = love.math.random(0, 2)
    local color_bird
    if rand == 0 then
        color_bird = "red"
    elseif rand == 1 then
        color_bird = "blue"
    elseif rand == 2 then
        color_bird = "yellow"
    end
    
    bird.animation = {
        love.graphics.newImage("sprites/"..color_bird.."bird-downflap.png"),
        love.graphics.newImage("sprites/"..color_bird.."bird-midflap.png"),
        love.graphics.newImage("sprites/"..color_bird.."bird-upflap.png")
    }

    bird.step_animation = 1
    bird.time = 0
    bird.angle = 0
    bird.game = false

    return bird
end

function Bird:update(dt, ps)
    if self.time > 0.1 then
        self.step_animation = self.step_animation + 1
        if self.step_animation > 3 then
            self.step_animation = 1
        end
        self.time = 0
    end
    self.time = self.time + dt

    if (self.game) then
        self.velocity.y = self.velocity.y + 0.2
        self.location.y = self.location.y + self.velocity.y
        self.angle = self.angle + 0.02
    end
end

function Bird:draw()
    local positionBird = self.animation[self.step_animation]
    love.graphics.translate(self.location.x, self.location.y)
    love.graphics.rotate(self.angle)
    love.graphics.draw(positionBird)
    
end

function Bird:keypressed(key, scancode, isrepeat)
    if (key == 'space') then
        self.sound_swoosh:play()
        self.angle = -0.5
        self.velocity.y = -3
        self.location.y = self.location.y - 8
    end
end