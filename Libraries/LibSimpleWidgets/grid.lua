-- Helper Functions

local function MaxCellHeightInRow(row)
  local maxHeight = 0
  for _, cell in ipairs(row) do
    maxHeight = math.max(maxHeight, cell:GetHeight())
  end
  return maxHeight
end

local function MaxColumnWidth(self, index)
  local maxWidth = 0
  for i, row in ipairs(self.rows) do
    local cell = row[index]
    if cell then
      maxWidth = math.max(maxWidth, cell:GetWidth())
    end
  end
  return maxWidth
end

local function LayoutCells(self, rowFrame, row, maxCellHeight)
  local rowWidth = 0
  local cells = {}
  local x = 0
  for i, cell in ipairs(row) do
    if i > 1 then
      x = x + self.padding
    end
    local width = self.columnWidths[i]
    if width == nil then
      width = MaxColumnWidth(self, i)
    end

    local offset = 0
    local justification = self.columnJustification[i]
    if justification == nil or justification == "fit" then
      cell:SetWidth(width)
    elseif justification == "left" then
      -- no adjustment
    elseif justification == "center" then
      offset = (width - cell:GetWidth()) / 2
    elseif justification == "right" then
      offset = width - cell:GetWidth()
    end

    cell:SetPoint("LEFT", rowFrame, "LEFT", x + offset, nil)
    cell:SetPoint("TOP", rowFrame, "TOP")
    cell:SetHeight(maxCellHeight)
    cell:SetVisible(true)
    cell.index = i
    table.insert(cells, cell)
    x = x + width
  end
  rowFrame.cells = cells
  return x
end

-- Public Functions

local function Layout(self)
  -- clear cell widths for auto-fitting
  for _, rowFrame in ipairs(self.rowFrames) do
    for _, cell in ipairs(rowFrame.cells) do
      if cell.ResizeToFit then
        cell:ResizeToFit()
      else
        cell:ClearWidth()
      end
    end
  end

  -- layout rows and cells
  local height = 0
  local width = 0
  local prevRowFrame
  for i, row in ipairs(self.rows) do
    local rowFrame = self.rowFrames[i]
    if not rowFrame then
      rowFrame = UI.CreateFrame("Frame", self:GetName().."Item"..i, self)
      rowFrame:SetBackgroundColor(0, 0, 0, 0)
      rowFrame.index = i
      rowFrame.cells = {}
      self.rowFrames[i] = rowFrame
    end

    if prevRowFrame then
      rowFrame:SetPoint("TOP", prevRowFrame, "BOTTOM", nil, self.padding)
      height = height + self.padding
    else
      rowFrame:SetPoint("TOP", self, "TOP", nil, self.margin)
    end

    rowFrame:SetPoint("LEFT", self, "LEFT", self.margin, nil)
    rowFrame:SetPoint("RIGHT", self, "RIGHT", -self.margin, nil)

    local maxCellHeight = MaxCellHeightInRow(row)
    rowFrame:SetHeight(maxCellHeight)
    rowFrame:SetVisible(true)

    local rowWidth = LayoutCells(self, rowFrame, row, maxCellHeight) + self.margin*2

    width = math.max(width, rowWidth)
    height = height + rowFrame:GetHeight()
    prevRowFrame = rowFrame
  end

  height = height + self.margin*2

  self:SetWidth(width)
  self:SetHeight(height)

  -- clean up leftover row frames and cells
  if #self.rows < #self.rowFrames then
    for i = #self.rows+1, #self.rowFrames do
      local rowFrame = self.rowFrames[i]
      rowFrame:SetVisible(false)
      for j, cell in ipairs(rowFrame.cells) do
        cell:SetVisible(false)
        cell:ClearAll()
      end
      rowFrame.cells = {}
    end
  end
end

local function SetBorder(self, width, r, g, b, a)
  Library.LibSimpleWidgets.SetBorder(self, width, r, g, b, a)
end

local function GetEnabled(self)
  return self.enabled
end

local function SetEnabled(self, enabled)
  assert(type(enabled) == "boolean", "param 1 must be a boolean!")

  self.enabled = enabled

  for _, row in ipairs(self.rows) do
    for _, cell in ipairs(row) do
      if cell.SetEnabled then
        cell:SetEnabled(enabled)
      end
    end
  end
end

local function AddRow(self, row)
  table.insert(self.rows, row)
  self:Layout()
end

local function InsertRow(self, row, index)
  table.insert(self.rows, index, row)
  self:Layout()
end

local function RemoveRow(self, index)
  if type(index) ~= "number" then
    for i, v in ipairs(self.rows) do
      if v == index then
        index = i
        break
      end
    end
    if type(index) ~= "number" then
      error("param 1 must be a number or a row table")
    end
  end

  local removed = table.remove(self.rows, index)
  if removed then
    for _, cell in ipairs(removed) do
      cell:SetVisible(false)
    end
    self:Layout()
  end

  return removed
end

local function GetRows(self)
  return self.rows
end

local function SetRows(self, rows)
  assert(type(rows) == "table", "param 1 must be a table!")

  -- Clean out existing cells and row frames
  for i, rowFrame in ipairs(self.rowFrames) do
    for j, cell in ipairs(rowFrame.cells) do
      cell:SetVisible(false)
      cell:ClearAll()
    end
    rowFrame.cells = {}
  end

  -- Replace rows and redo layout
  self.rows = rows
  self:Layout()
end

local function RemoveAllRows(self)
  self:SetRows({})
end

local function SetColumnWidth(self, index, width)
  self.columnWidths[index] = width
  self:Layout()
end

local function ClearColumnWidth(self, index)
  self.columnWidths[index] = nil
  self:Layout()
end

local function SetColumnJustification(self, index, justification)
  assert(justification == "fit" or justification == "left" or justification == "center" or justification == "right", "param 1 must be one of 'fit', 'left', 'center' or 'right'")
  self.columnJustification[index] = justification
  self:Layout()
end

local function ClearColumnJustification(self, index)
  self.columnJustification[index] = nil
  self:Layout()
end

local function SetCellPadding(self, padding)
  self.padding = padding
  self:Layout()
end

local function SetMargin(self, margin)
  self.margin = margin
  self:Layout()
end

-- Constructor Function

function Library.LibSimpleWidgets.Grid(name, parent)
  local widget = UI.CreateFrame("Mask", name, parent)
  widget:SetBackgroundColor(0, 0, 0, 1)

  widget.enabled = true
  widget.rows = {}
  widget.rowFrames = {}
  widget.columnWidths = {}
  widget.padding = 0
  widget.margin = 0
  widget.columnJustification = {}

  widget.SetBorder = SetBorder
  widget.GetEnabled = GetEnabled
  widget.SetEnabled = SetEnabled
  widget.Layout = Layout
  widget.AddRow = AddRow
  widget.InsertRow = InsertRow
  widget.RemoveRow = RemoveRow
  widget.GetRows = GetRows
  widget.SetRows = SetRows
  widget.RemoveAllRows = RemoveAllRows
  widget.SetColumnWidth = SetColumnWidth
  widget.ClearColumnWidth = ClearColumnWidth
  widget.SetColumnJustification = SetColumnJustification
  widget.ClearColumnJustification = ClearColumnJustification
  widget.SetCellPadding = SetCellPadding
  widget.SetMargin = SetMargin

  return widget
end
