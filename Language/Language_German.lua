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
LangG.Buttons.ToClipboard = "In Zwischenabl."
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
	"Auswahl-Delta",
	"Transformierter X-Abstand",
	"Transformierter Y-Abstand",
	"Transformierter Z-Abstand"
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
LangG.Text.SavedSets = "Gespeich. Sets" -- >>==<<
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
LangG.Text.ConfirmUsePosition = "Die ursprüngliche Position dieses Sets ist %.1fm entfernt.\nDen Vorgang fortsetzen?"

----------------------------------------
--Prints
----------------------------------------
LangG.Prints = {}
--Main
LangG.Prints.DimensionOnly = "Dieses Addon ist nur für die Benutzung innerhalb von Dimensionen gedacht."
LangG.Prints.ProcessFinished = "Vorgang Beendet."
LangG.Prints.SetFinished = "Item set \"%s\" ist geladen and ausgewählt."
LangG.Prints.PasteFinished = "Alle Gegenstände sind platziert und ausgewählt."
LangG.Prints.WordFinished = "Das Wort ist platziert und ausgewählt."
--Copy / Paste
LangG.Prints.Copy_SelectItem = "Bitte einen Gegenstand auswählen um Attribute zu kopieren."
LangG.Prints.NumbersOnly = "Bitte nur numerische Werte eingeben."
LangG.Prints.CopyFirst = "Bitte vor dem Einfügen erst etwas kopieren."
LangG.Prints.SelectItemSource = "Bitte mindestens eine Quelle für neue Gegenstände auswählen."
LangG.Prints.NotPasteInventory = "Zwischenablage kann nicht eingefügt werden - folgende Gegenstände fehlen im Inventar:"
LangG.Prints.NotPasteSelection = "Zwischenablage kann nicht eingefügt werden - folgende Gegenstände fehlen in der Auswahl:"
--Tribal Magic
LangG.Prints.NoRoundTable = "Du hast scheinbar keinen Runden Stammestisch in deinem Inventar!"
--Alfiebet
LangG.Prints.SelectFont = "Wähle eine Schriftart."
LangG.Prints.SelectSize = "Wähle eine Größe."
LangG.Prints.SelectSkin = "Wähle eine Oberfläche."
LangG.Prints.OnlyLetters = "Es sind nur Buchstaben für ein Wort erlaubt."
LangG.Prints.TypeWord = "Bitte zuerst ein Wort eingeben."
LangG.Prints.WordMissingItems = "Das Wort kann nicht erstellt werden - folgende Gegenstände fehlen im Inventar:"
LangG.Prints.WordNeededItems = "Folgende Gegenstände werden benötigt um das Wort \"%s\" zu erstellen:"
LangG.Prints.WordCouldNotPrint = "Die Materialien konnten nicht aufgelistet werden."
--Import/Export
LangG.Prints.SetNotFound = "Item set \"%s\" nicht gefunden."
LangG.Prints.SelectExport = "Du mußt ein Set auswählen um es zu exportieren."
LangG.Prints.Exported = "Item set \"%s\" exportiert."
LangG.Prints.SelectImport = "Du mußt ein Set auswählen um es zu importieren."
LangG.Prints.Imported = "Item set \"%s\" importiert."
--Load / Save
LangG.Prints.Saved = "Item set \"%s\" gespeichert."
LangG.Prints.MinOneItem = "Es muß mindestens ein Gegenstand ausgewählt sein um zu speichern."
LangG.Prints.EnterName = "Es wird ein Name benötigt um das Set zu speichern."
LangG.Prints.LoadNeededItems = "Folgende Gegenstände werden benötigt um \"%s\" zu laden:"
LangG.Prints.LoadPrintMats = "Wähle ein Set um dessen Materialliste auszugeben."
LangG.Prints.LoadSelectSet = "Wähle ein Set um es zu laden."
LangG.Prints.NotLoadedBags = "Set kann nicht geladen werden - folgende Gegenstände fehlen im Inventar:"
LangG.Prints.NotLoadedSelection = "Set kann nicht geladen werden - folgende Gegenstände fehlen in der Auswahl:"
LangG.Prints.SetLoaded = "Item set \"%s\" geladen."
LangG.Prints.SetRemoved = "Item set \"%s\" gelöscht."
LangG.Prints.NotRemoved = "\"%s\" konnte nicht gelöscht werden - kein Set mit diesem Namen vorhanden."
LangG.Prints.RemoveSelectSet = "Wähle ein Set um es zu löschen."
LangG.Prints.CopiedClipboard =  "Item set \"%s\" wurde in die Zwischenablage von \"Kopieren & Einfügen\" kopiert."
--Measurements
LangG.Prints.SelectType = "Wähle eine Form."
LangG.Prints.SelectOrientation = "Wähle eine Ausrichtung."
LangG.Prints.TypeSize = "Wähle eine Größe."
LangG.Prints.SizeC = "Die Größe muß im Bereich von %.2f bis %.1f liegen."
LangG.Prints.Selection1 = "Transformierte Modi benötigen einen ausgewählten Gegenstand."
LangG.Prints.Selection2 = "Auswahl-Delta benötigt zwei ausgewählte Gegenstände."
--Move, Rotate, Scale
LangG.Prints.ModifyPosition = "Bitte wähle einen Gegenstand aus um dessen Position zu verändern."
LangG.Prints.ModifyRotation = "Bitte wähle einen Gegenstand aus um dessen Rotation zu verändern."
LangG.Prints.ModifyScale = "Bitte wähle einen Gegenstand aus um dessen Größe zu verändern."
