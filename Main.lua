Dta = {}

--Addon information
Dta.Version = Inspect.Addon.Detail(Inspect.Addon.Current()).toc.Version
Dta.Language = Inspect.System.Language()


--Items
Dta.selectedItems = {}
Dta.clipboard = {}
Dta.groupClipboard = {}
Dta.itemList = {}
Dta.AllItems = {}
Dta.DimensionItemCount = 0
Dta.PasteSets = 0

--Load & Save
Dta.Setname = ""
Dta.constructions = {}
Dta.constructionsdefaults = {}
Dta.constructionstbx = {}
Dta.FinishedSet = true
Dta.SelectionQueue = {}
Dta.ItemsToPlace = 0
Dta.ItemsPlaced = 1

--Import & Export
Dta.ExportTbx = {}
Dta.ExportSaved = {}
Dta.ExportImport_Sets = {}
Dta.ExportSet = {}
Dta.ImportSet = {}

--Move, Rotate and Scale
Dta.pendingActions = {}
Dta.lastFrameTime = 0

--Copy & Paste
Dta.FlickerOffset = true
Dta.FlickerReduc = 0.0003
Dta.FinishedPaste = true
Dta.ItemsToPaste = 0
Dta.ItemsPasted = 1
Dta.PastingItems = false

--Others
Dta.Deleting = false
Dta.Key = nil
Dta.PlayerID = Inspect.Unit.Lookup("player")
Dta.CurrentZoneID = nil
Dta.OldZoneID = nil
Dta.ZoneDetails = {}
Dta.InDimenion = false

--Flying
Dta.desiredPitch = 0
Dta.pitchButtons = {}
Dta.waitingForCarpet = false
Dta.FlyingType = "IFEC11D174272F87C,3E1F104FE8C67224,,,,,,"
Dta.magicYOffset = 0.47
Dta.carpetId = "d"
Dta.lastPlayerPos = {coordX = 0, coordY = 0, coordZ = 0}
Dta.olderPlayerPos = Dta.lastPlayerPos
Dta.evenOlderPlayerPos = Dta.olderPlayerPos
Dta.lastCarpetMove = 0
Dta.lastYaw = 0

---------------------------------
--CATCH COROUTINES
---------------------------------
Dta.Copa_Co_Active = false
Dta.LoadSet_Co_Active = false
Dta.PlaceItem_Co_Active = false

--------------------------------------
--MAIN FUNCTIONS
--------------------------------------

function Dta.main()
    Command.Event.Attach(Command.Slash.Register("Dt"), Dta.commandHandler, "Dimtools Command")
    Command.Event.Attach(Event.Unit.Availability.Full, Dta.Event_Unit_Availability_Full, "Event_Unit_Availability_Full")
    Command.Event.Attach(Event.Unit.Detail.Zone, Dta.Event_Unit_Detail_Zone, "Event_Unit_Detail_Zone")
    Command.Event.Attach(Event.System.Update.Begin, Dta.tick, "refresh")
    Command.Event.Attach(Event.Dimension.Layout.Add, Dta.addEventHandler, "Update selection")
    Command.Event.Attach(Event.Dimension.Layout.Remove, Dta.removeEventHandler, "Update selection")
    Command.Event.Attach(Event.Dimension.Layout.Update, Dta.updateEventHandler, "Update selection")
end

