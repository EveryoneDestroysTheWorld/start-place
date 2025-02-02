--!strict

local MemoryStoreService = game:GetService("MemoryStoreService");
local HttpService = game:GetService("HttpService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local ServerStorage = game:GetService("ServerStorage");
local TeleportService = game:GetService("TeleportService");

local placeMap = require(ServerStorage.PlaceMap);
local Stage = require(ServerStorage.Packages.Stage);

local locks = {};

ReplicatedStorage.Shared.Functions.TeleportToMatch.OnServerInvoke = function(player)

  assert(not table.find(locks, player), "We're already preparing a match for you.");
  table.insert(locks, player);

  assert(not RunService:IsStudio(), "Studio players currently cannot teleport to servers. Try using the Roblox Player instead.")

  print("[Matchmaking] Reserving server...");
  local placeID = placeMap.turfWar;
  local serverAccessCode, privateServerID = TeleportService:ReserveServer(placeID);
  print(`[Matchmaking] Server reserved: {privateServerID}`);

  print("[Matchmaking] Saving match settings to memory store...");
  local serverSettings = {
    id = HttpService:GenerateGUID(false);
    contestantIDs = {player.UserId};
    gameModeID = "TurfWar";
    stageID = Stage.random().id;
    duration = 180;
  };
  MemoryStoreService:GetHashMap("PrivateServerRoundMetadata"):SetAsync(privateServerID, HttpService:JSONEncode(serverSettings), 2592000);

  print(`[Matchmaking] Teleporting {player.Name} to the match...`)
  local teleportOptions = Instance.new("TeleportOptions");
  teleportOptions.ReservedServerAccessCode = serverAccessCode;
  TeleportService:TeleportAsync(placeID, {player}, teleportOptions);

end;