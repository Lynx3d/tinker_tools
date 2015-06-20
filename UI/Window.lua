local DraggableFrame = {}

DraggableFrame.MouseDownCallback = function(self, handle)
	self.dragging = true
	mouse = Inspect.Mouse()
	self.dragStartX = mouse.x - self.window:GetLeft()
	self.dragStartY = mouse.y - self.window:GetTop()
	self:EventAttach(Event.UI.Input.Mouse.Cursor.Move, DraggableFrame.MouseMoveCallback, "dragFrameMover")
end

DraggableFrame.MouseUpCallback = function(self, handle)
	self.dragging = false
	if type(self.movedCallback) == "function" then self.movedCallback() end
	self:EventDetach(Event.UI.Input.Mouse.Cursor.Move, DraggableFrame.MouseMoveCallback)
end

DraggableFrame.MouseMoveCallback = function(self,h)
	local md = Inspect.Mouse()
	if self.dragging then
		self.window:SetPoint("TOPLEFT", UIParent, "TOPLEFT", md.x - self.dragStartX, md.y - self.dragStartY)
	end
end

function DraggableFrame.Setup(dragframe, window, callback)
	dragframe.window = window
	dragframe.movedCallback = callback
	dragframe:EventAttach(Event.UI.Input.Mouse.Left.Down, DraggableFrame.MouseDownCallback, "mdcb")
	dragframe:EventAttach(Event.UI.Input.Mouse.Left.Up, DraggableFrame.MouseUpCallback, "mucb")
	dragframe:EventAttach(Event.UI.Input.Mouse.Left.Upoutside, DraggableFrame.MouseUpCallback, "muocb")
end

local Window = { headerSize = 30 }

function Window.defaultCloseCallback(self, handle)
	self:GetParent():SetVisible(false)
	-- function optionally passed to window construction
	if type(self.closeCallback) == "function" then self.closeCallback() end
end

