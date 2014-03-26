Dta.Help = {}

    function Dta.Help.InfoHandler(Item)
        Dta.ui.windowHelp.ScrollInfoLoad:ScrollTo(0)
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
		Lang[Dta.Language].Intro.Label,
		Lang[Dta.Language].Main.Label,
		Lang[Dta.Language].Move.Label,
		Lang[Dta.Language].Rotate.Label,
		Lang[Dta.Language].Scale.Label,
		Lang[Dta.Language].CopyandPaste.Label,
		Lang[Dta.Language].LoadandSave.Label,
		Lang[Dta.Language].ImportandExport.Label,
		Lang[Dta.Language].TribalMagic.Label,
		Lang[Dta.Language].OffsetCalc.Label,
		Lang[Dta.Language].Alfiebet.Label,
		Lang[Dta.Language].ChanceLog.Label,
		Lang[Dta.Language].Afterword.Label
	}

	Dta.Help.helpTopic = {} --{label = "", text = ""}
	local helpIndex = Dta.Help.helpIndex
	local helpTopic = Dta.Help.helpTopic

	helpTopic[helpIndex[1]] = {
		{
		label = Lang[Dta.Language].Intro.Label,
		text01 = Lang[Dta.Language].Intro.Text1,
		text02 = Lang[Dta.Language].Intro.Text2,
		text03 = Lang[Dta.Language].Intro.Text3,
		pic01 = "",
		pic02 = "",
		pic03 = ""
		}
	}

	helpTopic[helpIndex[2]] = {
		{
		label = Lang[Dta.Language].Main.Label,
		text01 = Lang[Dta.Language].Main.Text1,
		text02 = Lang[Dta.Language].Main.Text2,
		text03 = Lang[Dta.Language].Main.Text3,
		pic01 = "Main_window.jpg",
		pic02 = "",
		pic03 = ""
		}
	}

	helpTopic[helpIndex[3]] = {
		{
		label = Lang[Dta.Language].Move.Label,
		text01 = Lang[Dta.Language].Move.Text1,
		text02 = Lang[Dta.Language].Move.Text2,
		text03 = Lang[Dta.Language].Move.Text3,
		pic01 = "Move_Window.jpg",
		pic02 = "",
		pic03 = ""
			}
	}

	helpTopic[helpIndex[4]] = {
		{
		label = Lang[Dta.Language].Rotate.Label,
		text01 = Lang[Dta.Language].Rotate.Text1,
		text02 = Lang[Dta.Language].Rotate.Text2,
		text03 = Lang[Dta.Language].Rotate.Text3,
		pic01 = "Rotate_Window.jpg",
		pic02 = "",
		pic03 = ""
			}
	}

	helpTopic[helpIndex[5]] = {
		{
		label = Lang[Dta.Language].Scale.Label,
		text01 = Lang[Dta.Language].Scale.Text1,
		text02 = Lang[Dta.Language].Scale.Text2,
		text03 = Lang[Dta.Language].Scale.Text3,
		pic01 = "Scale_Window.jpg",
		pic02 = "",
		pic03 = ""
			}
	}

	helpTopic[helpIndex[6]] = {
		{
		label = Lang[Dta.Language].CopyandPaste.Label,
		text01 = Lang[Dta.Language].CopyandPaste.Text1,
		text02 = Lang[Dta.Language].CopyandPaste.Text2,
		text03 = Lang[Dta.Language].CopyandPaste.Text3,
		pic01 = "Copy_Window_01.jpg",
		pic02 = "Copy_Window_02.jpg",
		pic03 = "Copy_Window_03.jpg"
		}
	}

	helpTopic[helpIndex[7]] = {
		{
		label = Lang[Dta.Language].LoadandSave.Label,
		text01 = Lang[Dta.Language].LoadandSave.Text1,
		text02 = Lang[Dta.Language].LoadandSave.Text2,
		text03 = Lang[Dta.Language].LoadandSave.Text3,
		pic01 = "Load_Window_01.jpg",
		pic02 = "Load_Window_02.jpg",
		pic03 = "Load_Window_03.jpg"
		}
	}

	helpTopic[helpIndex[8]] = {
		{
		label = Lang[Dta.Language].ImportandExport.Label,
		text01 = Lang[Dta.Language].ImportandExport.Text1,
		text02 = Lang[Dta.Language].ImportandExport.Text2,
		text03 = Lang[Dta.Language].ImportandExport.Text3,
		pic01 = "Import_Window.jpg",
		pic02 = "",
		pic03 = ""
		}
	}

	helpTopic[helpIndex[9]] = {
		{
		label = Lang[Dta.Language].TribalMagic.Label,
		text01 = Lang[Dta.Language].TribalMagic.Text1,
		text02 = Lang[Dta.Language].TribalMagic.Text2,
		text03 = Lang[Dta.Language].TribalMagic.Text3,
		pic01 = "Flying_Window.jpg",
		pic02 = "",
		pic03 = ""
		}
	}

	helpTopic[helpIndex[10]] = {
		{
		label = Lang[Dta.Language].OffsetCalc.Label,
		text01 = Lang[Dta.Language].OffsetCalc.Text1,
		text02 = Lang[Dta.Language].OffsetCalc.Text2,
		text03 = Lang[Dta.Language].OffsetCalc.Text3,
		pic01 = "Offset_Calc_Window.jpg",
		pic02 = "",
		pic03 = ""
		}
	}


	helpTopic[helpIndex[11]] = {
		{
		label = Lang[Dta.Language].Alfiebet.Label,
		text01 = Lang[Dta.Language].Alfiebet.Text1,
		text02 = Lang[Dta.Language].Alfiebet.Text2,
		text03 = Lang[Dta.Language].Alfiebet.Text3,
		pic01 = "Alfiebet_Window_01.jpg",
		pic02 = "",
		pic03 = ""
		}
	}

	helpTopic[helpIndex[12]] = {
		{
		label = Lang[Dta.Language].ChanceLog.Label,
		text01 = Lang[Dta.Language].ChanceLog.Text1,
		text02 = Lang[Dta.Language].ChanceLog.Text2,
		text03 = Lang[Dta.Language].ChanceLog.Text3,
		pic01 = "",
		pic02 = "",
		pic03 = ""
		}
	}

	helpTopic[helpIndex[13]] = {
		{
		label = Lang[Dta.Language].Afterword.Label,
		text01 = Lang[Dta.Language].Afterword.Text1,
		text02 = Lang[Dta.Language].Afterword.Text2,
		text03 = Lang[Dta.Language].Afterword.Text3,
		pic01 = "",
		pic02 = "",
		pic03 = ""
		}
	}
