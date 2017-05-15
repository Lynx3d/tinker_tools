local Dta = select(2, ...)

Dta.Lang.English = {}
local English = Dta.Lang.English
----------------------------------------
--Help
----------------------------------------

---Intro------------------------------------------------------------------
English.Intro = {}
English.Intro.Label = "Intro"
English.Intro.Text1 = "\
Hello Dimensioneers!\
\
This Addon is the continuation of Dimension Tools, originally developed\
by Kikimora with the support of the Rift Dream Dimensions team.\
And Dimension Tools is an advancement of Dimension Toolbox by Arkzy.\
\
The following is a summary of the core features:\
\
<u>Tinker Tools Features:</u>\
- Compact user interface giving you more screen space when building dimensions.\
  All the tools can be brought up individually with the buttons provided in\
  the main window.\
\
- Move, scale and rotate hundreds of items at once precisely in various modes.\
  (Though you must keep in mind that the more items you modify, the longer it\
  takes to finish processing it.)\
\
- The functionality of the Copy/Paste tool ranges from transfering selected values\
  between items with optional offset to cloning whole groups of items and placing\
  multiple copies in your dimension directly from your bags and/or bank.\
\
- With the Load/Save feature you can choose between loading one of the\
  default sets or your own saved sets. And for convenience you can place\
  multiple copies of a saved set at once with an offset on the X, Y or X axis.\
\
- The Import/Export feature allows you to transfer your saved sets using a global file\
  or via text copy and paste. Also supports importing Toolbox sets in text format.\
\
Thanks for all the support from the dimension community,\
and have fun building your dreams!"

English.Intro.Text2 = "<u>Change Log</u>\
For the changes please refer to the included Changelog.txt file.\
\
For a more detailed list of changes, you can also check the commit log at\
https://github.com/Lynx3d/dimension_tools/commits/master"
English.Intro.Text3 = ""

---Main-------------------------------------------------------------------
English.Main = {}
English.Main.Label = "Main"
English.Main.Text1 = "\
The tool button is where it all starts. Left-click it to open the main window,\
right-click it to drag it. The main window holds the basic information about\
the selected items along with the buttons to open up all the individual tools.\
\
Tinker Tools can only be opened inside of dimensions, unless you override\
this with the '/tt force' chat command."

English.Main.Text2 = "\
The item icon has a small 'x'-button to clear the selection, and a right-click\
on the icon will set a waypoint on the minimap.\
\
<u>Window Toggle Buttons:</u>\
- ?: Opens up this help window.\
- Move: A tool to move items in various modes.\
- Rotate: A tool to rotate items in various modes.\
- Scale: A tool to scale items in various modes.\
- Offset Calc.: A tool to determine offset values for proper item alignment.\
- Copy / Paste: A tool to copy and paste items with many options.\
- Load / Save: A tool to load and save structures. Also links to Import / Export.\
- Tribal Magic: A tool that allows you to move more freely.\
- Alfiebet: A text creation tool using standard building blocks.\
- Reskin: A tool to replace building blocks with a different appearance."

English.Main.Text3 = ""

---Move-------------------------------------------------------------------
English.Move = {}
English.Move.Label = "Move"
English.Move.Text1 = "\
The Move Window is where you modify the positions of the selected items."

English.Move.Text2 = "\
<u>Descriptions:</u>\
- X/Y/Z: Specifies the coordinates for the X/Y/Z axis.\
  Empty fields will leave the associated axis unaffected.\
- Absolute: Moves the item(s) to the coordinates set in X,Y,Z.\
- Relative: Moves the item(s) with an offset from current position by the\
  numbers set in X,Y,Z.\
- As Group: Treats the whole selection as one object with the selection center\
  as position; only available in absolute mode.\
- Local Axes: Moves each item along its local axes. Local axis means the item's\
  rotation is applied to the global axis, creating a coordinate system that rotates\
  with the object. Since the item itself defines the origin, this is only available\
  in relative mode.\
- Move: Starts the moving of the item(s).\
- Reset: Resets the item(s) to your current position."

English.Move.Text3 = ""