function Dta.addEventHandler(hEvent, dimensionItem) --executed all the time in a dimension
    if Dta.Copa_Co_Active then
        for id, value in pairs(dimensionItem) do
            local data = Inspect.Dimension.Layout.Detail(id)
            if data ~= nil then
                coroutine.resume(Dta.copa.Co_PlaceItem)
            end
        end
    end

    if Dta.PlaceItem_Co_Active then
        for id, value in pairs(dimensionItem) do
            local data = Inspect.Dimension.Layout.Detail(id)
            if data ~= nil then
                coroutine.resume(Dta.losa.Co_PlaceItem)
            end
        end
    elseif Dta.LoadSet_Co_Active then
        for id, value in pairs(dimensionItem) do
            local data = Inspect.Dimension.Layout.Detail(id)
            if data ~= nil then
                coroutine.resume(Dta.losa.Co_LoadItem)
            end
        end
    end

    if Dta.alphabet.PlaceLetter_Co_Active then
        for id, value in pairs(dimensionItem) do
            local data = Inspect.Dimension.Layout.Detail(id)
            if data ~= nil then
                coroutine.resume(Dta.alphabet.Co_PlaceLetter)
            end
        end
    elseif Dta.alphabet.PlaceWord_Co_Active then
        for id, value in pairs(dimensionItem) do
            local data = Inspect.Dimension.Layout.Detail(id)
            if data ~= nil then
                coroutine.resume(Dta.alphabet.Co_PlaceWord)
            end
        end
    end

    if #Dta.pendingActions == 1 then
        print(Lang[Dta.Language].Prints.ProcessFinished)
    end

    if not Dta.FinishedSet then
        if Dta.ItemsPlaced < Dta.ItemsToPlace then
            --print("ItemsPlaced: " .. Dta.ItemsPlaced .. " out of " .. Dta.ItemsToPlace)
            for id, value in pairs(dimensionItem) do
                local data = Inspect.Dimension.Layout.Detail(id)
                if data ~= nil then
                    Dta.items.QueueSelection(id)
                end
            end
            Dta.ItemsPlaced = Dta.ItemsPlaced + 1
        elseif Dta.ItemsPlaced == Dta.ItemsToPlace then
            for id, value in pairs(dimensionItem) do
                local data = Inspect.Dimension.Layout.Detail(id)
                if data ~= nil then
                    Dta.items.QueueSelection(id)
                end
            end
            --print("ItemsPlaced: " .. Dta.ItemsPlaced .. " out of " .. Dta.ItemsToPlace)
            Dta.FinishedSet = true
            Dta.ItemsPlaced = 1
        end
    end

    if Dta.waitingForCarpet == true then
        for id, value in pairs(dimensionItem) do
            local data = Inspect.Dimension.Layout.Detail(id)
            if data ~= nil then
                if data.type == Dta.FlyingType then
                    Dta.carpetId = id
                    Dta.waitingForCarpet = false
                    Dta.magicYOffset = Inspect.Unit.Detail("player").coordY - Inspect.Dimension.Layout.Detail(id).coordY
                    Dta.magicYOffset = Dta.magicYOffset + 0.47
                end
            end
        end
    end

end

function Dta.removeEventHandler(hEvent, dimensionItem) --Executed when item is removed
    if #Dta.pendingActions == 1 then
        print(Lang[Dta.Language].Prints.ProcessFinished)
    end
    if Dta.losa.tableLength(Dta.selectedItems) > 0 then
        Dta.Deleting = true
        Dta.items.updateSelection(dimensionItem)
        --print("Item Removed")
    end

end

function Dta.updateEventHandler(hEvent, dimensionItem) --Executed on every select/ deselect or change of an dimension item
    if #Dta.pendingActions == 1 then
        print(Lang[Dta.Language].Prints.ProcessFinished)
    end
    Dta.items.updateSelection(dimensionItem)

    if Dta.FinishedSet and Dta.Setname ~= "" and #Dta.SelectionQueue == 1 then
        print(string.format(Lang[Dta.Language].Prints.SetFinished, Dta.Setname))
        Dta.Setname = ""
    end

    if Dta.FinishedSet and Dta.PastingItems and #Dta.SelectionQueue == 1 then
        print(Lang[Dta.Language].Prints.PasteFinished)
        Dta.PastingItems = false
    end

    if Dta.FinishedSet and Dta.alphabet.PastingWord and #Dta.SelectionQueue == 1 then
        print(Lang[Dta.Language].Prints.WordFinished)
        Dta.alphabet.PastingWord = false
    end

end

function Dta.Event_Unit_Detail_Zone(hEvent, u)
    if u[Dta.PlayerID] then
        Dta.CurrentZoneID = nil
    end
end

function Dta.Event_Unit_Availability_Full(hEvent, t)
    for k,v in pairs(t) do
        if v == "player" then
            Dta.CurrentZoneID = nil
            break
        end
    end
end


