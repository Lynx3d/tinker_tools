local Dta = select(2, ...)
local Lang = Dta.Lang

Lang["English"] = {}
----------------------------------------
--Help
----------------------------------------

---Intro------------------------------------------------------------------
Lang["English"].Intro = {}
Lang["English"].Intro.Label = "Intro"
Lang["English"].Intro.Text1 = "\
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
- The Import/Export feature allows you to export your saved sets to a file\
  and share that with your friends by just sending them the file. On their\
  turn they can choose which sets to import to their own saved sets.\
\
Thanks for all the support from the dimension community,\
and have fun building your dreams!"

Lang["English"].Intro.Text2 = ""
Lang["English"].Intro.Text3 = ""

---Main-------------------------------------------------------------------
Lang["English"].Main = {}
Lang["English"].Main.Label = "Main"
Lang["English"].Main.Text1 = "\
The tool button is where it all starts. Left-click it to open the main window,\
right-click it to drag it. The main window holds the basic information about\
the selected items along with the buttons to open up all the individual tools.\
\
Tinker Tools can only be opened inside of dimensions, unless you override\
this with the '/tt force' chat command."

Lang["English"].Main.Text2 = "\
The item icon has a small 'x'-button to clear the selection, and a right-click\
on the icon will set a waypoint on the minimap.\
\
<u>Buttons:</u>\
- ?: Opens up this help window.\
- Move: Opens up a window for the Move Tools.\
- Rotate: Opens up a window for the Rotate Tools.\
- Scale: Opens up a window for the Scale Tools.\
- Offset Calc.: Opens up a window for the Offset Calculator.\
- Copy / Paste: Opens up a window for the Copy and Paste Tools.\
- Load / Save: Opens up a window for the Load and Save Tools.\
- Tribal Magic: Opens up a window for Tribal Magic.\
- Alfiebet: Opens up a window for the Alfiebet text creator."

Lang["English"].Main.Text3 = ""

---Move-------------------------------------------------------------------
Lang["English"].Move = {}
Lang["English"].Move.Label = "Move"
Lang["English"].Move.Text1 = "\
The Move Window is where you modify the positions of the selected items."

Lang["English"].Move.Text2 = "\
<u>Descriptions:</u>\
- X/Y/Z: Specifies the coordinates for the X/Y/Z axis.\
  Empty fields will leave the associated axis unaffected.\
- Absolute: Moves the item(s) to the coordinates set in X,Y,Z.\
- Relative: Moves the item(s) with an offset from current position by the\
  numbers set in X,Y,Z.\
- As Group: Treats the whole selection as one object with the selection center\
  as position; only available in absolute mode.\
- Move: Starts the moving of the item(s).\
- Reset: Resets the item(s) to your current position."

Lang["English"].Move.Text3 = ""

---Rotate-----------------------------------------------------------------
Lang["English"].Rotate = {}
Lang["English"].Rotate.Label = "Rotate"
Lang["English"].Rotate.Text1 = "\
The Rotate Window is where you modify the Rotation of the selected item(s)."

Lang["English"].Rotate.Text2 = "\
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

Lang["English"].Rotate.Text3 = ""

---Scale------------------------------------------------------------------
Lang["English"].Scale = {}
Lang["English"].Scale.Label = "Scale"
Lang["English"].Scale.Text1 = "\
The Scale Window is where you modify the Scale of the selected item(s)."

Lang["English"].Scale.Text2 = "\
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

Lang["English"].Scale.Text3 = ""

---Copy and Paste---------------------------------------------------------
Lang["English"].CopyandPaste = {}
Lang["English"].CopyandPaste.Label = "Copy and Paste"
Lang["English"].CopyandPaste.Text1 = "\
The Copy / Paste Tool is pretty versatile, and behaves a bit different\
depending on what you do.\
When you copy a single item, you can paste its values to any other item,\
the item type gets ignored in this case, and individual values can be excluded.\
But the real power lies in the ability to copy a group of items and paste an\
array with incremental offsets, using items from your inventory."

