local Dta = select(2, ...)

Dta.Selections = {}
Dta.Selections.saved = {}

function Dta.Selections.PickupClicked()
	Dta.ui.showConfirmation(Dta.Locale.Text.ConfirmPickup, Dta.Selections.PickupSelection, nil, nil)
end

function Dta.Selections.PickupSelection()
	for id, details in pairs(Dta.selectedItems) do
		Dta.items.QueuePickup(id)
	end
end

function Dta.Selections.SaveSelection(name, overwrite)
	if Dta.selectionCount < 1 then
		Dta.CPrint(Dta.Locale.Prints.MinOneItem)
		return
	elseif not name or #name == 0 then
		Dta.CPrint(Dta.Locale.Prints.EnterName)
		return
	elseif Dta.Selections.saved[name] and not overwrite then
		Dta.ui.showConfirmation(string.format(Dta.Locale.Text.ConfirmOverwrite, name),
								true, false, coroutine.running())
		local ok = coroutine.yield()
		if ok then
			-- recurse to re-run previous checks
			Dta.Selections.SaveSelection(name, true)
		end
		return
	end
	local new_set = {}
	for id, _ in pairs(Dta.selectedItems) do
		new_set[id] = true
	end
	Dta.Selections.saved[name] = new_set
	Dta.Selections.RefreshList()
end

function Dta.Selections.SaveSelectionClicked()
	local selUI = Dta.Tools.Select.window
	local name = selUI.name:GetText()
	local cr = coroutine.wrap(Dta.Selections.SaveSelection)
	cr(name)
end

function Dta.Selections.RefreshList()
	local selUI = Dta.Tools.Select.window
	if selUI then
		selUI:RefreshNameList()
	end
end

function Dta.Selections.DeleteSelectionClicked()
	local selUI = Dta.Tools.Select.window
	local name = selUI.nameList:GetSelectedItem()
	if name then
		Dta.ui.showConfirmation(string.format(Dta.Locale.Text.ConfirmDeleteSet, name), Dta.Selections.DeleteSelection, nil, name)
	end
end

function Dta.Selections.DeleteSelection(name)
	Dta.Selections.saved[name] = nil
	Dta.Selections.RefreshList()
end

function Dta.Selections.LoadSelectionClicked()
	local name = Dta.Tools.Select.window.nameList:GetSelectedItem()
	if not name then
		Dta.CPrint(Dta.Locale.Prints.LoadSelectSet)
		return
	end
	local set = Dta.Selections.saved and Dta.Selections.saved[name]
	if not set then
		Dta.CPrint("<set not found>")
		return
	end
	for id, _ in pairs(set) do
		Dta.items.QueueSelection(id)
	end
end

function Dta.Selections.InvertSelectionClicked()
	local cr = coroutine.wrap(Dta.Selections.InvertSelection)
	cr()
end

function Dta.Selections.InvertSelection()
	local items = Inspect.Dimension.Layout.List()
	local sel_count = 0
	for id, crated in pairs(items) do
		if not crated and not Dta.selectedItems[id] then
			sel_count = sel_count + 1
		end
	end
	-- warn when we get above the limit that will cause disconnects when handling
	-- with Rift's own tools
	if sel_count > 200 then
		Dta.ui.showConfirmation(string.format(Dta.Locale.Text.ConfirmInvSelect, sel_count),
								true, false, coroutine.running())
		local ok = coroutine.yield()
		if not ok then
			return
		end
	end
	for id, crated in pairs(items) do
		if not crated then
			if Dta.selectedItems[id] then
				Dta.items.QueueDeselection(id)
			else
				Dta.items.QueueSelection(id)
			end
		end
	end
end
