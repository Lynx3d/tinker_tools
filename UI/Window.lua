local Dta = select(2, ...)

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
	if type(self.movedCallback) == "function" then self.movedCallback(self.window) end
	self:EventDetach(Event.UI.Input.Mouse.Cursor.Move, DraggableFrame.MouseMoveCallback)
end

DraggableFrame.MouseMoveCallback = function(self,h)
	local md = Inspect.Mouse()
	if self.dragging then
		self.window:SetPoint("TOPLEFT", UIParent, "TOPLEFT", md.x - self.dragStartX, md.y - self.dragStartY)
	end
end

function DraggableFrame.Setup(dragframe, window, callback, button)
	button = button or "Left"
	dragframe.window = window
	dragframe.movedCallback = callback
	dragframe:EventAttach(Event.UI.Input.Mouse[button].Down, DraggableFrame.MouseDownCallback, "mdcb")
	dragframe:EventAttach(Event.UI.Input.Mouse[button].Up, DraggableFrame.MouseUpCallback, "mucb")
	dragframe:EventAttach(Event.UI.Input.Mouse[button].Upoutside, DraggableFrame.MouseUpCallback, "muocb")
end

-------------------------------------------------
-- Simple Window small border, optional header
-- with title, drag functionality and close button
-------------------------------------------------

local Window = { headerSize = 30, classicHeaderSize = 40 }
Window.rectPath = {	{xProportional = 0, yProportional = 0},
					{xProportional = 0, yProportional = 1},
					{xProportional = 1, yProportional = 1},
					{xProportional = 1, yProportional = 0},
					{xProportional = 0, yProportional = 0} }

function Window.defaultCloseCallback(self, handle)
	local my_window = self:GetParent()
	my_window:SetVisible(false)
	-- function optionally passed to window construction
	if type(self.closeCallback) == "function" then self.closeCallback(my_window) end
end

-- create a window border
function Window.createWindowBorder(window)
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
	window.frame_topleft:SetShape(Window.rectPath, fill, nil)
	window.frame_topleft:SetLayer(10)
	-- bottom left corner; size 75x44, offset -13, 11
	window.frame_bottomleft = UI.CreateFrame("Canvas", "frame_bottomleft", window)
	window.frame_bottomleft:SetPoint("TOPLEFT", window, "BOTTOMLEFT", -13, -33)
	window.frame_bottomleft:SetPoint("BOTTOMRIGHT", window, "BOTTOMLEFT", 62, 11)
	fill.transform = { 1, 0, 0, 0, 1, -212 }
	window.frame_bottomleft:SetShape(Window.rectPath, fill, nil)
	window.frame_bottomleft:SetLayer(10)
	-- top right corner; size 74x75, offset 12, -9
	window.frame_topright = UI.CreateFrame("Canvas", "frame_topright", window)
	window.frame_topright:SetPoint("TOPLEFT", window, "TOPRIGHT", -62, -9)
	window.frame_topright:SetPoint("BOTTOMRIGHT", window, "TOPRIGHT", 12, 66)
	fill.transform = { 1, 0, -182, 0, 1, 0 }
	window.frame_topright:SetShape(Window.rectPath, fill, nil)
	window.frame_topright:SetLayer(10)
	-- bottom right corner; size 74x44, offset 12, 11
	window.frame_bottomright = UI.CreateFrame("Canvas", "frame_bottomright", window)
	window.frame_bottomright:SetPoint("TOPLEFT", window, "BOTTOMRIGHT", -62, -33)
	window.frame_bottomright:SetPoint("BOTTOMRIGHT", window, "BOTTOMRIGHT", 12, 11)
	fill.transform = { 1, 0, -182, 0, 1, -212 }
	window.frame_bottomright:SetShape(Window.rectPath, fill, nil)
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
	window.frame_left.fill = Dta.copyTable(fill)
	window.frame_left.fill.transform = { 1, 0, 0, 0, h_scale, -75 * h_scale }
	window.frame_left:SetShape(Window.rectPath, window.frame_left.fill, nil)
	window.frame_left:SetLayer(10)
	window.frame_left:EventAttach(Event.UI.Layout.Size, Window.redrawVerticalBorder, "redrawLBorder")
	-- right side:  width 15, offset 12
	window.frame_right = UI.CreateFrame("Canvas", "frame_left", window)
	window.frame_right:SetPoint("TOPLEFT", window, "TOPRIGHT", -3, 66)
	window.frame_right:SetPoint("BOTTOMRIGHT", window, "BOTTOMRIGHT", 12, -33)
	window.frame_right.fill = Dta.copyTable(fill)
	window.frame_right.fill.transform = { 1, 0, -241, 0, h_scale, -75 * h_scale }
	window.frame_right:SetShape(Window.rectPath, window.frame_right.fill, nil)
	window.frame_right:SetLayer(10)
	window.frame_right:EventAttach(Event.UI.Layout.Size, Window.redrawVerticalBorder, "redrawRBorder")

	local f_width = window:GetWidth() - 62 - 62
	local w_scale = f_width / 107 -- 256 - 75 - 74
	-- top: height 14, offset -9
	window.frame_top = UI.CreateFrame("Canvas", "frame_top", window)
	window.frame_top:SetPoint("TOPLEFT", window, "TOPLEFT", 62, -9)
	window.frame_top:SetPoint("BOTTOMRIGHT", window, "TOPRIGHT", -62, 5)
	window.frame_top.fill = Dta.copyTable(fill)
	window.frame_top.fill.transform = { w_scale, 0, -75 * w_scale, 0, 1, 0 }
	window.frame_top:SetShape(Window.rectPath, window.frame_top.fill, nil)
	window.frame_top:SetLayer(10)
	window.frame_top:EventAttach(Event.UI.Layout.Size, Window.redrawHorizontalBorder, "redrawTBorder")
	-- bottom: height 15, offset 11
	window.frame_bottom = UI.CreateFrame("Canvas", "frame_bottom", window)
	window.frame_bottom:SetPoint("TOPLEFT", window, "BOTTOMLEFT", 62, -4)
	window.frame_bottom:SetPoint("BOTTOMRIGHT", window, "BOTTOMRIGHT", -62, 11)
	window.frame_bottom.fill = Dta.copyTable(fill)
	window.frame_bottom.fill.transform = { w_scale, 0, -75 * w_scale, 0, 1, -241 }
	window.frame_bottom:SetShape(Window.rectPath, window.frame_bottom.fill, nil)
	window.frame_bottom:SetLayer(10)
	window.frame_bottom:EventAttach(Event.UI.Layout.Size, Window.redrawHorizontalBorder, "redrawBBorder")
