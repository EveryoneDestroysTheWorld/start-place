--!strict

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local StarterGui = game:GetService("StarterGui");

local React = require(ReplicatedStorage.Shared.Packages.react);
local ReactRoblox = require(ReplicatedStorage.Shared.Packages["react-roblox"]);
local StartMenu = require(script.components.StartMenu);

local gui = script.StartMenuGUI:Clone();
gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui");

local root = ReactRoblox.createRoot(gui);
root:render(React.createElement(StartMenu));

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false);