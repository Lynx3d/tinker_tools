local Dta = select(2, ...)

Dta.measurements = {}

Dta.measurements.OrientationAxisMap = {
	{ "x", "y", "z" }, -- Default
	{ "x", "z", "y" }, -- Pitch 90
	{ "z", "y", "x" }, -- Yaw 90
	{ "y", "x", "z" }, -- Roll 90
	{ "z", "x", "y" }, -- Pitch & Yaw 90
	{ "y", "z", "x" }  -- Pitch & Roll 90
}

Dta.measurements.Dimensions = {
	{ x = 0.75, y = 0.75, z = 0.75, minScale = 0.25, maxScale = 5 }, -- Cube
	{ x = 2.25, y = 0.05, z = 0.25, minScale = 0.25, maxScale = 6 }, -- Plank
	{ x = 0.125, y = 1, z = 0.125, minScale = 0.25, maxScale = 12 }, -- Pole
	{ x = 1.125, y = 0.0375, z = 0.75, minScale = 0.25, maxScale = 12 }, -- Rectangle
	{ x = 0.75, y = 0.0375, z = 0.75, minScale = 0.25, maxScale = 12 }, -- Tile
	{ x = 4, y = 0.25, z = 4, minScale = 0.25, maxScale = 2 }, -- Floor
	{ x = 4, y = 0.25, z = 8, minScale = 0.25, maxScale = 2 }, -- Hall Floor
	{ x = 8, y = 0.25, z = 8, minScale = 0.25, maxScale = 2 } -- Large Floor
--	{ x = 0.371, y = 5, z = 0.3725, minScale = 0.25, maxScale = 2 } -- Corner Post
}

function Dta.measurements.CalculationsClicked()
	local Measurement_UI = Dta.Tools.Offset.window.Measurements
	local size = Measurement_UI.Size:GetText()
	local shape = Measurement_UI.TypeLoad:GetSelectedIndex()
	local orientation = Measurement_UI.OrientationLoad:GetSelectedIndex()
	local scale, scale_ok = Dta.ui.checkNumber(size, nil)
	local dims

	if not orientation then
		return Dta.CPrint(Dta.Locale.Prints.SelectOrientation)
	end

	if not shape then
		if orientation ~= 7 then
			return Dta.CPrint(Dta.Locale.Prints.SelectType)
		end
	else
		dims = Dta.measurements.Dimensions[shape]
		if orientation ~= 7 then
			if not (scale and scale_ok) then
				return Dta.CPrint(Dta.Locale.Prints.TypeSize)
			elseif scale > dims.maxScale or scale < dims.minScale then
				return Dta.CPrint(string.format(Dta.Locale.Prints.SizeC, dims.minScale, dims.maxScale))
			end
		end
		if orientation > 7 and Dta.selectionCount ~=1 then
			return Dta.CPrint(Dta.Locale.Prints.Selection1)
		end
	end

	if orientation == 7 then
		if Dta.selectionCount ~= 2 then
			return Dta.CPrint(Dta.Locale.Prints.Selection2)
		end
		local id, details1 = next(Dta.selectedItems)
		local _, details2 = next(Dta.selectedItems, id)
		Dta.measurements.result = { details1.coordX - details2.coordX,
									details1.coordY - details2.coordY,
									details1.coordZ - details2.coordZ }
	elseif orientation < 7 then
		local axisMap = Dta.measurements.OrientationAxisMap[orientation]
		Dta.measurements.result = { scale * dims[axisMap[1]],
									scale * dims[axisMap[2]],
									scale * dims[axisMap[3]] }
	else
		local _, details = next(Dta.selectedItems)
		local vec = { 0, 0, 0 }
		if orientation == 8 then
			vec[1] = dims.x * scale
		elseif orientation == 9 then
			vec[2] = dims.y * scale
		else
			vec[3] = dims.z * scale
		end
		local m_rot = Dta.Matrix.createZYX(details.pitch, details.yaw, details.roll, true)
		Dta.measurements.result = Dta.Matrix.Transform(m_rot, vec)
	end
	Measurement_UI.x:SetText(tostring(Dta.items.round(Dta.measurements.result[1], 4)))
	Measurement_UI.y:SetText(tostring(Dta.items.round(Dta.measurements.result[2], 4)))
	Measurement_UI.z:SetText(tostring(Dta.items.round(Dta.measurements.result[3], 4)))
end

local half_pi = 0.5 * math.pi

function Dta.measurements.IsEqual(a, b)
	return math.abs(a - b) < 1e-5
end

function Dta.measurements.IsAxisAligned(val)
	return Dta.measurements.IsEqual(val, 0) or Dta.measurements.IsEqual(val, math.pi)
			or Dta.measurements.IsEqual(val, -math.pi)
end

function Dta.measurements.IsOrthogonal(val)
	return Dta.measurements.IsEqual(val, half_pi) or Dta.measurements.IsEqual(val, -half_pi)