Lang["English"].CopyandPaste.Text2 = "\
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
  the offsets to the values of the previously placed copy.\
- Flicker reduction: This adds a small offset to each placed copy to prevent\
  visual flickering from overlapping coplanar parts (Z-fighting).\
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

Lang["English"].CopyandPaste.Text3 = "\
<u>Descriptions of additional options:</u>\
- Nr. of Copies: This will be showing up when Offset multiple items is activated.\
- Pick: This button is available when Custom Pivot is active and lets you record the\
  position of your current selection. This lets you for example build a spiral\
  staircase around a specific center point. The pivot is kept until you pick a new\
  one, and doesn't change if you move the item(s) afterwards.\
- Bags: Controls whether to include items from your bags to place new items.\
- Bank: Controls whether to include items from your bank (bags and vaults) to\
  place new items. Note that this has limitations when you don't have\
  actual bank access."


---Load and Save----------------------------------------------------------
Lang["English"].LoadandSave = {}
Lang["English"].LoadandSave.Label = "Load and Save"
Lang["English"].LoadandSave.Text1 = "\
The Load / Save Sets window is all about saving the sets you created to be\
able to load them up on other places in your dimension or in other dimensions\
you have."

Lang["English"].LoadandSave.Text2 = "\
<u>Descriptions:</u>\
- Name (Textbox):  Here you set the name for the set you want to save.\
- Save Set: Saves the set to file.\
- Default Sets: Gives you the possibility to load the default sets provided\
  by me and the rest of the RiftDreamDimensions team. These sets are tools\
  created to aid you in your creativity.\
\
  For a detailed guide on how to use these tools you can go to\
  http://RiftDreamDimensions.com and take a look at the\
  Dimension Tools PDF file.\
\
- Saved Sets : Gives you the possibility to load your own made sets into your\
  Dimensions.\
- Tbx Sets: Gives you the possibility to load your old Toolbox Sets, explanation\
  on how that works you find later in this help.\
- Name (Drop box): A list of all the saved items. Depending on if you have\
  chosen Default Sets or Saved Sets the drop box will go to different lists.\
- Load Set: Loads the selected set into your dimension using items you have\
  selected in your dimension or using items from your bags.\
- Print Materials: Print out a list of items needed for the selected set.\
- Load New Items: Makes it possible to load the set using items from your bags.\
\
The following items will only be active when Saved Sets or Tbx Sets are activated.\
- Delete Set: Removes the selected set from your saved list (only Saved Sets) .\
- Load at original location: If this is selected the set will be loaded with\
  the stats it was originally saved with. Otherwise the set will be loaded close\
  to your current position.\
- Place Multiple Copies Of Set: This activates the possibility to load multiple\
  copies of your set into your dimension and set a X, Y or Z offset between\
  the placed sets.\
\
The options used for this are shown in the picture below here.\
- Nr. Copies: Lets you set how many copies of the set you want to place in\
  your dimension.\
-X: Sets the X offset.\
-Y: Sets the Y offset.\
-Z: Sets the Z offset."

Lang["English"].LoadandSave.Text3 = "\
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
Lang["English"].ImportandExport = {}
Lang["English"].ImportandExport.Label = "Import and Export"
Lang["English"].ImportandExport.Text1 = "\
The Import / Export Sets window is all about sharing your sets with other\
friends in the game.\
The sets will be saved in and loaded from a file called: Dimtools_Export.lua\
The file can be found under:\
/Users/[YourName]/Documents/RIFT/Interface/Saved/SavedVariables"

