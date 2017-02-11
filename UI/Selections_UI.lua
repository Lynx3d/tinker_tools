local Dta = select(2, ...)

local SelectionWindowSettings = {
	WIDTH = 315,
	HEIGHT = 200,
	CLOSABLE = true,
	MOVABLE = true,
	POS_X = "SelectionwindowPosX",
	POS_Y = "SelectionwindowPosY"
}

function Dta.ui.buildSelectionWindow()
	local Locale = Dta.Locale
	local x = Dta.settings.get("SelectionwindowPosX")
	local y = Dta.settings.get("SelectionwindowPosY")

	local newWindow = Dta.ui.Window.Create("SelectionWindow",
							Dta.ui.context,
							Locale.Titles.Selection,
							SelectionWindowSettings.WIDTH,
							SelectionWindowSettings.HEIGHT,
							x, y,
							SelectionWindowSettings.CLOSABLE,
							SelectionWindowSettings.MOVABLE,
							Dta.ui.hideSelectionWindow,
							Dta.ui.WindowMoved
							)
	local selWindow = newWindow.content
	newWindow.settings = SelectionWindowSettings

	newWindow.name = Dta.ui.createTextfield("selectionsName", selWindow, 55, 0, 245)
	newWindow.saveBtn = Dta.ui.createButton("selectionsSaveBtn", selWindow, 10, 25, nil, nil,
											Locale.Buttons.SaveSelection, nil, Dta.Selections.SaveSelectionClicked)
	newWindow.nameList = Dta.ui.createDropdown("selectionsNameSelect", selWindow, 55, 60, 245)
	newWindow.loadBtn = Dta.ui.createButton("selectionsLoadBtn", selWindow, 10, 130, nil, nil,
											Locale.Buttons.LoadSelection, nil, Dta.Selections.LoadSelectionClicked)
	newWindow.deleteBtn = Dta.ui.createButton("selectionsDeleteBtn", selWindow, 160, 130, nil, nil,
											  Locale.Buttons.DeleteSelection, nil, Dta.Selections.DeleteSelectionClicked)
	newWindow.invertBtn = Dta.ui.createButton("selectionsInvertBtn", selWindow, 10, 160, nil, nil,
											  Locale.Buttons.InvertSelection, nil, Dta.Selections.InvertSelectionClicked)
	newWindow.pickupBtn = Dta.ui.createButton("PickupBtn", selWindow, 160, 160, nil, nil,
											  Locale.Buttons.Pickup, nil, Dta.Selections.PickupClicked)

	function newWindow:RefreshNameList()
		local nameList = {}
		for name, _ in pairs(Dta.Selections.saved) do
			table.insert(nameList, name)
		end
		-- TODO: sort alphabetically
		self.nameList:SetItems(nameList)
	end

	-- other tools can already have created selection sets
	newWindow:RefreshNameList()

	return newWindow
end

-- Show the selection window
function Dta.ui.showSelectionWindow(sel_window)
	sel_window:SetVisible(true)
	sel_window.nameList:SetEnabled(true)
end

-- Hide the selection window
function Dta.ui.hideSelectionWindow(sel_window)
	sel_window:SetVisible(false)
	sel_window:ClearKeyFocus()
	-- workaround for dropdown not closing automatically
	sel_window.nameList:SetEnabled(false)
end

Dta.RegisterTool("Select", Dta.ui.buildSelectionWindow, Dta.ui.showSelectionWindow, Dta.ui.hideSelectionWindow)
