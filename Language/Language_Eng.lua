Lang = {}

Lang["English"] = {}
----------------------------------------
--Help
----------------------------------------

---Intro------------------------------------------------------------------
Lang["English"].Intro = {}
Lang["English"].Intro.Label = "Intro"
Lang["English"].Intro.Text1 = "\
Hello Dimensioneers,\
\
I am Kikimora, add-on programmer and dimension builder who has always liked\
using Dimension Toolbox by Arkzy.\
\
Over the months our game of Rift has changed so inspired by Dimension Toolbox\
and with the expertise and support of the members of Rift Dream Dimensions I\
managed to create Dimension Tools. I hope you will enjoy Dtools as much as I\
enjoyed making it.\
\
The following is a simplified check list of what Dimension Tools offers:\
\
<u>Dimension Tools Features:</u>\
- Dimension Tools is smaller giving  more space on your screen when building\
  in your dimensions. All the tools can be brought up by clicking on the\
  buttons provided in the main window.\
\
- With Dimension Tools you can move, scale and rotate hundreds of items at once\
  without any problems. (Though you must keep in mind the more items you use\
  the longer it takes to finish processing it.)\
\
- With the Copy/Paste option in Dimension Tools you can copy 1 item and place\
  multiple copies of it in your dimension with or without offset directly from\
  your bags, bank or both.\
\
- With the new Load/Save feature you can now choose between using one of the\
  default sets or your own saved sets. A nice new feature to the Load/Save\
  feature is that you can save a set and place multiple copies of it at once\
  with an offset on the X, Y or X axis.\
\
- The new Import/Export feature allows you to export sets you made to a file\
  and share that with your friends by just sending them the file. On their\
  turn they can then import the set or even multiple sets to their own saved\
  sets.\
\
With the RDD team we will continue testing possible new features and ensuring\
current ones continue to work well as Rift evolves.!\
\
Thanks and have fun building Dream Dimensions!"

Lang["English"].Intro.Text2 = ""
Lang["English"].Intro.Text3 = ""

---Main-------------------------------------------------------------------
Lang["English"].Main = {}
Lang["English"].Main.Label = "Main"
Lang["English"].Main.Text1 = "\
The main window is where it all starts. This is the only window visible by\
default and will hold the basic information about the items along with the\
buttons to open up all the other tools in Dimension Tools."

Lang["English"].Main.Text2 = "\
<u>Buttons:</u>\
- ?: Opens up this help window.\
- Move Window: Opens up a window for the Move tools.\
- Rotate Window: Opens up a window for the Rotate Tools.\
- Scale Window: Opens up a window for the Scale Tools.\
- Copy / Paste: Opens up a window for the Copy and Paste Tools.\
- Load / Save: Opens up a window for the Load and Save Tools.\
- Import / Export: Opens up a window for the Import and Export Tools.\
- Tribal Magic: Opens up a window for Tribal Magic.\
- Offset Calc.: Opens up a window for the Offset Calculator."

Lang["English"].Main.Text3 = ""

---Move-------------------------------------------------------------------
Lang["English"].Move = {}
Lang["English"].Move.Label = "Move"
Lang["English"].Move.Text1 = "\
The Move Window is where you set the positions of the selected item(s)."

Lang["English"].Move.Text2 = "\
<u>Descriptions:</u>\
- X: Sets the coordinates for the X axis.\
- Y: Sets the coordinates for the Y axis.\
- Z: Sets the coordinates for the Z axis.\
- Absolute: Moves the item(s) to the coordinates set in X,Y,Z.\
- Relative: Moves the item(s) with an offset from current position by the\
  numbers set in X,Y,Z.\n- Move: Starts the moving of the item(s).\
- Reset: Resets the item(s) to your current position."

Lang["English"].Move.Text3 = ""

