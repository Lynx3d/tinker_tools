local LINE_HEIGHT = 12.65
local PADDING = 4

local env16 = Inspect.System.Secure ~= nil

-- Helper Functions

local function countLines(text)
  local count = 1
  for n in text:gmatch("[\r\n]") do
    count = count + 1
  end
  return count
end

local function resizeToText(frame, text)
  local lineCount = countLines(text)
  local height = LINE_HEIGHT * lineCount + PADDING*2
  frame:SetHeight(height)
end


-- Hook Functions

local function SetTextHook(self, text)
  self:OldSetText(text)
  resizeToText(self, text)
end


-- Textfield Frame Events

local function KeyUpHandler(self, key)
  local widget = self:GetParent():GetParent()

  -- Handle Enter and Tab
  local text = self:GetText()
  local pos = self:GetCursor()
  local prefix = string.sub(text, 1, pos)
  local suffix = string.sub(text, pos+1)

  if key == "Return" then
    local newText = prefix .."\n".. suffix
    resizeToText(self, newText)
    self:OldSetText(newText)
    if env16 then
      self:SetCursor(pos+1) -- Rift 1.6
    else
      self:SetSelection(pos, pos+1)
    end
    if widget.Event.TextAreaChange then
      widget.Event.TextAreaChange(widget)
    end
  elseif key == "Tab" then
    if env16 then
      local newText = prefix .."\t".. suffix
      resizeToText(self, newText)
      self:OldSetText(newText)
      self:SetCursor(pos+1) -- Rift 1.6
    else
      local newText = prefix .."\t ".. suffix
      resizeToText(self, newText)
      self:OldSetText(newText)
      self:SetSelection(pos+1, pos+2)
    end
    if widget.Event.TextAreaChange then
      widget.Event.TextAreaChange(widget)
    end
  end

  -- calc cursor offset, ensure it's visible
  local text = self:GetText()
  local pos = self:GetCursor()
  local prefix = string.sub(text, 1, pos)
  local cursorLine = countLines(prefix)
  local scroller = self:GetParent()
  local cursorOffset = (cursorLine-1) * LINE_HEIGHT + PADDING
  if cursorOffset < scroller:GetScrollOffset() then
    scroller:ScrollTo(math.max(cursorOffset, 0))
  elseif cursorOffset > scroller:GetScrollOffset() + scroller:GetHeight() - LINE_HEIGHT then
    scroller:ScrollTo(math.min(cursorOffset - scroller:GetHeight() + LINE_HEIGHT + PADDING, scroller:GetMaxOffset()))
  end
end

local function TextfieldChangeHandler(self)
  local scroller = self:GetParent()
  local widget = scroller:GetParent()
  if widget.Event.TextAreaChange then
    widget.Event.TextAreaChange(widget)
  end
  resizeToText(self, self:GetText())
end

local function TextfieldSelectHandler(self)
  local scroller = self:GetParent()
  local widget = scroller:GetParent()
  if widget.Event.TextAreaSelect then
    widget.Event.TextAreaSelect(widget)
  end
end


-- Public Functions

local function SetBorder(self, width, r, g, b, a)
  Library.LibSimpleWidgets.SetBorder(self.scroller, width, r, g, b, a)
end

local function SetBackgroundColor(self, r, g, b, a)
  self.scroller:SetBackgroundColor(r, g, b, a)
end

local function GetText(self)
  return self.textarea:GetText()
end

local function SetText(self, text)
  self.textarea:SetText(text)
end

local function GetCursor(self)
  return self.textarea:GetCursor()
end

local function SetCursor(self, pos)
  self.textarea:SetCursor(pos)
end

local function GetEnabled(self)
  return self.enabled
end

local function SetEnabled(self, enabled)
  assert(type(enabled) == "boolean", "param 1 must be a boolean!")

  self.enabled = enabled
  self.blocker:SetVisible(not enabled)
end

local function GetSelection(self)
  return self.textarea:GetSelection()
end

local function SetSelection(self, selBegin, selEnd)
  self.textarea:SetSelection(selBegin, selEnd)
end

local function GetSelectionText(self)
  self.textarea:GetSelectionText()
end

local function GetKeyFocus(self)
  return self.textarea:GetKeyFocus()
end

local function SetKeyFocus(self, focus)
  self.textarea:SetKeyFocus(focus)
end


-- Constructor Function

function Library.LibSimpleWidgets.TextArea(name, parent)
  local widget = UI.CreateFrame("Frame", name, parent)
  widget.scroller = UI.CreateFrame("SimpleScrollView", name.."ScrollView", widget)
  widget.textarea = UI.CreateFrame("RiftTextfield", name.."TextArea", widget.scroller)
  widget.blocker = UI.CreateFrame("Frame", name.."Blocker", parent)

  widget.scroller:SetAllPoints(widget)
  widget.scroller:SetContent(widget.textarea)

  widget.blocker:SetAllPoints(widget)
  widget.blocker:SetBackgroundColor(0, 0, 0, 0.5)
  widget.blocker:SetLayer(widget:GetLayer()+1)
  widget.blocker:SetVisible(false)

  -- Dummy blocking events
  widget.blocker.Event.LeftDown = function() end
  widget.blocker.Event.LeftUp = function() end
  widget.blocker.Event.LeftClick = function() end
  widget.blocker.Event.WheelForward = function() end
  widget.blocker.Event.WheelBack = function() end

  widget.enabled = true

  -- Install SetText hook on the textarea to handle resizing
  widget.textarea.OldSetText = widget.textarea.SetText
  widget.textarea.SetText = SetTextHook

  widget.textarea.Event.KeyUp = KeyUpHandler
  widget.textarea.Event.TextfieldChange = TextfieldChangeHandler
  widget.textarea.Event.TextfieldSelect = TextfieldSelectHandler

  function widget.scroller.Event.LeftClick()
    widget.textarea:SetKeyFocus(true)
  end

  widget.SetBorder = SetBorder
  widget.SetBackgroundColor = SetBackgroundColor
  widget.GetCursor = GetCursor
  widget.SetCursor = SetCursor
  widget.GetEnabled = GetEnabled
  widget.SetEnabled = SetEnabled
  widget.GetSelection = GetSelection
  widget.SetSelection = SetSelection
  widget.GetSelectionText = GetSelectionText
  widget.GetText = GetText
  widget.SetText = SetText
  widget.GetKeyFocus = GetKeyFocus
  widget.SetKeyFocus = SetKeyFocus

  Library.LibSimpleWidgets.EventProxy(widget, {"TextAreaChange","TextAreaSelect"})

  return widget
end
