local Dta = select(2, ...)

local ItemList = {}
local lProps =
{
	height = 40,
	spacing = 42,
	bgCol = { 0.07, 0.01, 0, 0.5 }
}

local function lSetItemDisplay(self, details)
	assert(self.type == details.type)
	self.icon:SetTexture("Rift", details.icon)
	self.name:SetText(details.name)
	local col = Dta.items.textColor[details.rarity or "common"]
	self.name:SetFontColor(col.r, col.g, col.b)
end

local function lItemListUpdate(self)
	local curTime = Inspect.Time.Frame()
	if curTime - self.lastUpdate < 0.25 then
		return
	end

	local itemDetails = Inspect.Item.Detail(self.missing)
	assert(itemDetails)
	-- display the details we already have
	for type, details in pairs(itemDetails) do
		self.itemList[self.missing[type]]:SetItemDisplay(details)
		self.missing[type] = nil
	end
	if not next(self.missing) or curTime > self.timeout then
		--if next(self.missing) then print("Timeout!") end
		Command.Event.Detach(Event.System.Update.Begin, self._pollItemDetails)
		self._polling = false
	end
	self.lastUpdate = curTime
end

local function lItemDisplayMouseIn(self)
	Command.Tooltip(self.type)
end

local function lItemDisplayMouseOut(self)
	Command.Tooltip(nil)
end

-- UI --
function ItemList.CreateItemDisplay(parent)
	local itemFrame = UI.CreateFrame("Frame", "ItemDiplay", parent)
	itemFrame:SetHeight(lProps.height)
	itemFrame:SetWidth(272) -- TODO: proper value
	itemFrame:SetBackgroundColor(unpack(lProps.bgCol))
	itemFrame.icon = Dta.ui.createTexture("ItemDiplay.icon", itemFrame, nil, nil, 4, 4, 32, 32)
	itemFrame.name = Dta.ui.createText("ItemDiplay.name", itemFrame, 40, 0, "", 14)
	itemFrame.name:SetWordwrap(true)
	itemFrame.name:SetWidth(220)
	itemFrame.amount = Dta.ui.createText("ItemDiplay.name", itemFrame, nil, nil, "", 14)
	itemFrame.amount:SetEffectGlow({offsetX=1, offsetY=1, strength=3})
	itemFrame.amount:SetPoint("BOTTOMRIGHT", itemFrame.icon, "BOTTOMRIGHT", -1, -1)
	itemFrame.amount:SetLayer(5)

	itemFrame.SetItemDisplay = lSetItemDisplay
	itemFrame:EventAttach(Event.UI.Input.Mouse.Cursor.In, lItemDisplayMouseIn, "ItemDisplayShowTooltip")
	itemFrame:EventAttach(Event.UI.Input.Mouse.Cursor.Out, lItemDisplayMouseOut, "ItemDisplayClearTooltip")

	return itemFrame
end

function ItemList.Create()
	local newWindow = Dta.ui.Window.Create("ItemListWindow",
							Dta.ui.context,
							Dta.Locale.Titles.MaterialList,
							300,
							450,
							10,	10,	true, true, -- X, Y, CLOSABLE, MOVABLE
							nil, nil -- close callback, moved callback
							)
	newWindow.itemListView = UI.CreateFrame("SimpleScrollView", "ItemScrollView", newWindow.content)
	newWindow.itemListView:SetPoint("TOPLEFT", newWindow.content, "TOPLEFT", 5, 5)
	newWindow.itemListView:SetWidth(290)
	newWindow.itemListView:SetHeight(430)
	newWindow.itemListFrame = UI.CreateFrame("Frame", "ItemListFrame", newWindow.itemListView)
	newWindow.itemListFrame:SetHeight(lProps.spacing)

	newWindow.itemListView:SetContent(newWindow.itemListFrame)
	newWindow.recycled = {}
	newWindow._polling = false

	newWindow.SetList = ItemList.SetList
	newWindow._pollItemDetails = function(h) lItemListUpdate(newWindow) end
	return newWindow
end

function ItemList.SetList(self, shoppingList)
	-- recycle frames
	if self.itemList then
		for idx, frame in pairs(self.itemList) do
			frame:SetVisible(false)
			frame:ClearPoint("TOPLEFT")
			table.insert(self.recycled, frame)
		end
	end

	self.missing = {}
	self.itemList = {}
	for type, entry in pairs(shoppingList) do
		local itemDP = table.remove(self.recycled) or ItemList.CreateItemDisplay(self.itemListFrame)
		itemDP:SetVisible(true)
		itemDP:SetPoint("TOPLEFT", self.itemListFrame, "TOPLEFT", 0, #self.itemList * lProps.spacing )
		itemDP.amount:SetText(tostring(entry.amount))
		itemDP.type = type
		table.insert(self.itemList, itemDP)
		self.missing[type] = #self.itemList
	end
	self.itemListFrame:SetHeight(#self.itemList * lProps.spacing)
	local itemDetails = Inspect.Item.Detail(self.missing)
	assert(itemDetails)
	-- display the details we already have, or use saved values
	for k, itemDP in pairs(self.itemList) do
		if itemDetails[itemDP.type] then
			itemDP:SetItemDisplay(itemDetails[itemDP.type])
			self.missing[itemDP.type] = nil
		else
			itemDP.name:SetText(shoppingList[itemDP.type].name)
			itemDP.name:SetFontColor(0.8, 0.8, 0.8)
			itemDP.icon:SetTexture("Rift", "placeholder_icon.dds")
		end
	end
	-- schedule updates for item details still missing
	if next(self.missing) then
		self.lastUpdate = Inspect.Time.Frame()
		self.timeout = self.lastUpdate + 5
		if not self._polling then
			Command.Event.Attach(Event.System.Update.Begin, self._pollItemDetails, "ItemListPollDetails")
			self._polling = true
		end
	elseif self_polling then
		-- cancel unfinished polling from old list
		Command.Event.Detach(Event.System.Update.Begin, self._pollItemDetails)
		self._polling = false
	end
end

function Dta.ui.ShowMaterialList(shoppingList)
	if not Dta.ui.GlobalItemList then
		Dta.ui.GlobalItemList = ItemList.Create()
		Dta.ui.GlobalItemList:SetLayer(100)
	else
		Dta.ui.GlobalItemList:SetVisible(true)
	end
	Dta.ui.GlobalItemList:SetList(shoppingList)
end
