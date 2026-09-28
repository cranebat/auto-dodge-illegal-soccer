-- CLIENT SCRIPT (goes in StarterPlayer > StarterPlayerScripts)
-- Put this in a LocalScript, NOT a regular Script

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ActionRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Action")

local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.R then

        local actionData = {
            Protocol = "ActionCommand",
            Command = {
                ActionId = math.random(1, 100000),
                Mode = "Dodge",
                Kind = "Tackle",
                AimDirection = Vector3.new(1, 0, 0),
                PlayerVelocity = Vector3.new(0, 0, 0),
                ShotTime = tick()
            }
        }

        print("[CLIENT] Sending action:", actionData.Command.Mode)
        ActionRemote:FireServer(actionData)
    end
end)