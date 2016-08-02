local Dta = select(2, ...)

Dta.Help = {}

function Dta.Help.InfoHandler(index)
	local helpUI = Dta.ui.windowHelp.content
	helpUI.ScrollInfoLoad:ScrollTo(0)
	local info = Dta.Help.helpTopic[index]

	local InfoLabel = info.label
	local InfoText01 = info.text01
	local InfoText02 = info.text02
	local InfoText03 = info.text03
	local InfoPic01 = info.pic01
	local InfoPic02 = info.pic02
	local InfoPic03 = info.pic03
	local InfoPosition = 0

	helpUI.HeaderInfo:SetFontSize(30)
	helpUI.HeaderInfo:SetPoint("TOPLEFT", helpUI.HelpInfo, "TOPLEFT", 0, 0)
	helpUI.HeaderInfo:SetText("<u>"..InfoLabel.."</u>", true)

	InfoPosition = InfoPosition + helpUI.HeaderInfo:GetHeight() + 20

	helpUI.TextInfo01:SetFontSize(15)
	helpUI.TextInfo01:SetPoint("TOPLEFT", helpUI.HelpInfo, "TOPLEFT", 0, InfoPosition)
	helpUI.TextInfo01:SetText(InfoText01, true)

	InfoPosition = InfoPosition + helpUI.TextInfo01:GetHeight() + 20

	helpUI.PicInfo01:SetPoint("TOPLEFT", helpUI.HelpInfo, "TOPLEFT", 30, InfoPosition)
	helpUI.PicInfo01:SetTexture(Dta.AddonID, "textures/"..InfoPic01)

	InfoPosition = InfoPosition + helpUI.PicInfo01:GetHeight() + 20

	helpUI.TextInfo02:SetFontSize(15)
	helpUI.TextInfo02:SetPoint("TOPLEFT", helpUI.HelpInfo, "TOPLEFT", 0, InfoPosition)
	helpUI.TextInfo02:SetText(InfoText02, true)

	InfoPosition = InfoPosition + helpUI.TextInfo02:GetHeight() + 20

	helpUI.PicInfo02:SetPoint("TOPLEFT", helpUI.HelpInfo, "TOPLEFT", 30, InfoPosition)
	helpUI.PicInfo02:SetTexture(Dta.AddonID, "textures/"..InfoPic02)

	InfoPosition = InfoPosition + helpUI.PicInfo02:GetHeight() + 20

	helpUI.TextInfo03:SetFontSize(15)
	helpUI.TextInfo03:SetPoint("TOPLEFT", helpUI.HelpInfo, "TOPLEFT", 0, InfoPosition)
	helpUI.TextInfo03:SetText(InfoText03, true)

	InfoPosition = InfoPosition + helpUI.TextInfo03:GetHeight() + 20

	helpUI.PicInfo03:SetPoint("TOPLEFT", helpUI.HelpInfo, "TOPLEFT", 30, InfoPosition)
	helpUI.PicInfo03:SetTexture(Dta.AddonID, "textures/"..InfoPic03)

	local InfoTotalHeight = InfoPosition + helpUI.PicInfo03:GetHeight() + 30
	helpUI.HelpInfo:SetHeight(InfoTotalHeight)
end

