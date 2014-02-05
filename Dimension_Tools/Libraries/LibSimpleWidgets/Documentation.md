LibSimpleWidgets is a library which provides a set of simple widgets not provided by the official Rift API. It integrates into the UI.CreateFrame function, adding several new frame types:

* SimpleCheckbox (checkbox with a label)
* SimpleGrid (grid of widgets)
* SimpleList (list of selectable strings)
* SimpleRadioButton (radio button with a label)
* SimpleScrollView (wraps any fixed-height frame)
* SimpleSelect (dropdown list)
* SimpleSlider (slider with the current value displayed next to it)
* SimpleTabView (tabbed frames)
* SimpleTextArea (multi-line textfield in scrollview)
* SimpleTooltip (mouseover popup frame with text)
* SimpleWindow (draggable RiftWindow)

The new frame types inherit all of Frame's functions and add a few more functions specific to each widget.

SimpleRadioButton has a companion function called RadioButtonGroup, which returns a controller object that manages a group of radio buttons to ensure that only one is selected at a time and to generate an event when the selected radio button changes.

The Layout function, given a table describing a widget layout, will create frames and lay them out accordingly. If you've ever used AceConfig and AceGUI, then you'll find this familiar. You can call Layout with the same parent frame and config table to refresh the widgets without creating new frames. You can find more details near the bottom of this document after the Frame Types.

The SetBorder function adds a border to any frame. There are three types of border: plain, rounded and tooltip. Widgets have a SetBorder function which is equivalent to the plain border style. You can find more details near the bottom of this document after the Frame Types.


Frame Type: SimpleCheckbox
==========================

SimpleCheckbox displays a checkbox with a label. It supports the following functions from RiftCheckbox: GetChecked, SetChecked, GetEnabled, SetEnabled. It also supports the following events from RiftCheckbox: CheckboxChange.

Functions
---------

**SetBorder(width, r, g, b, a)**  
Sets a solid border of a specific width and color.

**GetFontSize(size)**  
Gets the font size.

**SetFontSize(size)**  
Sets the font size. Automatically resizes the frame.

**GetText()**  
Returns the text of the label.

**SetText(text)**  
Sets the text for the label.

**SetLabelPos(pos)**  
Sets the position of the label, relative to the checkbox. This can be: "left" or "right".

**ResizeToFit()**  
Resizes the frame to fit the label.


Frame Type: SimpleGrid
======================

SimpleGrid displays a grid of widgets laid out in rows and columns. It supports the following standard functions: GetEnabled, SetEnabled.

The grid has configurable padding between cells and a margin around the edge. Each row's height is determined by the widget with the largest height in that row, with other widgets having their height increased to fit. Each column's width is determined by the widget with the largest width in that column. Specific columns can have their width overridden. By default, cell width is automatically fitted to the column width but columns can be set to center, left or right justification instead, in which case the widget's natural width (as determined by ClearWidth())  is used and the widget is shifted to the center, left or right of the column.

It's recommended that you use widgets with similar heights across all columns and rows, to avoid the grid looking "uneven".

Functions
---------

**SetBorder(width, r, g, b, a)**  
Sets a solid border of a specific width and color.

**Layout()**  
Recalculates the layout of the grid, taking into account new cell widths and heights.

**AddRow(row)**  
Adds a row to the bottom of the grid. *row* must be an indexed table of Rift Frames or widgets from this library.

**InsertRow(row, index)**  
Inserts a row at *index*. The row currently at *index* and all the rows below that are shifted down.

**RemoveRow(index)**  
Removes the row at *index*. Rows below that are shifted up. *index* may also be the exact same row table object used to originally add the row to the grid.

**GetRows()**  
Returns a table of all the rows in the grid.

**SetRows(rows)**  
Sets all the rows in the grid, replacing any existing rows. *rows* must be an indexed table of row tables, as described in *AddRow*.

**RemoveAllRows()**  
Removes all the rows from the grid.

**SetColumnWidth(index, width)**  
Sets the width of the column at *index*.

**ClearColumnWidth(index)**  
Clears a previously set width for the column at *index*. The column width is automatically calculated as described in the introduction.

