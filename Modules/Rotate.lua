local Dta = select(2, ...)

Dta.rotate = {}

--------------------------------------
--ROTATE BUTTON HANDLERS
--------------------------------------
function Dta.rotate.ModeSwapped(rotate_ui)
	rotate_ui.pitch:SwapText()
	rotate_ui.roll:SwapText()
	rotate_ui.yaw:SwapText()
end

function Dta.rotate.modifyRotationModeAbsChanged()
	local rotate_ui = Dta.Tools.Rotate.window.modifyRotation
	-- both checked means we are now switching mode
	if rotate_ui.modeAbs:GetChecked() and rotate_ui.modeRel:GetChecked() then
		rotate_ui.modeRel:SetChecked(false)
		rotate_ui.modeAsGrp:CBSetEnabled(false)
		Dta.rotate.ModeSwapped(rotate_ui)
	elseif not rotate_ui.modeRel:GetChecked() then
		rotate_ui.modeAbs:SetChecked(true)
	end
end

function Dta.rotate.modifyRotationModeRelChanged()
	local rotate_ui = Dta.Tools.Rotate.window.modifyRotation
	-- both checked means we are now switching mode
	if rotate_ui.modeRel:GetChecked() and rotate_ui.modeAbs:GetChecked() then
		rotate_ui.modeAbs:SetChecked(false)
		rotate_ui.modeAsGrp:CBSetEnabled(true)
		Dta.rotate.ModeSwapped(rotate_ui)
	elseif not rotate_ui.modeAbs:GetChecked() then
		rotate_ui.modeRel:SetChecked(true)
	end
end

function Dta.rotate.modifyRotationButtonClicked()
	local pitch, pitch_ok = Dta.ui.checkNumber(Dta.Tools.Rotate.window.modifyRotation.pitch:GetText())
	local yaw, yaw_ok = Dta.ui.checkNumber(Dta.Tools.Rotate.window.modifyRotation.yaw:GetText())
	local roll, roll_ok = Dta.ui.checkNumber(Dta.Tools.Rotate.window.modifyRotation.roll:GetText())
	if not (pitch_ok and yaw_ok and roll_ok) then
		Dta.CPrint(Dta.Locale.Prints.NumbersOnly)
		return
	end
	Dta.rotate.setItemRotations(yaw, pitch, roll,
								Dta.Tools.Rotate.window.modifyRotation.modeRel:GetChecked(),
								Dta.Tools.Rotate.window.modifyRotation.modeAsGrp:GetChecked())
end

function Dta.rotate.modifyRotationResetButtonClicked()
	Dta.rotate.resetItemRotations()
end

function Dta.rotate.fetchPitchButtonClicked()
	if Dta.Tools.Rotate.window.modifyRotation.modeRel:GetChecked() then
		Dta.Tools.Rotate.window.modifyRotation.pitch:SetText("0")
	elseif Dta.selectionCount == 1 then
		local id, item = next(Dta.selectedItems)
		Dta.Tools.Rotate.window.modifyRotation.pitch:SetText(tostring(Dta.items.round(math.deg(item.pitch), 4)))
	end
end

function Dta.rotate.fetchYawButtonClicked()
	if Dta.Tools.Rotate.window.modifyRotation.modeRel:GetChecked() then
		Dta.Tools.Rotate.window.modifyRotation.yaw:SetText("0")
	elseif Dta.selectionCount == 1 then
		local id, item = next(Dta.selectedItems)
		Dta.Tools.Rotate.window.modifyRotation.yaw:SetText(tostring(Dta.items.round(math.deg(item.yaw), 4)))
	end
end

function Dta.rotate.fetchRollButtonClicked()
	if Dta.Tools.Rotate.window.modifyRotation.modeRel:GetChecked() then
		Dta.Tools.Rotate.window.modifyRotation.roll:SetText("0")
	elseif Dta.selectionCount == 1 then
		local id, item = next(Dta.selectedItems)
		Dta.Tools.Rotate.window.modifyRotation.roll:SetText(tostring(Dta.items.round(math.deg(item.roll), 4)))
	end
end

function Dta.rotate.fetchAllButtonClicked()
	Dta.rotate.fetchPitchButtonClicked()
	Dta.rotate.fetchYawButtonClicked()
	Dta.rotate.fetchRollButtonClicked()
end