---Rotate-----------------------------------------------------------------
English.Rotate = {}
English.Rotate.Label = "Rotate"
English.Rotate.Text1 = "\
The Rotate Window is where you modify the Rotation of the selected item(s)."

English.Rotate.Text2 = "\
<u>Descriptions:</u>\
- Pitch: Specifies the rotation about the X axis.\
- Yaw: Specifies the rotation about the Y axis.\
- Roll: Specifies the rotation about the Z axis.\
- Absolute: Sets the item(s) rotation to the exact numbers you put in Pitch,\
  Yaw and Roll.\
  NOTE: While empty fields will use the current values, there is always more\
  than one way to represent the same rotation. Rift may convert the angles if\
  your input exceeds certain boundaries, and hence chance all 3 values, which\
  may greatly confuse you on subsequent rotation adjustments. So it is highly\
  recommended to not leave fields empty in absolute mode.\
- Relative: Rotates the item(s) with the numbers you set in Yaw, Pitch and\
  Roll from the current rotation. So if current rotation is 30 degrees Yaw\
  and you put 20 degrees in the Yaw box it will end up having a rotation\
  of 50 degrees.\
- As Group: Treats the whole selection as one object. Note that since selections\
  are temporary, there is no way to save a current rotation for the group.\
  This has two consequences: This mode is only available in relative mode, and\
  the rotation happens around the global axis.\
  Note that you can rotate a single item around global axis too this way.\
- Rotate: Starts the rotation of the item(s).\
- Reset: Resets the item(s) Pitch, Yaw and Roll to 0 degrees."

English.Rotate.Text3 = ""

---Scale------------------------------------------------------------------
English.Scale = {}
English.Scale.Label = "Scale"
English.Scale.Text1 = "\
The Scale Window is where you modify the Scale of the selected item(s)."

English.Scale.Text2 = "\
<u>Descriptions:</u>\
- Scale: Specifies the scale factor for the selected item(s).\
- Absolute: Sets the scale of the item(s) to the exact number you put in.\
- Relative: Sets the scale of the item(s) to the current scale multiplied by\
  the number you put in.\
- As Group: Treats the whole selection as one object. Note that since selections\
  are temporary, there is no way to determine a current scale of the group,\
  so it is only available in relative mode.\
  Warning: Items have diverse scale limitations. If you exceed those, your group\
  will fall apart, so to speak, because this mode also has to move items.\
- Scale: Starts the scaling of the item(s).\
- Reset: Resets the item(s) scale to 1."

English.Scale.Text3 = ""

---Copy and Paste---------------------------------------------------------
English.CopyandPaste = {}
English.CopyandPaste.Label = "Copy and Paste"
English.CopyandPaste.Text1 = "\
The Copy / Paste Tool is pretty versatile, and behaves a bit different\
depending on what you do.\
When you copy a single item, you can paste its values to any other item,\
the item type gets ignored in this case, and individual values can be excluded.\
But the real power lies in the ability to copy a group of items and paste an\
array with incremental offsets, using items from your inventory."

English.CopyandPaste.Text2 = "\
You can disable and enable any of the offsets by clicking the selection box\
in front of the text fields. When pasting to a single selected object, this\
also controls which properties are transferred to the selected item.\
\
<u>Descriptions:</u>\
- Offset X, Y, Z: Sets the offset for the X, Y, Z axis for the item(s) you\
  are going to paste the clipboard to.\
- Offset Pitch, Yaw, Roll: Sets the rotation offset for the Pitch, Yaw,\
  Roll axis for the item(s) you are going to paste the clipboard to.\
  For single items, the values are simply added to the original values.\
  For item groups or when a pivot is used, the items get transformed using the\
  global coordinate axis.\
- Offset Scale: Sets the scale change for the paste. For example, 0.2 will make\
  the placed copy 20% larger, and -0.2 consequently 20% smaller.\
- Offset multiple items: Makes it possible to paste an array by iteratively adding\
  the offsets to the values of the previously placed copy. This accepts either\
  a count or a range in the form first:last. So 5 is equivalent to 1:5. First and\
  last may be zero or even negative. This way you can include the original position\
  with 0:5, extend a previously pasted array like 6:10 for 5 more copies, inverse\
  the direction with -1:-5 etc.\
- Flicker reduction: This adds a small quasi-random offset to each placed copy to\
  prevent visual flickering from overlapping coplanar parts (Z-fighting).\
  The input field lets you adjust the amplitude of the offset sequence.\
- Custom Pivot: This causes rotation and scaling to be calculated relative to the\
  point you picked (see below for details).\
- Use New Items: Activates the possibility to place new items from your bags or\
  bank into your dimension. Your inventory will be scanned to ensure you have\
  enough items before the pasting begins\
- Copy: Copies the stats of the items you have selected to clipboard.\
- Paste: Pastes the clipboard according to the settings you made.\
  This may take a while when placing many new items.\
\
Depending on the settings, additional controls become available, as seen below:"