end

function Window.redrawVerticalBorder(self)
	local new_height = self:GetHeight()
	local h_scale = 1
	if new_height > 35 then
		h_scale = new_height / 137 -- 256 - 75 - 44
	end
	self.fill.transform[5] = h_scale
	self.fill.transform[6] = -75 * h_scale
	self:SetShape(Window.rectPath, self.fill, nil)
end

function Window.redrawHorizontalBorder(self)
	local w_scale = self:GetWidth() / 107 -- 256 - 75 - 74
	self.fill.transform[1] = w_scale
	self.fill.transform[3] = -75 * w_scale
	self:SetShape(Window.rectPath, self.fill, nil)
end

function Window.drawBackground(canvas)
	local width = canvas:GetWidth()
	local height = canvas:GetHeight()
	local crop = canvas.crop
	local width_scale = width / (crop[3] - crop[1])
	-- don't squash vertically below min_aspect, only stretch if proportion too wide
	local height_scale = math.max(canvas.min_height * width_scale, height / (crop[4] - crop[2]))
	-- round top corners to match window frame
	local path = {	{x = 0, y = 10},
					{x = 10, y = 0, xControl = 0, yControl = 0},
					{x = width - 10, y = 0 },
					{x = width, y = 10, xControl = width, yControl = 0},
					{x = width, y = height},
					{x = 0, y = height },
					{x = 0, y = 10} }
	local fill = {	type = 'texture',
					source = canvas.source,
					transform = { width_scale, 0, -crop[1] * width_scale, 0, height_scale, -crop[2] * height_scale },
					texture = canvas.asset }
	canvas:SetShape(path, fill, nil)
end

function Window.SetBackground(self, resource, asset, crop, min_height)
	local bg = self.background
	bg.source = resource
	bg.asset = asset
	bg.crop = crop
	bg.min_height = min_height or 0
	Window.drawBackground(bg)
end

function Window.SetContentHeight(self, newHeight)
	self:SetHeight(newHeight + self:GetHeight() - self.content:GetHeight())