Lang["English"].ImportandExport.Text2 = "\
<u>Descriptions:</u>\
- Saved Sets: Sets the first drop box to your Tinker Tools Sets.\
- Tbx Sets: Sets the first drop box to your Toolbox Sets.\
- Name (First drop box): Here you can select any of your own saved sets to\
  export to file.\
- Export: Exports the selected set to file.\
- Name (Second drop box): Here you can select any of the sets saved in the\
  export File.\
- Import: Imports the selected set to your own saved sets list and then removes\
  the set from the export file.\
\
To give a set or multiple sets you have to export the sets and then\
logout or type [/reloadui] in the chat to save the file. After that you can\
send the Dimtools_Export.lua file located at:\
/Users/[YourName]/Documents/RIFT/Interface/Saved/SavedVariables\
\
When you recieve a set or multiple sets in a  Dimtools_Export.lua file you\
have to copy it into the SavedVariables directory found under:\
/Users/[YourName]/Documents/RIFT/Interface/Saved/SavedVariables\
Then start the game and then you can use the import option to get the set or\
sets in your saved sets. Keep in mind you can NOT copy the file into the\
directory if you are logged into the game. The game does NOT allow overwriting\
of files when you are logged in."

Lang["English"].ImportandExport.Text3 = ""

---Tribal Magic-----------------------------------------------------------
Lang["English"].TribalMagic = {}
Lang["English"].TribalMagic.Label = "Tribal Magic"
Lang["English"].TribalMagic.Text1 = "\
Tribal Magic is the Magic Carpet addon made by AladdinRift integrated into\
Dimension Tools with only a small adjustment to the items it uses. Instead of\
using an Ogre Rug I went for the smaller Round Tribal Table to give you more\
room to look around without seeing the edges of the item you fly on."

Lang["English"].TribalMagic.Text2 = "\
<u>Descriptions:</u>\
- Place: places the Round Tribal Table in your dimension for flying.\
- Pick up: Picks up the Round Tribal Table from your dimension.\
- 0: Levels out the Round Tribal Table, so you can move around on the altitude\
  you currently are.\
- +1 to +4: Change the angle of the Round Tribal Table. The higher the number\
  the faster you will go Up (+) in your dimension.\
- -1 to -4: Change the angle of the Round Tribal Table. The lower the number\
  the faster you will go Down (-)in your dimension."

Lang["English"].TribalMagic.Text3 = ""

---Chance Log-------------------------------------------------------------
Lang["English"].ChanceLog = {}
Lang["English"].ChanceLog.Label = "Change Log"
Lang["English"].ChanceLog.Text1 = "\
For the changes please refer to the included Changelog.txt\
\
For a more detailed list of changes, you can also check the commit log at\
https://github.com/Lynx3d/dimension_tools/commits/master"

Lang["English"].ChanceLog.Text2 = ""
Lang["English"].ChanceLog.Text3 = ""

---Afterword--------------------------------------------------------------
Lang["English"].Afterword = {}
Lang["English"].Afterword.Label = "Afterword"
Lang["English"].Afterword.Text1 = "\
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

Lang["English"].Afterword.Text2 = ""
Lang["English"].Afterword.Text3 = ""

---Offset Calc.-----------------------------------------------------------
Lang["English"].OffsetCalc = {}
Lang["English"].OffsetCalc.Label = "Offset Calc."
Lang["English"].OffsetCalc.Text1 = "\
The Offset Calculator is a tool you can use to see what offset is need to\
place building blocks seamlessly against each other.\
This tool has come to life because of questions about how you determine the\
offset of a building block."

Lang["English"].OffsetCalc.Text2 = "\
- Shape: Here you choose the type of item you want the offset for.\
  Supported shapes: Pole, Tile, Cube, Plank, Rectangle and Floors.\
- Orientation:  Here you choose the orientation of an item.\
  Supported are all 6 possible +/- 90° rotation combinations.\
  A special case is 'Selection Delta', this does not work on the\
  shape of an item, but calculates the differences between two\
  selected items.\
- Scale: Here you set the scale of the item.\
- Calculate: Calculates the offsets for you.\
- X: The offset on the X axis.\
- Y: The offset on the Y axis.\
- Z: The offset on the Z axis.\
- Detect: This tries to detect all parameters from the selection."

