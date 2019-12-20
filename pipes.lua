Pipes = {}
Pipes.__index = Pipes

function Pipes:create(x, span)
    local pipe = {}
    setmetatable(pipe, Pipes)

    pipe.sound_point = love.audio.newSource('audio/point.ogg', 'static')

    pipe.sound_hit = love.audio.newSource('audio/hit.ogg', 'static')
    pipe.sound_die = love.audio.newSource('audio/die.ogg', 'static')
    
    pipe.X = x
    pipe.Y = math.random(150, height - 150)

    pipe.XD = x + 200
    pipe.YD = math.random(150, height - 150)

    pipe.span = span

    local rand = love.math.random(0, 1)
    local color_pipe
    if rand == 0 then
        color_pipe = "red"
    else
        color_pipe = "green"
    end

    pipe.image = love.graphics.newImage("sprites/pipe-"..color_pipe..".png")

    pipe.flag = true
    pipe.flagD = true

    return pipe
end

function Pipes:update()
    self.X = self.X - 2
    if (self.X < -52) then
        self.X = width + 52
        self.Y = math.random(150, height - 150)
        self:draw()
        if (self.span > 60) then
            self.span = self.span - 2
        end
    end

    --[[ self.XD = self.XD - 2
    if (self.XD < -52) then
        self.XD = width + 52
        self.YD = math.random(150, height - 150)
        self:draw()
    end ]]
    
    if(bird.location.x > self.X - 78 and bird.location.x < self.X)  then
        if(bird.location.y > self.Y - self.span/2 and bird.location.y < self.Y + self.span/2) then
            if (self.flag) then
                score.count = score.count + 1
                self.sound_point:play()
                self.flag = false
            end
        else
            self.sound_hit:play()
            game = false
            restart = true
            self.sound_die:play()
        end
    else
        self.flag = true
    end

    if(bird.location.y < 0) then
        self.sound_hit:play()
        game = false
        restart = true
        self.sound_die:play()
    end

    if(bird.location.y > 512) then
        self.sound_hit:play()
        game = false
        restart = true
        self.sound_die:play()
    end

    --if(bird.location.x > self.XD and bird.location.x < self.XD + 52)  then
    --    if (bird.location.y > self.YD - self.span/2 and bird.location.y < self.YD + self.span/2) then
    --        if (self.flagD) then
    --            score.count = score.count + 1
    --            self.sound_point:play()
    --            self.flagD = false
    --        end
    --    end
    --else
    --    self.flagD = true
    --end

    
end

function Pipes:draw()
    love.graphics.draw(self.image, self.X, self.Y - self.span/2, math.pi, 1, 1, 0, 0) 
    love.graphics.draw(self.image, self.X - 52, self.Y + self.span/2, 0, 1, 1, 0, 0) 

    --love.graphics.draw(self.image, self.XD, self.YD - self.span/2, math.pi, 1, 1, 0, 0) 
    --love.graphics.draw(self.image, self.XD - 52, self.YD + self.span/2, 0, 1, 1, 0, 0) 
end