
Settings = ac.INIConfig.scriptSettings():mapSection("SETTINGS", {
    throttle = "W",
    brake = "S",
    scroll = 0.02,
    debug = 0
})

local gasFinal = 0
local brakeFinal = 0
local steeringFinal = 0

function script.update(dt, deltaX)
    --Mouse Steering--
    steeringFinal = steeringFinal + deltaX
    steeringFinal = math.clamp(steeringFinal, -1, 1)
    
    --Throttle Part--
    if ac.isKeyDown(ac.KeyIndex[Settings.throttle]) then
        if ac.isKeyPressed(ac.KeyIndex[Settings.throttle]) then gasFinal = 0.25 end
        if ac.getUI().mouseWheel > 0 then
            gasFinal = math.min(gasFinal + Settings.scroll, 1.0)
        elseif ac.getUI().mouseWheel < 0 then
            gasFinal = math.max(gasFinal - Settings.scroll, 0.0)
        end
    elseif ac.isKeyReleased(ac.KeyIndex[Settings.throttle]) then gasFinal = 0.0
    end

    --Brake Part--
    if ac.isKeyDown(ac.KeyIndex[Settings.brake]) then
        if ac.isKeyPressed(ac.KeyIndex[Settings.brake]) then brakeFinal = 0.25 end
        if ac.getUI().mouseWheel > 0 then
            brakeFinal = math.min(brakeFinal + Settings.scroll, 1.0)
        elseif ac.getUI().mouseWheel < 0 then
            brakeFinal = math.max(brakeFinal - Settings.scroll, 0.0)
        end
    elseif ac.isKeyReleased(ac.KeyIndex[Settings.brake]) then brakeFinal = 0.0
    end

    --Output Part-
    ac.getJoypadState().steer = steeringFinal
    ac.getJoypadState().gas = gasFinal
    ac.getJoypadState().brake = brakeFinal
    ac.debug("gas", ac.getJoypadState().gas)
    ac.debug("brake", ac.getJoypadState().brake)
    ac.debug("Debug", Settings.debug)
end