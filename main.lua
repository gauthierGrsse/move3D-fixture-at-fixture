-- Clone 3D position GrandMA2
-- Gauthier G
local textinput = gma.textinput
local feedback = gma.feedback
local echo = gma.echo
local cmd = gma.cmd
local getobj = gma.show.getobj

local function error(reason) -- fatal error display
    feedback("ERROR : Plugin clone 3D position stop working")
    gma.gui.msgbox("3D position plugin ERROR", reason)
end

local function testFixture(fixtureId) -- return true if fixture with input fixture id exist and false if not
    if not getobj.verify(getobj.handle("Fixture " .. fixtureId)) then
        error("Fixture " .. fixtureId .. " does not exist")
        return false
    end
    return true
end

local function clone()
    local working = 0

    local inFixture = tonumber(textinput("Input fixture", "")) -- input source fixture
    echo("Fixture A test")
    if not testFixture(inFixture) then
        working = 1 -- set working at 1 if fatal error to stop plugin
    end

    local outFixture
    if working == 0 then -- if working is not 0 : stop plugin
        outFixture = tonumber(textinput("Output fixture", "")) -- input recipient
        echo("Fixture B test")
        if not testFixture(outFixture) then
            working = 1
        end
    end

    if inFix and working == 0 then
        feedback("Clone 3D position fixture " .. inFixture .. " to fixture " .. outFixture)

        inFix = getobj.handle("Fixture " .. inFixture)
        echo("Get fixture A")

        coord = {}

        for x = 15, 20, 1 do -- the columns for the 3D position are from 15 to 20
            local temp = gma.show.property.get(getobj.child(inFix, 0), x) -- get the value of the column
            coord[#coord + 1] = temp -- store them in an array
            
            feedback(temp)
            feedback(#coord, " / ", coord[#coord])
        end
        echo("Get 3D position of fixture A")

        cmd("BlindEdit On")
        cmd("Fixture " .. outFixture)
        cmd("Move3D At " .. coord[1] .. " " .. coord[2] .. " " .. coord[3]) -- set 3D position
        cmd("Rotate3D At " .. coord[4] .. " " .. coord[5] .. " " .. coord[6]) -- set 3D rotation
        cmd("ClearAll")
        cmd("BlindEdit Off")
    end
end

return clone