-- create a window border
function Window.createWindowBorder(window)
	local path = {	{xProportional = 0, yProportional = 0},
					{xProportional = 0, yProportional = 1},
					{xProportional = 1, yProportional = 1},
					{xProportional = 1, yProportional = 0},
					{xProportional = 0, yProportional = 0} }
	local fill = {	type = 'texture',
					-- transform = {0.5, 0, 0, 0, 1, 0 },
					-- transform = Utility.Matrix.Create(0.5, 1, 0, 0, 0),
					source = "Rift",
					texture = "window_small_frame.png.dds" }
	-- CORNERS
	-- top left corner; size 75x75, offset -13, -9
	window.frame_topleft = UI.CreateFrame("Canvas", "frame_topleft", window)
	window.frame_topleft:SetPoint("TOPLEFT", window, "TOPLEFT", -13, -9)
	window.frame_topleft:SetPoint("BOTTOMRIGHT", window, "TOPLEFT", 62, 66)
	window.frame_topleft:SetShape(path, fill, nil)
	window.frame_topleft:SetLayer(10)
	-- bottom left corner; size 75x44, offset -13, 11
	window.frame_bottomleft = UI.CreateFrame("Canvas", "frame_bottomleft", window)
	window.frame_bottomleft:SetPoint("TOPLEFT", window, "BOTTOMLEFT", -13, -33)
	window.frame_bottomleft:SetPoint("BOTTOMRIGHT", window, "BOTTOMLEFT", 62, 11)
	fill.transform = { 1, 0, 0, 0, 1, -212 }
	window.frame_bottomleft:SetShape(path, fill, nil)
	window.frame_bottomleft:SetLayer(10)
	-- top right corner; size 74x75, offset 12, -9
	window.frame_topright = UI.CreateFrame("Canvas", "frame_topright", window)
	window.frame_topright:SetPoint("TOPLEFT", window, "TOPRIGHT", -62, -9)
	window.frame_topright:SetPoint("BOTTOMRIGHT", window, "TOPRIGHT", 12, 66)
	fill.transform = { 1, 0, -182, 0, 1, 0 }
	window.frame_topright:SetShape(path, fill, nil)
	window.frame_topright:SetLayer(10)
	-- bottom right corner; size 74x44, offset 12, 11
	window.frame_bottomright = UI.CreateFrame("Canvas", "frame_bottomright", window)
	window.frame_bottomright:SetPoint("TOPLEFT", window, "BOTTOMRIGHT", -62, -33)
	window.frame_bottomright:SetPoint("BOTTOMRIGHT", window, "BOTTOMRIGHT", 12, 11)
	fill.transform = { 1, 0, -182, 0, 1, -212 }
	window.frame_bottomright:SetShape(path, fill, nil)
	window.frame_bottomright:SetLayer(10)
	-- SIDES
	local f_height = window:GetHeight() - 66 - 33
	local h_scale = 1
	if f_height > 35 then
		h_scale = f_height / 137 -- 256 - 75 - 44
	end
	-- left side:  width 16, offset -13
	window.frame_left = UI.CreateFrame("Canvas", "frame_left", window)
	window.frame_left:SetPoint("TOPLEFT", window, "TOPLEFT", -13, 66)
	window.frame_left:SetPoint("BOTTOMRIGHT", window, "BOTTOMLEFT", 3, -33)
	fill.transform = { 1, 0, 0, 0, h_scale, -75 * h_scale }
	window.frame_left:SetShape(path, fill, nil)
	window.frame_left:SetLayer(10)
	-- right side:  width 15, offset 12
	window.frame_right = UI.CreateFrame("Canvas", "frame_left", window)
	window.frame_right:SetPoint("TOPLEFT", window, "TOPRIGHT", -3, 66)
	window.frame_right:SetPoint("BOTTOMRIGHT", window, "BOTTOMRIGHT", 12, -33)
	fill.transform = { 1, 0, -241, 0, h_scale, -75 * h_scale }
	window.frame_right:SetShape(path, fill, nil)
	window.frame_right:SetLayer(10)

	local f_width = window:GetWidth() - 62 - 62
	local w_scale = f_width / 107 -- 256 - 75 - 74
	-- top: height 14, offset -9
	window.frame_top = UI.CreateFrame("Canvas", "frame_top", window)
	window.frame_top:SetPoint("TOPLEFT", window, "TOPLEFT", 62, -9)
	window.frame_top:SetPoint("BOTTOMRIGHT", window, "TOPRIGHT", -62, 5)
	fill.transform = { w_scale, 0, -75 * w_scale, 0, 1, 0 }
	window.frame_top:SetShape(path, fill, nil)
	window.frame_top:SetLayer(10)
	-- bottom: height 15, offset 11
	window.frame_bottom = UI.CreateFrame("Canvas", "frame_bottom", window)
	window.frame_bottom:SetPoint("TOPLEFT", window, "BOTTOMLEFT", 62, -4)
	window.frame_bottom:SetPoint("BOTTOMRIGHT", window, "BOTTOMRIGHT", -62, 11)
	fill.transform = { w_scale, 0, -75 * w_scale, 0, 1, -241 }
	window.frame_bottom:SetShape(path, fill, nil)
	window.frame_bottom:SetLayer(10)
end

function Window.drawBackground(canvas)
	local width = canvas:GetWidth()
	local height = canvas:GetHeight()
	local crop = 6
	local width_scale = width / (1024 - 2*crop)
	local height_scale = math.max(width_scale, height / (512 - 2*crop)) -- don't squash vertically, only stretch if proportion too wide
	-- round top corners to match window frame
	local path = {	{x = 0, y = 10},
					{x = 10, y = 0, xControl = 0, yControl = 0},
					{x = width - 10, y = 0 },
					{x = width, y = 10, xControl = width, yControl = 0},
					{x = width, y = height},
					{x = 0, y = height },
					{x = 0, y = 10} }
	local fill = {	type = 'texture',
					source = "Rift",
					transform = { width_scale, 0, -crop * width_scale, 0, height_scale, -crop * height_scale },
					texture = "dimension_window_bg_right_large.png.dds" }
	canvas:SetShape(path, fill, nil)