end

function Window.createFramedWindow(name, parent, title, width, height, x, y, closable, movable, closeCallback, moveCallback)
	local newWindow = UI.CreateFrame("Frame", name, parent)
	newWindow:SetHeight(height + ((title or movable) and Window.headerSize or 0))
	newWindow:SetWidth(width)
	newWindow:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y)

	newWindow:EventAttach(Event.UI.Input.Mouse.Left.Click, Dta.ui.clickCallback, "WindowBackgroundClicked")

	newWindow.background = UI.CreateFrame("Canvas", name .. "Background", newWindow)
	newWindow.background:SetPoint("TOPLEFT", newWindow, "TOPLEFT", 0, 0)
	newWindow.background:SetPoint("BOTTOMRIGHT", newWindow, "BOTTOMRIGHT", 0, 0)
	Window.SetBackground(newWindow, "Rift", "dimension_window_bg_right_large.png.dds", {6, 6, 1018, 506}, 1)
	newWindow.background:SetLayer(1)
	newWindow.background:EventAttach(Event.UI.Layout.Size, Window.drawBackground, "redrawBackground")

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
	end

	newWindow.content = UI.CreateFrame("Frame", name .. "WindowContent", newWindow)
	if title or movable then
		newWindow.content:SetPoint("TOPLEFT", newWindow, "TOPLEFT", 0, Window.headerSize)
	else
		newWindow.content:SetPoint("TOPLEFT", newWindow, "TOPLEFT")
	end
	newWindow.content:SetPoint("BOTTOMRIGHT", newWindow, "BOTTOMRIGHT")
	newWindow.content:SetLayer(4)
	newWindow.SetContentHeight = Window.SetContentHeight
	newWindow.SetBackground = Window.SetBackground

	return newWindow
end

function Window.SetBackground_FL(self, resource, asset, overlap)
	self.background:SetTexture(resource, asset)
	if overlap then
		self.background:SetPoint("TOPLEFT", self, "TOPLEFT", -overlap[1], Window.classicHeaderSize - overlap[2])
		self.background:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", overlap[3], overlap[4])
	else
		self.background:SetPoint("TOPLEFT", self, "TOPLEFT", 0, Window.classicHeaderSize)
		self.background:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
	end
end

function Window.createFramelessWindow(name, parent, title, width, height, x, y, closable, movable, closeCallback, moveCallback)
	local newWindow = UI.CreateFrame("Frame", name, parent)
	newWindow:SetHeight(height + Window.classicHeaderSize + 5)
	newWindow:SetWidth(width)
	newWindow:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y)
	--newWindow:SetLayer(11)

	newWindow:EventAttach(Event.UI.Input.Mouse.Left.Click, Dta.ui.clickCallback, "WindowBackgroundClicked")

	newWindow.background = UI.CreateFrame("Texture", name .. "Background", newWindow)
	newWindow.background:SetPoint("TOPLEFT", newWindow, "TOPLEFT", 0, Window.classicHeaderSize)
	newWindow.background:SetPoint("BOTTOMRIGHT", newWindow, "BOTTOMRIGHT", 0, 0)
	newWindow.background:SetTexture("Rift", "dimension_window_bg_right_large.png.dds")
	newWindow.background:SetLayer(2)

	--[[local background2Position = newWindow:GetHeight()-80
	newWindow.background2 = UI.CreateFrame("Texture", name .. "Background2", newWindow)
	newWindow.background2:SetPoint("CENTERX", newWindow, "CENTERX")
	newWindow.background2:SetPoint("CENTERY", newWindow, "CENTERY", nil, background2Position/2)
	newWindow.background2:SetWidth(width)
	newWindow.background2:SetHeight(95)
	newWindow.background2:SetAlpha(0.3)
	newWindow.background2:SetTexture("Rift", "dimensions_tools_header.png.dds")
	newWindow.background2:SetLayer(5)  ]]


	if closable then
		newWindow.closeBtn = Dta.ui.createButton(name .. "CloseBtn", newWindow, newWindow:GetWidth()-35, 7, nil, nil, nil, "close", Window.defaultCloseCallback)
		newWindow.closeBtn.closeCallback = closeCallback
		newWindow.closeBtn:SetLayer(4)
	end

	if movable then
		newWindow.moveFrame = UI.CreateFrame("Texture", name .. "WindowMover", newWindow)
		newWindow.moveFrame:SetPoint("TOPLEFT", newWindow, "TOPLEFT", 0, 0)
		newWindow.moveFrame:SetPoint("BOTTOMRIGHT", newWindow, "TOPRIGHT", 0, Window.classicHeaderSize + 5)
		newWindow.moveFrame:SetTexture("Rift", "dimensions_main_bg_top.png.dds")
		newWindow.moveFrame:SetLayer(1)

		DraggableFrame.Setup(newWindow.moveFrame, newWindow, moveCallback)
		--newWindow.moveFrame:SetBackgroundColor(1, 0, 0, 0.5) --Debug

		newWindow.header = UI.CreateFrame("Text", name .. "header", newWindow.moveFrame)
		newWindow.header:SetFontSize(20)
		newWindow.header:SetText(title)
		newWindow.header:SetFontColor(0,0,0,1)
		newWindow.header:SetPoint("CENTERX", newWindow.moveFrame, "CENTERX")
		newWindow.header:SetPoint("CENTERY", newWindow.moveFrame, "CENTERY", nil, 5)
	end

	newWindow.content = UI.CreateFrame("Frame", name .. "WindowContent", newWindow)
	newWindow.content:SetPoint("TOPLEFT", newWindow, "TOPLEFT", 0, Window.classicHeaderSize + 5)
	newWindow.content:SetPoint("BOTTOMRIGHT", newWindow, "BOTTOMRIGHT")
	newWindow.content:SetLayer(4)
	newWindow.SetContentHeight = Window.SetContentHeight
	newWindow.SetBackground = Window.SetBackground_FL

	return newWindow
