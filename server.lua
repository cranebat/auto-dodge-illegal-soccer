-- SERVER SCRIPT (goes in ServerScriptService)
-- Put this in a regular Script, NOT a LocalScript

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ActionRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Action")

ActionRemote.OnServerEvent:Connect(function(player, data)

    print("[SERVER] Received from", player.Name, ":", data.Protocol)

    -- ===== VALIDATION =====

    if data.Protocol ~= "ActionCommand" then
        print("[SERVER] Invalid protocol, ignoring")
        return
    end

    if not data.Command then
        print("[SERVER] Missing Command table, ignoring")
        return
    end

    local cmd = data.Command

    if cmd.Kind ~= "Tackle" then
        print("[SERVER] Invalid Kind:", cmd.Kind)
        return
    end

    local validModes = { Dodge = true, Block = true, Counter = true }
    if not validModes[cmd.Mode] then
        print("[SERVER] Invalid Mode:", cmd.Mode)
        return
    end

    local timeDifference = tick() - cmd.ShotTime
    if timeDifference > 1 then
        print("[SERVER] Action too old, possible lag or cheating")
        return
    end

    local humanoid = player.Character:FindFirstChild("Humanoid")
    if not humanoid or humanoid.Health <= 0 then
        print("[SERVER] Player is dead or invalid")
        return
    end

    print("[SERVER] ✓ Action validated!")
    print("[SERVER] Player", player.Name, "performed:", cmd.Mode, "tackle")

    if cmd.Mode == "Dodge" then
        print("[SERVER] Dodge was successful!")
    elseif cmd.Mode == "Block" then
        print("[SERVER] Block was successful!")
    elseif cmd.Mode == "Counter" then
        print("[SERVER] Counter attack!")
    end

end)