English.CopyandPaste.Text3 = "\
<u>Descriptions of additional options:</u>\
- Nr. of Copies: This will be showing up when Offset multiple items is activated.\
- Pick: This button is available when Custom Pivot is active and lets you record the\
  position of your current selection. This lets you for example build a spiral\
  staircase around a specific center point.\
  The pivot is kept until you pick a new one (or leave the dimension), and doesn't\
  change if you move or remove the item(s) afterwards.\
- Bags: Controls whether to include items from your bags to place new items.\
- Bank: Controls whether to include items from your bank (bags and vaults) to\
  place new items. Note that this has limitations when you don't have\
  actual bank access."


---Load and Save----------------------------------------------------------
English.LoadandSave = {}
English.LoadandSave.Label = "Load and Save"
English.LoadandSave.Text1 = "\
The Load / Save Sets window is all about saving the sets you created to be\
able to load them up on other places in your dimension or in other dimensions\
you have."

English.LoadandSave.Text2 = "\
<u>Descriptions:</u>\
- Name (Textbox):  Here you set the name for the set you want to save.\
- Save Set: Saves the set to file.\
- Import/Export: Opens the Import/Export dialog (see next help topic)\
\
- Default Sets: Gives you the possibility to load the default sets provided\
  by the RiftDreamDimensions team.\
  These sets are tools created to aid you in your creativity.\
\
  For a detailed guide on how to use these tools you can go to\
  http://RiftDreamDimensions.com and take a look at the\
  Dimension Tools PDF file.\
\
- Saved Sets: Gives you the possibility to load your own made sets into your\
  Dimensions.\
- Tbx Sets: Gives you the possibility to load your old Toolbox Sets, explanation\
  on how that works you find later in this help.\
\
- Search: Filters the drop-down below, refreshes when hitting 'return'.\
- Name (Drop-down): A list of all available set. Depending on if you have\
  chosen Default Sets or Saved Sets the drop box will go to different lists.\
- Load Set: Loads the selected set into your dimension using items you have\
  selected in your dimension or using items from your bags.\
- Print Materials: Print out a list of items needed for the selected set.\
- Delete Set: Removes the selected set from your saved list (only Saved Sets).\
- To Clipboard: This copies the set to the Copy&Paste clipboard, so you can paste\
  it with that tool. This gives you more options, for example pasting multiple\
  copies, but also allows using the Reskin tool to change materials before pasting.\
- Use New Items: This places new items from your inventory. Otherwise you need\
  to have the required items placed and selected.\
- Load at original location: If this is selected, the set will be loaded with\
  the coordinates it was originally saved with. Otherwise it will be loaded close\
  to your current position, or if enabled, at your reference point.\
  Only advisable when dimension keys of load and save match.\
\
- Use Reference Point: This option allows for more control over the placement of\
  loaded sets. When saving a set, the picked point is simply saved along with the\
  items of the set. When you later load this set, the set will be moved so that\
  the saved reference point aligns with your current pick. If the set has no\
  reference point, the center point of the set will be used instead.\
- Pick: This sets your current selection center as reference point."