Lang["English"].OffsetCalc.Text3 = ""

---Alfiebet-----------------------------------------------------------
Lang["English"].Alfiebet = {}
Lang["English"].Alfiebet.Label = "Alfiebet"
Lang["English"].Alfiebet.Text1 = "\
Going through allot of dimensions over time one thing you see a lot, people\
writing words using different items. Some are really clear others are really\
bright using light sources to make them. But one thing they all have in common,\
people want to say something to their dimension visitors. That is why we as\
the RiftDreamDimensions team came up with the idea to make a word processor\
in Dimension Tools. And after a lot of thinking and work done by the\
RiftDreamDimensions team creating fonts for it we managed to get this tool\
working for you all to enjoy."

Lang["English"].Alfiebet.Text2 = "\
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

Lang["English"].Alfiebet.Text3 = ""

----------------------------------------
--Buttons
----------------------------------------
Lang["English"].Buttons = {}
Lang["English"].Buttons.MoveWindow = "Move"
Lang["English"].Buttons.RotateWindow = "Rotate"
Lang["English"].Buttons.ScaleWindow = "Scale"
Lang["English"].Buttons.CopyPaste = "Copy / Paste"
Lang["English"].Buttons.LoadSave = "Load / Save"
Lang["English"].Buttons.ImportExport = "Import / Export"
Lang["English"].Buttons.TribalMagic = "Tribal Magic"
Lang["English"].Buttons.OffsetCalc = "Offset Calc."
Lang["English"].Buttons.Reskin = "Reskin"
Lang["English"].Buttons.Copy = "Copy"
Lang["English"].Buttons.Paste = "Paste"
Lang["English"].Buttons.Pick = "Pick"
Lang["English"].Buttons.Import = "Import"
Lang["English"].Buttons.Export = "Export"
Lang["English"].Buttons.Place = "Place"
Lang["English"].Buttons.PickUp = "Pick Up"
Lang["English"].Buttons.SaveSet = "Save Set"
Lang["English"].Buttons.LoadSet = "Load Set"
Lang["English"].Buttons.RemoveSet = "Delete Set"
Lang["English"].Buttons.PrintMaterials = "Print Materials"
Lang["English"].Buttons.ToClipboard = "To Clipboard"
Lang["English"].Buttons.Move = "Move"
Lang["English"].Buttons.Reset = "Reset"
Lang["English"].Buttons.Rotate = "Rotate"
Lang["English"].Buttons.Scale = "Scale"
Lang["English"].Buttons.Calculate = "Calculate"
Lang["English"].Buttons.Detect = "Detect"
Lang["English"].Buttons.Transfer = "Transfer"
Lang["English"].Buttons.LoadWord = "Load Word"
Lang["English"].Buttons.Yes = "Yes"
Lang["English"].Buttons.No = "No"
Lang["English"].Buttons.OK = "OK"
Lang["English"].Buttons.Cancel = "CANCEL"
Lang["English"].Buttons.Apply = "Apply"