end

function Window.ClearKeyFocus(self)
	if self.key_focus_frame then
		self.key_focus_frame:SetKeyFocus(false)
	end
end

function Window.Create(...)
	local style = Dta.settings.get("WindowStyle")
	local new_window
	if style == "classic" then
		new_window = Window.createFramelessWindow(...)
	else
		new_window = Window.createFramedWindow(...)
	end
	new_window.ClearKeyFocus = Window.ClearKeyFocus
	new_window:EventAttach(Event.UI.Input.Key.Focus.Gain.Bubble,
		function(frame, hEvent)
			new_window.key_focus_frame = hEvent:GetTarget()
		end,
		"window_key_focus_gain")
	new_window:EventAttach(Event.UI.Input.Key.Focus.Loss.Bubble,
		function(frame, hEvent)
			new_window.key_focus_frame = nil
		end,
		"window_key_focus_loss")
	return new_window
end

-------------------------------------------------
-- Window that replicates Rift confirmation popups
-------------------------------------------------

function Window.createPopupBorder(window)
	local fill = {	type = 'texture',
					-- transform = {0.5, 0, 0, 0, 1, 0 },
					-- transform = Utility.Matrix.Create(0.5, 1, 0, 0, 0),
					source = "Rift",
					texture = "window_popup_alpha.png.dds" }
	-- CORNERS
	-- top left corner; size 20x15, offset -6, -1
	window.frame_topleft = UI.CreateFrame("Canvas", "frame_topleft", window)
	window.frame_topleft:SetPoint("TOPLEFT", window, "TOPLEFT", -6, -1)
	window.frame_topleft:SetPoint("BOTTOMRIGHT", window, "TOPLEFT", 14, 14)
	window.frame_topleft:SetShape(Window.rectPath, fill, nil)
	window.frame_topleft:SetLayer(-10)
	-- bottom left corner; size 20x23, offset -6, 9
	window.frame_bottomleft = UI.CreateFrame("Canvas", "frame_bottomleft", window)
	window.frame_bottomleft:SetPoint("TOPLEFT", window, "BOTTOMLEFT", -6, -14)
	window.frame_bottomleft:SetPoint("BOTTOMRIGHT", window, "BOTTOMLEFT", 14, 9)
	fill.transform = { 1, 0, 0, 0, 1, -105 }
	window.frame_bottomleft:SetShape(Window.rectPath, fill, nil)
	window.frame_bottomleft:SetLayer(-10)
	-- top right corner; size 19x15, offset 5, -1
	window.frame_topright = UI.CreateFrame("Canvas", "frame_topright", window)
	window.frame_topright:SetPoint("TOPLEFT", window, "TOPRIGHT", -14, -1)
	window.frame_topright:SetPoint("BOTTOMRIGHT", window, "TOPRIGHT", 5, 14)
	fill.transform = { 1, 0, -109, 0, 1, 0 }
	window.frame_topright:SetShape(Window.rectPath, fill, nil)
	window.frame_topright:SetLayer(-10)
	-- bottom right corner; size 19x23, offset 5, 9
	window.frame_bottomright = UI.CreateFrame("Canvas", "frame_bottomright", window)
	window.frame_bottomright:SetPoint("TOPLEFT", window, "BOTTOMRIGHT", -14, -14)
	window.frame_bottomright:SetPoint("BOTTOMRIGHT", window, "BOTTOMRIGHT", 5, 9)
	fill.transform = { 1, 0, -109, 0, 1, -105 }
	window.frame_bottomright:SetShape(Window.rectPath, fill, nil)
	window.frame_bottomright:SetLayer(-10)
	-- SIDES
	local f_height = window:GetHeight() - 14 - 14
	local h_scale = 1
	if f_height > 90 then
		h_scale = f_height / 90 -- 128 - 15 - 23
	end
	-- left side:  width 20, offset -6
	window.frame_left = UI.CreateFrame("Canvas", "frame_left", window)
	window.frame_left:SetPoint("TOPLEFT", window, "TOPLEFT", -6, 14)
	window.frame_left:SetPoint("BOTTOMRIGHT", window, "BOTTOMLEFT", 14, -14)
	fill.transform = { 1, 0, 0, 0, h_scale, -15 * h_scale }
	window.frame_left:SetShape(Window.rectPath, fill, nil)
	window.frame_left:SetLayer(-10)
	-- right side:  width 19, offset 5
	window.frame_right = UI.CreateFrame("Canvas", "frame_left", window)
	window.frame_right:SetPoint("TOPLEFT", window, "TOPRIGHT", -14, 14)
	window.frame_right:SetPoint("BOTTOMRIGHT", window, "BOTTOMRIGHT", 5, -14)
	fill.transform = { 1, 0, -109, 0, h_scale, -15 * h_scale }
	window.frame_right:SetShape(Window.rectPath, fill, nil)
	window.frame_right:SetLayer(-10)

	local f_width = window:GetWidth() - 14 - 14
	local w_scale = 1
	if f_width > 89 then
		w_scale = f_width / 89 -- 128 - 20 - 19
	end
	-- top: height 15, offset -1
	window.frame_top = UI.CreateFrame("Canvas", "frame_top", window)
	window.frame_top:SetPoint("TOPLEFT", window, "TOPLEFT", 14, -1)
	window.frame_top:SetPoint("BOTTOMRIGHT", window, "TOPRIGHT", -14, 14)
	fill.transform = { w_scale, 0, -20 * w_scale, 0, 1, 0 }
	window.frame_top:SetShape(Window.rectPath, fill, nil)
	window.frame_top:SetLayer(-10)
	-- bottom: height 15, offset 11
	window.frame_bottom = UI.CreateFrame("Canvas", "frame_bottom", window)
	window.frame_bottom:SetPoint("TOPLEFT", window, "BOTTOMLEFT", 14, -14)
	window.frame_bottom:SetPoint("BOTTOMRIGHT", window, "BOTTOMRIGHT", -14, 9)
	fill.transform = { w_scale, 0, -20 * w_scale, 0, 1, -105 }
	window.frame_bottom:SetShape(Window.rectPath, fill, nil)
	window.frame_bottom:SetLayer(-10)
	-- center piece
	window.frame_center = UI.CreateFrame("Canvas", "frame_center", window)
	window.frame_center:SetPoint("TOPLEFT", window, "TOPLEFT", 14, 14)
	window.frame_center:SetPoint("BOTTOMRIGHT", window, "BOTTOMRIGHT", -14, -14)
	fill.transform = { w_scale, 0, -20 * w_scale, 0, h_scale, -15 * h_scale }
	window.frame_center:SetShape(Window.rectPath, fill, nil)
	window.frame_center:SetLayer(-10)