**SetColumnJustification(index, justification)**  
Sets the justification of the column at *index*. *justification* may be one of "fit", "left", "right" or "center". "fit" means the default behaviour of resizing the widget's width to fit the column width. All other settings use the the widget's natural width. "left" pushes it against the left edge of the column. "right" pushes it against the right edge of the column. "center" positions the widget in the center of the column.

**ClearColumnJustification(index)**  
Clears a previously set justification for the column at *index*. The default behaviour of "fit" is restored for cells in that column.

**SetCellPadding(padding)**  
Sets the width in pixels of the gap between cells. By default this is 0.

**SetMargin(margin)**  
Sets the width in pixels of the gap between the cells and the edge of the SimpleGrid frame. By default this is 0.


Frame Type: SimpleList
======================

SimpleList displays a list of strings in a frame. It automatically adjusts its height to show all the items, so it is best combined with ScrollView. It supports the following standard functions: GetEnabled, SetEnabled.

In addition to the list of string items, you can also provide a corresponding list of values (any kind of object) which are associated by index with the displayed items.

You can also provide a corresponding list of levels for each item. Levels start at 1 and determine how far the item is indented, it's font size and color, background color and whether items of that level are selectable by the user. If a particular setting has not been set (i.e. nil) for a specific level, the defaults are used.

The height of the frame is automatically set when SetItems is called.

SimpleList can operate in either single- or multi-select mode. The selection mode can be switched by calling SetSelectionMode(mode) with mode being either "single" or "multi". Single-select mode allows only a single item to be selected. Multi-select mode allows multiple items to be selected at the same time.

Functions
---------

**SetBorder(width, r, g, b, a)**  
Sets a solid border of a specific width and color.

**SetBackgroundColor(r, g, b, a)**  
Sets the background color of the widget.

**GetFontSize(size)**  
Gets the font size.

**SetFontSize(size)**  
Sets the font size. Automatically adjusts the height of the frame.

**GetEnabled()**  
Returns the enabled state of the widget.

**SetEnabled(enabled)**  
Sets the enabled state of the widget. A disabled widget does not react to user input.

**SetLevelIndentSize(size)**  
Sets the number of pixels an item is indented for each level.

**SetLevelFontSize(level, size)**  
Sets the font size for items of a specific level.

**SetLevelFontColor(level, r, g, b)**  
Sets the font color for items of a specific level.

**SetLevelBackgroundColor(level, r, g, b, a)**  
Sets the background color for items of a specific level.

**SetLevelSelectable(level, selectable)**  
Sets whether items of a specific level can be selected by the user.

**GetItems()**  
Returns the list of items set by SetItems.

**SetItems(items, values, levels)**  
Sets the list of items (table of strings) to be displayed , the optional list of values (table of objects) and optional list of levels which are associated by index with the items. Automatically adjusts the height of the frame. Clears the current selection. Does not trigger the ItemSelect or SelectionChange events.

**GetValues()**  
Returns the list of values set by SetItems. If none was set, returns an empty table.

**SetSelectionMode(mode)**  
Sets the selection mode. Valid modes are "single" or "multi".

**GetSelectedIndex()**  
Returns the index of the selected item. First item is index 1. Only works in single-select mode.

**SetSelectedIndex(index, silent)**  
Sets the selected item by index as if the user clicked it. Triggers the ItemSelect and SelectionChange events. First item is index 1. Passing nil will clear the selection, which will also trigger the ItemSelect event. Re-selecting the same item will **not** trigger an ItemSelect event. Only works in single-select mode. Passing true for the optional silent parameter will suppress the ItemSelect and SelectionChange events.

**GetSelectedItem()**  
Returns the string item that the user has selected. Only works in single-select mode.

**SetSelectedItem(item, silent])**  
Sets the selected item as if the user clicked it. Only works in single-select mode. Triggers the ItemSelect and SelectionChange events. If there is more than one occurrence of the item string in the list, the first one is selected. Passing nil will clear the selection, which will also trigger the ItemSelect event. Re-selecting the same item will **not** trigger an ItemSelect event. Passing true for the optional silent parameter will suppress the ItemSelect and SelectionChange events.

**GetSelectedValue()**  
Returns the value corresponding to the item that the user has selected. Only works in single-select mode.