---Rotate-----------------------------------------------------------------
Lang["English"].Rotate = {}
Lang["English"].Rotate.Label = "Rotate"
Lang["English"].Rotate.Text1 = "\
The Rotate Window is where you set the Rotation of the selected item(s).\
Here I have to start with some information about rotation in add-ons, so\
far in the add-on I have not been able to find a way to actually get group\
rotation done. So even though it can handle a lot of items at once they\
will all get the same rotation done on each item and will not be rotated\
as a group."

Lang["English"].Rotate.Text2 = "\
<u>Descriptions:</u>\
- Yaw: Sets the Rotation over the Yaw axis.\
- Pitch: Sets the Rotation over the Pitch axis.\
- Roll: Sets the Rotation over the Roll axis.\
- Absolute: Sets the item(s) Rotation to the exact numbers you put in Yaw,\
  Pitch and Roll.\
- Relative: Rotates the item(s) with the numbers you set in Yaw, Pitch and\
  Roll from the current rotation. So if current rotation is 20 degrees Yaw\
  and you put 20 degrees in the Yaw box it will end up having a rotation\
  of 40 degrees.\
- Rotate: Starts the rotation of the item(s).\
- Reset: Resets the item(s) rotation to Yaw, Pitch, Roll / 0, 0, 0."

Lang["English"].Rotate.Text3 = ""

---Scale------------------------------------------------------------------
Lang["English"].Scale = {}
Lang["English"].Scale.Label = "Scale"
Lang["English"].Scale.Text1 = "\
The Scale Window is where you set the Scale of the selected item(s)."

Lang["English"].Scale.Text2 = "\
<u>Descriptions:</u>\
- Scale: Sets the Scale for the selected item(s).\
- Absolute: Sets the Scale of the item(s) to the exact number you put in.\
- Relative: Sets the Scale of the item(s) to the current Scale plus the\
  number you put in.\
- Scale: Starts the Scaling of the item(s).\
- Reset: Resets the item(s) Scale to 1."

Lang["English"].Scale.Text3 = ""

---Copy and Paste---------------------------------------------------------
Lang["English"].CopyandPaste = {}
Lang["English"].CopyandPaste.Label = "Copy and Paste"
Lang["English"].CopyandPaste.Text1 = "\
The Copy / Paste Items window can be used to copy the stats of an item and\
transfer those stats to other items in your dimension or place multiple\
copies of the item in your dimension from your bags or bank. You can do this\
with or without a offset."

Lang["English"].CopyandPaste.Text2 = "\
You can disable and enable any of the offsets by clicking the selection box\
in front of the text fields. By doing this you can choose what stats are\
transferred to the other item(s).\
\
<u>Descriptions:</u>\
- Offset X, Y, Z: Sets the offset for the X, Y, Z axis for the item(s) you\
  have selected to transfer the stats to or want to place new in your dimension.\
- Offset Yaw, Pitch, Roll: Sets the rotation offset over the Yaw, Pitch,\
  Roll axis for the item(s) you have selected to transfer the stats to or\
  want to place new in your dimension.\
- Offset Scale: Sets the Scale for the item(s) you have selected to transfer\
  the stats to or want to place new in your dimension.\
- Copy: Copies the stats of the item you have selected.\
- Paste: Pastes the stats of the copied item to the item(s) you have selected\
  or places the new item(s) from your bags or bank in your dimension.\
- Offset multiple items: Makes it possible to paste an offset to all selected\
  items or new items you place. Each time it takes the stats of the last placed\
  item and applies the offset to the next item in row. Can be used to for example\
  create a wall or well designed patterns.\
- Use New Item: Activates the possibility to place new items from your bags or\
  bank into your dimension."

