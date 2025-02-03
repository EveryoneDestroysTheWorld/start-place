--!strict

local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");

local React = require(ReplicatedStorage.Shared.Packages.react);
local fonts = require(ReplicatedStorage.Shared.Modules.fonts);

local function StartMenu()

  local statusText, setStatusText = React.useState("PRESS ANY BUTTON TO START");
  local isPlayerReady, setIsPlayerReady = React.useState(false);

  React.useEffect(function()
  
    local statusEvent;

    if isPlayerReady then

      task.spawn(function()

        setStatusText("CONNECTING...");

        statusEvent = ReplicatedStorage.Shared.Events.InitializationStatusChanged.OnClientEvent:Connect(function(newStatusText: string)
        
          assert(typeof(newStatusText) == "string");
          setStatusText(newStatusText:upper())

        end);

        xpcall(function()
        
          ReplicatedStorage.Shared.Functions.TeleportToMatch:InvokeServer();

        end, function(message)
        
          setStatusText(message);

        end);
        
      end)

    else

      statusEvent = UserInputService.InputBegan:Connect(function(input: InputObject)
      
        local isKeyboardPress = input.UserInputType == Enum.UserInputType.Keyboard;
        local isMouseButtonClick = input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 or input.UserInputType == Enum.UserInputType.MouseButton3;
        local isTouch = input.UserInputType == Enum.UserInputType.Touch;
        local isGamepadPress = input.UserInputType == Enum.UserInputType.Gamepad1 or input.UserInputType == Enum.UserInputType.Gamepad2 or input.UserInputType == Enum.UserInputType.Gamepad3 or input.UserInputType == Enum.UserInputType.Gamepad4 or input.UserInputType == Enum.UserInputType.Gamepad5 or input.UserInputType == Enum.UserInputType.Gamepad6 or input.UserInputType == Enum.UserInputType.Gamepad7 or input.UserInputType == Enum.UserInputType.Gamepad8;
        local isPlayerNowReady = isKeyboardPress or isMouseButtonClick or isTouch or isGamepadPress;
        if isPlayerNowReady then

          setIsPlayerReady(true);

        end;

      end);

    end

    return function()

      if statusEvent then

        statusEvent:Disconnect();

      end;

    end;

  end, {isPlayerReady});

  return React.createElement("Frame", {
    BackgroundTransparency = 1;
    Size = UDim2.new(1, 0, 1, 0);
  }, {
    BackgroundImage = React.createElement("ImageLabel", {
      BackgroundColor3 = Color3.fromRGB(35, 35, 35);
      BorderSizePixel = 0;
      Image = "rbxassetid://6372755229";
      ImageColor3 = Color3.fromRGB(43, 43, 43);
      Size = UDim2.new(1, 0, 1, 0);
      ScaleType = Enum.ScaleType.Tile;
      TileSize = UDim2.new(0, 16, 0, 16);
      ZIndex = 1;
    });
    Logo = React.createElement("ImageLabel", {
      BackgroundTransparency = 1;
      Image = "rbxassetid://132219857852717";
      Size = UDim2.new(0, 300, 0, 100);
      Position = UDim2.new(0, 30, 0, 30);
      ScaleType = Enum.ScaleType.Fit;
      ZIndex = 2;
    }, {
      UIAspectRatioConstraint = React.createElement("UIAspectRatioConstraint", {
        AspectRatio = 1080 / 423
      })
    });
    VersionText = React.createElement("TextLabel", {
      AnchorPoint = Vector2.new(1, 0);
      AutomaticSize = Enum.AutomaticSize.XY;
      BackgroundTransparency = 1;
      LayoutOrder = 2;
      Position = UDim2.new(1, -30, 0, 30);
      Size = UDim2.new();
      FontFace = fonts.Regular;
      TextColor3 = Color3.fromRGB(199, 199, 199);
      TextSize = 14;
      ZIndex = 2;
      TextXAlignment = Enum.TextXAlignment.Right;
      Text = "PROTOTYPE";
    });
    BottomTextContainer = React.createElement("Frame", {
      AnchorPoint = Vector2.new(1, 1);
      AutomaticSize = Enum.AutomaticSize.XY;
      BackgroundTransparency = 1;
      Position = UDim2.new(1, -30, 1, -30);
      ZIndex = 2;
    }, {
      UIListLayout = React.createElement("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder;
        Padding = UDim.new(0, 5);
        HorizontalAlignment = Enum.HorizontalAlignment.Right;
        VerticalAlignment = Enum.VerticalAlignment.Bottom;
      });
      StatusText = React.createElement("TextLabel", {
        AutomaticSize = Enum.AutomaticSize.XY;
        LayoutOrder = 1;
        BackgroundTransparency = 1;
        Size = UDim2.new();
        FontFace = fonts.Bold;
        TextColor3 = Color3.fromRGB(238, 238, 238);
        TextSize = 16;
        Text = statusText;
        TextXAlignment = Enum.TextXAlignment.Right;
        TextWrapped = true;
      });
      CopyrightText = React.createElement("TextLabel", {
        AutomaticSize = Enum.AutomaticSize.XY;
        BackgroundTransparency = 1;
        LayoutOrder = 2;
        Size = UDim2.new();
        FontFace = fonts.Regular;
        TextColor3 = Color3.fromRGB(199, 199, 199);
        TextSize = 14;
        Text = "© 2023 – 2025 Beastslash LLC";
        TextXAlignment = Enum.TextXAlignment.Right;
      });
    });
  });

end;

return StartMenu;