end

function Window.CreatePopup(name, parent, width, height, x, y, movable)
	local newWindow = UI.CreateFrame("Frame", name, parent)
	newWindow:SetHeight(height)
	newWindow:SetWidth(width)
	newWindow:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y)
	Window.createPopupBorder(newWindow)

	if movable then
		DraggableFrame.Setup(newWindow, newWindow)
	end

	return newWindow
end

-------------------------------------------------
-- Simple Button with custom images
-------------------------------------------------

local Button = {}

Button.mouseIn = function(self, handle)
	self:SetTexture(self.skin_resource, self.skin_over)
end

Button.mouseOut = function(self, handle)
	if self.is_pressed then
		self:SetTexture(self.skin_resource, self.skin_over)
	else
		self:SetTexture(self.skin_resource, self.skin_normal)
	end
end

Button.mouseDown = function(self, handle)
	self:SetTexture(self.skin_resource, self.skin_pressed)
end

Button.mouseUp = function(self, handle)
	-- self.is_pressed = not self.is_pressed
	self:SetTexture(self.skin_resource, self.skin_over)
end

function Button.SetEnabled(self, enabled)
	if enabled == self.is_enabled then
		return
	end
	if enabled then
		self:SetTexture(self.skin_resource, self.skin_normal)
		self:EventAttach(Event.UI.Input.Mouse.Cursor.In, Button.mouseIn, "Button.MouseIn")
		self:EventAttach(Event.UI.Input.Mouse.Cursor.Out, Button.mouseOut, "Button.MouseOut")
		self:EventAttach(Event.UI.Input.Mouse.Left.Down, Button.mouseDown, "Button.MouseDown")
		self:EventAttach(Event.UI.Input.Mouse.Left.Up, Button.mouseUp, "Button.MouseUp")
		if self.click_callback then
			self:EventAttach(Event.UI.Input.Mouse.Left.Click, self.click_callback, "Button.UserAction")
		end
	else
		self:SetTexture(self.skin_resource, self.skin_disabled)
		self:EventDetach(Event.UI.Input.Mouse.Cursor.In, Button.mouseIn, "Button.MouseIn")
		self:EventDetach(Event.UI.Input.Mouse.Cursor.Out, Button.mouseOut, "Button.MouseOut")
		self:EventDetach(Event.UI.Input.Mouse.Left.Down, Button.mouseDown, "Button.MouseDown")
		self:EventDetach(Event.UI.Input.Mouse.Left.Up, Button.mouseUp, "Button.MouseUp")
		if self.click_callback then
			self:EventDetach(Event.UI.Input.Mouse.Left.Click, self.click_callback, "Button.UserAction")
		end
	end
	self.is_enabled = enabled