**SetSelectedValue(item, silent)**  
Sets the selected item associated with the value as if the user clicked it. Only works in single-select mode. Triggers the ItemSelect and SelectionChange events. If there is more than one occurrence of the value in the list, the first one is selected. Passing nil will clear the selection, which will also trigger the ItemSelect event. Re-selecting the same item will **not** trigger an ItemSelect event. Passing true for the optional silent parameter will suppress the ItemSelect and SelectionChange events.

**AddSelectedIndex(index, silent)**  
Sets a particular item to be selected. Only works in multi-select mode. First item is index 1. Does not affect the selection state of other items in the list. Triggers SelectionChange event. Passing true for the optional silent parameter will suppress the SelectionChange event.

**RemoveSelectedIndex(index, silent)**  
Sets a particular item to be not selected. Only works in multi-select mode. First item is index 1. Does not affect the selection state of other items in the list. Triggers SelectionChange event. Passing true for the optional silent parameter will suppress the SelectionChange event.

**GetSelection()**  
Returns an indexed table of the currently selected item(s). Works in both selection modes. Each entry in the table is another table containing three keyed values: index, item & value. For example: { { index=1, item="Item #1", value=123 }, { index=3, item="Item #3", value=789 } }

**ClearSelection(silent)**  
Clears the current selection. Works in both selection modes. Triggers SelectionChange event. Passing true for the optional silent parameter will suppress the SelectionChange event.

**GetSelectedIndices()**  
Returns an indexed table of the currently selected indices. Works in both selection modes.

**SetSelectedIndices(indices, silent)**  
Sets particular items to be selected. Only works in multi-select mode. First item is index 1. Replaces existing selection. Triggers SelectionChange event. Passing nil will clear the selection, which will also trigger the SelectionChange event. Passing true for the optional silent parameter will suppress the SelectionChange event.

**GetSelectedItems()**  
Returns an indexed table of the currently selected items. Works in both selection modes.

**SetSelectedItems(items, silent)**  
Sets particular items to be selected. Only works in multi-select mode. Replaces existing selection. Triggers SelectionChange event. If there is more than one occurrence of the item in the list, all are selected. Passing nil will clear the selection, which will also trigger the SelectionChange event. Passing true for the optional silent parameter will suppress the SelectionChange event.

**GetSelectedValues()**  
Returns an indexed table of the currently selected values. Works in both selection modes.

**SetSelectedValues(values, silent)**  
Sets particular items to be selected. Only works in multi-select mode. Replaces existing selection. Triggers SelectionChange event. If there is more than one occurrence of the value in the list, all are selected. Passing nil will clear the selection, which will also trigger the SelectionChange event. Passing true for the optional silent parameter will suppress the SelectionChange event.

Events
------

**ItemClick(item, value, index)**  
Event is triggered by the user clicking an item in the list. If no value list was given to SetItems, value will be nil. It will always be fired regardless of the current selection.

**ItemSelect(item, value, index)**  
Event is triggered in single-select mode by the user clicking an item in the list or by calling SetSelectedIndex, SetSelectedItem or SetSelectedValue functions. If no value list was given to SetItems, value will be nil. If the selection has been cleared by calling one of the SetSelected* functions with nil, then item, value and index will all be nil. Re-selecting the same item will **not** trigger an ItemSelect event.

**SelectionChange()**  
Event is triggered in both single- and multi-select mode by the user clicking an item in the list to change it's selection state, or by calling ClearSelection, AddSelectedIndex, RemoveSelectedIndex, SetSelectedIndex, SetSelectedItem, SetSelectedValue, SetSelectedIndices, SetSelectedItems or SetSelectedValues functions.



Frame Type: SimpleRadioButton
=============================

SimpleRadioButton draws a radio button with a label. It is best used with the RadioButtonGroup controller object to ensure that only one radio button in a group is selected.

It has the same functions as SimpleCheckbox except GetChecked, SetChecked.

Functions
---------

**GetSelected()**
Returns whether this radio button is selected.

**SetSelected(selected, silent)**  
Sets whether this radio button is selected. If this radio button belongs to a radio button group, the previously selected radio button is deselected. Triggers the RadioButtonSelect event if this radio button was not previously selected. Passing true for the optional silent parameter will suppress the RadioButtonSelect event.

**ResizeToFit()**  
Resizes the frame to fit the label.

Events
------

**RadioButtonSelect()**
Triggered when this radio button is selected either by the user or by calling SetSelected(true).



