local Dta = select(2, ...)

local SelectionWindowSettings = {
	WIDTH = 315,
	HEIGHT = 185,
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

	newWindow.nameLabel = Dta.ui.createText("selectionsNameLabel", selWindow, 10, 0, Dta.Locale.Text.Name, 14)
	newWindow.name = Dta.ui.createTextfield("selectionsName", selWindow, 65, 0, 235)
	newWindow.saveBtn = Dta.ui.createButton("selectionsSaveBtn", selWindow, 10, 25, nil, nil,
											Locale.Buttons.SaveSet, nil, Dta.Selections.SaveSelectionClicked)

	newWindow.divider1 = Dta.ui.createTexture("slectionDivider1", selWindow, "Rift", "divider_06.png.dds", 0, 55, selWindow:GetWidth())

	newWindow.nameLabel2 = Dta.ui.createText("selectionsNameLabel2", selWindow, 10, 75, Dta.Locale.Text.Name, 14)
	newWindow.nameList = Dta.ui.createDropdown("selectionsNameSelect", selWindow, 65, 75, 235)
	newWindow.loadBtn = Dta.ui.createButton("selectionsLoadBtn", selWindow, 10, 100, nil, nil,
											Locale.Buttons.LoadSet, nil, Dta.Selections.LoadSelectionClicked)
	newWindow.deleteBtn = Dta.ui.createButton("selectionsDeleteBtn", selWindow, 160, 100, nil, nil,
											  Locale.Buttons.RemoveSet, nil, Dta.Selections.DeleteSelectionClicked)

	newWindow.divider2 = Dta.ui.createTexture("slectionDivider2", selWindow, "Rift", "divider_06.png.dds", 0, 130, selWindow:GetWidth())

	newWindow.invertBtn = Dta.ui.createButton("selectionsInvertBtn", selWindow, 10, 145, nil, nil,
											  Locale.Buttons.InvertSelection, nil, Dta.Selections.InvertSelectionClicked)
	newWindow.pickupBtn = Dta.ui.createButton("PickupBtn", selWindow, 160, 145, nil, nil,
											  Locale.Buttons.PickUp, nil, Dta.Selections.PickupClicked)

	function newWindow:RefreshNameList()
		local nameList = {}
		for name, _ in pairs(Dta.Selections.saved) do
			table.insert(nameList, name)
		end
		-- TODO: sort alphabetically
		self.nameList:SetItems(nameList)
	end

	-- "abuse" cycle function for clearing input focus on 'return' key
	newWindow:EventAttach(Event.UI.Input.Key.Down.Dive, Dta.ui.FocusCycleCallback, "Selection_TabFocusCycle")
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
