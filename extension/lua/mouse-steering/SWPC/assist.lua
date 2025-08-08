local settings = ac.INIConfig.scriptSettings():mapSection("SETTINGS", {
    throttle = 'W',
    brake = 'S',
    scroll = 0.02,
    debug = false
})

local gasFinal = 0
local brakeFinal = 0
local steeringFinal = 0

function script.update(dt, deltaX)
    --Mouse Steering--
    steeringFinal = math.clamp(steeringFinal + deltaX, -1, 1)
    
    --Throttle Part--
    if ac.isKeyDown(ac.KeyIndex[settings.throttle]) and ac.isKeyDown(ac.KeyIndex.Shift) then
        gasFinal = 1
    elseif ac.isKeyPressed(ac.KeyIndex[settings.throttle]) then gasFinal = 0.25
    elseif ac.isKeyDown(ac.KeyIndex[settings.throttle]) then
        if ac.getUI().mouseWheel ~= 0 then
            gasFinal = math.clamp(gasFinal + ac.getUI().mouseWheel * settings.scroll, 0, 1)
        end
    else gasFinal = 0
    end

    --Brake Part--
    if ac.isKeyDown(ac.KeyIndex[settings.brake]) and ac.isKeyDown(ac.KeyIndex.Shift) then
        brakeFinal = 1
    elseif ac.isKeyPressed(ac.KeyIndex[settings.brake]) then brakeFinal = 0.25
    elseif ac.isKeyDown(ac.KeyIndex[settings.brake]) then
        if ac.getUI().mouseWheel ~= 0 then
            brakeFinal = math.clamp(brakeFinal + ac.getUI().mouseWheel * settings.scroll, 0, 1)
        end
    else brakeFinal = 0
    end

    --Output Part-
    ac.getJoypadState().steer = steeringFinal
    ac.getJoypadState().gas = gasFinal
    ac.getJoypadState().brake = brakeFinal
    ac.debug("gas", ac.getJoypadState().gas)
    ac.debug("brake", ac.getJoypadState().brake)
    ac.debug("Debug", settings.debug)
end