Frame Type: SimpleScrollView
============================

SimpleScrollView wraps a frame of fixed-height in a viewport with a scrollbar and mousewheel support. It supports the following standard functions: GetEnabled, SetEnabled.

Functions
---------

**SetBorder(width, r, g, b, a)**  
Sets a solid border of a specific width and color.

**SetBackgroundColor(r, g, b, a)**  
Sets the background color of the widget.

**SetContent(contentFrame)**  
Sets the frame that will displayed as the content of the scrollview. The frame must have no points set and must have a fixed height. The frame will have its width resized to match the scrollview.

**GetScrollInterval()**  
Returns the number of pixels scrolled by the mousewheel.

**SetScrollInterval(interval)**  
Sets the number of pixels scrolled by the mousewheel.

**GetShowScrollbar()**  
Returns whether the scrollbar is displayed.

**SetShowScrollbar(show)**  
Sets whether the scrollbar is displayed.

**GetScrollbarColor**  
Returns the color of the scrollbar: r, g, b, a.

**SetScrollbarColor(r, g, b, a)**  
Sets the color of the scrollbar.

**GetScrollbarWidth()**  
Returns the width of the scrollbar.

**SetScrollbarWidth(width)**  
Sets the width of the scrollbar.



Frame Type: SimpleSelect
========================

SimpleSelect displays a dropdown selection list of strings. It supports the following standard functions: GetEnabled, SetEnabled.

The dropdown is automatically resized to fit the number of items, up to a configured maximum height, beyond which it will instead display a scrollbar. The default maximum height for the dropdown is the equivalent of 10 items at the default font size. 

For the best look, it is recommended that you don't set the border on this widget, since it has a preset border.

Functions
---------

**SetBorder(width, r, g, b, a)**  
Sets a solid border of a specific width and color. This affects both the frame displaying the currently selected item and the dropdown frame.

**SetBackgroundColor(r, g, b, a)**  
Sets the background color of the widget.

**GetFontSize(size)**  
Gets the font size.

**SetFontSize(size)**  
Sets the font size. Automatically adjusts the height the dropdown.

**GetShowArrow()**  
Gets whether the down arrow button is shown.

**SetShowArrow(showArrow)**  
Sets whether the down arrow button is shown.

**GetMaxDropdownHeight()**  
Gets the maximum height to which the dropdown will expand in order to accommodate the list of items before the scrollbar becomes visible.

**SetMaxDropdownHeight(height)**  
Sets the maximum height to which the dropdown will expand in order to accommodate the list of items before the scrollbar becomes visible.

**GetItems()**  
Returns the list of items set by SetItems.

**SetItems(items, values)**  
Sets the list of items (table of strings) to be displayed and the optional list of values (table of objects) which are associated by index with the items. Automatically adjusts the height the dropdown. Clears the current selection.

**ResizeToDefault() -- DEPRECATED -- Use ResizeToFit instead.**  
Resizes the frame to fit the current text and items.

**ResizeToFit()**  
Resizes the frame to fit the current text and items.

**GetValues()**  
Returns the list of values set by SetItems. If none was set, returns an empty table.

**GetSelectedIndex()**  
Returns the index of the selected item. First item is index 1.

**SetSelectedIndex(index, silent)**  
Sets the selected item by index as if the user clicked it. Triggers the ItemSelect event (see below). First item is index 1. Passing nil will clear the selection, which will also trigger the ItemSelect event. Re-selecting the same item will **not** trigger an ItemSelect event. Passing true for the optional silent parameter will suppress the ItemSelect event.

**GetSelectedItem()**  
Returns the string item that the user has selected.

**SetSelectedItem(item, silent)**  
Sets the selected item as if the user clicked it. Triggers the ItemSelect event (see below). If there is more than one occurrence of the item string in the list, the first one is selected. Passing nil will clear the selection, which will also trigger the ItemSelect event. Re-selecting the same item will **not** trigger an ItemSelect event. Passing true for the optional silent parameter will suppress the ItemSelect event.

**GetSelectedValue()**  
Returns the value corresponding to the item that the user has selected.

**SetSelectedValue(value, silent)**  
Sets the selected item associated with the value as if the user clicked it. Triggers the ItemSelect event (see below). If there is more than one occurrence of the value in the list, the first one is selected. Passing nil will clear the selection, which will also trigger the ItemSelect event. Re-selecting the same item will **not** trigger an ItemSelect event. Passing true for the optional silent parameter will suppress the ItemSelect event.

