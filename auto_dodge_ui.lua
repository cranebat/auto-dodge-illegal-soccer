-- AUTO-DODGE SCRIPT WITH UI
-- This script creates a simple UI for toggling auto-dodge on/off

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Get the RemoteEvent
local ActionRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Action")

-- Script state
local enabled = false

-- Create ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "AutoDodgeGui"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- Main Frame
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 250, 0, 120)
frame.Position = UDim2.new(0, 20, 0, 20)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderColor3 = Color3.fromRGB(0, 150, 255)
frame.BorderSizePixel = 2
frame.Parent = gui

-- Title Label
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
title.BorderSizePixel = 0
title.Text = "AUTO-DODGE"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- Status Label
local status = Instance.new("TextLabel")
status.Name = "Status"
status.Size = UDim2.new(1, -10, 0, 25)
status.Position = UDim2.new(0, 5, 0, 40)
status.BackgroundTransparency = 1
status.Text = "Status: OFF"
status.TextColor3 = Color3.fromRGB(255, 100, 100)
status.TextScaled = true
status.Font = Enum.Font.Gotham
status.Parent = frame

-- Toggle Button
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(1, -10, 0, 30)
toggleButton.Position = UDim2.new(0, 5, 0, 75)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Text = "ENABLE (R to dodge)"
toggleButton.TextScaled = true
toggleButton.Font = Enum.Font.GothamBold
toggleButton.BorderSizePixel = 0
toggleButton.Parent = frame

-- Toggle function
local function toggle()
    enabled = not enabled

    if enabled then
        status.Text = "Status: ON ✓"
        status.TextColor3 = Color3.fromRGB(100, 255, 100)
        toggleButton.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
        toggleButton.Text = "DISABLE"
    else
        status.Text = "Status: OFF"
        status.TextColor3 = Color3.fromRGB(255, 100, 100)
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        toggleButton.Text = "ENABLE (R to dodge)"
    end
end

-- Button click event
toggleButton.MouseButton1Click:Connect(toggle)

-- Key press event (R to dodge)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if enabled and input.KeyCode == Enum.KeyCode.R then
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

        print("[✓ AUTO-DODGE] Dodging! (" .. tick() .. ")")
        ActionRemote:FireServer(actionData)
    end
end)

print("[✓] Auto-Dodge UI loaded! Click the button to enable.")