Lang["English"].CopyandPaste.Text3 = "\
<u>Descriptions of new options:</u>\
- Bags: Will set it so that only items from your bags are taken to place as\
  new items.\
- Bank Bags: Will set it so that only items from your bank bags are taken to\
  place as new items.\
- Vaults: Will set it so that only items from your bank vaults are taken to\
  place as new items.\
- Nr. of Items (As seen in the picture below): This will be showing up when both\
  Offset multiple items and Use New Item is activated. This gives you the\
  possibility to paste in multiple new items from your bags or bank. It will\
  check if you have enough items to place if not then it will say how many\
  items you can max place."


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
- Remove Set: Removes the selected set from your saved list (only Saved Sets) .\
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
Toolbox to work within Dimension Tools as well.\
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
- Saved Sets: Sets the first drop box to your Dimension Tools Sets.\
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
Lang["English"].ChanceLog.Label = "Chance Log"
Lang["English"].ChanceLog.Text1 = "\
Version 1.2.2\
- Added Offset Calculator module.\
- Added Offset Calculator to help.\
- Added Dimension detection, so that DT can only be opened inside dimensions.\
\
Version 1.2.1.r17\
- adjusted help to match new options in copy & paste\
\
Version 1.2.0.r16\
- Rewrote Central point calculations.\
- Made some small changes in Tribal Magic, to improve performance.\
\
Version 1.2.0.r15\
- Changed: The options Bags, Bank, Both under Copy/Paste to Bags, Bank Bags,\
  Vaults. This to give a more precise choice of where to take the items from.\
- Added a counter to the main menu for selected items, you can now see how\
  many items you have selected.\
\
Version 1.2.0\
- Implemented the Magic Carpet addon into Dimension Tools under the name\
  Tribal Magic."

Lang["English"].ChanceLog.Text2 = ""
Lang["English"].ChanceLog.Text3 = ""

---ToDo List--------------------------------------------------------------
Lang["English"].ToDoList = {}
Lang["English"].ToDoList.Label = "ToDo List"
Lang["English"].ToDoList.Text1 = "\
This is only the first release of Dimension Tools. Along the way I will add\
things to this list so you can all see what is worked on at the moment.\
Some projects will stay surprises till they are released."

Lang["English"].ToDoList.Text2 = ""
Lang["English"].ToDoList.Text3 = ""

---Afterword--------------------------------------------------------------
Lang["English"].Afterword = {}
Lang["English"].Afterword.Label = "Afterword"
Lang["English"].Afterword.Text1 = "\
Many thanks to the Rift Dream Dimensions team for supporting\
me on the making of this add-on and beta testing it for me.\
\
I hope you will all enjoy the addon and make a lot of wonderful creations\
with it.\
For questions, errors or other information about the addon you want to share\
with us, visit http://riftdreamdimensions.com/ \
\
Special Thanks:\
AladdinRift, for letting me use his code from Magic Carpet to integrate it\
into Dimension Tools.\
\
Websites:\
http://inhousegaming.com/ - For all your Trion game fun.\
http://www.curse.com/addons/rift - This Add-on and many others."

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
- Type: Here you choose the type of item you want the offset for.\
  Supported Types: Pole, Tile, Cube, Plank and Rectangle.\
- Orientation:  Here you choose the orientation of an item.\
  Supported Orientations:\
  Default: Yaw, Pitch and Roll all at 0\
  Yaw 90: Yaw at 90, Pitch and Roll at 0\
  Pitch 90: Pitch at 90, Yaw and Roll at 0\
  Roll 90: Roll at 90, Yaw and Pitch at 0\
- Scale: Here you set the scale of the item.\
- Calculate: Calculates the offsets for you.\
- X: The offset on the X axis.\
- Y: The offset on the Y axis.\
- Z: The offset on the Z axis."

Lang["English"].OffsetCalc.Text3 = ""

---Alfiebet-----------------------------------------------------------
Lang["English"].Alfiebet = {}
Lang["English"].Alfiebet.Label = "Alfiebet"
Lang["English"].Alfiebet.Text1 = ""
Lang["English"].Alfiebet.Text2 = ""
Lang["English"].Alfiebet.Text3 = ""

