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
    steeringFinal = steeringFinal + deltaX
    steeringFinal = math.clamp(steeringFinal, -1, 1)
    
    --Throttle Part--
    if ac.isKeyDown(ac.KeyIndex[settings.throttle]) then
        if ac.isKeyPressed(ac.KeyIndex[settings.throttle]) then gasFinal = 0.25
        elseif ac.getUI().mouseWheel > 0 then
            gasFinal = math.min(gasFinal + settings.scroll, 1.0)
        elseif ac.getUI().mouseWheel < 0 then
            gasFinal = math.max(gasFinal - settings.scroll, 0.0)
        end
    elseif ac.isKeyReleased(ac.KeyIndex[settings.throttle]) then gasFinal = 0.0
    end

    if ac.isKeyDown(ac.KeyIndex[settings.throttle]) and ac.isKeyDown(ac.KeyIndex.Shift) then
        gasFinal = 1.0
    end

    --Brake Part--
    if ac.isKeyDown(ac.KeyIndex[settings.brake]) then
        if ac.isKeyPressed(ac.KeyIndex[settings.brake]) then brakeFinal = 0.25
        elseif ac.getUI().mouseWheel > 0 then
            brakeFinal = math.min(brakeFinal + settings.scroll, 1.0)
        elseif ac.getUI().mouseWheel < 0 then
            brakeFinal = math.max(brakeFinal - settings.scroll, 0.0)
        end
    elseif ac.isKeyReleased(ac.KeyIndex[settings.brake]) then brakeFinal = 0.0
    end

    if ac.isKeyDown(ac.KeyIndex[settings.brake]) and ac.isKeyDown(ac.KeyIndex.Shift) then
        brakeFinal = 1.0
    end

    --Output Part-
    ac.getJoypadState().steer = steeringFinal
    ac.getJoypadState().gas = gasFinal
    ac.getJoypadState().brake = brakeFinal
    ac.debug("gas", ac.getJoypadState().gas)
    ac.debug("brake", ac.getJoypadState().brake)
    ac.debug("Debug", settings.debug)
end
