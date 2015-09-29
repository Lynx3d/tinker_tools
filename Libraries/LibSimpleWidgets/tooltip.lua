local PADDING = 10 -- tooltip border width
local MAX_WIDTH = 250
local MAX_HEIGHT = 500
local MOUSE_X_OFFSET = 15
local MOUSE_Y_OFFSET = 20

-- Helper Functions

local function ResizeToFit(self)
  self.text:ClearAll()
  local w = math.min(MAX_WIDTH, self.text:GetWidth())
  self.text:SetWidth(w)
  local h = math.min(MAX_HEIGHT, self.text:GetHeight())
  self.text:ClearWidth()
  self.text:SetPoint("TOPLEFT", self, "TOPLEFT", PADDING, PADDING)
  self.text:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -PADDING, -PADDING)
  self:SetWidth(w + PADDING * 2)
  self:SetHeight(h + PADDING * 2)
end

-- Public Functions

local function GetFontSize(self)
  return self.text:GetFontSize()
end

local function SetFontSize(self, size)
  assert(type(size) == "number", "param 1 must be a number!")

  self.text:SetFontSize(size)
  ResizeToFit(self)
end

local function GetFontColor(self)
  return self.text:GetFontColor()
end

local function SetFontColor(self, r, g, b, a)
  self.text:SetFontColor(r, g, b, a)
end

local INVERSE_ANCHORS = {
  TOPLEFT = "BOTTOMRIGHT",
  TOPRIGHT = "BOTTOMLEFT",
  BOTTOMLEFT = "TOPRIGHT",
  BOTTOMRIGHT = "TOPLEFT",
  TOPCENTER = "BOTTOMCENTER",
  BOTTOMCENTER = "TOPCENTER",
  CENTERLEFT = "CENTERRIGHT",
  CENTERRIGHT = "CENTERLEFT",
}

local function Show(self, owner, text, anchor, xoffset, yoffset)
  assert(type(owner) == "table", "param 1 must be a frame!")
  assert(type(text) == "string", "param 2 must be a string!")
  assert(anchor == nil or type(anchor) == "string", "param 3 must be a string!")
  assert(xoffset == nil or type(xoffset) == "number", "param 4 must be a number!")
  assert(yoffset == nil or type(yoffset) == "number", "param 5 must be a number!")

  anchor = anchor or "MOUSE"
  xoffset = 0
  yoffset = 0

  self.owner = owner
  self.text:SetText(text)
  self:ClearAll()
  ResizeToFit(self)

  if anchor == "MOUSE" then
    local m = Inspect.Mouse()
    --  bottom right location by default
    local selfAnchor = "TOPLEFT"
    local targetAnchor = "TOPLEFT"
    local x = m.x + MOUSE_X_OFFSET
    local y = m.y + MOUSE_Y_OFFSET
    local _, _, screenWidth, screenHeight = UIParent:GetBounds()
    -- flip to the left if it goes past the right edge of the screen
    if x + self:GetWidth() > screenWidth then
      x = m.x
      selfAnchor = string.gsub(selfAnchor, "LEFT", "RIGHT")
    end
    -- flip upwards if it goes past the bottom edge of the screen
    if y + self:GetHeight() > screenHeight then
      y = m.y
      selfAnchor = string.gsub(selfAnchor, "TOP", "BOTTOM")
    end
    self:SetPoint(selfAnchor, UIParent, targetAnchor, x, y)
  else
    local ttAnchor = INVERSE_ANCHORS[anchor]
    if not ttAnchor then
        print("LSW: Unsupported anchor point for tooltip: " .. anchor)
      ttAnchor = "TOPLEFT"
      anchor = "BOTTOMRIGHT"
    end
    self:SetPoint(ttAnchor, owner, anchor, xoffset, yoffset)
  end

  self:SetVisible(true)
end

local function Hide(self, owner)
  if self.owner ~= owner then return end
  self:SetVisible(false)
  self.owner = nil
end

local function InjectEvents(self, frame, tooltipTextFunc, anchor, xoffset, yoffset)
  assert(type(frame) == "table", "param 1 must be a frame!")
  assert(type(tooltipTextFunc) == "function", "param 2 must be a function!")
  assert(anchor == nil or type(anchor) == "string", "param 3 must be a string!")
  assert(xoffset == nil or type(xoffset) == "number", "param 4 must be a number!")
  assert(yoffset == nil or type(yoffset) == "number", "param 5 must be a number!")

  -- Can't use self inside the event functions since it will then refer to the frame, not our tooltip.
  local tooltip = self
  local oldMouseIn = frame.Event.MouseIn
  local oldMouseMove = frame.Event.MouseMove
  local oldMouseOut = frame.Event.MouseOut
  frame.Event.MouseIn = function(self)
    tooltip:Show(self, tooltipTextFunc(tooltip), anchor, xoffset, yoffset)
    if oldMouseIn then oldMouseIn(self) end
  end
  frame.Event.MouseMove = function(self, x, y)
    tooltip:Show(self, tooltipTextFunc(tooltip), anchor, xoffset, yoffset)
    if oldMouseMove then oldMouseMove(self, x, y) end
  end
  frame.Event.MouseOut = function(self)
    tooltip:Hide(self)
    if oldMouseOut then oldMouseOut(self) end
  end
  frame.LSW_Tooltip_OldMouseIn = oldMouseIn
  frame.LSW_Tooltip_OldMouseMove = oldMouseMove
  frame.LSW_Tooltip_OldMouseOut = oldMouseOut
end

local function RemoveEvents(self, frame)
  assert(type(frame) == "table", "param 1 must be a frame!")

  frame.Event.MouseIn = frame.LSW_Tooltip_OldMouseIn
  frame.Event.MouseMove = frame.LSW_Tooltip_OldMouseMove
  frame.Event.MouseOut = frame.LSW_Tooltip_OldMouseOut
  
  frame.LSW_Tooltip_OldMouseIn = nil
  frame.LSW_Tooltip_OldMouseMove = nil
  frame.LSW_Tooltip_OldMouseOut = nil
end


-- Constructor Function

function Library.LibSimpleWidgets.Tooltip(name, parent)
  local widget = UI.CreateFrame("Frame", name, parent)
  widget.text = UI.CreateFrame("Text", name .. "Text", widget)

  widget.text:SetBackgroundColor(0, 0, 0, 1)
  widget:SetLayer(999)
  Library.LibSimpleWidgets.SetBorder("tooltip", widget)
  widget.__lsw_border:SetPosition("inside")
  widget:SetVisible(false)

  widget.text:SetWordwrap(true)
  ResizeToFit(widget)

  widget.GetFontSize = GetFontSize
  widget.SetFontSize = SetFontSize
  widget.GetFontColor = GetFontColor
  widget.SetFontColor = SetFontColor
  widget.Show = Show
  widget.Hide = Hide
  widget.InjectEvents = InjectEvents
  widget.RemoveEvents = RemoveEvents

  return widget
end
