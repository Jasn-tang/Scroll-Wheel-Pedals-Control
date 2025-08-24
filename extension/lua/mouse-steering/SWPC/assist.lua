--Change script settings here--
-------------------------------
local throttle = "W" --Key to press for throttle while scrolling mouse wheel.
local brake = "S" --Key to press for brake while scrolling mouse wheel.
local scroll = 0.02 --What percent will each scroll change.
-------------------------------

local gasFinal = 0
local brakeFinal = 0
local steeringFinal = 0

function script.update(dt, deltaX)
    --Mouse Steering--
    steeringFinal = math.clamp(steeringFinal + deltaX, -1, 1)
    
    --Throttle Part--
    if ac.isKeyDown(ac.KeyIndex[throttle]) and ac.isKeyDown(ac.KeyIndex.Shift) then
        gasFinal = 1
    elseif ac.isKeyPressed(ac.KeyIndex[throttle]) then gasFinal = 0.25
    elseif ac.isKeyDown(ac.KeyIndex[throttle]) then
        gasFinal = math.clamp(gasFinal + ac.getUI().mouseWheel * scroll, 0, 1)
    else gasFinal = 0
    end

    --Brake Part--
    if ac.isKeyDown(ac.KeyIndex[brake]) and ac.isKeyDown(ac.KeyIndex.Shift) then
        brakeFinal = 1
    elseif ac.isKeyPressed(ac.KeyIndex[brake]) then brakeFinal = 0.25
    elseif ac.isKeyDown(ac.KeyIndex[brake]) then
        brakeFinal = math.clamp(brakeFinal + ac.getUI().mouseWheel * scroll, 0, 1)
    else brakeFinal = 0
    end

    --Output Part-
    ac.getJoypadState().steer = steeringFinal
    ac.getJoypadState().gas = gasFinal
    ac.getJoypadState().brake = brakeFinal
    ac.debug("gas", ac.getJoypadState().gas)
    ac.debug("brake", ac.getJoypadState().brake)
end