----------------------------------------
--Menus
----------------------------------------
Lang["English"].Menus = {}
Lang["English"].Menus.WindowStyle = { "Default", "Borderless" }
Lang["English"].Menus.ItemType = {
	"Cubes",
	"Plank",
	"Pole",
	"Rectangle",
	"Tile",
	"Floor",
	"Hall Floor",
	"Large Floor"
}
Lang["English"].Menus.Orientation = {
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
Lang["English"].Titles = {}
Lang["English"].Titles.Main = "Tinker Tools"
Lang["English"].Titles.Move = "Move"
Lang["English"].Titles.Rotate = "Rotate"
Lang["English"].Titles.Scale = "Scale"
Lang["English"].Titles.CopyPaste = "Copy / Paste Items"
Lang["English"].Titles.LoadSave = "Load / Save Sets"
Lang["English"].Titles.ImportExport = "Import / Export Sets"
Lang["English"].Titles.TribalMagic = "Tribal Magic"
Lang["English"].Titles.OffsetCalc = "Offset Calculation"
Lang["English"].Titles.Help = "Tinker Tools Help"
Lang["English"].Titles.Settings = "Settings"
Lang["English"].Titles.TransferValues = "Transfer Values to:"
Lang["English"].Titles.Reskin = "Replace Skins"


----------------------------------------
--Text
----------------------------------------
Lang["English"].Text = {}
Lang["English"].Text.Yaw = "Yaw"
Lang["English"].Text.Pitch = "Pitch"
Lang["English"].Text.Roll = "Roll"
Lang["English"].Text.Scale = "Scale"
Lang["English"].Text.NothingSelected = "Nothing selected"
Lang["English"].Text.NrSelectItems = "Nr. of selected items:"
Lang["English"].Text.MultiSelectItems = "Multiple items selected"
Lang["English"].Text.Offset = "Offset"
Lang["English"].Text.OffsetMultiItems = "Offset multiple items"
Lang["English"].Text.FlickerReduce = "Flicker Reduction"
Lang["English"].Text.UseNewItems = "Use New Items"
Lang["English"].Text.SelectionPivot = "Custom Pivot"
Lang["English"].Text.NrItems = "Nr. of Copies"
Lang["English"].Text.Bags = "Bags"
Lang["English"].Text.BankBags = "Bank"
Lang["English"].Text.Vaults = "Vaults"
Lang["English"].Text.DefaultSets = "Default Sets"
Lang["English"].Text.SavedSets = "Saved Sets"
Lang["English"].Text.TbxSets = "Tbx Sets"
Lang["English"].Text.Name = "Name"
Lang["English"].Text.Search = "Search"
Lang["English"].Text.LoadOrigionalLocation = "Load at original location"
Lang["English"].Text.MultiCopies = "Place Multiple Copies of Set"
Lang["English"].Text.NrCopies = "Nr. Copies"
Lang["English"].Text.Absolute = "Absolute"
Lang["English"].Text.Relative = "Relative"
Lang["English"].Text.MoveAsGroup = "As group"
Lang["English"].Text.Type = "Shape"
Lang["English"].Text.Orientation = "Orientation"
Lang["English"].Text.Word = "Word"
Lang["English"].Text.Font = "Font"
Lang["English"].Text.Size = "Size"
Lang["English"].Text.Skin = "Skin"
Lang["English"].Text.Horizontal = "Place Horizontal"
Lang["English"].Text.Vertical = "Place Vertical"
Lang["English"].Text.ConsoleMessages = "Console Messages"
Lang["English"].Text.WindowStyle = "Window Style"
Lang["English"].Text.NotIdleNotification = "Previous operation has not finished yet.\nAbort currently running operation now?"
Lang["English"].Text.ConfirmDeleteSet = "Delete item set '%s'?"
Lang["English"].Text.ConfirmUsePosition = "The original position of this set is %.1fm away.\nContinue operation?"
Lang["English"].Text.Invert = "Inverse Direction"
Lang["English"].Text.OldSkin = "Old Skin"
Lang["English"].Text.NewSkin = "New Skin"
Lang["English"].Text.Tile = "Tile"
Lang["English"].Text.Rectangle = "Rectangle"
Lang["English"].Text.Triangle = "Triangle"
Lang["English"].Text.Plank = "Plank"
Lang["English"].Text.Cube = "Cube"
Lang["English"].Text.Sphere = "Sphere"
Lang["English"].Text.Pole = "Pole"
Lang["English"].Text.Disc = "Disc"


----------------------------------------
--Prints
----------------------------------------
Lang["English"].Prints = {}
--Main
Lang["English"].Prints.DimensionOnly = "This addon is intended for use in Dimensions only."
Lang["English"].Prints.ProcessFinished = "Processing Finished."
Lang["English"].Prints.SetFinished = "Item set \"%s\" loaded and selected."
Lang["English"].Prints.PasteFinished = "All items are placed and selected."
Lang["English"].Prints.WordFinished = "The word is placed and selected."
--Copy / Paste
Lang["English"].Prints.Copy_SelectItem = "Please select an item in order to copy attributes"
Lang["English"].Prints.NumbersOnly = "Please enter numeric values only"
Lang["English"].Prints.CopyFirst = "Please copy an item before pasting"
Lang["English"].Prints.SelectItemSource = "Please select at least one source for new items"
Lang["English"].Prints.NotPasteInventory = "Cannot paste clipboard - the following items are missing from your bags:"
Lang["English"].Prints.NotPasteSelection = "Cannot paste clipboard - the following items are missing from your selection:"
--Tribal Magic
Lang["English"].Prints.NoRoundTable = "You do not seem to have an Round Tribal Table in your inventory!"
--Alfiebet
Lang["English"].Prints.SelectFont = "Select a Font"
Lang["English"].Prints.SelectSize = "Select a Size"
Lang["English"].Prints.SelectSkin = "Select a Skin"
Lang["English"].Prints.OnlyLetters = "Only letters allowed in the word"
Lang["English"].Prints.TypeWord = "Please type a word first"
Lang["English"].Prints.WordMissingItems = "Cannot build this word - the following items are missing from your bags:"
Lang["English"].Prints.WordNeededItems = "The following items are required to create the word \"%s\":"
Lang["English"].Prints.WordCouldNotPrint = "Could not print materials"
--Import/Export
Lang["English"].Prints.SetNotFound = "Item set \"%s\" not found"
Lang["English"].Prints.SelectExport = "You must select a set in order to Export it"
Lang["English"].Prints.Exported = "Item set \"%s\" Exported"
Lang["English"].Prints.SelectImport = "You must select a set in order to Import it"
Lang["English"].Prints.Imported = "Item set \"%s\" Imported"
--Load / Save
Lang["English"].Prints.Saved = "Item set \"%s\" saved"
Lang["English"].Prints.MinOneItem = "Must select 1 or more items in order to save them"
Lang["English"].Prints.EnterName = "Must enter a name in order to save the set"
Lang["English"].Prints.LoadNeededItems = "The following items are required for loading \"%s\":"
Lang["English"].Prints.LoadPrintMats = "You must select a set in order to print its materials"
Lang["English"].Prints.LoadSelectSet = "You must select a set in order to load it"
Lang["English"].Prints.NotLoadedBags = "Cannot load set - the following items are missing from your bags:"
Lang["English"].Prints.NotLoadedSelection = "Cannot load set - the following items are missing from your selection:"
Lang["English"].Prints.SetLoaded = "Item set \"%s\" loaded"
Lang["English"].Prints.SetRemoved = "Item set \"%s\" removed"
Lang["English"].Prints.NotRemoved = "Could not remove \"%s\" - no such set found"
Lang["English"].Prints.RemoveSelectSet = "You must select a set in order to remove it"
Lang["English"].Prints.CopiedClipboard =  "Item set \"%s\" has been copied to the Copy & Paste tool's clipboard."
--Measurements
Lang["English"].Prints.SelectType = "Select a Type"
Lang["English"].Prints.SelectOrientation = "Select an Orientation"
Lang["English"].Prints.TypeSize = "Type a Size"
Lang["English"].Prints.SizeC = "Make sure Size is between %.2f and %.1f"
Lang["English"].Prints.Selection1 = "Transformed mode requires one selected item."
Lang["English"].Prints.Selection2 = "Selection Delta requires two selected items."
--Move, Rotate, Scale
Lang["English"].Prints.ModifyPosition = "Please select an item in order to modify its position"
Lang["English"].Prints.ModifyRotation = "Please select an item in order to modify its rotation"
Lang["English"].Prints.ModifyScale = "Please select an item in order to modify its scale"
--Reskin
Lang["English"].Prints.ClipboardEmpty = "The Copy & Paste clipboard is empty."
Lang["English"].Prints.Summary = "Replacement summary:"
