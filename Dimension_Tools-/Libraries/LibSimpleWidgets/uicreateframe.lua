local frameConstructors = {
  SimpleCheckbox    = Library.LibSimpleWidgets.Checkbox,
  SimpleGrid        = Library.LibSimpleWidgets.Grid,
  SimpleList        = Library.LibSimpleWidgets.List,
  SimpleRadioButton = Library.LibSimpleWidgets.RadioButton,
  SimpleScrollList  = Library.LibSimpleWidgets.ScrollList,
  SimpleScrollView  = Library.LibSimpleWidgets.ScrollView,
  SimpleSelect      = Library.LibSimpleWidgets.Select,
  SimpleSlider      = Library.LibSimpleWidgets.Slider,
  SimpleTabView     = Library.LibSimpleWidgets.TabView,
  SimpleTextArea    = Library.LibSimpleWidgets.TextArea,
  SimpleTooltip     = Library.LibSimpleWidgets.Tooltip,
  SimpleWindow      = Library.LibSimpleWidgets.Window,
}

local oldUICreateFrame = UI.CreateFrame
UI.CreateFrame = function(frameType, name, parent)
  assert(type(frameType) == "string", "param 1 must be a string!")
  assert(type(name) == "string", "param 2 must be a string!")
  assert(type(parent) == "table", "param 3 must be a valid frame parent!")

  local constructor = frameConstructors[frameType]
  if constructor then
    return constructor(name, parent)
  else
    return oldUICreateFrame(frameType, name, parent)
  end
end