----------------------------------------
--Buttons
----------------------------------------
Lang["English"].Buttons = {}
Lang["English"].Buttons.MoveWindow = "Move Window"
Lang["English"].Buttons.RotateWindow = "Rotate Window"
Lang["English"].Buttons.ScaleWindow = "Scale Window"
Lang["English"].Buttons.CopyPaste = "Copy / Paste"
Lang["English"].Buttons.LoadSave = "Load / Save"
Lang["English"].Buttons.ImportExport = "Import / Export"
Lang["English"].Buttons.TribalMagic = "Tribal Magic"
Lang["English"].Buttons.OffsetCalc = "Offset Calc."
Lang["English"].Buttons.Copy = "Copy"
Lang["English"].Buttons.Paste = "Paste"
Lang["English"].Buttons.Import = "Import"
Lang["English"].Buttons.Export = "Export"
Lang["English"].Buttons.Place = "Place"
Lang["English"].Buttons.PickUp = "Pick Up"
Lang["English"].Buttons.SaveSet = "Save Set"
Lang["English"].Buttons.LoadSet = "Load Set"
Lang["English"].Buttons.RemoveSet = "Remove Set"
Lang["English"].Buttons.PrintMaterials = "Print Materials"
Lang["English"].Buttons.Move = "Move"
Lang["English"].Buttons.Reset = "Reset"
Lang["English"].Buttons.Rotate = "Rotate"
Lang["English"].Buttons.Scale = "Scale"
Lang["English"].Buttons.Calculate = "Calculate"
Lang["English"].Buttons.LoadWord = "Load Word"

----------------------------------------
--Titles
----------------------------------------
Lang["English"].Titles = {}
Lang["English"].Titles.Main = "Dimension Tools"
Lang["English"].Titles.Move = "Move Window"
Lang["English"].Titles.Rotate = "Rotate Window"
Lang["English"].Titles.Scale = "Scale Window"
Lang["English"].Titles.CopyPaste = "Copy / Paste Items"
Lang["English"].Titles.LoadSave = "Load / Save Sets"
Lang["English"].Titles.ImportExport = "Import / Export Sets"
Lang["English"].Titles.TribalMagic = "Tribal Magic"
Lang["English"].Titles.OffsetCalc = "Offset Calc."
Lang["English"].Titles.Help = "Dimension Tools Help"


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
Lang["English"].Text.UseNewItems = "Use New Item"
Lang["English"].Text.NrItems = "Nr. of Items"
Lang["English"].Text.Bags = "Bags"
Lang["English"].Text.BankBags = "Bank Bags"
Lang["English"].Text.Vaults = "Vaults"
Lang["English"].Text.DefaultSets = "Default Sets"
Lang["English"].Text.SavedSets = "Saved Sets"
Lang["English"].Text.TbxSets = "Tbx Sets"
Lang["English"].Text.Name = "Name"
Lang["English"].Text.LoadOrigionalLocation = "Load at original location"
Lang["English"].Text.MultiCopies = "Place Multiple Copies of Set"
Lang["English"].Text.NrCopies = "Nr. Copies"
Lang["English"].Text.Absolute = "Absolute"
Lang["English"].Text.Relative = "Relative"
Lang["English"].Text.MoveAsGroup = "Move as group"
Lang["English"].Text.Type = "Type"
Lang["English"].Text.Orientation = "Orientation"
Lang["English"].Text.Word = "Word"
Lang["English"].Text.Font = "Font"
Lang["English"].Text.Size = "Size"
Lang["English"].Text.Skin = "Skin"
Lang["English"].Text.Horizontal = "Place Horizontal"
Lang["English"].Text.Vertical = "Place Vertical"


----------------------------------------
--Prints
----------------------------------------
Lang["English"].Prints = {}
Lang["English"].Prints.DimensionOnly = "This addon is intended for use in Dimensions only."
Lang["English"].Prints.ProcessFinished = "Processing Finished."
Lang["English"].Prints.SetFinished = "Item set \"%s\" loaded and selected."
Lang["English"].Prints.PasteFinished = "All items are placed and selected."
--Lang["English"].Prints.WordFinished = "The word is placed and selected."
