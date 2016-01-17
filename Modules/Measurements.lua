local Dta = select(2, ...)
local Lang = Dta.Lang

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
}

function Dta.measurements.CalculationsClicked()
	local size = Dta.ui.windowMeasurements.Measurements.Size:GetText()
	local shape = Dta.ui.windowMeasurements.Measurements.TypeLoad:GetSelectedIndex()
	local orientation = Dta.ui.windowMeasurements.Measurements.OrientationLoad:GetSelectedIndex()
	local scale, scale_ok = Dta.ui.checkNumber(size, nil)
	local dims

	if not shape then
		if orientation ~= 7 then
			return Dta.CPrint(Lang[Dta.Language].Prints.SelectType)
		elseif Dta.selectionCount ~= 2 then
			return Dta.CPrint("this mode requires two selected items") -- TODO: localization
		end
	else
		if not scale or not scale_ok then
			return Dta.CPrint(Lang[Dta.Language].Prints.TypeSize)
		end

		dims = Dta.measurements.Dimensions[shape]
		if scale > dims.maxScale or scale < dims.minScale then
			return Dta.CPrint(Lang[Dta.Language].Prints.SizeC)
		end
	end

	if not orientation then
		return Dta.CPrint(Lang[Dta.Language].Prints.SelectOrientation)
	end

	if orientation == 7 then
		local id, details1 = next(Dta.selectedItems)
		local _, details2 = next(Dta.selectedItems, id)
		Dta.ui.windowMeasurements.Measurements.x:SetText(tostring(Dta.items.round(details1.coordX - details2.coordX, 4)))
		Dta.ui.windowMeasurements.Measurements.y:SetText(tostring(Dta.items.round(details1.coordY - details2.coordY, 4)))
		Dta.ui.windowMeasurements.Measurements.z:SetText(tostring(Dta.items.round(details1.coordZ - details2.coordZ, 4)))
	else
		local axisMap = Dta.measurements.OrientationAxisMap[orientation]
		Dta.ui.windowMeasurements.Measurements.x:SetText(tostring(Dta.items.round(scale * dims[axisMap[1]], 4)))
		Dta.ui.windowMeasurements.Measurements.y:SetText(tostring(Dta.items.round(scale * dims[axisMap[2]], 4)))
		Dta.ui.windowMeasurements.Measurements.z:SetText(tostring(Dta.items.round(scale * dims[axisMap[3]], 4)))
	end
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
	if Dta.selectionCount == 0 then return
	elseif Dta.selectionCount == 2 then
		Dta.ui.windowMeasurements.Measurements.OrientationLoad:SetSelectedIndex(7)
		return
	end
	local _, details = next(Dta.selectedItems)
	local entry = Dta.Defaults.ItemDB[details.type]
	if entry then
		if entry.shape == "cube" then
			Dta.ui.windowMeasurements.Measurements.TypeLoad:SetSelectedIndex(1)
		elseif entry.shape == "plank" then
			Dta.ui.windowMeasurements.Measurements.TypeLoad:SetSelectedIndex(2)
		elseif entry.shape == "pole" then
			Dta.ui.windowMeasurements.Measurements.TypeLoad:SetSelectedIndex(3)
		elseif entry.shape == "rectangle" then
			Dta.ui.windowMeasurements.Measurements.TypeLoad:SetSelectedIndex(4)
		elseif entry.shape == "tile" then
			Dta.ui.windowMeasurements.Measurements.TypeLoad:SetSelectedIndex(5)
		elseif entry.shape == "floor" then
			Dta.ui.windowMeasurements.Measurements.TypeLoad:SetSelectedIndex(6)
		elseif entry.shape == "hall floor" then
			Dta.ui.windowMeasurements.Measurements.TypeLoad:SetSelectedIndex(7)
		elseif entry.shape == "large floor" then
			Dta.ui.windowMeasurements.Measurements.TypeLoad:SetSelectedIndex(8)
		end
		-- orientation
		if Dta.measurements.IsAxisAligned(details.yaw) then
			if Dta.measurements.IsAxisAligned(details.pitch) then
				if Dta.measurements.IsAxisAligned(details.roll) then
					-- default
					Dta.ui.windowMeasurements.Measurements.OrientationLoad:SetSelectedIndex(1)
				elseif Dta.measurements.IsOrthogonal(details.roll) then
					-- roll 90°
					Dta.ui.windowMeasurements.Measurements.OrientationLoad:SetSelectedIndex(4)
				end
			elseif Dta.measurements.IsOrthogonal(details.pitch) then
				if Dta.measurements.IsAxisAligned(details.roll) then
					-- pitch 90°
					Dta.ui.windowMeasurements.Measurements.OrientationLoad:SetSelectedIndex(2)
				elseif Dta.measurements.IsOrthogonal(details.roll) then
					-- pitch 90° + roll 90°
					Dta.ui.windowMeasurements.Measurements.OrientationLoad:SetSelectedIndex(6)
				end
			end
		elseif Dta.measurements.IsOrthogonal(details.yaw) then
			-- gimbal lock, roll should be zero because effect is identical to pitch
			if Dta.measurements.IsAxisAligned(details.pitch) then
				-- yaw 90°
				Dta.ui.windowMeasurements.Measurements.OrientationLoad:SetSelectedIndex(3)
			elseif Dta.measurements.IsOrthogonal(details.pitch) then
				-- yaw 90° + pitch/roll 90°
				Dta.ui.windowMeasurements.Measurements.OrientationLoad:SetSelectedIndex(5)
			end
		end
		Dta.ui.windowMeasurements.Measurements.Size:SetText(tostring(details.scale))
	end
end
