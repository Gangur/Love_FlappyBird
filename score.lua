Score = {}
Score.__index = Score

function Score:create()
    local score = {}
    setmetatable(score, Score)
    score.font = love.graphics.newFont('fonts/Regular_04B_19.TTF', 42)
    score.count = 0
    return score
end

function Score:draw()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setFont(self.font)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(self.count, width / 2 + 2, 48)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(self.count, width / 2, 46)
    love.graphics.setColor(r, g, b, a)
end