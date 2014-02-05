-- Helper Functions

local function resizeCurrentForRange(current, max)
  local oldCurrent = current:GetText()
  current:SetText(tostring(max))
  current:ClearWidth()
  current:SetWidth(current:GetWidth())
  current:SetText(oldCurrent)
end


-- Public Functions

local function SetBorder(self, width, r, g, b, a)
  Library.LibSimpleWidgets.SetBorder(self.current, width, r, g, b, a)
  Library.LibSimpleWidgets.SetBorder(self.editor, width, r, g, b, a)
  Library.LibSimpleWidgets.SetBorder(self.dropdown, width, r, g, b, a)
end

local function SetBackgroundColor(self, r, g, b, a)
  self.current:SetBackgroundColor(r, g, b, a)
  self.slider:SetBackgroundColor(r, g, b, a)
end

local function GetEnabled(self)
  return self.enabled
end

local function SetEnabled(self, enabled)
  assert(type(enabled) == "boolean", "param 1 must be a boolean!")

  self.enabled = enabled
  if enabled then
    self.current:SetFontColor(1, 1, 1, 1)
  else
    self.current:SetFontColor(0.5, 0.5, 0.5, 1)
  end
  if self.editor then
    self.editor:SetVisible(enabled)
    self.current:SetVisible(not enabled)
  end
  self.slider:SetEnabled(enabled)
end

local function GetRange(self)
  return self.slider:GetRange()
end

local function SetRange(self, min, max, silent)
  assert(type(min) == "number", "param 1 must be a number!")
  assert(type(max) == "number", "param 2 must be a number!")
  assert(min <= max, "min must be less than or equal to max!")
  assert(silent == nil or type(silent) == "boolean", "param 3 must be a boolean!")

  self.silent = silent ~= nil and silent
  self.slider:SetRange(min, max)
  self.silent = false
  resizeCurrentForRange(self.current, max)
end

local function GetPosition(self)
  return self.slider:GetPosition()
end

local function SetPosition(self, position, silent)
  assert(type(position) == "number", "param 1 must be a number!")
  local min, max = self.slider:GetRange()
  assert(position >= min, "position must be greater than or equal to range minimum")
  assert(position <= max, "position must be less than or equal to range minimum")
  assert(silent == nil or type(silent) == "boolean", "param 2 must be a boolean!")

  self.silent = silent ~= nil and silent
  self.slider:SetPosition(position)
  self.silent = false
  self.current:SetText(tostring(position))
  if self.editor then
    self.editor:SetText(tostring(position))
  end
end

local function ResizeToFit(self)
  self.slider:ClearAll()
  self.current:ClearAll()
  local min, max = self.slider:GetRange()
  resizeCurrentForRange(self.current, max)
  self:SetWidth(self.slider:GetWidth() + self.current:GetWidth())
  self:SetHeight(self.slider:GetHeight() - 2) -- magic numbers!
  self.current:SetPoint("TOPRIGHT", self, "TOPRIGHT")
  self.current:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")
  self.slider:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 6)
  self.slider:SetPoint("BOTTOMRIGHT", self.current, "BOTTOMLEFT", -10, 0)
end

local function GetEditable(self)
  return self.editor and self.editor:GetVisible()
end

local function SetEditable(self, editable)
  assert(type(editable) == "boolean", "param 1 must be a boolean!")

  if editable then
    if not self.editor then
      self.editor = UI.CreateFrame("RiftTextfield", self:GetName().."Editor", self)
      self.editor:SetBackgroundColor(0.2, 0.2, 0.2, 1)
      Library.LibSimpleWidgets.SetBorder(self.editor, 1, 0.5, 0.5, 0.5, 1)
      self.editor:SetAllPoints(self.current)
      self.editor.Event.KeyUp = function(editor, key)
        local code = string.byte(key)
        if not code then return end
        code = tonumber(code)
        if code == 13 then
          local pos = tonumber(self.editor:GetText())
          local min, max = self.slider:GetRange()
          if pos ~= nil and pos >= min and pos <= max then
            self.slider:SetPosition(pos)
            self.current:SetText(tostring(pos))
          else
            self.editor:SetText(tostring(self.slider:GetPosition()))
          end
          self.editor:SetKeyFocus(false)
        end
      end
      self.editor.Event.KeyFocusLoss = function()
        self.editor:SetText(tostring(self.slider:GetPosition()))
      end
    end
    self.editor:SetText(tostring(self.slider:GetPosition()))
    self.current:SetVisible(false)
    self.editor:SetVisible(true)
  else
    if self.editor then
      self.editor:SetVisible(false)
      self.current:SetVisible(true)
    end
  end
end


-- Constructor Function

function Library.LibSimpleWidgets.Slider(name, parent)
  local widget = UI.CreateFrame("Frame", name, parent)
  widget.slider = UI.CreateFrame("RiftSlider", widget:GetName().."Slider", widget)
  widget.current = UI.CreateFrame("Text", widget:GetName().."Current", widget)

  widget.enabled = true

  widget.current:SetText(tostring(widget.slider:GetPosition()))

  widget.current:SetBackgroundColor(0, 0, 0, 1)
  Library.LibSimpleWidgets.SetBorder(widget.current, 1, 0.5, 0.5, 0.5, 1)

  ResizeToFit(widget)

  function widget.slider.Event:SliderChange()
    local pos = tostring(widget.slider:GetPosition())
    widget.current:SetText(pos)
    if widget.editor then
      widget.editor:SetText(pos)
    end
    if not widget.silent and widget.Event.SliderChange then
      widget.Event.SliderChange(widget)
    end
  end

  function widget.slider.Event:SliderGrab()
    if widget.Event.SliderGrab then
      widget.Event.SliderGrab(widget)
    end
  end

  function widget.slider.Event:SliderRelease()
    if widget.Event.SliderRelease then
      widget.Event.SliderRelease(widget)
    end
  end

  widget.SetBorder = SetBorder
  widget.SetBackgroundColor = SetBackgroundColor
  widget.GetEnabled = GetEnabled
  widget.SetEnabled = SetEnabled
  widget.GetRange = GetRange
  widget.SetRange = SetRange
  widget.GetPosition = GetPosition
  widget.SetPosition = SetPosition
  widget.ResizeToFit = ResizeToFit
  widget.GetEditable = GetEditable
  widget.SetEditable = SetEditable

  Library.LibSimpleWidgets.EventProxy(widget, {"SliderChange","SliderGrab","SliderRelease"})

  return widget
end
