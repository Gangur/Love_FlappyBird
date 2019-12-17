BackgroundImage = {}
BackgroundImage.__index = BackgroundImage

function BackgroundImage:create()
    local image = {}
    setmetatable(image, BackgroundImage)

    local rand = love.math.random(0, 1)
    if (rand == 0) then
        image.mainLayout = love.graphics.newImage("sprites/background-day.png")
    else
        image.mainLayout = love.graphics.newImage("sprites/background-night.png")
    end
    
    image.footer = love.graphics.newImage("sprites/base.png")
    image.startScreen = love.graphics.newImage("sprites/message.png")
    image.shift = 0
    return image
end

function BackgroundImage:update(dt)
    self.shift = self.shift - dt * 100
    if self.shift + self.footer:getWidth() < width then
        self.shift = 0
    end
end

function BackgroundImage:draw()
    love.graphics.draw(self.mainLayout, 0, 0)
    love.graphics.draw(self.footer, self.shift, height - self.footer:getHeight())
    if not(game)  then
        love.graphics.draw(self.startScreen, (width - self.startScreen:getWidth()) / 2, height/7)
    end
end