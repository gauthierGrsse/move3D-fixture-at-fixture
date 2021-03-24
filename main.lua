-- Clone 3D position GrandMA2
-- Gauthier G

local textinput = gma.textinput
local feedback = gma.feedback
local echo = gma.echo
local cmd = gma.cmd

local function clone()
    local inFixture = tonumber(textinput("Input fixture", ""))
    local outFixture = tonumber(textinput("Output fixture", ""))

    inFix = gma.show.getobj.handle("Fixture "..inFixture)
    if inFix then
        coord = {}
        for x=15, 17, 1 do
            local temp = gma.show.property.get(gma.show.getobj.child(inFix, 0), x)
            coord[#coord+1] = temp
            feedback(temp)
            feedback(#coord, " / ", coord[#coord])
        end

        cmd("Fixture "..outFixture)
        cmd("Move3D At "..coord[1].." "..coord[2].." "..coord[3])
    end
end

return clone
