local Dta = select(2, ...)
local Lang = Dta.Lang

Lang["German"] = {}
local LangG = Lang["German"]
----------------------------------------
--Help
----------------------------------------

-- TODO

----------------------------------------
--Buttons
----------------------------------------
LangG.Buttons = {}
LangG.Buttons.MoveWindow = "Verschieben"
LangG.Buttons.RotateWindow = "Drehen"
LangG.Buttons.ScaleWindow = "Skalieren"
LangG.Buttons.CopyPaste = "Kopieren/Einfg."
LangG.Buttons.LoadSave = "Laden/Speichern"
LangG.Buttons.ImportExport = "Import / Export"
LangG.Buttons.TribalMagic = "Tribal Magic"
LangG.Buttons.OffsetCalc = "Abstand Ber."
LangG.Buttons.Copy = "Kopieren"
LangG.Buttons.Paste = "Einfügen"
LangG.Buttons.Pick = "Auswählen"
LangG.Buttons.Import = "Importieren"
LangG.Buttons.Export = "Exportieren"
LangG.Buttons.Place = "Platzieren"
LangG.Buttons.PickUp = "Aufheben"
LangG.Buttons.SaveSet = "Set speichern"
LangG.Buttons.LoadSet = "Set laden"
LangG.Buttons.RemoveSet = "Set löschen"
LangG.Buttons.PrintMaterials = "Materialliste"
LangG.Buttons.Move = "Verschieben"
LangG.Buttons.Reset = "Zurücksetzen"
LangG.Buttons.Rotate = "Drehen"
LangG.Buttons.Scale = "Skalieren"
LangG.Buttons.Calculate = "Berechnen"
LangG.Buttons.Detect = "Ermitteln"
LangG.Buttons.LoadWord = "Wort laden"
LangG.Buttons.Yes = "Ja"
LangG.Buttons.No = "Nein"
LangG.Buttons.OK = "O.K."
LangG.Buttons.Cancel = "ABBRECHEN"

----------------------------------------
--Menus
----------------------------------------
LangG.Menus = {}
LangG.Menus.WindowStyle = { "Standard", "Randlos" }
LangG.Menus.ItemType = {
	"Würfel",
	"Planke",
	"Pfosten",
	"Rechteck",
	"Platte",
	"Boden",
	"Flurboden",
	"Großer Boden"
}
LangG.Menus.Orientation = {
	"Standard",
	"Pitch 90",
	"Yaw 90",
	"Roll 90",
	"Pitch & Yaw 90",
	"Pitch & Roll 90",
	"Auswahl-Delta"
}
----------------------------------------
--Titles
----------------------------------------
LangG.Titles = {}
LangG.Titles.Main = "Dimension Tools"
LangG.Titles.Move = "Verschieben"
LangG.Titles.Rotate = "Drehen"
LangG.Titles.Scale = "Skalieren"
LangG.Titles.CopyPaste = "Kopieren / Einfügen"
LangG.Titles.LoadSave = "Laden / Speichern"
LangG.Titles.ImportExport = "Import / Export"
LangG.Titles.TribalMagic = "Tribal Magic"
LangG.Titles.OffsetCalc = "Abstand Berechnen"
LangG.Titles.Help = "Dimension Tools Hilfe"
LangG.Titles.Settings = "Einstellungen"

----------------------------------------
--Text
----------------------------------------
LangG.Text = {}
LangG.Text.Yaw = "Yaw"
LangG.Text.Pitch = "Pitch"
LangG.Text.Roll = "Roll"
LangG.Text.Scale = "Größe"
LangG.Text.NothingSelected = "Nichts ausgewählt"
LangG.Text.NrSelectItems = "Anzahl Gegenstände:"
LangG.Text.MultiSelectItems = "Mehrere Gegenstände ausgewählt"
LangG.Text.Offset = "Abstand"
LangG.Text.OffsetMultiItems = "Reihe mehrerer Kopien"
LangG.Text.FlickerReduce = "Flimmerreduktion"
LangG.Text.UseNewItems = "Neue Gegenstände"
LangG.Text.SelectionPivot = "Spezieller Drehpunkt"
LangG.Text.NrItems = "Anz. Kopien"
LangG.Text.Bags = "Taschen"
LangG.Text.BankBags = "Bank"
--LangG.Text.Vaults = "Vaults"
LangG.Text.DefaultSets = "Standard Sets"
LangG.Text.SavedSets = "Gespeicherte Sets" -- >>==<<
LangG.Text.TbxSets = "Tbx Sets"
LangG.Text.Name = "Name"
LangG.Text.Search = "Suche"
LangG.Text.LoadOrigionalLocation = "An ursprüngl. Position"
LangG.Text.MultiCopies = "Mehrere Kopien platzieren"
LangG.Text.NrCopies = "Anz. Kopien"
LangG.Text.Absolute = "Absolut"
LangG.Text.Relative = "Relativ"
LangG.Text.MoveAsGroup = "Als Gruppe"
LangG.Text.Type = "Form"
LangG.Text.Orientation = "Ausrichtung"
LangG.Text.Word = "Wort"
LangG.Text.Font = "Schriftart"
LangG.Text.Size = "Größe"
LangG.Text.Skin = "Oberfläche"
LangG.Text.Horizontal = "Horizontal platzieren"
LangG.Text.Vertical = "Vertikal platzieren"
LangG.Text.ConsoleMessages = "Konsolen-Nachrichten"
LangG.Text.WindowStyle = "Fenster-Stil"
LangG.Text.NotIdleNotification = "Previous operation has not finished yet.\nAbort currently running operation now?"
LangG.Text.ConfirmDeleteSet = "Gegenstands-Set '%s' löschen?"