function Dta.commandHandler(hEvent, command)

  if command == "reset" then
    Dta.settings.set("MainwindowPosX", 0)
    Dta.settings.set("MainwindowPosY", 32)
    Dta.settings.set("MovewindowPosX", 0)
    Dta.settings.set("MovewindowPosY", 370)
    Dta.settings.set("RotatewindowPosX", 0)
    Dta.settings.set("RotatewindowPosY", 410)
    Dta.settings.set("ScalewindowPosX", 0)
    Dta.settings.set("ScalewindowPosY", 450)
    Dta.settings.set("CopyPastewindowPosX", 320)
    Dta.settings.set("CopyPastewindowPosY", 410)
    Dta.settings.set("LoSawindowPosX", 320)
    Dta.settings.set("LoSawindowPosY", 450)
    Dta.settings.set("ExpImpwindowPosX", 320)
    Dta.settings.set("ExpImpwindowPosY", 370)
    Dta.settings.set("HelpwindowPosX", 650)
    Dta.settings.set("HelpwindowPosY", 335)
    Dta.settings.set("FlyingwindowPosX", 475)
    Dta.settings.set("FlyingwindowPosY", 32)
    Dta.settings.set("AlphabetwindowPosX", 0)
    Dta.settings.set("AlphabetwindowPosY", 530)
    Dta.settings.set("MeasurementswindowPosX", 0)
    Dta.settings.set("MeasurementswindowPosY", 490)

    if Dta.ui.windowtest then Dta.ui.windowtest:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 32) end
    if Dta.ui.windowMove then Dta.ui.windowMove:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 370) end
    if Dta.ui.windowRotate then Dta.ui.windowRotate:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 410) end
    if Dta.ui.windowScale then Dta.ui.windowScale:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 450) end
    if Dta.ui.windowCopyPaste then Dta.ui.windowCopyPaste:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 320, 410) end
    if Dta.ui.windowLoSa then Dta.ui.windowLoSa:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 320, 450) end
    if Dta.ui.windowExpImp then Dta.ui.windowExpImp:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 320, 370) end
    if Dta.ui.windowHelp then Dta.ui.windowHelp:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 650, 335) end
    if Dta.ui.windowFlying then Dta.ui.windowFlying:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 475, 32) end
    if Dta.ui.windowAlphabet then Dta.ui.windowAlphabet:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 530) end
    if Dta.ui.windowMeasurements then Dta.ui.windowMeasurements:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 490) end
    print("Position reset")
  elseif command == "help" then
    Dta.help_ui.toggleHelpWindow()
  else
    if Dta.InDimenion == true then
        Dta.ui.toggleMainWindow()
    else
        print(Lang[Dta.Language].Prints.DimensionOnly)
    end
  end
end

--------------------------------------
--QUEUE HANDLER
--------------------------------------

