local Dta = select(2, ...)
local Lang = Dta.Lang

Dta.rotate = {}

--------------------------------------
--ROTATE BUTTON HANDLERS
--------------------------------------

function Dta.rotate.modifyRotationModeAbsChanged()
	if Dta.ui.windowRotate.modifyRotation.modeAbs:GetChecked() then
		Dta.ui.windowRotate.modifyRotation.modeRel:SetChecked(false)
		Dta.ui.windowRotate.modifyRotation.modeAsGrp:CBSetEnabled(false)
	elseif not Dta.ui.windowRotate.modifyRotation.modeRel:GetChecked() then
		Dta.ui.windowRotate.modifyRotation.modeAbs:SetChecked(true)
	end
end

function Dta.rotate.modifyRotationModeRelChanged()
	if Dta.ui.windowRotate.modifyRotation.modeRel:GetChecked() then
		Dta.ui.windowRotate.modifyRotation.modeAbs:SetChecked(false)
		Dta.ui.windowRotate.modifyRotation.modeAsGrp:CBSetEnabled(true)
	elseif not Dta.ui.windowRotate.modifyRotation.modeAbs:GetChecked() then
		Dta.ui.windowRotate.modifyRotation.modeRel:SetChecked(true)
	end
end

function Dta.rotate.modifyRotationButtonClicked()
	local pitch, pitch_ok = Dta.ui.checkNumber(Dta.ui.windowRotate.modifyRotation.pitch:GetText())
	local yaw, yaw_ok = Dta.ui.checkNumber(Dta.ui.windowRotate.modifyRotation.yaw:GetText())
	local roll, roll_ok = Dta.ui.checkNumber(Dta.ui.windowRotate.modifyRotation.roll:GetText())
	if not (pitch_ok and yaw_ok and roll_ok) then
		Dta.CPrint(Lang[Dta.Language].Prints.NumbersOnly)
		return
	end
	Dta.rotate.setItemRotations(yaw, pitch, roll,
								Dta.ui.windowRotate.modifyRotation.modeRel:GetChecked(),
								Dta.ui.windowRotate.modifyRotation.modeAsGrp:GetChecked())
end

function Dta.rotate.modifyRotationResetButtonClicked()
	Dta.rotate.resetItemRotations()
end

function Dta.rotate.fetchPitchButtonClicked()
	if Dta.selectionCount == 1 then
		local id, item = next(Dta.selectedItems)
		Dta.ui.windowRotate.modifyRotation.pitch:SetText(tostring(Dta.items.round(math.deg(item.pitch), 4)))
	end
end

function Dta.rotate.fetchYawButtonClicked()
	if Dta.selectionCount == 1 then
		local id, item = next(Dta.selectedItems)
		Dta.ui.windowRotate.modifyRotation.yaw:SetText(tostring(Dta.items.round(math.deg(item.yaw), 4)))
	end
end

function Dta.rotate.fetchRollButtonClicked()
	if Dta.selectionCount == 1 then
		local id, item = next(Dta.selectedItems)
		Dta.ui.windowRotate.modifyRotation.roll:SetText(tostring(Dta.items.round(math.deg(item.roll), 4)))
	end
end

function Dta.rotate.fetchAllButtonClicked()
	if Dta.selectionCount == 1 then
		local id, item = next(Dta.selectedItems)
		Dta.ui.windowRotate.modifyRotation.pitch:SetText(tostring(Dta.items.round(math.deg(item.pitch), 4)))
		Dta.ui.windowRotate.modifyRotation.yaw:SetText(tostring(Dta.items.round(math.deg(item.yaw), 4)))
		Dta.ui.windowRotate.modifyRotation.roll:SetText(tostring(Dta.items.round(math.deg(item.roll), 4)))
	end
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
		Dta.items.QueueNotification(Lang[Dta.Language].Prints.ProcessFinished, Dta.selectionCount)
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
		Dta.items.QueueNotification(Lang[Dta.Language].Prints.ProcessFinished, Dta.selectionCount)
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
		Dta.CPrint(Lang[Dta.Language].Prints.ModifyRotation)
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