Events
------

**ItemSelect(item, value, index)**  
Event is triggered by the user clicking an item in the dropdown or by calling SetSelectedIndex, SetSelectedItem or SetSelectedValue functions. If no value list was given to SetItems, value will be nil. If the selection has been cleared by calling one of the SetSelected* functions with nil, then item, value and index will all be nil. Re-selecting the same item will **not** trigger an ItemSelect event.



Frame Type: SimpleSlider
========================

SimpleSlider is a RiftSlider with a textbox displaying the position of the slider to the right of the slider. It supports the following functions from RiftSlider: GetEnabled, SetEnabled, GetPosition, SetPosition, GetRange, SetRange. It also supports the following events from RiftSlider: SliderChange, SliderGrab, SliderRelease.

Functions
---------

**SetEditable(editable)**  
Sets whether the numerical display of the slider position is editable by the user as a textfield. The SliderChange event will only be triggered by pressing Enter when editing. Any other loss of key focus will revert the textfield to the original slider position.

**SetPosition(position, silent)**  
Changes the current position of the scrollbar. The new position must be within the current range. Passing true for the optional silent parameter will suppress the SliderChange event.

**ResizeToFit()**  
Resizes the frame to fit the slider and max range number view.



Frame Type: SimpleTabView
=========================

SimpleTabView is a container for a stack of frames with tabs for selecting which frame is visible. It is styled on the Rift tabs like you see in the Social window.

Functions
---------

**AddTab(label, frame)**  
Adds a tab with the given label that will display the given frame when selected.

**RemoveTab(index)**  
Removes the tab at the given index.

**GetActiveTab()**  
Returns the index of the active tab. Index starts at 1.

**SetActiveTab(index)**  
Sets the tab that is currently active and thus displaying its frame. Index starts at 1.

**SetTabLabel(index, label)**  
Sets the label for a tab. Index starts at 1.

**SetTabContent(index, frame)**  
Sets the frame displayed for a tab. Index starts at 1.

**SetTabPosition(position)**  
Sets the position of the tabs. Valid positions are "top", "bottom", "left" and "right". Default is "bottom".

**GetFontSize()**  
Gets the font size for tabs.

**SetFontSize(size)**  
Sets the font size for tabs.

**GetInactiveFontColor()**  
Gets the font color for inactive tabs. Returns red, green. blue, alpha.

**SetInactiveFontColor(r, g, b, a)**  
Sets the font color for inactive tabs.

**GetActiveFontColor()**  
Gets the font color for active tabs. Returns red, green. blue, alpha.

**SetActiveFontColor(r, g, b, a)**  
Sets the font color for active tabs.

**GetHighlightFontColor()**  
Gets the font color for highlighted tabs. Returns red, green. blue, alpha.

**SetHighlightFontColor(r, g, b, a)**  
Sets the font color for highlighted tabs.

**GetTabContentBackgroundColor()**  
Gets the background color for the tab contents. Returns red, green. blue, alpha.

**SetTabContentBackgroundColor(r, g, b, a)**  
Sets the background color for the tab contents.

**GetTabContentBorderColor()**  
Gets the border color for the tab contents. Returns red, green. blue, alpha.

**SetTabContentBorderColor(r, g, b, a)**  
Sets the border color for the tab contents.

**GetActiveTabBackgroundColor()**  
Gets the background color for the active tab. Returns red, green. blue, alpha.

**SetActiveTabBackgroundColor(r, g, b, a)**  
Sets the background color for the active tab.

**GetActiveTabBorderColor()**  
Gets the border color for the active tab. Returns red, green. blue, alpha.

**SetActiveTabBorderColor(r, g, b, a)**  
Sets the border color for the active tab.

**GetInactiveTabBackgroundColor()**  
Gets the background color for inactive tabs. Returns red, green. blue, alpha.

**SetInactiveTabBackgroundColor(r, g, b, a)**  
Sets the background color for inactive tabs.

**GetInactiveTabBorderColor()**  
Gets the border color for inactive tabs. Returns red, green. blue, alpha.

**SetInactiveTabBorderColor(r, g, b, a)**  
Sets the border color for inactive tabs.