function Dta.tick(handle)
	local currentFrameTime = Inspect.Time.Frame()
	local deltaT = 	currentFrameTime - Dta.lastFrameTime

	Dta.lastFrameTime = currentFrameTime

	if Dta.CurrentZoneID == nil then
	    local PlayerDetails = Inspect.Unit.Detail("player")
	    if PlayerDetails and PlayerDetails.zone then
	        if Dta.ZoneDetails[PlayerDetails.zone] == nil then
	            local ZoneDetails = Inspect.Zone.Detail(PlayerDetails.zone)
	            if ZoneDetails and ZoneDetails.name then
	                Dta.ZoneDetails[PlayerDetails.zone] = ZoneDetails.name
				end
			end
			if Dta.ZoneDetails[PlayerDetails.zone] and PlayerDetails.zone ~= Dta.OldZoneID then
			    local ZoneName = Dta.ZoneDetails[PlayerDetails.zone]
			    if string.find(ZoneName, "Dimension") or string.find(ZoneName, "Измерение") then
			        Dta.InDimenion = true
			    else
			        if Dta.ui.active then Dta.ui.hideMainWindow() end
			        Dta.InDimenion = false
			    end
			    Dta.OldZoneID = PlayerDetails.zone
			end
		end
	end

	if #Dta.pendingActions > 0 then
	  local action = table.remove(Dta.pendingActions, 1)
	  if action.op == "scale" then
	    Command.Dimension.Layout.Place(action.id, {scale=action.amount})
	  end
	  if action.op == "move" then
	    Command.Dimension.Layout.Place(action.id, {coordX=action.x, coordY=action.y, coordZ=action.z})
	  end
	  if action.op == "rotate" then
	    Command.Dimension.Layout.Place(action.id, {pitch=action.pitch, yaw=action.yaw, roll=action.roll})
	  end
	  if action.op == "select" then
	    Command.Dimension.Layout.Select(action.id, true)
	  end
	  if action.op == "copa" then
	    Command.Dimension.Layout.Place(action.id, {coordX=action.x, coordY=action.y, coordZ=action.z, pitch=action.pitch, yaw=action.yaw, roll=action.roll, scale=action.amount})
	  end
	  if action.op == "losa" then
	    Command.Dimension.Layout.Place(action.id, {coordX=action.x, coordY=action.y, coordZ=action.z, pitch=action.pitch, yaw=action.yaw, roll=action.roll, scale=action.amount})
	  end

	end

	if #Dta.SelectionQueue > 0 and Dta.FinishedSet and Dta.FinishedPaste then
	    local action = table.remove(Dta.SelectionQueue, 1)
	    if action.op == "deselect" then
	        Command.Dimension.Layout.Select(action.id, false)
	    end
	    if action.op == "select" then
	        Command.Dimension.Layout.Select(action.id, true)
	    end
	end

	if Dta.carpetId ~= "d" then
	    local playerDetails = Inspect.Unit.Detail("player")
	    if playerDetails["coordX"] == nil then
	        Dta.carpetId = "d"
	        return
		end

		--if Dta.lastPlayerPos["coordX"] == nil then
		--    return
		--end

	    local xDiff = playerDetails["coordX"] - Dta.lastPlayerPos["coordX"]
	    local yDiff = playerDetails["coordY"] - Dta.lastPlayerPos["coordY"]
	    local zDiff = playerDetails["coordZ"] - Dta.lastPlayerPos["coordZ"]
	    if math.abs(xDiff) > 0.001 or
	        math.abs(yDiff) > 0.02 or
	        math.abs(zDiff) > 0.001 then

	        if playerDetails["coordX"] ~= Dta.lastPlayerPos["coordX"] or playerDetails["coordY"] ~= Dta.lastPlayerPos["coordY"] or playerDetails["coordZ"] ~= Dta.lastPlayerPos["coordZ"] then
	            Dta.lastCarpetMove = currentFrameTime
	            local update = {}
	            update["coordX"] = playerDetails["coordX"]
	            update["coordY"] = playerDetails["coordY"] - Dta.magicYOffset
	            -- 0.2044681331
	            update["coordZ"] = playerDetails["coordZ"]

	            if Dta.desiredPitch > 0 then
	                update["coordY"] = update["coordY"] - Dta.desiredPitch * 0.125
	            end

	            if math.abs(xDiff) > 0.01 or math.abs(zDiff) > 0.01 then
	                if Dta.olderPlayerPos["coordX"] ~= 0 then
	                    update["yaw"] = math.atan2(playerDetails["coordZ"] - Dta.evenOlderPlayerPos["coordZ"], playerDetails["coordX"] - Dta.evenOlderPlayerPos["coordX"]) + (math.pi / 2)
	                else
	                    update["yaw"] = math.atan2(zDiff, xDiff) + (math.pi / 2)
	                end

	                if update["yaw"] > math.pi then
	                    update["yaw"] = update["yaw"] - 2 * math.pi
	                end

	                if update["yaw"] < -math.pi then
	                    update["yaw"] = update["yaw"] + 2 * math.pi
	                end

	                local yawDiff = math.abs(update["yaw"] - Dta.lastYaw)
	                if yawDiff > 2 * math.pi then
	                    yawDiff = yawDiff - 2 * math.pi
	                end

	                if yawDiff < 0.105 then
	                    update["yaw"] = Dta.lastYaw
	                end
	                Dta.lastYaw = update["yaw"]

	                while Dta.lastYaw > math.pi do
	                    Dta.lastYaw = Dta.lastYaw - math.pi * 2
	                end

	                while Dta.lastYaw < -math.pi do
	                    Dta.lastYaw = Dta.lastYaw + math.pi * 2
	                end

	                --if Dta.desiredPitch ~= 0 then
	                -- MakeZRotation
	                local zMatrix = {}
	                zMatrix[0] = {}
	                zMatrix[1] = {}
	                zMatrix[2] = {}

	                local sn = math.sin(Dta.desiredPitch)
	                local cs = math.cos(Dta.desiredPitch)

	                zMatrix[0][0] = cs
	                zMatrix[0][1] = sn
	                zMatrix[0][2] = 0
	                zMatrix[1][0] = -sn
	                zMatrix[1][1] = cs
	                zMatrix[1][2] = 0
	                zMatrix[2][0] = 0
	                zMatrix[2][1] = 0
	                zMatrix[2][2] = 1

	                local yMatrix = {}
	                yMatrix[0] = {}
	                yMatrix[1] = {}
	                yMatrix[2] = {}

	                sn = math.sin(Dta.lastYaw)
	                cs = math.cos(Dta.lastYaw)

	                yMatrix[0][0] = cs
	                yMatrix[0][1] = 0
	                yMatrix[0][2] = -sn
	                yMatrix[1][0] = 0
	                yMatrix[1][1] = 1
	                yMatrix[1][2] = 0
	                yMatrix[2][0] = sn
	                yMatrix[2][1] = 0
	                yMatrix[2][2] = cs

	                local aMatrix = zMatrix
	                local bMatrix = yMatrix

	                local rMatrix = {}
	                rMatrix[0] = {}
	                rMatrix[1] = {}
	                rMatrix[2] = {}

	                rMatrix[0][0] = aMatrix[0][0]*bMatrix[0][0] + aMatrix[0][1]*bMatrix[1][0] + aMatrix[0][2]*bMatrix[2][0]
	                rMatrix[1][0] = aMatrix[1][0]*bMatrix[0][0] + aMatrix[1][1]*bMatrix[1][0] + aMatrix[1][2]*bMatrix[2][0]
	                rMatrix[2][0] = aMatrix[2][0]*bMatrix[0][0] + aMatrix[2][1]*bMatrix[1][0] + aMatrix[2][2]*bMatrix[2][0]
	                rMatrix[0][1] = aMatrix[0][0]*bMatrix[0][1] + aMatrix[0][1]*bMatrix[1][1] + aMatrix[0][2]*bMatrix[2][1]
	                rMatrix[1][1] = aMatrix[1][0]*bMatrix[0][1] + aMatrix[1][1]*bMatrix[1][1] + aMatrix[1][2]*bMatrix[2][1]
	                rMatrix[2][1] = aMatrix[2][0]*bMatrix[0][1] + aMatrix[2][1]*bMatrix[1][1] + aMatrix[2][2]*bMatrix[2][1]
	                rMatrix[0][2] = aMatrix[0][0]*bMatrix[0][2] + aMatrix[0][1]*bMatrix[1][2] + aMatrix[0][2]*bMatrix[2][2]
	                rMatrix[1][2] = aMatrix[1][0]*bMatrix[0][2] + aMatrix[1][1]*bMatrix[1][2] + aMatrix[1][2]*bMatrix[2][2]
	                rMatrix[2][2] = aMatrix[2][0]*bMatrix[0][2] + aMatrix[2][1]*bMatrix[1][2] + aMatrix[2][2]*bMatrix[2][2]


	                --rMatrix = yMatrix

	                local rfxAngle = 0
	                local rfyAngle = 0
	                local rfzAngle = 0

	                rfyAngle = -math.asin(rMatrix[0][2])
	                if rfyAngle < math.pi/2 then
	                    if rfyAngle > -math.pi/2 then
	                        rfxAngle = -math.atan2(-rMatrix[1][2], rMatrix[2][2])
	                        rfzAngle = -math.atan2(-rMatrix[0][1], rMatrix[0][0])
					    else
					        local frmy = math.atan2(rMatrix[1][0], rMatrix[1][1])
					        rfzAngle = 0
					        rfxAngle = frmy - rfzAngle
					    end
	                else
	                    local frpy = math.atan2(rMatrix[1][0], rMatrix[1][1])
	                    rfzAngle = 0
	                    rfxAngle = rfzAngle - frpy
	                end

	                update["pitch"] = rfzAngle
	                update["roll"] = rfxAngle
	                update["yaw"] = rfyAngle
                end


	            Command.Dimension.Layout.Place(Dta.carpetId, update)

	            Dta.evenOlderPlayerPos = Dta.olderPlayerPos
	            Dta.olderPlayerPos = Dta.lastPlayerPos

	            Dta.lastPlayerPos["coordX"] = playerDetails["coordX"]
	            Dta.lastPlayerPos["coordY"] = playerDetails["coordY"]
	            Dta.lastPlayerPos["coordZ"] = playerDetails["coordZ"]
            end
        end
    end
end
Dta.main()