--------------------------------------
--ROTATE ITEMS (NO GROUP ROTATION YET)
--------------------------------------

function Dta.rotate.setItemRotations(yaw, pitch, roll, relative, grouped)
	if Dta.selectionCount > 0 then
		Dta.rotate.Co_RotateItem = coroutine.create(function ()
			if relative and grouped then
				yaw = math.rad(yaw or 0)
				pitch = math.rad(pitch or 0)
				roll = math.rad(roll or 0)
				local m_rot = Dta.Matrix.createZYX(pitch, yaw, roll, true)
				for k, details in pairs(Dta.selectedItems) do
					Dta.rotate.rotateRelative(details, m_rot, Dta.selectionCount > 1)
				end
			else
				for k, details in pairs(Dta.selectedItems) do
					Dta.rotate.setItemRotation(k, yaw, pitch, roll, relative)
				end
			end
		end)
		coroutine.resume(Dta.rotate.Co_RotateItem)
		Dta.items.QueueNotification(Dta.Locale.Prints.ProcessFinished, Dta.selectionCount)
	end
end

--------------------------------------
--RESET ITEM ROTATION
--------------------------------------

function Dta.rotate.resetItemRotations()
	if Dta.selectionCount > 0 then
		Dta.rotate.Co_RotateItemReset = coroutine.create(function ()
			for k, details in pairs(Dta.selectedItems) do
				Dta.rotate.setItemRotation(k, 0, 0, 0, false)
			end
		end)
		coroutine.resume(Dta.rotate.Co_RotateItemReset)
		Dta.items.QueueNotification(Dta.Locale.Prints.ProcessFinished, Dta.selectionCount)
	end
end

--------------------------------------
--ROTATE AND RESET HANDLER
--------------------------------------

function Dta.rotate.setItemRotation(index, yaw, pitch, roll, relative)
	if Dta.selectedItems[index] ~= nil then
		local newPlacement = {}
		if relative then
			newPlacement.pitch =  Dta.selectedItems[index].pitch
			newPlacement.yaw = Dta.selectedItems[index].yaw
			newPlacement.roll = Dta.selectedItems[index].roll

			if pitch then newPlacement.pitch = newPlacement.pitch + math.rad(pitch) end
			if yaw then newPlacement.yaw = newPlacement.yaw + math.rad(yaw) end
			if roll then newPlacement.roll = newPlacement.roll + math.rad(roll) end
		else
			newPlacement.pitch = pitch and math.rad(pitch) or Dta.selectedItems[index].pitch
			newPlacement.yaw = yaw and math.rad(yaw) or Dta.selectedItems[index].yaw
			newPlacement.roll = roll and math.rad(roll) or Dta.selectedItems[index].roll
		end

		Dta.items.QueueRotate(Dta.selectedItems[index].id, newPlacement.pitch, newPlacement.roll, newPlacement.yaw)
	else
		Dta.CPrint(Dta.Locale.Prints.ModifyRotation)
	end
end

-------------------------------
-- calculate new rotation values after rotating around global axis
-- if a pivot is given, also calculate new position relative to pivot
-------------------------------
function Dta.rotate.rotateItem(details, m_rot, pivot)
	local m_item = Dta.Matrix.createZYX(details.pitch, details.yaw, details.roll, true)
	local rx, ry, rz = Dta.Matrix.ToZYX(Dta.Matrix.Multiply(m_rot, m_item), true)

	if pivot then
		local vec = { details.coordX - pivot.x,
					  details.coordY - pivot.y,
					  details.coordZ - pivot.z }
		vec = Dta.Matrix.Transform(m_rot, vec)
		return { pitch = rx, yaw = ry, roll = rz }, vec
	end
	return { pitch = rx, yaw = ry, roll = rz }, nil
end

function Dta.rotate.rotateRelative(details, m_rot, selection_pivot)
	local r, vec = Dta.rotate.rotateItem(details, m_rot, selection_pivot and Dta.selectionCenter)
	if selection_pivot then
		Dta.items.QueueTransform(details.id, Dta.selectionCenter.x + vec[1], Dta.selectionCenter.y + vec[2], Dta.selectionCenter.z + vec[3],
								r.pitch, r.yaw, r.roll)
	else
		Dta.items.QueueRotate(details.id, r.pitch, r.roll, r.yaw)
	end
end