Events
------

**TabSelect(index)**  
Triggered when a tab is selected either by the user or through SetActiveTab. Will not be triggered if the tab is already active. Index starts at 1.


Frame Type: SimpleTextArea
==========================

SimpleTextArea is a multi-line RiftTextfield wrapped in a SimpleScrollView. Enter and Tab are handled appropriately. As the cursor moves off the top and bottom edges, it will scroll to keep the cursor visible.

It supports the following RiftTextfield functions: GetCursor, GetSelection, GetSelectionText, GetText, SetCursor, SetSelection, SetText, GetEnabled, SetEnabled, GetKeyFocus, SetKeyFocus.

Functions
---------

**SetBorder(width, r, g, b, a)**  
Sets a solid border of a specific width and color.

**SetBackgroundColor(r, g, b, a)**  
Sets the background color of the widget.

Events
------

**TextAreaChange(item)**  
Triggered by the text changing.

**TextAreaSelect(item)**  
Triggered by the text selection changing.



Frame Type: SimpleTooltip
=========================

SimpleTooltip is a frame that can be configured to popup when the user mouses over a frame.

The recommended method of using it is to create one tooltip frame per top-level window and then call InjectEvents for each frame in the window you want to have a tooltip. However, you can handle the events yourself and just call Show() and Hide() when necessary.

Functions
---------

**GetFontSize(size)**  
Gets the font size.

**SetFontSize(size)**  
Sets the font size. Automatically resizes the frame.

**Show(owner, text, anchor, xoffset, yoffset)**  
Attach the tooltip to the *owner* frame and display *text* in the tooltip. The remaining arguments are optional: *anchor* determines how the tooltip is positioned on the screen: "MOUSE" (the default) anchors the top-left of the tooltip to the lower right corner of the mouse cursor while the mouse is over the *owner* frame. The standard anchor names like "TOPLEFT", etc. will anchor the tooltip by its opposite corner  (e.g. "BOTTOMRIGHT") to the specified corner of the *owner* frame. *xoffset* and *yoffset* (both 0 by default) modify the tooltip's position relative to the anchor point.

**Hide(owner)**  
Hides the tooltip if it is still associated with the *owner* frame.

**InjectEvents(frame, tooltipTextFunc, anchor, xoffset, yoffset)**  
Injects MouseIn/MouseOut/MouseOver events into *frame* which will show and hide the tooltip as appropriate. *tooltipTextFunc* will be called, passing the tooltip frame as the first argument, to get the text to display in the tooltip. The optional *anchor*, *xoffset* and *yoffset* arguments are passed to the Show function when the tooltip is shown.



Frame Type: SimpleWindow
========================

SimpleWindow is just a normal RiftWindow with the appropriate event handlers to make it draggable. No extra functions have been added.

Functions
---------

**SetCloseButtonVisible(visible)**  
Sets whether the close button is displayed in the top right corner of the window.

**Close()**  
Triggered when the window is closed by clicking the close button.



Function: RadioButtonGroup
==========================

**Library.LibSimpleWidgets.RadioButtonGroup(name)**  
Creates a controller object (see below) with the given name, that manages a group of radio buttons.



Object: RadioButtonGroup
========================

Manages a group of radio buttons to ensure that only one is selected at a time and generates an event when the selected radio button in that group changes.

This object does not manage the layout of the radio buttons. You will have to position the individual SimpleRadioButton frames yourself.

Functions
---------

**AddRadioButton(radioButton)**  
Adds a radio button to the group.

**RemoveRadioButton(radioButton)**  
Removes a radio button from the group. *radioButton* can either be the radio button frame itself or an index, starting at 1, according to the original order in which the radio buttons were added.

**GetRadioButton(index)**  
Returns the radio button frame at the given index.

**GetSelectedRadioButton()**  
Returns the currently selected radio button.

**GetSelectedIndex()**  
Returns the index of the currently selected radio button.

**SetSelectedIndex(index, silent)**  
Sets the radio button at the specified index to be selected. Passing true for the optional silent parameter will suppress the RadioButtonChange event.

Events
------

**RadioButtonChange()**  
Triggered when the selected radio button in this group changes.



Function: Layout
================

**Library.LibSimpleWidgets.Layout(configTable, parent)**  
Lays out widgets according to *configTable* in the *parent* frame. Currently uses a fixed 2 column layout.

