local Dta = select(2, ...)
local Lang = Dta.Lang

Dta.items = {}

Dta.items.textColor =
{
	sellable = 		{ hexcol = "#888888", r = 136/255, g = 136/255, b = 136/255 },
	common = 		{ hexcol = "#ffffff", r = 1.0, g = 1.0, b = 1.0 },
	uncommon =  	{ hexcol = "#00cc00", r = 0, g = 0.8, b = 0 },
	rare = 			{ hexcol = "#2681fe", r = 38/255, g = 129/255, b = 254/255 },
	epic = 			{ hexcol = "#b049ff", r = 176/255, g = 73/255, b =  1.0},
	relic = 		{ hexcol = "#ff9900", r = 1.0, g = 153/255, b = 0 },
	transcendant = 	{ hexcol = "#cc1313", r = 0.8, g = 19/255, b = 19/255 },
	quest = 		{ hexcol = "#fff600", r = 1.0, g = 246/255, b = 0 }
}

--------------------------------------
--QUEUE FUNCTIONS
--------------------------------------

function Dta.items.QueueScale(id, amount)
	table.insert(Dta.pendingActions, {op="scale", amount=amount, id=id})
end

function Dta.items.QueueMove(id, x, y, z)
	table.insert(Dta.pendingActions, {op="move", x=x, y=y, z=z, id=id})
end

function Dta.items.QueueRotate(id, pitch, roll, yaw)
	table.insert(Dta.pendingActions, {op="rotate", pitch=pitch, yaw=yaw, roll=roll, id=id})
end

function Dta.items.QueueSelect(id)
	table.insert(Dta.pendingActions, {op="select", id=id})
end

function Dta.items.QueueAdd(id, x, y, z, pitch, yaw, roll, scale)
	table.insert(Dta.pendingActions, {
		op="add",
		details = { coordX=x, coordY=y, coordZ=z, pitch=pitch, roll=roll, yaw=yaw, scale=scale },
		id=id })
end

function Dta.items.QueueTransform(id, x, y, z, pitch, yaw, roll, scale)
	table.insert(Dta.pendingActions, {
		op="xform",
		details = { coordX=x, coordY=y, coordZ=z, pitch=pitch, roll=roll, yaw=yaw, scale=scale },
		id=id })
end

function Dta.items.QueueNotification(message, action_count)
	if action_count and action_count >= Dta.Dta.notifyThreshold then
		table.insert(Dta.pendingActions, {op="notify", text=message})
	end
end

function Dta.items.QueueSelection(id)
	table.insert(Dta.SelectionQueue, {op="select", id=id})
end

function Dta.items.QueueDeselection(id)
	table.insert(Dta.SelectionQueue, {op="deselect", id=id})
end
--------------------------------------
--ITEM UPDATE
--------------------------------------

function Dta.items.setItemColor(type)
	local color = Dta.items.textColor.common
	local details = type and Inspect.Item.Detail(type)
	if details and details.rarity then
		color = Dta.items.textColor[details.rarity] or color
	end
	Dta.ui.windowtest.itemDetails.name:SetFontColor(color.r, color.g, color.b)
end

-- Rift API is currently bugged, gimbal lock handling gives Pitch value the wrong sign.
-- Apparently values are not stored as pitch/yaw/roll internally, but we don't have
-- access to internal representation, unfortunately
function Dta.items.fixRotation(details)
	if Dta.measurements.IsOrthogonal(details.yaw) then
		details.pitch = -details.pitch
	end
	-- TODO: find way to cleanup pitch/roll effectively flipping item ontop and back
	-- to keep -90° < yaw < 90°. While that's a valid way to handle it, I find it
	-- rather unintuitive to work with, especially when pitch+roll are +/- 180°
	-- would affect rotate tool with empty fields though
end