end

-- if 'pressed' is nil, it will just toggle, otherwise set it to given state
function Button.Toggle(self, pressed)
	if pressed == nil then state = not self.is_pressed end
	if pressed ~= self.is_pressed then
		self.is_pressed = pressed
		if pressed then
			self:SetTexture(self.skin_resource, self.skin_over)
		else
			self:SetTexture(self.skin_resource, self.skin_normal)
		end
	end
end

function Button.Create(name, parent, click_callback, tex_normal, tex_over, tex_pressed, tex_disabled, resource)
	resource = resource or "Rift"
	local btn = UI.CreateFrame("Texture", name, parent)
	btn.skin_resource = resource
	btn.skin_normal = tex_normal
	btn.skin_over = tex_over
	btn.skin_pressed = tex_pressed
	btn.skin_disabled = tex_disabled
	btn.is_pressed = false
	btn.is_enabled = true
	btn.Toggle = Button.Toggle
	btn.SetEnabled = Button.SetEnabled

	btn:SetTexture(resource, tex_normal)
	btn:EventAttach(Event.UI.Input.Mouse.Cursor.In, Button.mouseIn, "Button.MouseIn")
	btn:EventAttach(Event.UI.Input.Mouse.Cursor.Out, Button.mouseOut, "Button.MouseOut")
	btn:EventAttach(Event.UI.Input.Mouse.Left.Down, Button.mouseDown, "Button.MouseDown")
	btn:EventAttach(Event.UI.Input.Mouse.Left.Up, Button.mouseUp, "Button.MouseUp")
	if click_callback then
		btn.click_callback = click_callback
		btn:EventAttach(Event.UI.Input.Mouse.Left.Click, click_callback, "Button.UserAction")
	end

	return btn
end

-------------------
-- hook into addon
-------------------

Dta.ui.Window = Window
Dta.ui.DraggableFrame = DraggableFrame
Dta.ui.Button = Button
