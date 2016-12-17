local Dta = select(2, ...)

Dta.Selections = {}

function Dta.Selections.PickupClicked()
	Dta.ui.showConfirmation("<Are you sure you want to pickup all selected items?", Dta.Selections.PickupSelection, nil, nil)
end

function Dta.Selections.PickupSelection()
	for id, details in pairs(Dta.selectedItems) do
		Dta.items.QueuePickup(id)
	end
end

function Dta.Selections.SaveSelectionClicked()
	local selUI = Dta.Tools.Select.window
	local name = selUI.name:GetText()
	if not Dta.Selections.saved then
		Dta.Selections.saved = {}
	end

	if not name or #name == 0 then
		Dta.CPrint("<enter name>")
		return
	elseif Dta.Selections.saved[name] then
		Dta.CPrint("<already exists>")
		return
	elseif Dta.selectionCount < 1 then
		Dta.CPrint("<select something")
		return
	end
	local new_set = {}
	for id, _ in pairs(Dta.selectedItems) do
		new_set[id] = true
	end
	Dta.Selections.saved[name] = new_set
	Dta.Selections.RefreshList()
end

function Dta.Selections.RefreshList()
	local nameList = {}
	if Dta.Selections.saved then
		for name, _ in pairs(Dta.Selections.saved) do
			table.insert(nameList, name)
		end
	end
	Dta.Tools.Select.window.nameList:SetItems(nameList)
end

function Dta.Selections.DeleteSelectionClicked()
	local selUI = Dta.Tools.Select.window
	local name = selUI.nameList:GetSelectedItem()
	if name then
		Dta.ui.showConfirmation(string.format("<Delete selection '%s'?", name), Dta.Selections.DeleteSelection, nil, name)
	end
end

function Dta.Selections.DeleteSelection(name)
	Dta.Selections.saved[name] = nil
	Dta.Selections.RefreshList()
end

function Dta.Selections.LoadSelectionClicked()
	local name = Dta.Tools.Select.window.nameList:GetSelectedItem()
	if not name then
		Dta.CPrint("<select set>")
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
	local items = Inspect.Dimension.Layout.List()
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