English.LoadandSave.Text3 = "\
Tbx Sets is somewhat special. By default that set is empty, but for old Dimension\
Toolbox users this is a way to get your sets that you made with Dimension\
Toolbox to work within Tinker Tools as well.\
\
To get your old sets loaded into Dimension Tools you need to do the following:\
1: Locate the tbx.lua File, found under:\
   /Users/[YourName]/Documents/RIFT/Interface/Saved/[YourRiftAccount]\
   /SavedVariables\
2: Copy the file txb.lua into the same directory.\
3: Rename the new file to tbx_Import.lua\
4: Now start up rift and you should have all your old Dimension Toolbox Sets\
   there to load up and place in your dimensions.\
\
Be aware you will not be able to remove any of the sets loaded under Tbx Sets,\
so I highly recommend that before you copy and rename the file go to Dimension\
Toolbox and delete all sets you don't want to use in Dimension Tools."


---Import and Export------------------------------------------------------
English.ImportandExport = {}
English.ImportandExport.Label = "Import and Export"
English.ImportandExport.Text1 = "\
The Import / Export Sets window is all about sharing your sets with other\
friends in the game.\
There are two ways to exchange sets, with the Dimension Tools export addon\
and by converting it to/from text you can copy/paste using the system clipboard.\
\
The Dimension Tools export is an embedded addon that uses saved variabls to\
exchange the data, the file will be named Dimtools_Export.lua\
Usually you will find that file at:\
C:/Users/%USERNAME%/My Documents/RIFT/Interface/Saved/SavedVariables\
Note that the default path depends on the Windows version and locale, and\
furthermore depends on the DocumentsDirectory variable in rift.cfg.\
But generally, Saved/ resides in the same directory as your Addons/ directory,\
which can be opened from Rift's addons configuration dialog."

English.ImportandExport.Text2 = "\
<u>Descriptions:</u>\
- Saved Sets: Sets the source for sets to your Tinker Tools saved sets.\
- Tbx Sets: Sets the source to your Toolbox sets that were auto-imported.\
- Name (First drop-down): Here you can select any of your own saved sets to\
  be exported.\
- Export: Exports the selected set to the Dimtools_Export.lua file.\
- Export Text: Exports the selected set to the text box at the bottom.\
- Name (Second drop-down): Here you can select any of the sets saved in the\
  export File.\
- New Name: Specify the name this set will have. Optional for Dimension Tools\
  Import, mandatory for Text Import.\
- Import: Imports the selected set to your saved sets list and then removes\
  the set from the export file.\
- Import Text: Imports the text from the text box at the bottom to your saved\
  sets list. Also accepts the Dimension Toolbox format (auto-detected).\
\
When using Dimension Tools file export, keep in mind that addon data is not\
written to disk until addons are unloaded, so either logout or use the /reloadui\
chat command to save the data to Dimtools_Export.lua\
\
When you import from a foreign Dimtools_Export.lua file, you must not be logged in\
with your character when you copy it into the SavedVariables directory, otherwise\
it will be overwritten before you can import anything from it."

English.ImportandExport.Text3 = ""

---Tribal Magic-----------------------------------------------------------
English.TribalMagic = {}
English.TribalMagic.Label = "Tribal Magic"
English.TribalMagic.Text1 = "\
Tribal Magic is based on the Magic Carpet addon made by AladdinRift.\
Instead of an Ochre Rug it uses the smaller Round Tribal Table to give you\
more room to look around without seeing the edges of the item you fly on."

English.TribalMagic.Text2 = "\
<u>Descriptions:</u>\
- Place: places the Round Tribal Table in your dimension for flying.\
- Pick up: Picks up the Round Tribal Table from your dimension.\
- Slider: Changes the angle of the Round Tribal Table.\
    0: Levels out the Round Tribal Table, so you can move around on the altitude\
        you currently are.\
    +1 to +4: The higher the number the more you will go upwards as you move.\
    -1 to -4: The lower the number the more you will go downwards as you move.\
  The slider can also be moved with the mouse wheel when the cursor is above it."

English.TribalMagic.Text3 = ""