function Dta.items.updateItemDetails()
	if Dta.ui.windowtest ~= nil then
		if Dta.selectionCount > 0 then
			Dta.ui.windowtest.itemDetails.clearSelection:SetVisible(true)
			if Dta.selectionCount > 1 then
				Dta.ui.windowtest.itemDetails.icon:SetTexture(Dta.AddonID, "textures/multiple.png")
				Dta.ui.windowtest.itemDetails.name:SetText(Lang[Dta.Language].Text.MultiSelectItems)
				Dta.ui.windowtest.itemDetails.name:SetFontColor(1, 1, 1)
				local cp = Dta.items.getCentralPoint(Dta.selectedItems)
				Dta.selectionCenter = cp
				Dta.ui.windowtest.itemDetails.nrItems:SetText(tostring(Dta.selectionCount))
				Dta.ui.windowtest.itemDetails.x:SetText(tostring(Dta.items.round(cp.x,4)))
				Dta.ui.windowtest.itemDetails.y:SetText(tostring(Dta.items.round(cp.y,4)))
				Dta.ui.windowtest.itemDetails.z:SetText(tostring(Dta.items.round(cp.z,4)))
				Dta.ui.windowtest.itemDetails.yaw:SetText("-")
				Dta.ui.windowtest.itemDetails.pitch:SetText("-")
				Dta.ui.windowtest.itemDetails.roll:SetText("-")
				Dta.ui.windowtest.itemDetails.scale:SetText("-")
				if Dta.ui.windowMove then Dta.ui.windowMove.modifyPosition.moveAsGrp:SetVisible(true) end
			else
				local ItemID, details = next(Dta.selectedItems)
				if details ~= nil then
					if details.icon == "" then
						Dta.ui.windowtest.itemDetails.icon:SetTexture(Dta.AddonID, "textures/default.png")
					else
						Dta.ui.windowtest.itemDetails.icon:SetTexture("Rift", details.icon)
					end
					Dta.selectionCenter = { x = details.coordX, y = details.coordY, z = details.coordZ }
					Dta.ui.windowtest.itemDetails.name:SetText(tostring(details.name))
					Dta.items.setItemColor(details.type)
					Dta.ui.windowtest.itemDetails.nrItems:SetText(tostring(Dta.selectionCount))
					Dta.ui.windowtest.itemDetails.x:SetText(tostring(Dta.items.round(details.coordX,4)))
					Dta.ui.windowtest.itemDetails.y:SetText(tostring(Dta.items.round(details.coordY,4)))
					Dta.ui.windowtest.itemDetails.z:SetText(tostring(Dta.items.round(details.coordZ,4)))
					Dta.ui.windowtest.itemDetails.yaw:SetText(tostring(Dta.items.round(math.deg(details.yaw),4)))
					Dta.ui.windowtest.itemDetails.pitch:SetText(tostring(Dta.items.round(math.deg(details.pitch),4)))
					Dta.ui.windowtest.itemDetails.roll:SetText(tostring(Dta.items.round(math.deg(details.roll),4)))
					Dta.ui.windowtest.itemDetails.scale:SetText(tostring(Dta.items.round(details.scale,4)))
					if Dta.ui.windowMove then Dta.ui.windowMove.modifyPosition.moveAsGrp:SetVisible(false) end
				end
			end
		else
			Dta.ui.windowtest.itemDetails.clearSelection:SetVisible(false)
			Dta.ui.windowtest.itemDetails.icon:SetTexture(Dta.AddonID, "textures/blank.png")
			Dta.ui.windowtest.itemDetails.name:SetText(Lang[Dta.Language].Text.NothingSelected)
			Dta.ui.windowtest.itemDetails.name:SetFontColor(1, 1, 1)
			Dta.selectionCenter = nil
			Dta.ui.windowtest.itemDetails.nrItems:SetText("-")
			Dta.ui.windowtest.itemDetails.x:SetText("-")
			Dta.ui.windowtest.itemDetails.y:SetText("-")
			Dta.ui.windowtest.itemDetails.z:SetText("-")
			Dta.ui.windowtest.itemDetails.yaw:SetText("-")
			Dta.ui.windowtest.itemDetails.pitch:SetText("-")
			Dta.ui.windowtest.itemDetails.roll:SetText("-")
			Dta.ui.windowtest.itemDetails.scale:SetText("-")
			if Dta.ui.windowMove then Dta.ui.windowMove.modifyPosition.moveAsGrp:SetVisible(false) end
		end
	end