function Dta.Help.Init()
	Dta.Help.helpIndex = {
		Dta.Locale.Intro.Label,
		Dta.Locale.Main.Label,
		Dta.Locale.Move.Label,
		Dta.Locale.Rotate.Label,
		Dta.Locale.Scale.Label,
		Dta.Locale.CopyandPaste.Label,
		Dta.Locale.LoadandSave.Label,
		Dta.Locale.ImportandExport.Label,
		Dta.Locale.TribalMagic.Label,
		Dta.Locale.OffsetCalc.Label,
		Dta.Locale.Alfiebet.Label,
		Dta.Locale.Reskin.Label,
		Dta.Locale.Afterword.Label
	}

	Dta.Help.helpTopic = {}
	local helpTopic = Dta.Help.helpTopic

	helpTopic[1] = {
		label = Dta.Locale.Intro.Label,
		text01 = Dta.Locale.Intro.Text1,
		text02 = Dta.Locale.Intro.Text2,
		text03 = Dta.Locale.Intro.Text3,
		pic01 = "",
		pic02 = "",
		pic03 = ""
	}

	helpTopic[2] = {
		label = Dta.Locale.Main.Label,
		text01 = Dta.Locale.Main.Text1,
		text02 = Dta.Locale.Main.Text2,
		text03 = Dta.Locale.Main.Text3,
		pic01 = "Main_window.jpg",
		pic02 = "",
		pic03 = ""
	}

	helpTopic[3] = {
		label = Dta.Locale.Move.Label,
		text01 = Dta.Locale.Move.Text1,
		text02 = Dta.Locale.Move.Text2,
		text03 = Dta.Locale.Move.Text3,
		pic01 = "Move_Window.jpg",
		pic02 = "",
		pic03 = ""
	}

	helpTopic[4] = {
		label = Dta.Locale.Rotate.Label,
		text01 = Dta.Locale.Rotate.Text1,
		text02 = Dta.Locale.Rotate.Text2,
		text03 = Dta.Locale.Rotate.Text3,
		pic01 = "Rotate_Window.jpg",
		pic02 = "",
		pic03 = ""
	}

	helpTopic[5] = {
		label = Dta.Locale.Scale.Label,
		text01 = Dta.Locale.Scale.Text1,
		text02 = Dta.Locale.Scale.Text2,
		text03 = Dta.Locale.Scale.Text3,
		pic01 = "Scale_Window.jpg",
		pic02 = "",
		pic03 = ""
	}

	helpTopic[6] = {
		label = Dta.Locale.CopyandPaste.Label,
		text01 = Dta.Locale.CopyandPaste.Text1,
		text02 = Dta.Locale.CopyandPaste.Text2,
		text03 = Dta.Locale.CopyandPaste.Text3,
		pic01 = "Copy_Window_01.jpg",
		pic02 = "Copy_Window_02.jpg",
		pic03 = ""
	}

	helpTopic[7] = {
		label = Dta.Locale.LoadandSave.Label,
		text01 = Dta.Locale.LoadandSave.Text1,
		text02 = Dta.Locale.LoadandSave.Text2,
		text03 = Dta.Locale.LoadandSave.Text3,
		pic01 = "Load_Window_01.jpg",
		pic02 = "Load_Window_02.jpg",
		pic03 = ""
	}

	helpTopic[8] = {
		label = Dta.Locale.ImportandExport.Label,
		text01 = Dta.Locale.ImportandExport.Text1,
		text02 = Dta.Locale.ImportandExport.Text2,
		text03 = Dta.Locale.ImportandExport.Text3,
		pic01 = "Import_Window.jpg",
		pic02 = "",
		pic03 = ""
	}

	helpTopic[9] = {
		label = Dta.Locale.TribalMagic.Label,
		text01 = Dta.Locale.TribalMagic.Text1,
		text02 = Dta.Locale.TribalMagic.Text2,
		text03 = Dta.Locale.TribalMagic.Text3,
		pic01 = "Flying_Window.jpg",
		pic02 = "",
		pic03 = ""
	}

	helpTopic[10] = {
		label = Dta.Locale.OffsetCalc.Label,
		text01 = Dta.Locale.OffsetCalc.Text1,
		text02 = Dta.Locale.OffsetCalc.Text2,
		text03 = Dta.Locale.OffsetCalc.Text3,
		pic01 = "Offset_Calc_Window.jpg",
		pic02 = "",
		pic03 = ""
	}

	helpTopic[11] = {
		label = Dta.Locale.Alfiebet.Label,
		text01 = Dta.Locale.Alfiebet.Text1,
		text02 = Dta.Locale.Alfiebet.Text2,
		text03 = Dta.Locale.Alfiebet.Text3,
		pic01 = "Alfiebet_Window_01.jpg",
		pic02 = "",
		pic03 = ""
	}

	helpTopic[12] = {
		label = Dta.Locale.Reskin.Label,
		text01 = Dta.Locale.Reskin.Text1,
		text02 = Dta.Locale.Reskin.Text2,
		text03 = Dta.Locale.Reskin.Text3,
		pic01 = "",
		pic02 = "",
		pic03 = ""
	}

	helpTopic[13] = {
		label = Dta.Locale.Afterword.Label,
		text01 = Dta.Locale.Afterword.Text1,
		text02 = Dta.Locale.Afterword.Text2,
		text03 = Dta.Locale.Afterword.Text3,
		pic01 = "",
		pic02 = "",
		pic03 = ""
	}
end
