local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")

-- Fungsi Notifikasi
local function notify(title, text)
    StarterGui:SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = 3;
    })
end

local ScreenGui = Instance.new("ScreenGui")
local DragFrame = Instance.new("Frame") -- Alas buat digeser
local TextButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "InvisGuiDimz"

-- Setup Alas (Pegang bagian ini untuk geser)
DragFrame.Name = "DragFrame"
DragFrame.Parent = ScreenGui
DragFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
DragFrame.Position = UDim2.new(0.5, -60, 0.4, 0)
DragFrame.Size = UDim2.new(0, 120, 0, 50)
DragFrame.Active = true

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = DragFrame

-- Setup Tombol
TextButton.Parent = DragFrame
TextButton.Size = UDim2.new(0.8, 0, 0.7, 0)
TextButton.Position = UDim2.new(0.1, 0, 0.15, 0)
TextButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
TextButton.Text = "Invis: OFF"
TextButton.TextColor3 = Color3.new(1,1,1)
TextButton.Font = Enum.Font.SourceSansBold
TextButton.TextSize = 14
Instance.new("UICorner", TextButton)

-- Script Drag Manual (Mobile Friendly)
local dragging, dragInput, dragStart, startPos
DragFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = DragFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        DragFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
end)

-- Fitur Invisible
local active = false
TextButton.MouseButton1Click:Connect(function()
    local char = game.Players.LocalPlayer.Character
    active = not active
    TextButton.Text = active and "Invis: ON" or "Invis: OFF"
    TextButton.BackgroundColor3 = active and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Decal") then
            v.Transparency = active and 1 or (v.Name == "HumanoidRootPart" and 1 or 0)
        end
    end
end)

notify("NOOB_GAMER1, welcome and thanks for using script.")