---Reskin-----------------------------------------------------------------
English.Reskin = {}
English.Reskin.Label = "Reskin"
English.Reskin.Text1 = "\
The Reskin Tool replaces building blocks of one surface appearance (skin)\
with another skin of your choice.\
It works on the Copy / Paste clipboard, so before you can start, you need\
to copy something first. Note that you can also copy a saved set to the\
clipboard.\
When you're finished, you can paste the reskinned clipboard. You'll probably\
want to activate the 'Use New Items' option for this, and pick up the original\
structure if you're pasting at the original location."
English.Reskin.Text2 = "\
<u>Descriptions:</u>\
- Old Skin: The skin you want to replace.\
- New Skin: The skin that will replace the old one.\
- Checkboxes: Select the building block shapes you want to be included.\
- Apply: Applies the changes to the clipboard and prints a summary."
English.Reskin.Text3 = ""
---Afterword--------------------------------------------------------------
English.Afterword = {}
English.Afterword.Label = "Afterword"
English.Afterword.Text1 = "\
Many thanks to the Rift Community for supporting me. Your feedback\
and in-game donations have helped me a lot to stay motivated and continue\
from where Kikimora left Dimension Tools at.\
\
A lot of work was put into refactoring the old code, effectively making\
this a whole new addon.\
\
I hope you will enjoy the addon with its signifficant interface changes\
and keep making a lot of wonderful creations with it.\
For questions, errors, suggestions or other information about the addon you\
want to share, have a look at the Dimensions section of the Rift forums.\
\
Special Thanks:\
AladdinRift, for allowing to integrate his code from Magic Carpet into\
Dimension Tools.\
\
The Translators:\
Aeryle, French translations.\
Thanks for continuing to work on the translation for this remake of the\
Dimension Tools addon.\
\
A little word from Aeryle:\
It was a pleasure for me to translate this Add-on in French.\
I hope the French Dimension community will enjoy it and i hope this\
translation will allow them to use this add-on more easily!"

English.Afterword.Text2 = ""
English.Afterword.Text3 = ""

---Offset Calc.-----------------------------------------------------------
English.OffsetCalc = {}
English.OffsetCalc.Label = "Offset Calc."
English.OffsetCalc.Text1 = "\
The Offset Calculator is a tool you can use to see what offset is need to\
place building blocks seamlessly against each other.\
This tool has come to life because of questions about how you determine the\
offset of a building block."

English.OffsetCalc.Text2 = "\
- Shape: Here you choose the type of item you want the offset for.\
  Supported shapes: Pole, Square, Cube, Plank, Rectangle and Floors.\
- Orientation:  Here you choose the orientation of an item.\
  Supported are all 6 possible +/- 90° rotation combinations.\
  For arbitrarily rotated items, Transformed X, Y and Z Offset give the\
  vector that represents the item's local X, Y or Z vector respectively.\
  A special case is 'Selection Delta', this does not work on the\
  shape of an item, but calculates the differences between two\
  selected items, and hence ignores the Shape and Scale setting.\
- Scale: Here you set the scale of the item.\
- Multiplier: Optional input. If present, the result will be multiplied\
  by this value.\
- Calculate: Calculates the offsets for you.\
- X: The offset on the X axis.\
- Y: The offset on the Y axis.\
- Z: The offset on the Z axis.\
- Detect: This tries to detect all parameters from the item selection."

English.OffsetCalc.Text3 = ""

---Alfiebet-----------------------------------------------------------
English.Alfiebet = {}
English.Alfiebet.Label = "Alfiebet"
English.Alfiebet.Text1 = "\
Going through allot of dimensions over time one thing you see a lot, people\
writing words using different items. Some are really clear others are really\
bright using light sources to make them. But one thing they all have in common,\
people want to say something to their dimension visitors. That is why we as\
the RiftDreamDimensions team came up with the idea to make a word processor\
in Dimension Tools. And after a lot of thinking and work done by the\
RiftDreamDimensions team creating fonts for it we managed to get this tool\
working for you all to enjoy."