Layout Config Table
-------------------

The config table contains tables keyed by an identifier, one for each widget.

    {
      id = { ... },
      id2 = { ... },
      ...
    }

Each of these tables describes a widget. The following types of widgets are available: button, textfield, hrule, checkbox, select, slider, spacer.

Basic widget settings
---------------------

    {
      order = <number>, -- determines order in which widgets are layed out, defaults to 100
      type = <string>, -- type of widget
      width = <string>, -- layout guide for widget width: default, column, full
      tooltipText = <string>, -- text to display in tooltip
    }

The *width* setting determines whether a widget will be sized according to its default size, to fill a column or to fill the parent's width.

button
------

    {
      label = <string>, -- displayed if labelPos is set, not used by hrule
      func = <function>, -- function to be called when widget is clicked
    }

textfield
---------

    {
      label = <string>, -- displayed if labelPos is set, not used by hrule
      labelPos = <string>, -- label position: top, left, right
      get = <function>, -- function which returns the initial value to be displayed
      set = <function>, -- function to be called when value is changed by user
    }

checkbox
--------

    {
      label = <string>, -- displayed if labelPos is set, not used by hrule
      labelPos = <string>, -- label position: left, right
      get = <function>, -- function which returns the initial value to be displayed
      set = <function>, -- function to be called when value is changed by user
    }

select
------

    {
      label = <string>, -- displayed if labelPos is set, not used by hrule
      labelPos = <string>, -- label position: top, left, right
      get = <function>, -- function which returns the initial item to be selected
      getvalue = <function> -- function which returns the initial value to be selected
      getindex = <function>, -- function which returns the initial index to be selected
      set = <function>, -- function to be called when selected item is changed by user
      items = <table>, -- items to be displayed in select
      values = <table>, -- (optional) values that correspond to items
    }

slider
------

    {
      label = <string>, -- displayed if labelPos is set, not used by hrule
      labelPos = <string>, -- label position: top, left, right
      get = <function>, -- function which returns the initial value to be displayed
      set = <function>, -- function to be called when value is changed by user
      min = <number>, -- minimum value for slider
      max = <number>, -- maximum value for slider
      editable = <boolean>, -- whether the slider value can be edited directly
    }

When a *set* function is called, the new value being set is passed as the only parameter. For select widgets though, the selected item, the corresponding value (if available) and the selected index are all passed to the set function.


# Function: SetBorder #

**Library.LibSimpleWidgets.SetBorder(type, frame, ...)**  
Sets the border on *frame*. *type* can be one of "plain", "rounded" or "tooltip". The remainder of the arguments depend on the type.

## Border Type: plain ##

**SetBorder("plain", frame, width, r, g, b, a, borders)**  
Sets the border to a plain line of the specified width and color. *borders* is an optional string containing a combination of one or more of the characters "t", "b", "l" and "r", that indicate which of the borders are visible -- top, bottom, left and right, respectively.

## Border Type: rounded ##

**SetBorder("rounded", frame)**  
Sets the border to a textured line with rounded corners.

## Border Type: tooltip ##

**SetBorder("rounded", frame)**  
Sets the border to a textured line that looks like the standard Rift tooltip border.


Code Examples
=============

Window + ScrollView + List
--------------------------

    local context = UI.CreateContext("SWT_Context")
    SWT_Window = UI.CreateFrame("SimpleWindow", "SWT_Window", context)
    SWT_Window:SetCloseButtonVisible(true)
    SWT_Window:SetTitle("List Test")
    SWT_Window:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 100, 100)
    SWT_Window.listScrollView = UI.CreateFrame("SimpleScrollView", "SWT_TestScrollView", SWT_Window:GetContent())
    SWT_Window.listScrollView:SetPoint("TOPLEFT", SWT_Window:GetContent(), "TOPLEFT")
    SWT_Window.listScrollView:SetWidth(150)
    SWT_Window.listScrollView:SetHeight(300)
    SWT_Window.listScrollView:SetBorder(1, 1, 1, 1, 1)
    SWT_Window.list = UI.CreateFrame("SimpleList", "SWT_TestList", SWT_Window.listScrollView)
    SWT_Window.list.Event.ItemSelect = function(view, item) print("ItemSelect("..item..")") end
    local items = {}
    for i=1,100 do
      table.insert(items, "Item "..i)
    end
    SWT_Window.list:SetItems(items)
    SWT_Window.listScrollView:SetContent(SWT_Window.list)

