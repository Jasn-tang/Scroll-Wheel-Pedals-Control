Settings = ac.INIConfig.scriptSettings():mapSection('SETTINGS', {
    throttle = 'W',
    brake = 'S',
    scroll = 0.02
})

local throttleKey = Settings.throttle
local brakeKey = Settings.brake
local scroll = Settings.scroll
local gasFinal = 0
local brakeFinal = 0

function script.update()
    --Throttle Part--
    if ac.isKeyDown(ac.KeyIndex[throttleKey]) then
        if ac.isKeyPressed(ac.KeyIndex[throttleKey]) then gasFinal = 0.25 end
        if ac.getUI().mouseWheel > 0 then
            gasFinal = math.min(gasFinal + scroll, 1.0)
        elseif ac.getUI().mouseWheel < 0 then
            gasFinal = math.max(gasFinal - scroll, 0.0)
        end
    elseif ac.isKeyReleased(ac.KeyIndex[throttleKey]) then gasFinal = 0.0
    end

    --Brake Part--
    if ac.isKeyDown(ac.KeyIndex[brakeKey]) then
        if ac.isKeyPressed(ac.KeyIndex[brakeKey]) then brakeFinal = 0.25 end
        if ac.getUI().mouseWheel > 0 then
            brakeFinal = math.min(brakeFinal + scroll, 1.0)
        elseif ac.getUI().mouseWheel < 0 then
            brakeFinal = math.max(brakeFinal - scroll, 0.0)
        end
    elseif ac.isKeyReleased(ac.KeyIndex[brakeKey]) then brakeFinal = 0.0
    end

    --Output Part-
    ac.getJoypadState().gas = gasFinal
    ac.getJoypadState().brake = brakeFinal
    ac.debug("gas", ac.getJoypadState().gas)
    ac.debug("brake", ac.getJoypadState().brake)
end