end

function Dta.items.updateSelection(dimensionItem, delete)
	-- events pass a table which always seem to be a single { item_id, true }, but loop nevertheless
	for id,details in pairs(dimensionItem) do
		-- the is no update event when a selected item gets removed from a dimension
		if delete then
			Dta.selectedItems[id] = nil
		else
			local detail = Inspect.Dimension.Layout.Detail(id)
			if detail ~= nil then
				if detail.selected then
					Dta.items.fixRotation(detail)
					Dta.selectedItems[id] = detail
					--print("Selected: " .. detail.name .. ", ID:" .. detail.id)
				else
					Dta.selectedItems[id] = nil
					--print("DeSelected: " .. detail.name .. ", ID:" .. detail.id)
				end
			else
				-- seems there is a bug in deselecting where an item id gets corrupt;
				-- subsequent select of same item is bugged too, it doesn't emit a change
				-- event at all but we can't work around that
				Dta.CPrint("Invalid ID, trying to fix selection. This Rift bug may cause side-effects.")
				for s_id, val in pairs(Dta.selectedItems) do
					detail = Inspect.Dimension.Layout.Detail(s_id)
					if detail and not detail.selected then
						Dta.selectedItems[s_id] = nil
					end
				end
			end
		end
	end

	Dta.selectionCount = Dta.losa.tableLength(Dta.selectedItems)
	Dta.items.StartDetails()

end

function Dta.items.StartDetails()
	if Dta.ui ~= nil and Dta.ui.active then
		Dta.items.updateItemDetails()
	end
end

function Dta.items.DeselectAll()
	for id,Details in pairs(Dta.selectedItems) do
		local detail = Inspect.Dimension.Layout.Detail(Details.id)
		if detail ~= nil then
			if detail.selected then
				Dta.items.QueueDeselection(Details.id)
			end
		end
	end
end

function Dta.items.round(num, dp)
	local mult = 10^(dp or 0)
	if num >= 0 then return math.floor(num * mult + 0.5) / mult end
	return math.ceil(num * mult - 0.5) / mult
end

--------------------------------------
--GET CENTRAL POINT
--------------------------------------
function Dta.items.getCentralPoint(itemsList)
	local itemsList = itemsList or {}
	if Dta.losa.tableLength(itemsList) > 0 then
		local centralPoint = {x = 0, y = 0, z = 0}
		local allX = {}
		local allY = {}
		local allZ = {}
		for k, details in pairs(itemsList) do
			table.insert(allX, details.coordX)
			table.insert(allY, details.coordY)
			table.insert(allZ, details.coordZ)
		end

		local minValuaX = Dta.items.getMinValue(allX)
		local minValuaY = Dta.items.getMinValue(allY)
		local minValuaZ = Dta.items.getMinValue(allZ)
		local maxValuaX = Dta.items.getMaxValue(allX)
		local maxValuaY = Dta.items.getMaxValue(allY)
		local maxValuaZ = Dta.items.getMaxValue(allZ)



		centralPoint.x = minValuaX + maxValuaX
		centralPoint.y = minValuaY + maxValuaY
		centralPoint.z = minValuaZ + maxValuaZ

		for k, v in pairs(centralPoint) do centralPoint[k] = v / 2 end

		centralPoint.minValuaX = minValuaX
		centralPoint.minValuaY = minValuaY
		centralPoint.minValuaZ = minValuaZ
		centralPoint.maxValuaX = maxValuaX
		centralPoint.maxValuaY = maxValuaY
		centralPoint.maxValuaZ = maxValuaZ

		return centralPoint
	end
end

function Dta.items.getMinValue(Table)
	local minValue = Table[1]
	for m=1, table.getn(Table) do
		if Table[m] < minValue then
			minValue = Table[m]
		end
	end
	return minValue
end

function Dta.items.getMaxValue(Table)
	local maxValue = Table[1]
	for m=1, table.getn(Table) do
		if Table[m] > maxValue then
			maxValue = Table[m]
		end
	end
	return maxValue
end