end

function Window.createFramedWindow(name, parent, title, width, height, x, y, closable, movable, closeCallback, moveCallback)
	local newWindow = UI.CreateFrame("Frame", name, parent)
	newWindow:SetHeight(height)
	newWindow:SetWidth(width)
	newWindow:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y)

	--newWindow:EventAttach(Event.UI.Input.Mouse.Left.Click, Dta.ui.clickCallback, "WindowBackgroundClicked")

	newWindow.background = UI.CreateFrame("Canvas", name .. "Background", newWindow)
	newWindow.background:SetPoint("TOPLEFT", newWindow, "TOPLEFT", 0, 0)
	newWindow.background:SetPoint("BOTTOMRIGHT", newWindow, "TOPRIGHT", 0, height)
	Window.drawBackground(newWindow.background)
	newWindow.background:SetLayer(1)

	Window.createWindowBorder(newWindow)

	if closable then
		-- rift close button defaults to 36x36
		newWindow.closeBtn = UI.CreateFrame("RiftButton", name, newWindow)
		newWindow.closeBtn:SetSkin("close")
		newWindow.closeBtn:SetPoint("TOPRIGHT", newWindow, "TOPRIGHT", 4, -4)
		newWindow.closeBtn:EventAttach(Event.UI.Input.Mouse.Left.Click, Window.defaultCloseCallback, "WindowCloseButtonClicked")
		newWindow.closeBtn.closeCallback = closeCallback
		newWindow.closeBtn:SetLayer(11)
	end

	-- create invisible window mover at header (title and buttons area)
	if movable then
		newWindow.moveFrame = UI.CreateFrame("Frame", name .. "WindowMover", newWindow)
		newWindow.moveFrame:SetPoint("TOPLEFT", newWindow, "TOPLEFT", 0, 0)
		newWindow.moveFrame:SetPoint("BOTTOMRIGHT", newWindow, "TOPRIGHT", 0, Window.headerSize)
		newWindow.moveFrame:SetLayer(4)

		DraggableFrame.Setup(newWindow.moveFrame, newWindow, moveCallback)
		-- newWindow.moveFrame:SetBackgroundColor(1, 0, 0, 0.5) --Debug
	end

	if title then
		-- TODO: make title independent of moveable setting
		newWindow.header = UI.CreateFrame("Text", name .. "header", newWindow)
		newWindow.header:SetFontSize(20)
		newWindow.header:SetText(title)
		newWindow.header:SetFont("Rift", "$Flareserif_bold")
		newWindow.header:SetFontColor(0,0,0,1)
		newWindow.header:SetEffectGlow(
			{	blurX=5,
				blurY=5,
				colorA = 0.5,
				colorR = 1,
				colorG = 1,
				colorB = 0.85,
				strength = 3})
		newWindow.header:SetPoint("TOPCENTER", newWindow, "TOPCENTER", 0, 2)
		newWindow.header:SetLayer(9)
		dump(newWindow.header:GetHeight(), newWindow.header:GetFont())
	end

	newWindow.content = UI.CreateFrame("Frame", name .. "WindowContent", newWindow)
	if title or movable then
		newWindow.content:SetPoint("TOPLEFT", newWindow, "TOPLEFT", 0, Window.headerSize)
	else
		newWindow.content:SetPoint("TOPLEFT", newWindow, "TOPLEFT")
	end
	newWindow.content:SetPoint("BOTTOMRIGHT", newWindow, "BOTTOMRIGHT")
	newWindow.content:SetLayer(4)
	dump("content size:", newWindow.content:GetWidth(), newWindow.content:GetHeight())

	return newWindow
end

Dta.ui.Window = Window
Dta.ui.DraggableFrame = newWindow