English.Alfiebet.Text2 = "\
- Word: This is where you type in the word you want in your dimension.\
        - The tool only works with letters A to Z.\
- Font: This is where you choose what font you like to use.\
- Size: Here you can choose the size of the font.\
- Skin: Here you can choose what type of skin you want to give your word.\
- Place Horizontal: Writes the word horizontal along the X axis.\
- Place Vertical: Writes the word vertical along the Y axis.\
- Load Word: places the word into your dimension.\
- Print Materials: Prints a list of items you need in your chat window.\
        This list will adjust itself depending on what skin you choose."

English.Alfiebet.Text3 = ""

English.Selection = {}
English.Selection.Label = "Selection"
English.Selection.Text1 = "\
The Selection tool mainly helps you saving and restoring the selection state\
of placed items. Some tool actions also automatically save a set of the items\
they used. Note that item identifiers are only valid for one building session.\
If the dimension gets unloaded (when the last player leaves), IDs become invalid\
and new ones are generated when you enter again. Consequently these sets are not\
saved when you log out, they are only temporary."

English.Selection.Text2 = "\
- Save Set: Saves your current selection\
- Load Set: Selects all items in the set. Currently selected items will remain\
  selected so you can combine selections as you please.\
- Name (drop-down): Lists all saved sets, including automatically created ones.\
  Automatically saved are your last copy selection, and the items placed by your\
  last paste and set loading.\
- Delete Set: Delete a saved set.\
- Invert: This inverts the selection state of all items, i.e. what's currently\
  selected will be unselected, and what's unselected will be selected. So if\
  nothing is selected, this will attempt to select everything (selecting requires\
  items to be in vewing range too).\
  *WARNING*: Attempting to modify too many items with Rift's own tools will cause\
  disconnects, losing all temporary data of your building session like TT's clipboard\
  and selection sets.\
- Pick Up: This does the same thing as Rift's Pick Up button. But this function\
  can handle large item counts without disconnect, you're only limited by the\
  bag space you have."

English.Selection.Text3 = ""

----------------------------------------
--Buttons
----------------------------------------
English.Buttons = {}
English.Buttons.MoveWindow = "Move"
English.Buttons.RotateWindow = "Rotate"
English.Buttons.ScaleWindow = "Scale"
English.Buttons.CopyPaste = "Copy / Paste"
English.Buttons.LoadSave = "Load / Save"
English.Buttons.ImportExport = "Import / Export"
English.Buttons.TribalMagic = "Tribal Magic"
English.Buttons.OffsetCalc = "Offset Calc."
English.Buttons.Reskin = "Reskin"
English.Buttons.Selection = "Selection"
English.Buttons.Copy = "Copy"
English.Buttons.Paste = "Paste"
English.Buttons.Pick = "Pick"
English.Buttons.Import = "Import"
English.Buttons.ImportText = "Import Text"
English.Buttons.Export = "Export"
English.Buttons.ExportText = "Export Text"
English.Buttons.Place = "Place"
English.Buttons.PickUp = "Pick Up"
English.Buttons.SaveSet = "Save Set"
English.Buttons.LoadSet = "Load Set"
English.Buttons.RemoveSet = "Delete Set"
English.Buttons.PrintMaterials = "Material List"
English.Buttons.ToClipboard = "To Clipboard"
English.Buttons.Move = "Move"
English.Buttons.Reset = "Reset"
English.Buttons.Rotate = "Rotate"
English.Buttons.Scale = "Scale"
English.Buttons.Calculate = "Calculate"
English.Buttons.Detect = "Detect"
English.Buttons.Transfer = "Transfer"
English.Buttons.LoadWord = "Load Word"
English.Buttons.Yes = "Yes"
English.Buttons.No = "No"
English.Buttons.OK = "OK"
English.Buttons.Cancel = "CANCEL"
English.Buttons.Apply = "Apply"
English.Buttons.More = "More..."
English.Buttons.Less = "Less..."
English.Buttons.InvertSelection = "Invert"

----------------------------------------
--Menus
----------------------------------------
English.Menus = {}
English.Menus.WindowStyle = { "Default", "Borderless" }
English.Menus.ItemType = {
	"Cubes",
	"Plank",
	"Pole",
	"Rectangle",
	"Square",
	"Floor",
	"Hall Floor",
	"Large Floor"
}
English.Menus.Orientation = {
	"Default",
	"Pitch 90",
	"Yaw 90",
	"Roll 90",
	"Pitch & Yaw 90",
	"Pitch & Roll 90",
	"Selection Delta",
	"Transformed X Offset",
	"Transformed Y Offset",
	"Transformed Z Offset"
}

