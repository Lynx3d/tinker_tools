local Dta = select(2, ...)

local ConnectorWindowSettings = {
	WIDTH = 305,
	HEIGHT = 250,
	POS_X = "ConnectorwindowPosX",
	POS_Y = "ConnectorwindowPosY"
}

function Dta.ui.buildConnectorWindow()
	local x = Dta.settings.get("ConnectorwindowPosX") or 0
	local y = Dta.settings.get("ConnectorwindowPosY") or 0

	local newWindow = Dta.ui.Window.Create("ConnectorWindow",
							Dta.ui.context,
							"<Connector>",
							ConnectorWindowSettings.WIDTH,
							ConnectorWindowSettings.HEIGHT,
							x, y, true, true,
							Dta.ui.hideConnectorWindow,
							Dta.ui.WindowMoved
							)
	newWindow.settings = ConnectorWindowSettings
	local winContent = newWindow.content

	-- Connector Controls --
	newWindow.corner = {}
	local cornerX = {12, 70, 128, 140, 140, 140, 128, 70, 12, 0, 0, 0}
	local cornerY = {0, 0, 0, 12, 70, 128, 140, 140, 140, 128, 70, 12}
	for i = 1,12 do
		local checkbox = UI.CreateFrame("RiftCheckbox", "ConCorner" .. i, winContent)
		checkbox:SetPoint("TOPLEFT", winContent, "TOPLEFT", 10 + cornerX[i], cornerY[i])
		checkbox.link = i
		checkbox:EventAttach(Event.UI.Checkbox.Change, Dta.Connector.LinkChanged, "connector_link_changed")
		newWindow.corner[i] = checkbox
	end
	newWindow.corner[Dta.Connector.link]:SetChecked(true)
	--
	newWindow.angle = Dta.ui.createTextfield("ConnectorAngle", winContent, 170, 15, 50)
	newWindow.axis = Dta.ui.createDropdown("ConnectorAxisSelect", winContent, 170, 40, 60)
	newWindow.axis:SetItems({"x", "y", "z"})

	newWindow.pasteBtn = Dta.ui.createButton("connectorApplyBtn", winContent, 10, 210, nil, nil,
											"<paste>", nil, Dta.Connector.ConnectClicked)
	return newWindow
end

function Dta.ui.showConnectorWindow(conWindow)
	conWindow:SetVisible(true)
end

function Dta.ui.hideConnectorWindow(conWindow)
	conWindow:SetVisible(false)
end

Dta.RegisterTool("Connector", Dta.ui.buildConnectorWindow, Dta.ui.showConnectorWindow, Dta.ui.hideConnectorWindow)
