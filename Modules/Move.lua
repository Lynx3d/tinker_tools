local Dta = select(2, ...)

Dta.move = {}

-------------------------------
-- POSITION CHECKBOXES / BUTTON HANDLERS
-------------------------------
function Dta.move.ModeSwapped(move_ui)
	move_ui.x:SwapText()
	move_ui.y:SwapText()
	move_ui.z:SwapText()
end

function Dta.move.modifyPositionModeAbsChanged()
	local move_ui = Dta.ui.windowMove.modifyPosition
	-- both checked means we are now switching mode
	if move_ui.modeAbs:GetChecked() and move_ui.modeRel:GetChecked() then
		move_ui.modeRel:SetChecked(false)
		move_ui.moveAsGrp:CBSetEnabled(true)
		move_ui.modeLocal:CBSetEnabled(false)
		Dta.move.ModeSwapped(move_ui)
	elseif not move_ui.modeRel:GetChecked() then
		move_ui.modeAbs:SetChecked(true)
	end
end

function Dta.move.modifyPositionModeRelChanged()
	local move_ui = Dta.ui.windowMove.modifyPosition
	-- both checked means we are now switching mode
	if move_ui.modeRel:GetChecked() and move_ui.modeAbs:GetChecked() then
		move_ui.modeAbs:SetChecked(false)
		move_ui.moveAsGrp:CBSetEnabled(false)
		move_ui.modeLocal:CBSetEnabled(true)
		Dta.move.ModeSwapped(move_ui)
	elseif not move_ui.modeAbs:GetChecked() then
		move_ui.modeRel:SetChecked(true)
	end
end

function Dta.move.modifyPositionButtonClicked()
	if Dta.selectionCount <= 0 then
		Dta.CPrint(Dta.Locale.Prints.ModifyPosition)
		return
	end
	local move_ui = Dta.ui.windowMove.modifyPosition
	local settings, ok = {}, {}
	settings.x, ok.x = Dta.ui.checkNumber(move_ui.x:GetText(), nil)
	settings.y, ok.y = Dta.ui.checkNumber(move_ui.y:GetText(), nil)
	settings.z, ok.z = Dta.ui.checkNumber(move_ui.z:GetText(), nil)
	if not (ok.x and ok.y and ok.z) then
		Dta.CPrint(Dta.Locale.Prints.NumbersOnly)
		return
	end
	settings.relative = move_ui.modeRel:GetChecked()
	settings.grouped = move_ui.moveAsGrp:GetChecked()
	settings.local_axis = move_ui.modeLocal:GetChecked()
	Dta.move.setItemPositions(settings)
end

function Dta.move.modifyPositionResetButtonClicked()
	Dta.move.resetItemPositions()
end

function Dta.move.fetchXButtonClicked()
	if Dta.ui.windowMove.modifyPosition.modeRel:GetChecked() then
		Dta.ui.windowMove.modifyPosition.x:SetText("0")
	elseif Dta.selectionCenter then
		Dta.ui.windowMove.modifyPosition.x:SetText(tostring(Dta.items.round(Dta.selectionCenter.x, 4)))
	end
end

function Dta.move.fetchYButtonClicked()
	if Dta.ui.windowMove.modifyPosition.modeRel:GetChecked() then
		Dta.ui.windowMove.modifyPosition.y:SetText("0")
	elseif Dta.selectionCenter then
		Dta.ui.windowMove.modifyPosition.y:SetText(tostring(Dta.items.round(Dta.selectionCenter.y, 4)))
	end
end

function Dta.move.fetchZButtonClicked()
	if Dta.ui.windowMove.modifyPosition.modeRel:GetChecked() then
		Dta.ui.windowMove.modifyPosition.z:SetText("0")
	elseif Dta.selectionCenter then
		Dta.ui.windowMove.modifyPosition.z:SetText(tostring(Dta.items.round(Dta.selectionCenter.z, 4)))
	end
end

function Dta.move.fetchAllButtonClicked()
	Dta.move.fetchXButtonClicked()
	Dta.move.fetchYButtonClicked()
	Dta.move.fetchZButtonClicked()
end

--------------------------------------
--MOVE ONE ITEM
--------------------------------------

function Dta.move.setItemPosition(details, x, y, z, relative, local_axis)
	if details then
		local newX, newY, newZ
		if relative then -- relative positioning
			if local_axis then
				local vec = { x or 0, y or 0, z or 0 }
				local m_rot = Dta.Matrix.createZYX(details.pitch, details.yaw, details.roll, true)
				vec = Dta.Matrix.Transform(m_rot, vec)
				newX = details.coordX + vec[1]
				newY = details.coordY + vec[2]
				newZ = details.coordZ + vec[3]
			else
				if x then newX = details.coordX + x end
				if y then newY = details.coordY + y end
				if z then newZ = details.coordZ + z end
			end
			Dta.items.QueueMove(details.id, newX, newY, newZ)
		else -- absolute positioning
			Dta.items.QueueMove(details.id, x, y, z)
		end
	end
end

--------------------------------------
--MOVE MULTIPLE ITEMS
--------------------------------------

function Dta.move.setItemPositions(settings)
	if not settings.relative and settings.grouped and Dta.selectionCount > 1 then -- group move
		local cp = Dta.items.getCentralPoint(Dta.selectedItems)
		local deltaX, deltaY, deltaZ
		if settings.x then deltaX = settings.x - cp.x end
		if settings.y then deltaY = settings.y - cp.y end
		if settings.z then deltaZ = settings.z - cp.z end
		for k, details in pairs(Dta.selectedItems) do
			Dta.move.setItemPosition(details, deltaX, deltaY, deltaZ, true, settings.local_axis)
		end
	else
		for k, details in pairs(Dta.selectedItems) do
			Dta.move.setItemPosition(details, settings.x, settings.y, settings.z, settings.relative, settings.local_axis)
		end
	end
	Dta.items.QueueNotification(Dta.Locale.Prints.ProcessFinished, Dta.selectionCount)
end

--------------------------------------
--RESET ITEMS TO PLAYER POSITION
--------------------------------------

function Dta.move.resetItemPositions()
	if Dta.selectionCount > 0 then
		local player = Inspect.Unit.Detail("player")
		Dta.move.Co_MoveItemReset = coroutine.create(function ()
			for k, details in pairs(Dta.selectedItems) do
				Dta.move.setItemPosition(details, player.coordX, player.coordY + 0.1, player.coordZ, false)
			end
		end)
		coroutine.resume(Dta.move.Co_MoveItemReset)
		Dta.items.QueueNotification(Dta.Locale.Prints.ProcessFinished, Dta.selectionCount)
	end
end
