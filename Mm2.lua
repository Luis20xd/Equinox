local player = game.Players.LocalPlayer
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()

local Window = OrionLib:MakeWindow({Name = "Trade Scam", HidePremium = false, SaveConfig = true, IntroEnabled = true, IntroText = "Loading", ConfigFolder = "TradeScamConfig"})
local Tab = Window:MakeTab({Name = "Scam", Icon = "rbxassetid://4483345998", PremiumOnly = false})

local playerList = {}
for _, v in ipairs(game.Players:GetPlayers()) do
    if v ~= player then
        table.insert(playerList, v.Name)
    end
end

local victimDropdown = Tab:AddDropdown({Name = "Username Victim", Default = "Select a player", Values = playerList, MultiSelect = false, Callback = function(Value)
    if Value then
        OrionLib:MakeNotification({
            Name = "Target Found",
            Content = "Username Victim: " .. Value,
            Time = 5
        })
    end
end})

local startScam = Tab:AddToggle({Name = "Start Trade Scam", Default = false, Callback = function(Value)
    if Value then
        -- Logic to start the trade scam
    end
end})

local freezeTrade = Tab:AddButton({Name = "Freeze Trade", Callback = function()
    OrionLib:MakeNotification({
        Name = "Freeze Trade Activated",
        Content = "Remove your items of the trade",
        Time = 5
    })
    -- Logic to freeze the trade
end})

local forceAccept = Tab:AddButton({Name = "Force Accept", Callback = function()
    OrionLib:MakeNotification({
        Name = "Force Accept Activated",
        Content = "JUST ACCEPT TRADE",
        Time = 5
    })
    -- Logic to force accept the trade
end})

local readTab = Window:MakeTab({Name = "READ❗️", Icon = "rbxassetid://4483345998", PremiumOnly = false})
readTab:AddLabel({Text = "❗️NOT WORKING IN PRIVATE SERVERS❗️"})
readTab:AddLabel({Text = "❗️If u execute many times that crash you❗️"})
readTab:AddLabel({Text = "❗️WORKING WITH ANY KNIFE OR GUN❗️"})

local extraTab = Window:MakeTab({Name = "EXTRA", Icon = "rbxassetid://4483345998", PremiumOnly = false})
extraTab:AddLabel({Text = "Player ESP Chams"})

-- ESP Logic
local function createESP(player)
    local billboard = Instance.new("BillboardGui", player.Character.Head)
    billboard.Size = UDim2.new(2, 0, 2, 0)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    local frame = Instance.new("Frame", billboard)
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    local textLabel = Instance.new("TextLabel", frame)
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Text = player.Name
    textLabel.TextScaled = true
    textLabel.TextColor3 = Color3.new(1, 0, 0)
    textLabel.BackgroundTransparency = 1
end

for _, p in ipairs(game.Players:GetPlayers()) do
    if p ~= player then
        createESP(p)
    end
end

game.Players.PlayerAdded:Connect(function(p)
    if p ~= player then
        createESP(p)
        table.insert(playerList, p.Name)
        victimDropdown:Refresh(playerList)
    end
end)

game.Players.PlayerRemoving:Connect(function(p)
    for i, name in ipairs(playerList) do
        if name == p.Name then
            table.remove(playerList, i)
            victimDropdown:Refresh(playerList)
            break
        end
    end
end)

-- Make the window draggable
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    Window.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Window.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Window.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Window.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