Layout
------

    local context = UI.CreateContext("SWT_Context")
    SWT_Window = UI.CreateFrame("SimpleWindow", "SWT_Window", context)
    SWT_Window:SetCloseButtonVisible(true)
    SWT_Window:SetTitle("Layout Test")
    SWT_Window:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 100, 100)
    local configTable = {
      textfield = {
        order = 10,
        type = "textfield",
        label = "My Textfield",
        labelPos = "left",
        width = "full",
        get = function() return "Intial value" end,
        set = function(value) print("My Textfield set: "..value) end,
      },
      button = {
        order = 20,
        type = "button",
        label = "My Button",
        func = function() print("My Button clicked") end,
      },
    }
    Library.LibSimpleWidgets.Layout(configTable, SWT_Window:GetContent())

Tooltip
-------

    local mybutton = UI.CreateFrame("RiftButton", "MyButton", parent)
    local mytextfield = UI.CreateFrame("RiftTextfield", "MyTextfield", parent)
    local tooltip = UI.CreateFrame("SimpleTooltip", "MyTooltip", parent)
    tooltip:InjectEvents(mybutton, function() return "My Button Tooltip" end)
    tooltip:InjectEvents(mytextfield , function() return "My Textfield Tooltip" end)

RadioButtonGroup
----------------

    local radioButtonGroup = Library.LibSimpleWidgets.RadioButtonGroup("MyRadioButtonGroup")
    radioButtonGroup.Event.RadioButtonChange = function(self)
      print(self:GetName().." selected radio button = "..self:GetSelectedRadioButton():GetName())
    end
    local radioButton1 = UI.CreateFrame("SimpleRadioButton", "MyRadioButton1", parent)
    radioButton1:SetText("Radio Button 1")
    radioButton1:SetPoint("TOPLEFT", parent, "TOPLEFT", 5, 5)
    radioButton1.Event.RadioButtonSelect = function(self)
      print(self:GetName().." selected")
    end
    local radioButton2 = UI.CreateFrame("SimpleRadioButton", "MyRadioButton2", parent)
    radioButton2:SetPoint("TOPLEFT", MyWindow.radioButton1, "BOTTOMLEFT", 0, 5)
    radioButton2:SetText("Radio Button 2")
    radioButton2.Event.RadioButtonSelect = function(self)
      print(self:GetName().." selected")
    end
    local radioButton3 = UI.CreateFrame("SimpleRadioButton", "MyRadioButton3", parent)
    radioButton3:SetPoint("TOPLEFT", radioButton2, "BOTTOMLEFT", 0, 5)
    radioButton3:SetText("Radio Button 3")
    radioButton3.Event.RadioButtonSelect = function(self)
      print(self:GetName().." selected")
    end
    radioButtonGroup:AddRadioButton(radioButton1)
    radioButtonGroup:AddRadioButton(radioButton2)
    radioButtonGroup:AddRadioButton(radioButton3)

Grid
----

    local grid = UI.CreateFrame("SimpleGrid", "MyGrid", parent)
    grid:SetPoint("TOPLEFT", parent, "TOPLEFT")
    grid:SetWidth(parent:GetWidth())
    grid:SetHeight(parent:GetWidth() * 0.75)
    grid:SetBorder(1, 1, 1, 1, 1)
    grid:SetMargin(1)
    grid:SetCellPadding(1)
    
    local cell_1_1 = UI.CreateFrame("Text", "Cell_1_1", grid)
    cell:SetText("Cell_1_1")
    local cell_1_2 = UI.CreateFrame("Text", "Cell_1_2", grid)
    cell:SetText("Cell_1_2")
    local row1 = { cell_1_1, cell_1_2 }
    grid:AddRow(row1)
    
    local cell_2_1 = UI.CreateFrame("Text", "Cell_2_1", grid)
    cell:SetText("Cell_2_1")
    local cell_2_2 = UI.CreateFrame("Text", "Cell_2_2", grid)
    cell:SetText("Cell_2_2")
    local row2 = { cell_2_1, cell_2_2 }
    grid:AddRow(row2)
