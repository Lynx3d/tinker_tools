local Dta = select(2, ...)

Dta.scale_ui = {}

-------------------------------
-- BUILD THE DIMENSIONTOOLS SCALEWINDOW
-------------------------------

local ScaleWindowSettings = {
	WIDTH = 305,
	HEIGHT = 130,
	CLOSABLE = true,
	MOVABLE = true,
	POS_X = "ScalewindowPosX",
	POS_Y = "ScalewindowPosY"
}

function Dta.scale_ui.buildScaleWindow()
	local x = Dta.settings.get("ScalewindowPosX")
	local y = Dta.settings.get("ScalewindowPosY")
	local newWindow = Dta.ui.Window.Create("Scalewindow",
							Dta.ui.context,
							Dta.Locale.Titles.Scale,
							ScaleWindowSettings.WIDTH,
							ScaleWindowSettings.HEIGHT,
							x,
							y,
							ScaleWindowSettings.CLOSABLE,
							ScaleWindowSettings.MOVABLE,
							Dta.scale_ui.ScaleWindowClosed,
							Dta.ui.WindowMoved
							)
	newWindow.settings = ScaleWindowSettings
	local Scalewindow = newWindow.content

	Scalewindow.background2 = UI.CreateFrame("Texture", "ScaleWindowBackground2", Scalewindow)
	Scalewindow.background2:SetPoint("BOTTOMCENTER", Scalewindow, "BOTTOMCENTER")
	Scalewindow.background2:SetWidth(ScaleWindowSettings.WIDTH)
	Scalewindow.background2:SetHeight(80)
	Scalewindow.background2:SetAlpha(0.3)
	Scalewindow.background2:SetTexture("Rift", "dimensions_tools_header.png.dds")
	Scalewindow.background2:SetLayer(5)

	-------------------------------
	--ITEM DETAILS
	-------------------------------

	Scalewindow.modifyScale = Dta.ui.createFrame("modifyScale", Scalewindow, 10, 5, Scalewindow:GetWidth()-20, Scalewindow:GetHeight()-20)
	Scalewindow.modifyScale:SetLayer(30)
	--Scalewindow.modifyScale:SetBackgroundColor(1, 0, 0, 0.5) --Debug

	Scalewindow.modifyScale.label = Dta.ui.createText("modifyScaleLabel", Scalewindow.modifyScale, 0, 25, Dta.Locale.Text.Scale, 14)

	Scalewindow.modifyScale.scale = Dta.ui.createTextfield("modifyScaleScale", Scalewindow.modifyScale, 45, 25, 80)
	Scalewindow.modifyScale.fetchScale = Dta.ui.createReloadButton("fetchScale", Scalewindow.modifyScale, 125, 25, Dta.scale.fetchScaleButtonClicked)

	Scalewindow.modifyScale.modeAbs = Dta.ui.createCheckbox("modifyScaleModeAbs", Scalewindow.modifyScale, 160, 5, Dta.Locale.Text.Absolute, true, nil, Dta.scale.modifyScaleModeAbsChanged)
	Scalewindow.modifyScale.modeRel = Dta.ui.createCheckbox("modifyScaleModeRel", Scalewindow.modifyScale, 160, 25, Dta.Locale.Text.Relative, false, nil, Dta.scale.modifyScaleModeRelChanged)
	Scalewindow.modifyScale.modeGrp = Dta.ui.createCheckbox("modifyScaleModeGrp", Scalewindow.modifyScale, 175, 45, Dta.Locale.Text.MoveAsGroup, false, nil, nil)
	Scalewindow.modifyScale.modeGrp:CBSetEnabled(false)

	Scalewindow.modifyScale.changeBtn = Dta.ui.createButton("modifyScaleBtn", Scalewindow.modifyScale, 0, 85, nil, nil, Dta.Locale.Buttons.Scale, nil, Dta.scale.modifyScaleButtonClicked)
	Scalewindow.modifyScale.resetBtn = Dta.ui.createButton("modifyScaleResetBtn", Scalewindow.modifyScale, 150, 85, nil, nil, Dta.Locale.Buttons.Reset, nil, Dta.scale.modifyScaleResetButtonClicked)

	-- "abuse" cycle function for clearing input focus on 'return' key
	Scalewindow:EventAttach(Event.UI.Input.Key.Up.Dive, Dta.ui.FocusCycleCallback, "Scalewindow_TabFocusCycle")

	-- TODO: temp fix for new window hierarchy
	newWindow.modifyScale = Scalewindow.modifyScale

	return newWindow
end

-- Show the toolbox window
function Dta.scale_ui.showScaleWindow()
	if Dta.ui.windowScale == nil then
		Dta.ui.windowScale = Dta.scale_ui.buildScaleWindow()
	else
		Dta.ui.windowScale:SetVisible(true)
	end
	Dta.ui.activeScale = true
end

-- Hide the toolbox window
function Dta.scale_ui.hideScaleWindow()
	Dta.ui.windowScale:SetVisible(false)
	Dta.ui.windowScale:ClearKeyFocus()
--	Dta.ui.windowScale = nil
	Dta.ui.activeScale = false
end

-- Toggle the toolbox window
function Dta.scale_ui.toggleScaleWindow()
	if Dta.ui.activeScale then Dta.scale_ui.hideScaleWindow()
	else Dta.scale_ui.showScaleWindow() end
end

--Called when the window has been closed
function Dta.scale_ui.ScaleWindowClosed()
	Dta.scale_ui.hideScaleWindow()
end