----------------------------------------
--Titles
----------------------------------------
English.Titles = {}
English.Titles.Main = "Tinker Tools"
English.Titles.Move = "Move"
English.Titles.Rotate = "Rotate"
English.Titles.Scale = "Scale"
English.Titles.CopyPaste = "Copy / Paste Items"
English.Titles.LoadSave = "Load / Save Sets"
English.Titles.ImportExport = "Import / Export Sets"
English.Titles.TribalMagic = "Tribal Magic"
English.Titles.OffsetCalc = "Offset Calculation"
English.Titles.Help = "Tinker Tools Help"
English.Titles.Settings = "Settings"
English.Titles.TransferValues = "Transfer Values to:"
English.Titles.Reskin = "Replace Skins"
English.Titles.Selection = "Selection"
English.Titles.MaterialList = "Material List"

----------------------------------------
--Text
----------------------------------------
English.Text = {}
English.Text.Yaw = "Yaw"
English.Text.Pitch = "Pitch"
English.Text.Roll = "Roll"
English.Text.Scale = "Scale"
English.Text.NothingSelected = "Nothing selected"
English.Text.NrSelectItems = "Nr. of selected items:"
English.Text.MultiSelectItems = "%d items selected"
English.Text.Offset = "Offset"
English.Text.OffsetMultiItems = "Offset multiple items"
English.Text.FlickerReduce = "Flicker Reduction"
English.Text.UseNewItems = "Use New Items"
English.Text.SelectionPivot = "Custom Pivot"
English.Text.NrItems = "Nr. of Copies"
English.Text.Bags = "Bags"
English.Text.BankBags = "Bank"
English.Text.Vaults = "Vaults"
English.Text.DefaultSets = "Default Sets"
English.Text.SavedSets = "Saved Sets"
English.Text.TbxSets = "Tbx Sets"
English.Text.Name = "Name"
English.Text.Search = "Search"
English.Text.LoadOrigionalLocation = "Load at original location"
English.Text.UseRefPoint = "Use reference point"
English.Text.Absolute = "Absolute"
English.Text.Relative = "Relative"
English.Text.MoveAsGroup = "As group"
English.Text.LocalAxes = "Local Axes"
English.Text.Type = "Shape"
English.Text.Orientation = "Orientation"
English.Text.Word = "Word"
English.Text.Font = "Font"
English.Text.Size = "Size"
English.Text.Skin = "Skin"
English.Text.Horizontal = "Place Horizontal"
English.Text.Vertical = "Place Vertical"
English.Text.ConsoleMessages = "Console Messages"
English.Text.WindowStyle = "Window Style"
English.Text.RestoreTools = "Remember opened Tools when closing\nMain Window"
English.Text.NotIdleNotification = "Previous operation has not finished yet.\nAbort currently running operation now?"
English.Text.ConfirmDeleteSet = "Delete item set '%s'?"
English.Text.ConfirmOverwrite = "The set '%s' already exists.\nOverwrite this set?"
English.Text.ConfirmUsePosition = "The original position of this set is %.1fm away.\nContinue operation?"
English.Text.ConfirmPickup = "Are you sure you want to pick up all selected items?"
English.Text.ConfirmInvSelect = "Handling too many items may cause disconnects.\nSelect %d items?"
English.Text.Invert = "Inverse Direction"
English.Text.OldSkin = "Old Skin"
English.Text.NewSkin = "New Skin"
English.Text.Tile = "Square"
English.Text.Rectangle = "Rectangle"
English.Text.Triangle = "Triangle"
English.Text.Plank = "Plank"
English.Text.Cube = "Cube"
English.Text.Sphere = "Sphere"
English.Text.Pole = "Pole"
English.Text.Disc = "Disc"
English.Text.NewName = "New Name"
English.Text.Category = "Category"
English.Text.AnySkin = "<Any Skin>"
English.Text.Multiplier = "Multiplier"

