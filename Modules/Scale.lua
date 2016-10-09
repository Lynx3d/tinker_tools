local Dta = select(2, ...)

Dta.scale = {}

--------------------------------------
--SCALE BUTTON HANDLERS
--------------------------------------

function Dta.scale.modifyScaleModeAbsChanged()
	local scale_ui = Dta.ui.windowScale.modifyScale
	-- both checked means we are now switching mode
	if scale_ui.modeAbs:GetChecked() and scale_ui.modeRel:GetChecked() then
		scale_ui.modeRel:SetChecked(false)
		scale_ui.modeGrp:CBSetEnabled(false)
		scale_ui.scale:SwapText()
	elseif not scale_ui.modeRel:GetChecked() then
		scale_ui.modeAbs:SetChecked(true)
	end
end

function Dta.scale.modifyScaleModeRelChanged()
	local scale_ui = Dta.ui.windowScale.modifyScale
	-- both checked means we are now switching mode
	if scale_ui.modeRel:GetChecked() and scale_ui.modeAbs:GetChecked() then
		scale_ui.modeAbs:SetChecked(false)
		scale_ui.modeGrp:CBSetEnabled(true)
		scale_ui.scale:SwapText()
	elseif not scale_ui.modeAbs:GetChecked() then
		scale_ui.modeRel:SetChecked(true)
	end
end

function Dta.scale.modifyScaleButtonClicked()
	Dta.scale.setItemScales(Dta.ui.windowScale.modifyScale.scale:GetText(),
							Dta.ui.windowScale.modifyScale.modeRel:GetChecked(),
							Dta.ui.windowScale.modifyScale.modeGrp:GetChecked())
end

function Dta.scale.modifyScaleResetButtonClicked()
	Dta.scale.resetItemScales()
end

function Dta.scale.fetchScaleButtonClicked()
	if Dta.ui.windowScale.modifyScale.modeRel:GetChecked() then
		Dta.ui.windowScale.modifyScale.scale:SetText("1")
	elseif Dta.selectionCount == 1 then
		local id, item = next(Dta.selectedItems)
		Dta.ui.windowScale.modifyScale.scale:SetText(tostring(Dta.items.round(item.scale, 4)))
	end
end

--------------------------------------
--SCALE ITEMS
--------------------------------------

function Dta.scale.setItemScales(scale, relative, as_group)
	if Dta.selectionCount > 0 then
		Dta.scale.Co_setScale = coroutine.create(function()
			for k, details in pairs(Dta.selectedItems) do
				Dta.scale.setItemScale(details, scale, relative, as_group)
			end
		end)
		coroutine.resume(Dta.scale.Co_setScale)
		Dta.items.QueueNotification(Dta.Locale.Prints.ProcessFinished, Dta.selectionCount)
	end
end

--------------------------------------
--RESET SCALE TO 1
--------------------------------------

function Dta.scale.resetItemScales()
	if Dta.selectionCount > 0 then
		Dta.scale.Co_ResetScale = coroutine.create(function ()
			for k, details in pairs(Dta.selectedItems) do
				Dta.scale.setItemScale(details, 1, false)
			end
		end)
		coroutine.resume(Dta.scale.Co_ResetScale)
		Dta.items.QueueNotification(Dta.Locale.Prints.ProcessFinished, Dta.selectionCount)
	end
end

--------------------------------------
--SCALE AND RESET SCALE HANDLER
--------------------------------------

function Dta.scale.setItemScale(details, scale, relative, as_group)
	if details ~= nil then
		local newPlacement = {}
		if relative ~= nil and relative then
			if scale == nil or scale == "" then scale = 0 end

			scale = tonumber(scale)
			if not scale then
				Dta.CPrint(Dta.Locale.Prints.NumbersOnly)
				return
			end

			-- calculate movement for group mode
			if as_group then
				newPlacement.x = Dta.selectionCenter.x + scale*(details.coordX - Dta.selectionCenter.x)
				newPlacement.y = Dta.selectionCenter.y + scale*(details.coordY - Dta.selectionCenter.y)
				newPlacement.z = Dta.selectionCenter.z + scale*(details.coordZ - Dta.selectionCenter.z)
			end
			newPlacement.scale = details.scale * scale
		else -- absolute positioning
			if scale == nil or scale == "" then scale = details.scale end

			if not tonumber(scale) then
				Dta.CPrint(Dta.Locale.Prints.NumbersOnly)
				return
			end

			newPlacement.scale = tonumber(scale)
		end
		Dta.items.QueueTransform(details.id, newPlacement.x, newPlacement.y, newPlacement.z,
								 nil, nil, nil, newPlacement.scale)
	else
		Dta.CPrint(Dta.Locale.Prints.ModifyScale)
	end
end
