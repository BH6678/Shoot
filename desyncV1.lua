local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function respawnar(plr)
    local rcdEnabled, wasHidden = false, false
    if gethidden then
        rcdEnabled, wasHidden = gethidden(workspace, 'RejectCharacterDeletions')
            ~= Enum.RejectCharacterDeletions.Disabled
    end

    if rcdEnabled and replicatesignal then
        replicatesignal(plr.ConnectDiedSignalBackend)
        task.wait(Players.RespawnTime - 0.1)
        replicatesignal(plr.Kill)
    else
        local char = plr.Character
        local hum = char:FindFirstChildWhichIsA('Humanoid')
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Dead)
        end
        char:ClearAllChildren()
        local newChar = Instance.new('Model')
        newChar.Parent = workspace
        plr.Character = newChar
        task.wait()
        plr.Character = char
        newChar:Destroy()
    end
end

raknet.desync(true)
respawnar(player)