----------------------------------------
--Prints
----------------------------------------
English.Prints = {}
--Main
English.Prints.DimensionOnly = "This addon is intended for use in Dimensions only."
English.Prints.ProcessFinished = "Processing Finished."
English.Prints.SetFinished = "Item set \"%s\" loaded and selected."
English.Prints.PasteFinished = "All items are placed and selected."
English.Prints.WordFinished = "The word is placed and selected."
--Copy / Paste
English.Prints.Copy_SelectItem = "Please select an item in order to copy attributes"
English.Prints.NumbersOnly = "Please enter numeric values only"
English.Prints.CopyFirst = "Please copy an item before pasting"
English.Prints.SelectItemSource = "Please select at least one source for new items"
English.Prints.NotPasteInventory = "Cannot paste clipboard - your inventory is missing the following items:"
English.Prints.NotPasteSelection = "Cannot paste clipboard - the selection is missing the following items:"
--Tribal Magic
English.Prints.NoRoundTable = "You do not seem to have an Round Tribal Table in your inventory!"
--Alfiebet
English.Prints.SelectFont = "Select a Font"
English.Prints.SelectSize = "Select a Size"
English.Prints.SelectSkin = "Select a Skin"
English.Prints.OnlyLetters = "Only letters allowed in the word"
English.Prints.TypeWord = "Please type a word first"
English.Prints.WordMissingItems = "Cannot build this word - the following items are missing from your bags:"
English.Prints.WordNeededItems = "The following items are required to create the word \"%s\":"
English.Prints.WordCouldNotPrint = "Could not print materials"
--Import/Export
English.Prints.SetNotFound = "Item set \"%s\" not found"
English.Prints.SelectExport = "You must select a set in order to Export it"
English.Prints.Exported = "Item set \"%s\" Exported"
English.Prints.SelectImport = "You must select a set in order to Import it"
English.Prints.Imported = "Item set \"%s\" Imported"
English.Prints.TextHint = "<Text input/output>\nCtrl+C: Copy\nCtrl+V: Paste\nCtrl+A: Select all\n"
--Load / Save
English.Prints.Saved = "Item set \"%s\" saved"
English.Prints.MinOneItem = "Must select 1 or more items in order to save them"
English.Prints.EnterName = "Must enter a name in order to save the set"
English.Prints.LoadNeededItems = "The following items are required for loading \"%s\":"
English.Prints.LoadPrintMats = "You must select a set in order to view its materials"
English.Prints.LoadSelectSet = "You must select a set in order to load it"
English.Prints.NotLoadedBags = "Cannot load set - the following items are missing from your bags:"
English.Prints.NotLoadedSelection = "Cannot load set - the following items are missing from your selection:"
English.Prints.SetLoaded = "Item set \"%s\" loaded"
English.Prints.SetRemoved = "Item set \"%s\" removed"
English.Prints.NotRemoved = "Could not remove \"%s\" - no such set found"
English.Prints.RemoveSelectSet = "You must select a set in order to remove it"
English.Prints.CopiedClipboard =  "Item set \"%s\" has been copied to the Copy & Paste tool's clipboard."
English.Prints.PickRefPoint =  "Please pick a reference point first."
English.Prints.NoRefPointWarn =  "This item set has no reference point. Using center point instead."
--Measurements
English.Prints.SelectType = "Select a Type"
English.Prints.SelectOrientation = "Select an Orientation"
English.Prints.TypeSize = "Type a Size"
English.Prints.SizeC = "Make sure Size is between %.2f and %.1f"
English.Prints.Selection1 = "Transformed mode requires one selected item."
English.Prints.Selection2 = "Selection Delta requires two selected items."
--Move, Rotate, Scale
English.Prints.ModifyPosition = "Please select an item in order to modify its position"
English.Prints.ModifyRotation = "Please select an item in order to modify its rotation"
English.Prints.ModifyScale = "Please select an item in order to modify its scale"
--Reskin
English.Prints.ClipboardEmpty = "The Copy & Paste clipboard is empty."
English.Prints.Summary = "Replacement summary:"
