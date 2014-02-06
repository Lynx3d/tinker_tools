Dta.Help = {}

    function Dta.Help.InfoHandler(Item)
        Dta.ui.windowHelp.ScrollInfoLoad.ScrollTo = 0
        local test = Dta.Help.helpTopic[Item]
        for i = 1, table.getn(test), 1 do
            local InfoLabel = test[i].label
            local InfoText01 = test[i].text01
            local InfoText02 = test[i].text02
            local InfoText03 = test[i].text03
            local InfoPic01 = test[i].pic01
            local InfoPic02 = test[i].pic02
            local InfoPic03 = test[i].pic03
            local InfoEmpty = ""
            local InfoPosition = 0

            if InfoLabel ~= "" and InfoText01 == "" and InfoText02 == "" and InfoText03 == "" and InfoPic01 == ""  and InfoPic02 == ""  and InfoPic03 == "" then
                Dta.ui.windowHelp.HeaderInfo:SetFontSize(30)
                Dta.ui.windowHelp.HeaderInfo:SetPoint("TOPLEFT", Helpwindow.HelpInfo, "TOPLEFT", 0, 0)
                Dta.ui.windowHelp.HeaderInfo:SetText("<u>"..InfoLabel.."</u>", true)

                --Empy fields to clear on switching
                Dta.ui.windowHelp.TextInfo01:SetText(InfoEmpty, true)
                Dta.ui.windowHelp.TextInfo02:SetText(InfoEmpty, true)
                Dta.ui.windowHelp.TextInfo03:SetText(InfoEmpty, true)
                Dta.ui.windowHelp.PicInfo01:SetTexture("Dimtools", "textures/"..InfoEmpty)
                Dta.ui.windowHelp.PicInfo02:SetTexture("Dimtools", "textures/"..InfoEmpty)
                Dta.ui.windowHelp.PicInfo03:SetTexture("Dimtools", "textures/"..InfoEmpty)

            elseif InfoLabel ~= "" and InfoText01 ~= "" and InfoText02 == "" and InfoText03 == "" and InfoPic01 == ""  and InfoPic02 == ""  and InfoPic03 == "" then
                Dta.ui.windowHelp.HeaderInfo:SetFontSize(30)
                Dta.ui.windowHelp.HeaderInfo:SetPoint("TOPLEFT", Helpwindow.HelpInfo, "TOPLEFT", 0, 0)
                Dta.ui.windowHelp.HeaderInfo:SetText("<u>"..InfoLabel.."</u>", true)

                InfoPosition = InfoPosition + Dta.ui.windowHelp.HeaderInfo:GetHeight() + 20

                Dta.ui.windowHelp.TextInfo01:SetFontSize(15)
                Dta.ui.windowHelp.TextInfo01:SetPoint("TOPLEFT", Helpwindow.HelpInfo, "TOPLEFT", 0, InfoPosition)
                Dta.ui.windowHelp.TextInfo01:SetText(InfoText01, true)

                --Empy fields to clear on switching
                Dta.ui.windowHelp.TextInfo02:SetText(InfoEmpty, true)
                Dta.ui.windowHelp.TextInfo03:SetText(InfoEmpty, true)
                Dta.ui.windowHelp.PicInfo01:SetTexture("Dimtools", "textures/"..InfoEmpty)
                Dta.ui.windowHelp.PicInfo02:SetTexture("Dimtools", "textures/"..InfoEmpty)
                Dta.ui.windowHelp.PicInfo03:SetTexture("Dimtools", "textures/"..InfoEmpty)

            elseif InfoLabel ~= "" and InfoText01 ~= "" and InfoText02 ~= "" and InfoText03 == "" and InfoPic01 ~= ""  and InfoPic02 == ""  and InfoPic03 == "" then
                Dta.ui.windowHelp.HeaderInfo:SetFontSize(30)
                Dta.ui.windowHelp.HeaderInfo:SetPoint("TOPLEFT", Helpwindow.HelpInfo, "TOPLEFT", 0, 0)
                Dta.ui.windowHelp.HeaderInfo:SetText("<u>"..InfoLabel.."</u>", true)

                InfoPosition = InfoPosition + Dta.ui.windowHelp.HeaderInfo:GetHeight() + 20

                Dta.ui.windowHelp.TextInfo01:SetFontSize(15)
                Dta.ui.windowHelp.TextInfo01:SetPoint("TOPLEFT", Helpwindow.HelpInfo, "TOPLEFT", 0, InfoPosition)
                Dta.ui.windowHelp.TextInfo01:SetText(InfoText01, true)

                InfoPosition = InfoPosition + Dta.ui.windowHelp.TextInfo01:GetHeight() + 20

                Dta.ui.windowHelp.PicInfo01:SetPoint("TOPLEFT", Helpwindow.HelpInfo, "TOPLEFT", 0, InfoPosition)
                Dta.ui.windowHelp.PicInfo01:SetTexture("Dimtools", "textures/"..InfoPic01)

                InfoPosition = InfoPosition + Dta.ui.windowHelp.PicInfo01:GetHeight() + 20

                Dta.ui.windowHelp.TextInfo02:SetFontSize(15)
                Dta.ui.windowHelp.TextInfo02:SetPoint("TOPLEFT", Helpwindow.HelpInfo, "TOPLEFT", 0, InfoPosition)
                Dta.ui.windowHelp.TextInfo02:SetText(InfoText02, true)

                --Empy fields to clear on switching
                Dta.ui.windowHelp.TextInfo03:SetText(InfoEmpty, true)
                Dta.ui.windowHelp.PicInfo02:SetTexture("Dimtools", "textures/"..InfoEmpty)
                Dta.ui.windowHelp.PicInfo03:SetTexture("Dimtools", "textures/"..InfoEmpty)

            elseif InfoLabel ~= "" and InfoText01 ~= "" and InfoText02 ~= "" and InfoText03 ~= "" and InfoPic01 ~= ""  and InfoPic02 ~= ""  and InfoPic03 ~= "" then
                Dta.ui.windowHelp.HeaderInfo:SetFontSize(30)
                Dta.ui.windowHelp.HeaderInfo:SetPoint("TOPLEFT", Helpwindow.HelpInfo, "TOPLEFT", 0, 0)
                Dta.ui.windowHelp.HeaderInfo:SetText("<u>"..InfoLabel.."</u>", true)

                InfoPosition = InfoPosition + Dta.ui.windowHelp.HeaderInfo:GetHeight() + 20

                Dta.ui.windowHelp.TextInfo01:SetFontSize(15)
                Dta.ui.windowHelp.TextInfo01:SetPoint("TOPLEFT", Helpwindow.HelpInfo, "TOPLEFT", 0, InfoPosition)
                Dta.ui.windowHelp.TextInfo01:SetText(InfoText01, true)

                InfoPosition = InfoPosition + Dta.ui.windowHelp.TextInfo01:GetHeight() + 20

                Dta.ui.windowHelp.PicInfo01:SetPoint("TOPLEFT", Helpwindow.HelpInfo, "TOPLEFT", 0, InfoPosition)
                Dta.ui.windowHelp.PicInfo01:SetTexture("Dimtools", "textures/"..InfoPic01)

                InfoPosition = InfoPosition + Dta.ui.windowHelp.PicInfo01:GetHeight() + 20

                Dta.ui.windowHelp.TextInfo02:SetFontSize(15)
                Dta.ui.windowHelp.TextInfo02:SetPoint("TOPLEFT", Helpwindow.HelpInfo, "TOPLEFT", 0, InfoPosition)
                Dta.ui.windowHelp.TextInfo02:SetText(InfoText02, true)

                InfoPosition = InfoPosition + Dta.ui.windowHelp.TextInfo02:GetHeight() + 20

                Dta.ui.windowHelp.PicInfo02:SetPoint("TOPLEFT", Helpwindow.HelpInfo, "TOPLEFT", 0, InfoPosition)
                Dta.ui.windowHelp.PicInfo02:SetTexture("Dimtools", "textures/"..InfoPic02)

                InfoPosition = InfoPosition + Dta.ui.windowHelp.PicInfo02:GetHeight() + 20

                Dta.ui.windowHelp.TextInfo03:SetFontSize(15)
                Dta.ui.windowHelp.TextInfo03:SetPoint("TOPLEFT", Helpwindow.HelpInfo, "TOPLEFT", 0, InfoPosition)
                Dta.ui.windowHelp.TextInfo03:SetText(InfoText03, true)

                InfoPosition = InfoPosition + Dta.ui.windowHelp.TextInfo03:GetHeight() + 20

                Dta.ui.windowHelp.PicInfo03:SetPoint("TOPLEFT", Helpwindow.HelpInfo, "TOPLEFT", 0, InfoPosition)
                Dta.ui.windowHelp.PicInfo03:SetTexture("Dimtools", "textures/"..InfoPic03)

            elseif InfoLabel ~= "" and InfoText01 ~= "" and InfoText02 ~= "" and InfoText03 == "" and InfoPic01 ~= ""  and InfoPic02 ~= ""  and InfoPic03 == "" then
                Dta.ui.windowHelp.HeaderInfo:SetFontSize(30)
                Dta.ui.windowHelp.HeaderInfo:SetPoint("TOPLEFT", Helpwindow.HelpInfo, "TOPLEFT", 0, 0)
                Dta.ui.windowHelp.HeaderInfo:SetText("<u>"..InfoLabel.."</u>", true)

                InfoPosition = InfoPosition + Dta.ui.windowHelp.HeaderInfo:GetHeight() + 20

                Dta.ui.windowHelp.TextInfo01:SetFontSize(15)
                Dta.ui.windowHelp.TextInfo01:SetPoint("TOPLEFT", Helpwindow.HelpInfo, "TOPLEFT", 0, InfoPosition)
                Dta.ui.windowHelp.TextInfo01:SetText(InfoText01, true)

                InfoPosition = InfoPosition + Dta.ui.windowHelp.TextInfo01:GetHeight() + 20

                Dta.ui.windowHelp.PicInfo01:SetPoint("TOPLEFT", Helpwindow.HelpInfo, "TOPLEFT", 0, InfoPosition)
                Dta.ui.windowHelp.PicInfo01:SetTexture("Dimtools", "textures/"..InfoPic01)

                InfoPosition = InfoPosition + Dta.ui.windowHelp.PicInfo01:GetHeight() + 20

                Dta.ui.windowHelp.TextInfo02:SetFontSize(15)
                Dta.ui.windowHelp.TextInfo02:SetPoint("TOPLEFT", Helpwindow.HelpInfo, "TOPLEFT", 0, InfoPosition)
                Dta.ui.windowHelp.TextInfo02:SetText(InfoText02, true)

                InfoPosition = InfoPosition + Dta.ui.windowHelp.TextInfo02:GetHeight() + 20

                Dta.ui.windowHelp.PicInfo02:SetPoint("TOPLEFT", Helpwindow.HelpInfo, "TOPLEFT", 0, InfoPosition)
                Dta.ui.windowHelp.PicInfo02:SetTexture("Dimtools", "textures/"..InfoPic02)

                --Empy fields to clear on switching
                Dta.ui.windowHelp.TextInfo03:SetText(InfoEmpty, true)
                Dta.ui.windowHelp.PicInfo03:SetTexture("Dimtools", "textures/"..InfoEmpty)

            end

            local HeaderHeight = Dta.ui.windowHelp.HeaderInfo:GetHeight()
            local Text01Height = Dta.ui.windowHelp.TextInfo01:GetHeight()
            local Text02Height = Dta.ui.windowHelp.TextInfo02:GetHeight()
            local Text03Height = Dta.ui.windowHelp.TextInfo03:GetHeight()
            local Pic01Height = Dta.ui.windowHelp.PicInfo01:GetHeight()
            local Pic02Height = Dta.ui.windowHelp.PicInfo02:GetHeight()
            local Pic03Height = Dta.ui.windowHelp.PicInfo03:GetHeight()
            local InfoTotalHeight = HeaderHeight + Text01Height + Text02Height + Text03Height + Pic01Height + Pic02Height + Pic03Height + 150
            Dta.ui.windowHelp.HelpInfo:SetHeight(InfoTotalHeight)
        end
    end

    Dta.Help.helpIndex = {
		"Intro",
		"Main",
		"Move",
		"Rotate",
		"Scale",
		"Copy and Paste",
		"Load and Save",
		"Import and Export",
		"Chance Log",
		"ToDo List",
		"Afterword"
	}

	Dta.Help.helpTopic = {} --{label = "", text = ""}
	local helpIndex = Dta.Help.helpIndex
	local helpTopic = Dta.Help.helpTopic

	helpTopic[helpIndex[1]] = {
		{
		label = "Intro",
		text01 = "Hello Dimensioneers,\n\nI am Kikimora, dimension builder and since a short time add-on programmer.\nEver since I started building dimensions I have been a big fan of Dimension\nToolbox, but there were some things I would have loved to see different.\n\nSo inspired by Dimension Toolbox made by Arkzy, I decided to go on a new journey\nand started on learning add-on programming in rift.\nWith the help and support of the members of RiftDreamDimensions I managed to\ncreate this add-on. I hope you will enjoy the add-on as much as I enjoyed making\nthe add-on.\n\nThere are a lot of different things in this add-on that were not possible yet in\nToolbox. Some of the differences I will list down here in the list below.\n\n<u>Big changes made:</u>\n- I made Dimension Tools a lot smaller then toolbox was, giving us more space on\n  screen when building in our dimensions. All the tools can be brought up by\n  clicking on the buttons provided in the main window. This way you only need to\n  open those tools you want to work with at that moment and keep all other tools\n  closed.\n- With Dimension Tools you can move, scale and rotate over a 1000 items at once\n  without any problems. (Though you must keep in mind the more items you use at\n  once the longer it takes to finish processing it.)\n- With the Copy/Paste option in Dimension Tools you can copy 1 item and place\n  multiple copies of it in your dimension with or without offset directly from you\n  bags or bank.\n- With the new Load/Save feature you can now choose between using one of the\n  default sets or your own saved sets. A nice new feature to the Load/Save feature\n  is that you can save a set and place multiple copies of it at once with an offset on\n  the X, Y or X axis.\n- The new Import/Export feature allows you to export sets you made to a file and\n  share that with your friends by just sending them the file. On their turn they can\n  then import the set or even multiple sets to their own saved sets.\n\nI hope I can provide you all with lots of fun and useful updates in the future while\nRift and this add-on keeps evolving.",
		text02 = "",
		text03 = "",
		pic01 = "",
		pic02 = "",
		pic03 = ""
		}
	}

	helpTopic[helpIndex[2]] = {
		{
		label = "Main",
		text01 = "The main window is where it all starts. This is the only window visible by default\nand will hold the basic information about the items along with the buttons to\nopen up all the other tools in Dimension Tools.",
		text02 = "<u>Buttons:</u>\n- ?: Opens up this help window.\n- Move Window: Opens up a window for the Move tools.\n- Rotate Window: Opens up a window for the Rotate Tools.\n- Scale Window: Opens up a window for the Scale Tools.\n- Copy / Paste: Opens up a window for the Copy and Paste Tools.\n- Load / Save: Opens up a window for the Load and Save Tools.\n- Import / Export: Opens up a window for the Import and Export Tools.\n",
		text03 = "",
		pic01 = "Main_window.jpg",
		pic02 = "",
		pic03 = ""
		}
	}

	helpTopic[helpIndex[3]] = {
		{
		label = "Move",
		text01 = "The Move Window is where you set the positions of the selected item(s).",
		text02 = "<u>Descriptions:</u>\n- X: Sets the coordinates for the X axis.\n- Y: Sets the coordinates for the Y axis.\n- Z: Sets the coordinates for the Z axis.\n- Absolute: Moves the item(s) to the coordinates set in X,Y,Z.\n- Relative: Moves the item(s) with an offset from current position by the numbers\n  set in X,Y,Z.\n- Move: Starts the moving of the item(s).\n- Reset: Resets the item(s) to your current position.\n",
		text03 = "",
		pic01 = "Move_Window.jpg",
		pic02 = "",
		pic03 = ""
			}
	}

	helpTopic[helpIndex[4]] = {
		{
		label = "Rotate",
		text01 = "The Rotate Window is where you set the Rotation of the selected item(s).\nHere I have to start with some information about rotation in add-ons, so far in\nthe add-on I have not been able to find a way to actually get group rotation done.\nSo even though it can handle a lot of items at once they will all get the same\nrotation done on each item and will not be rotated as a group.\n",
		text02 = "<u>Descriptions:</u>\n- Yaw: Sets the Rotation over the Yaw axis.\n- Pitch: Sets the Rotation over the Pitch axis.\n- Roll: Sets the Rotation over the Roll axis.\n- Absolute: Sets the item(s) Rotation to the exact numbers you put in Yaw, Pitch\n  and Roll.\n- Relative: Rotates the item(s) with the numbers you set in Yaw, Pitch and Roll\n  from the current rotation. So if current rotation is 20 degrees Yaw and you put 20\n  degrees in the Yaw box it will end up having a rotation of 40 degrees.\n- Rotate: Starts the rotation of the item(s).\n- Reset: Resets the item(s) rotation to Yaw, Pitch, Roll / 0, 0, 0.\n",
		text03 = "",
		pic01 = "Rotate_Window.jpg",
		pic02 = "",
		pic03 = ""
			}
	}

	helpTopic[helpIndex[5]] = {
		{
		label = "Scale",
		text01 = "The Scale Window is where you set the Scale of the selected item(s).",
		text02 = "<u>Descriptions:</u>\n- Scale: Sets the Scale for the selected item(s).\n- Absolute: Sets the Scale of the item(s) to the exact number you put in\n- Relative: Sets the Scale of the item(s) to the current Scale plus the number you\n  put in.\n- Scale: Starts the Scaling of the item(s).\n- Reset: Resets the item(s) Scale to 1.\n",
		text03 = "",
		pic01 = "Scale_Window.jpg",
		pic02 = "",
		pic03 = ""
			}
	}

	helpTopic[helpIndex[6]] = {
		{
		label = "Copy and Paste",
		text01 = "The Copy / Paste Items window can be used to copy the stats of an item and\ntransfer those stats to other items in your dimension or place multiple copies of\nthe item in your dimension from your bags or bank. You can do this with or\nwithout a offset.\n",
		text02 = "You can disable and enable any of the offsets by clicking the selection box in front\nof the text fields. By doing this you can choose what stats are transferred to the\nother item(s).\n\n<u>Descriptions:</u>\n- Offset X, Y, Z: Sets the offset for the X, Y, Z axis for the item(s) you have selected\n  to transfer the stats to or want to place new in your dimension.\n- Offset Yaw, Pitch, Roll: Sets the rotation offset over the Yaw, Pitch, Roll axis for\n  the item(s) you have selected to transfer the stats to or want to place new in your\n  dimension.\n- Offset Scale: Sets the Scale for the item(s) you have selected to transfer the stats\n  to or want to place new in your dimension.\n- Copy: Copies the stats of the item you have selected.\n- Paste: Pastes the stats of the copied item to the item(s) you have selected or\n  places the new item(s) from your bags or bank in your dimension.\n- Offset multiple items: Makes it possible to paste an offset to all selected items or\n  new items you place. Each time it takes the stats of the last placed item and\n  applies the offset to the next item in row. Can be used to for example create a\n  wall or well designed patterns.\n- Use New Item: Activates the possibility to place new items from your bags or\n  bank into your dimension.\n",
		text03 = "<u>Descriptions of new options:</u>\n- Bags: Will set it so that only items from your bags are taken to place as new\n  items.\n- Bank: Will set it so that only items from your bank are taken to place as new\n  items.\n- Both: Will set it so that items from both your bags and bank are taken to place\n  as new items. Be aware that it will take at random from bags and bank. This\n  option can be really useful if you do not have enough items in your bags but you\n  know you have some more in your bank, but you cannot summon a banker\n  anymore or just don’t feel like going out of your dimension at that time to pick up\n  some extra items from your bank.\n- Nr. of Items (As seen in the picture below): This will be showing up when both\n  Offset multiple items and Use New Item is activated. This gives you the possibility\n  to paste in multiple new items from your bags or bank. It will check if you have\n  enough items to place if not then it will say how many items you can max place.",
		pic01 = "Copy_Window_01.jpg",
		pic02 = "Copy_Window_02.jpg",
		pic03 = "Copy_Window_03.jpg"
		}
	}

	helpTopic[helpIndex[7]] = {
		{
		label = "Load and Save",
		text01 = "The Load / Save Sets window is all about saving the sets you created to be able\nto load them up on other places in your dimension or in other dimensions you\nhave.",
		text02 = "<u>Descriptions:</u>\n- Name (Textbox):  Here you set the name for the set you want to save.\n- Save Set: Saves the set to file.\n\n- Default Sets: Gives you the possibility to load the default sets provided by\n  me and the rest of the RiftDreamDimensions team. These sets are tools\n  created to aid you in your creativity.\n- Saved Sets : Gives you the possibility to load your own made sets into your\n  Dimensions.\n- Tbx Sets: Gives you the possibility to load your old Toolbox Sets, explanation on\n   how that works you find later in this help.\n- Name (Drop box): A list of all the saved items. Depending on if you have chosen\n  Default Sets or Saved Sets the drop box will go to different lists.\n- Load Set: Loads the selected set into your dimension using items you have\n  selected in your dimension or using items from your bags.\n- Print Materials: Print out a list of items needed for the selected set.\n- Load New Items: Makes it possible to load the set using items from your bags.\n\nThe following items will only be active when Saved Sets or Tbx Sets are activated.\n- Remove Set: Removes the selected set from your saved list (only Saved Sets) .\n- Load at original location: If this is selected the set will be loaded with the stats it\n  was originally saved with. Otherwise the set will be loaded close to your current\n  position.\n- Place Multiple Copies Of Set: This activates the possibility to load multiple copies\n  of your set into your dimension and set a X, Y or Z offset between the placed sets.\n\nThe options used for this are shown in the picture below here.\n- Nr. Copies: Lets you set how many copies of the set you want to place in your\n  dimension.\n-X: Sets the X offset.\n-Y: Sets the Y offset.\n-Z: Sets the Z offset.",
		text03 = "Tbx Sets is somewhat special. By default that set is empty, but for old Dimension\nToolbox users this is a way to get your sets that you made with Dimension Toolbox\nto work within Dimension Tools too.\n\nTo get your old sets loaded into Dimension Tools you need to do the following:\n1: Locate the tbx.lua File, found under:\n   /Users/[YourName]/Documents/RIFT/Interface/Saved/[YourRiftAccount]\n   /SavedVariables\n2: Copy the file txb.lua into the same directory.\n3: Rename the new file to tbx_Import.lua\n4: Now start up rift and you should have all your old Dimension Toolbox Sets there\n   to load up and place in your dimensions.\n\nBe aware you will not be able to remove any of the set loaded under Tbx Sets, so\nI highly recommend that before you copy and rename the file go to Dimension\nToolbox and delete all sets you don’t want to use in Dimension Tools anymore.",
		pic01 = "Load_Window_01.jpg",
		pic02 = "Load_Window_02.jpg",
		pic03 = "Load_Window_03.jpg"
		}
	}

	helpTopic[helpIndex[8]] = {
		{
		label = "Import and Export",
		text01 = "The Import / Export Sets window is all about sharing your sets with other friends\nin the game.\nThe sets will be saved in and loaded from a file called: Dimtools_Export.lua\nThe file can be found under: \n/Users/[YourName]/Documents/RIFT/Interface/Saved/SavedVariables",
		text02 = "<u>Descriptions:</u>\n- Saved Sets: Sets the first drop box to your Dimension Tools Sets.\n- Tbx Sets: Sets the first drop box to your Toolbox Sets.\n- Name (First drop box): Here you can select any of your own saved sets to export\n  to file.\n- Export: Exports the selected set to file.\n- Name (Second drop box): Here you can select any of the sets saved in the export\n  File.\n- Import: Imports the selected set to your own saved sets list and then removes\n  the set from the export file.\n\nTo give a set or multiple sets to a friend, you have to export the sets and then\nlogout or type [/reloadui] in the chat to save the file.  After that you can send the\nDimtools_Export.lua file located at:\n/Users/[YourName]/Documents/RIFT/Interface/Saved/SavedVariables\n\nIf you received a Dimtools_Export.lua file you have to copy it into the\nSavedVariables directory found under:\n/Users/[YourName]/Documents/RIFT/Interface/Saved/SavedVariables\nThen start the game and then you can use the import option to get the set or sets\nin your saved sets. Keep in mind you can NOT copy the file into the directory if you\nare logged into the game. The game does NOT allow overwriting of files when you\nare logged in.",
		text03 = "",
		pic01 = "Import_Window.jpg",
		pic02 = "",
		pic03 = ""
		}
	}

	helpTopic[helpIndex[9]] = {
		{
		label = "Chance Log",
		text01 = "Version 1.1.5.r12\n- Made changes to handle the items in dimensions better.\n- Changed the way old Toolbox Sets are handled, it is no longer needed to\n  copy the Toolbox saved variable to the Dimension Tools directory. You\n  can now copy the file in the same directory and rename the new file to\n  tbx_Import.lua\n- Updated the help\n\nVersion 1.1.5.r11\n- Minor changes in code to improve performance a bit.\n\nVersion 1.1.5.r4\n- Made some cosmetic changes in the copy / paste window\n- Fixed error with load Default sets\n- Added Dimension Toolbox Sets support for load sets and export sets\n- Updated the Help\n- Added Automatic Selection of loaded sets and pasted items\n\nVersion 1.1.4\n- Fixed error on pasting items without first copying an items, now gives\n  msg that you have to first copy an item.\n- Added possibility to load multiple copies of saved sets at once with an\n  offset.\n\nVersion 1.1.3\n- Adjusted the Save/Load Sets option to work without errors for new\n  installations of the addon.\n- Adjusted the Import/Export Sets option to work without errors for new\n  installations of the addon.\n- Added the possibility under Save/Load Sets to choose if you want to\n  load the set using new items or items selected in your dimension.\n",
		text02 = "",
		text03 = "",
		pic01 = "",
		pic02 = "",
		pic03 = ""
		}
	}

	helpTopic[helpIndex[10]] = {
		{
		label = "ToDo List",
		text01 = "",
		text02 = "",
		text03 = "",
		pic01 = "",
		pic02 = "",
		pic03 = ""
		}
	}

	helpTopic[helpIndex[11]] = {
		{
		label = "Afterword",
		text01 = "I want to give my special thanks to the RiftDreamDimensions.com team\nfor supporting me on the making of this add-on and beta testing it for me.\n\nI hope you will all enjoy the add-on and for questions and other information visit\nus at http://riftdreamdimensions.com/ \n\nWebsites:\nhttp://riftdreamdimensions.com/ - for all your Trion game fun.\nhttp://www.curse.com/addons/rift - This Add-on and many others.",
		text02 = "",
		text03 = "",
		pic01 = "",
		pic02 = "",
		pic03 = ""
		}
	}