end

function Dta.measurements.DetectClicked()
	local Measurement_UI = Dta.Tools.Offset.window.Measurements
	if Dta.selectionCount == 0 then
		return
	elseif Dta.selectionCount == 2 then
		Measurement_UI.OrientationLoad:SetSelectedIndex(7)
		return
	end
	local _, details = next(Dta.selectedItems)
	local entry = Dta.Defaults.ItemDB[details.type]
	if entry then
		if entry.shape == "cube" then
			Measurement_UI.TypeLoad:SetSelectedIndex(1)
		elseif entry.shape == "plank" then
			Measurement_UI.TypeLoad:SetSelectedIndex(2)
		elseif entry.shape == "pole" then
			Measurement_UI.TypeLoad:SetSelectedIndex(3)
		elseif entry.shape == "rectangle" then
			Measurement_UI.TypeLoad:SetSelectedIndex(4)
		elseif entry.shape == "tile" then
			Measurement_UI.TypeLoad:SetSelectedIndex(5)
		elseif entry.shape == "floor" then
			Measurement_UI.TypeLoad:SetSelectedIndex(6)
		elseif entry.shape == "hall floor" then
			Measurement_UI.TypeLoad:SetSelectedIndex(7)
		elseif entry.shape == "large floor" then
			Measurement_UI.TypeLoad:SetSelectedIndex(8)
		end
		-- orientation
		if Dta.measurements.IsAxisAligned(details.yaw) then
			if Dta.measurements.IsAxisAligned(details.pitch) then
				if Dta.measurements.IsAxisAligned(details.roll) then
					-- default
					Measurement_UI.OrientationLoad:SetSelectedIndex(1)
				elseif Dta.measurements.IsOrthogonal(details.roll) then
					-- roll 90°
					Measurement_UI.OrientationLoad:SetSelectedIndex(4)
				end
			elseif Dta.measurements.IsOrthogonal(details.pitch) then
				if Dta.measurements.IsAxisAligned(details.roll) then
					-- pitch 90°
					Measurement_UI.OrientationLoad:SetSelectedIndex(2)
				elseif Dta.measurements.IsOrthogonal(details.roll) then
					-- pitch 90° + roll 90°
					Measurement_UI.OrientationLoad:SetSelectedIndex(6)
				end
			end
		elseif Dta.measurements.IsOrthogonal(details.yaw) then
			-- gimbal lock, roll should be zero because effect is identical to pitch
			if Dta.measurements.IsAxisAligned(details.pitch) then
				-- yaw 90°
				Measurement_UI.OrientationLoad:SetSelectedIndex(3)
			elseif Dta.measurements.IsOrthogonal(details.pitch) then
				-- yaw 90° + pitch/roll 90°
				Measurement_UI.OrientationLoad:SetSelectedIndex(5)
			end
		end
		Measurement_UI.Size:SetText(tostring(details.scale))
	end
end

function Dta.measurements.TogglePopup(self)
	if Dta.Tools.Offset.window.TransferPopup:GetVisible() then
		Dta.Tools.Offset.window.TransferPopup:SetVisible(false)
		self:Toggle(false)
	else
		Dta.Tools.Offset.window.TransferPopup:SetVisible(true)
		self:Toggle(true)
	end
end

function Dta.measurements.TransferOffset(controls, mask, invert)
	local values = Dta.measurements.result
	for index, _ in pairs(mask) do
		controls[index]:SetText(tostring(Dta.items.round(invert and -values[index] or values[index], 4)))
	end
end

function Dta.measurements.TransferClicked()
	local transfer = Dta.Tools.Offset.window.TransferPopup
	local mask = { transfer.x:GetChecked() or nil, transfer.y:GetChecked() or nil, transfer.z:GetChecked() or nil }
	local invert = transfer.Invert:GetChecked()
	--if not (transfer.x:GetChecked() or transfer.y:GetChecked() or transfer.z:GetChecked())
	if not next(mask) or not Dta.measurements.result then
		return
	end
	if transfer.ToMove:GetChecked() then
		if not Dta.Tools.Move:IsActive() then
			Dta.Tools.Move.Toggle()
		end
		local move = Dta.Tools.Move.window.modifyPosition
		if not move.modeRel:GetChecked() then
			move.modeRel:SetChecked(true)
		end
		Dta.measurements.TransferOffset({move.x, move.y, move.z}, mask, invert)
	end
	if transfer.ToCopa:GetChecked() then
		if not Dta.Tools.CoPa:IsActive() then
			Dta.Tools.CoPa.Toggle()
		end
		local copyPaste = Dta.Tools.CoPa.window.copyPaste
		Dta.measurements.TransferOffset({copyPaste.xOffset, copyPaste.yOffset, copyPaste.zOffset}, mask, invert)
	end
end
