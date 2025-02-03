--!strict

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TeleportService = game:GetService("TeleportService");
local TweenService = game:GetService("TweenService");

ReplicatedStorage.Shared.Functions.ShowTeleportGUI.OnClientInvoke = function()

  local screenGUI = Instance.new("ScreenGui");
  screenGUI.DisplayOrder = 2;
  screenGUI.ScreenInsets = Enum.ScreenInsets.None;
  screenGUI.Parent = Players.LocalPlayer:WaitForChild("PlayerGui");
  
  local frame = Instance.new("Frame");
  frame.BackgroundColor3 = Color3.new(0, 0, 0);
  frame.BorderSizePixel = 0;
  frame.Size = UDim2.new(1, 0, 0, 0);
  frame.Parent = screenGUI;

  TeleportService:SetTeleportGui(screenGUI);

  local tween = TweenService:Create(frame, TweenInfo.new(1, Enum.EasingStyle.Bounce), {
    Size = UDim2.new(1, 0, 1, 0);
  });

  tween:Play();

  tween.Completed:Wait();

end;