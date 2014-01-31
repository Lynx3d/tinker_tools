Dta = {}


Dta.selectedItems = {}
Dta.clipboard = {}
Dta.groupClipboard = {}
Dta.itemList = {}
Dta.constructions = {}
Dta.constructionsdefaults = {}
Dta.ExportImport_Sets = {}
Dta.ExportSet = {}
Dta.ImportSet = {}
Dta.pendingActions = {}
Dta.lastFrameTime = 0
Dta.FlickerOffset = true
Dta.FlickerReduc = 0.0003
Dta.DimensionItemCount = 0
Dta.AllItems = {}
Dta.PasteSets = 0

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
  if Event.Dimension ~= nil and Inspect.Dimension ~= nil then
    Command.Event.Attach(Event.System.Update.Begin, Dta.tick, "refresh")
    Command.Event.Attach(Event.Dimension.Layout.Add, Dta.addEventHandler, "Update selection")
    Command.Event.Attach(Event.Dimension.Layout.Remove, Dta.removeEventHandler, "Update selection")
    Command.Event.Attach(Event.Dimension.Layout.Update, Dta.updateEventHandler, "Update selection")
  else
    print("This addon is intended for use with Dimensions.")
  end
end

function Dta.addEventHandler(hEvent) --executed all the time in a dimension
    if Dta.Copa_Co_Active then coroutine.resume(Dta.copa.Co_PlaceItem) end
    if Dta.PlaceItem_Co_Active then
        coroutine.resume(Dta.losa.Co_PlaceItem)
    elseif Dta.LoadSet_Co_Active then
        coroutine.resume(Dta.losa.Co_LoadItem)
    end
    if #Dta.pendingActions == 1 then
        print("Processing Finished")
    elseif #Dta.pendingActions == 0 then
        --Dta.items.updateSelection()
        --print("Item Added")
    end
end

function Dta.removeEventHandler(hEvent) --Executed when item is removed
    if #Dta.pendingActions == 1 then
        print("Processing Finished")
    elseif #Dta.pendingActions == 0 then
        if #Dta.selectedItems > 0 then
          Dta.items.updateSelection()
          --print("Item Removed")
        end
    end
end

function Dta.updateEventHandler(hEvent) --Executed on every select/ deselect or change of an dimension item
    if #Dta.pendingActions == 1 then
        print("Processing Finished")
    elseif #Dta.pendingActions == 0 then
        Dta.items.updateSelection()
        --print("Item Updated")
    end
end

function Dta.commandHandler(hEvent, command)

  if command == "reset" then
    Dta.settings.set("MainwindowPosX", 0)
    Dta.settings.set("MainwindowPosY", 32)
    Dta.settings.set("MovewindowPosX", 0)
    Dta.settings.set("MovewindowPosY", 370)
    Dta.settings.set("RotatewindowPosX", 0)
    Dta.settings.set("RotatewindowPosY", 545)
    Dta.settings.set("ScalewindowPosX", 0)
    Dta.settings.set("ScalewindowPosY", 720)
    Dta.settings.set("CopyPastewindowPosX", 455)
    Dta.settings.set("CopyPastewindowPosY", 32)
    Dta.settings.set("LoSawindowPosX", 455)
    Dta.settings.set("LoSawindowPosY", 330)
    Dta.settings.set("ExpImpwindowPosX", 785)
    Dta.settings.set("ExpImpwindowPosY", 32)
    Dta.settings.set("HelpwindowPosX", 400)
    Dta.settings.set("HelpwindowPosY", 100)
    Dta.settings.set("ExpImp_tbxwindowPosX", 785)
    Dta.settings.set("ExpImp_tbxwindowPosY", 230)




    if Dta.ui.windowtest then Dta.ui.windowtest:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 32) end
    if Dta.ui.windowMove then Dta.ui.windowMove:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 370) end
    if Dta.ui.windowRotate then Dta.ui.windowRotate:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 545) end
    if Dta.ui.windowScale then Dta.ui.windowScale:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 720) end
    if Dta.ui.windowCopyPaste then Dta.ui.windowCopyPaste:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 455, 32) end
    if Dta.ui.windowLoSa then Dta.ui.windowLoSa:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 455, 330) end
    if Dta.ui.windowExpImp then Dta.ui.windowExpImp:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 785, 32) end
    if Dta.ui.windowHelp then Dta.ui.windowHelp:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 400, 100) end
    if Dta.ui.windowExpImp_tbx then Dta.ui.windowExpImp_tbx:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 785, 230) end
    print("Position reset")
  else
    Dta.ui.toggleMainWindow()
  end
end

--------------------------------------
--QUEUE HANDLER
--------------------------------------

function Dta.tick(handle)
	local currentFrameTime = Inspect.Time.Frame()
	local deltaT = 	currentFrameTime - Dta.lastFrameTime

	Dta.lastFrameTime = currentFrameTime

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


end

Dta.main()
