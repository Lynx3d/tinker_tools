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
	newWindow.shapeDisplay = UI.CreateFrame("Canvas", "ConShapeDisplay", winContent)
	newWindow.shapeDisplay:SetPoint("TOPLEFT", winContent, "TOPLEFT", 10+17, 19)
	newWindow.shapeDisplay:SetPoint("BOTTOMRIGHT", winContent, "TOPLEFT", 10+137, 139)
	newWindow.shapeDisplay:SetBackgroundColor(0, 0, 1, 0.3) -- test
	--
	newWindow.angle = Dta.ui.createTextfield("ConnectorAngle", winContent, 170, 15, 50)
	newWindow.axis = Dta.ui.createDropdown("ConnectorAxisSelect", winContent, 170, 40, 60)
	newWindow.axis:SetItems({"x", "y", "z"})

	newWindow.pasteBtn = Dta.ui.createButton("connectorApplyBtn", winContent, 10, 210, nil, nil,
											"<paste>", nil, Dta.Connector.ConnectClicked)
	--TODO: TEMP, replace with selection event trigger
	newWindow.updateBtn = Dta.ui.createButton("connectorApplyBtn", winContent, 170, 210, nil, nil,
											"<update>", nil, Dta.ui.ConnectorUpdateUI)
	return newWindow
end

function Dta.ui.showConnectorWindow(conWindow)
	conWindow:SetVisible(true)
end

function Dta.ui.hideConnectorWindow(conWindow)
	conWindow:SetVisible(false)
end

function Dta.ui.ConnectorDrawShape(canvas, shape, axis)
	local shapeIdx = Dta.Connector.ShapeIndex[shape]
	if not shapeIdx then return end
	local dimensions = Dta.measurements.Dimensions[shapeIdx]
	local center = Dta.Connector.Center[shapeIdx]
	local axisMap = Dta.Connector.AxisMap[axis]
	local left = Dta.Connector.GetExtent(dimensions, center, axisMap[2], -1)
	local right = Dta.Connector.GetExtent(dimensions, center, axisMap[2], 1)
	local bottom = Dta.Connector.GetExtent(dimensions, center, axisMap[3], -1)
	local top = Dta.Connector.GetExtent(dimensions, center, axisMap[3], 1)
	local scale = 0.475 / math.max(-left, -bottom, right, top)
	local shapePath = {	{xProportional = 0.5 + left * scale, yProportional = 0.5 - top * scale},
						{xProportional = 0.5 + right * scale, yProportional = 0.5 - top * scale},
						{xProportional = 0.5 + right * scale, yProportional = 0.5 - bottom * scale},
						{xProportional = 0.5 + left* scale, yProportional = 0.5 - bottom * scale},
						{xProportional = 0.5 + left * scale, yProportional = 0.5 - top * scale} }
	--test
	if shape == "pole" and axis == 2 then
		shapePath = { {xProportional = 0.5 + left * scale, yProportional = 0.5},
					  {xProportional = 0.5, yProportional = 0.5 - top * scale,
						xControlProportional = 0.5 + left * scale, yControlProportional = 0.5 - top * scale},
					  {xProportional = 0.5 + right * scale, yProportional = 0.5,
						xControlProportional = 0.5 + right * scale, yControlProportional = 0.5 - top * scale},
					  {xProportional = 0.5, yProportional = 0.5 - bottom * scale,
						xControlProportional = 0.5 + right * scale, yControlProportional = 0.5 - bottom * scale},
					  {xProportional = 0.5 + left * scale, yProportional = 0.5,
						xControlProportional = 0.5 + left* scale, yControlProportional = 0.5 - bottom * scale},
					}
	end
	--
	canvas:SetShape(shapePath, {type = "solid", r=0.07, g=0.01, b=0, a=0.6}, {r=0, g=0, b=0, a=1, thickness=1})
end

-- TODO: turn into event handler when temp button is gone
function Dta.ui.ConnectorUpdateUI()
	local con_ui = Dta.Tools.Connector.window
	local available = false
	local shape, axis
	if Dta.selectionCount == 1 then
		-- TODO: make sure an axis is selected
		axis = con_ui.axis:GetSelectedIndex() or 1
		local _, details = next(Dta.selectedItems)
		local entry = Dta.Defaults.ItemDB[details.type]
		if entry and entry.shape then
			shape = entry.shape
			available = true
		end
	end
	con_ui.pasteBtn:SetEnabled(available)
	if available then
		Dta.ui.ConnectorDrawShape(con_ui.shapeDisplay, shape, axis)
	else
		con_ui.shapeDisplay:SetShape(nil, nil, nil)
	end
end

Dta.RegisterTool("Connector", Dta.ui.buildConnectorWindow, Dta.ui.showConnectorWindow, Dta.ui.hideConnectorWindow)
