local Dta = select(2, ...)

Dta.Connector = {}

Dta.Connector.link = 1
--[[ link points (outside), corners (inside):
    1   2   3
    ^---^---^
12 < 0  1  2 > 4
   |         |
11 < 7     3 > 5
   |         |
10 < 6  5  4 > 6
    v---v---v
    9   8   7

Algorithm:
- in object space:
 - calculate connection vector 1
 - calculate connection vector 2
 - rotate connection vector 2 by angle
 - add vec1 and vec2_rot
- transform vec1_vec2 into object_1 space
]]

function Dta.Connector.LinkChanged(checkbox)
	local con_ui = Dta.Tools.Connector.window
	assert(checkbox.link)
	if checkbox.link == Dta.Connector.link then
		if not checkbox:GetChecked() then -- otherwise secondary trigger from re-enable
			-- re-enable self because there shall always be exactly one box selected
			checkbox:SetChecked(true)
		end
	elseif checkbox:GetChecked() then -- otherwise secondary unselect trigger
		local active_box = con_ui.corner[Dta.Connector.link]
		assert(active_box:GetChecked() == true)
		Dta.Connector.link = checkbox.link
		active_box:SetChecked(false)
	end
end

-- TODO: move shape index to Measurements.lua and use for detection
Dta.Connector.ShapeIndex = {
	cube = 1,
	plank = 2,
	pole = 3,
	rectangle = 4,
	tile = 5,
--	floor = 6,
--	["hall floor"] = 7,
--	["large floor"] = 8
}

Dta.Connector.Center = {
	{ x = 0.375, y = 0, z = 0.375 }, -- Cube
	{ x = 1.125, y = 0, z = 0.125 }, -- Plank
	{ x = 0.0625, y = 0, z = 0.0625 }, -- Pole
	{ x = 0.5625, y = 0, z = 0.375 }, -- Rectangle
	{ x = 0.375, y = 0, z = 0.375 }, -- Tile
--	{ x = 4, y = 0.25, z = 4, minScale = 0.25, maxScale = 2 }, -- Floor
--	{ x = 4, y = 0.25, z = 8, minScale = 0.25, maxScale = 2 }, -- Hall Floor
--	{ x = 8, y = 0.25, z = 8, minScale = 0.25, maxScale = 2 } -- Large Floor
--	{ x = 0.371, y = 5, z = 0.3725, minScale = 0.25, maxScale = 2 } -- Corner Post
--	{ x = 4, y = 0.05, z = 4, minScale = 0.25, maxScale = 2 } -- Carpet Tile
}

Dta.Connector.AxisMap = {
	{ "x", "z", "y" },
	{ "y", "x", "z" },
	{ "z", "x", "y" }
}

local lCornerDirH = { -1, 0, 1, 1, 1, 0, -1, -1 }
local lCornerDirV = { 1, 1, 1, 0, -1, -1, -1, 0 } -- 90° CCW

function Dta.Connector.ConnectClicked()
	if not Dta.checkIdle() then
		return
	end
	if Dta.selectionCount ~= 1 then
		return
	end
	local con_ui = Dta.Tools.Connector.window
	local settings, success = {}, false
	settings.angle, success = Dta.ui.checkNumber(con_ui.angle:GetText(), 0)
	if success then
		settings.angle = math.rad(settings.angle)
	else
		Dta.CPrint(Dta.Locale.Prints.NumbersOnly)
		return
	end
	-- TODO: make sure an axis is selected
	settings.axis = con_ui.axis:GetSelectedIndex() or 1

	local _, details = next(Dta.selectedItems)
	settings.entry = Dta.Defaults.ItemDB[details.type]
	if not settings.entry or not settings.entry.shape then
		return
	end
	settings.shoppingList = { [details.type] = { name = details.name, amount = 1 } }
	Dta.losa.ScanInventory(settings.shoppingList, true, false)
	local missing = Dta.losa.checkShoppingList(settings.shoppingList)
	if missing then
		Dta.CPrint("<no item in inventory>")
		return
	end
	Dta.AddItem_Co = coroutine.create(Dta.Connector.Connect)
	local ok, err = coroutine.resume(Dta.AddItem_Co, details, settings)
	if not ok then dump(err) end
end

function Dta.Connector.GetExtent(dimensions, center, axis, dir)
	if dir == 1 then return dimensions[axis] - center[axis]
	elseif dir == -1 then return - center[axis]
	else return 0
	end
end

function Dta.Connector.GetVector(shape, corner, axis, scale)
	local shapeIdx = Dta.Connector.ShapeIndex[shape]
	if not shapeIdx then return end
	local dimensions = Dta.measurements.Dimensions[shapeIdx]
	local center = Dta.Connector.Center[shapeIdx]
	local axisMap = Dta.Connector.AxisMap[axis]
	local vec = {}
	vec[axisMap[1]] = 0
	vec[axisMap[2]] = scale * Dta.Connector.GetExtent(dimensions, center, axisMap[2], lCornerDirH[corner]) --dimensions[lAxisMap[axis][2]] * lCornerDirH[corner]
	vec[axisMap[3]] = scale * Dta.Connector.GetExtent(dimensions, center, axisMap[3], lCornerDirV[corner])--dimensions[lAxisMap[axis][3]] * lCornerDirV[corner]
	return vec
end

function Dta.Connector.Connect(details, settings)
	local shape = settings.entry.shape
	local linkVal = Dta.Connector.link - 1
	local majorAxis = settings.axis
	local minorAxis = math.floor(linkVal / 3) -- range 0-3
	local corner = (linkVal - minorAxis) % 8 -- range 0-8
	local corner2 = (2*((minorAxis + 2) % 4 + minorAxis + 1) - corner) % 8
	local vec1 = Dta.Connector.GetVector(shape, corner + 1, majorAxis, details.scale)
	local vec2 = Dta.Connector.GetVector(shape, corner2 + 1, majorAxis, details.scale)
	local m_rot = Dta.Matrix.createZYX(details.pitch, details.yaw, details.roll, true)
	local new_details = {}
	-- rotate connection vector 2 by input angle
	if settings.angle and settings.angle ~= 0 then
		local m_rot2
		if majorAxis == 1 then
			m_rot2 = Dta.Matrix.createZYX(settings.angle, 0, 0, true)
		elseif majorAxis == 2 then
			m_rot2 = Dta.Matrix.createZYX(0, settings.angle, 0, true)
		else
			m_rot2 = Dta.Matrix.createZYX(0, 0, settings.angle, true)
		end
		local temp = Dta.Matrix.Transform(m_rot2, {vec2.x, vec2.y, vec2.z})
		vec2 = { x = temp[1], y = temp[2], z = temp[3] }
		local m_final = Dta.Matrix.Multiply(m_rot, m_rot2)
		new_details.pitch, new_details.yaw, new_details.roll = Dta.Matrix.ToZYX(m_final, true)
	else
		new_details.pitch = details.pitch
		new_details.yaw = details.yaw
		new_details.roll = details.roll
	end
	--
	local vec1_vec2 = { vec1.x - vec2.x, vec1.y - vec2.y, vec1.z - vec2.z }
	-- transform vec1_vec2 into object_1 space
	local vec_final = Dta.Matrix.Transform(m_rot, vec1_vec2)

	new_details.type = details.type
	new_details.coordX = details.coordX + vec_final[1]
	new_details.coordY = details.coordY + vec_final[2]
	new_details.coordZ = details.coordZ + vec_final[3]
	new_details.scale = details.scale
	Dta.copa.pasteSingleItem(new_details, settings.shoppingList, true)
end
