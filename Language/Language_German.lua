local Dta = select(2, ...)

Dta.Lang.German = {}
local German = Dta.Lang.German
----------------------------------------
--Help
----------------------------------------

-- TODO

----------------------------------------
--Buttons
----------------------------------------
German.Buttons = {}
German.Buttons.MoveWindow = "Verschieben"
German.Buttons.RotateWindow = "Drehen"
German.Buttons.ScaleWindow = "Skalieren"
German.Buttons.CopyPaste = "Kopieren/Einfg."
German.Buttons.LoadSave = "Laden/Speichern"
German.Buttons.ImportExport = "Import / Export"
German.Buttons.TribalMagic = "Tribal Magic"
German.Buttons.OffsetCalc = "Abstand Ber."
German.Buttons.Copy = "Kopieren"
German.Buttons.Paste = "Einfügen"
German.Buttons.Pick = "Auswählen"
German.Buttons.Import = "Importieren"
German.Buttons.ImportText = "Text Import"
German.Buttons.Export = "Exportieren"
German.Buttons.ExportText = "Text Export"
German.Buttons.Place = "Platzieren"
German.Buttons.PickUp = "Aufheben"
German.Buttons.SaveSet = "Set speichern"
German.Buttons.LoadSet = "Set laden"
German.Buttons.RemoveSet = "Set löschen"
German.Buttons.PrintMaterials = "Materialliste"
German.Buttons.ToClipboard = "In Zwischenabl."
German.Buttons.Move = "Verschieben"
German.Buttons.Reset = "Zurücksetzen"
German.Buttons.Rotate = "Drehen"
German.Buttons.Scale = "Skalieren"
German.Buttons.Calculate = "Berechnen"
German.Buttons.Detect = "Erkennen"
German.Buttons.Transfer = "Übertragen"
German.Buttons.LoadWord = "Wort laden"
German.Buttons.Yes = "Ja"
German.Buttons.No = "Nein"
German.Buttons.OK = "O.K."
German.Buttons.Cancel = "ABBRECHEN"
German.Buttons.Apply = "Anwenden"
German.Buttons.More = "Mehr..."
German.Buttons.Less = "Weniger..."
German.Buttons.Selection = "Auswahl"
German.Buttons.InvertSelection = "Invertieren"

----------------------------------------
--Menus
----------------------------------------
German.Menus = {}
German.Menus.WindowStyle = { "Standard", "Randlos" }
German.Menus.ItemType = {
	"Würfel",
	"Planke",
	"Pfosten",
	"Rechteck",
	"Quadrat",
	"Boden",
	"Flurboden",
	"Großer Boden"
}
German.Menus.Orientation = {
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
German.Titles = {}
German.Titles.Main = "Tinker Tools"
German.Titles.Move = "Verschieben"
German.Titles.Rotate = "Drehen"
German.Titles.Scale = "Skalieren"
German.Titles.CopyPaste = "Kopieren / Einfügen"
German.Titles.LoadSave = "Laden / Speichern"
German.Titles.ImportExport = "Import / Export"
German.Titles.TribalMagic = "Tribal Magic"
German.Titles.OffsetCalc = "Abstand Berechnen"
German.Titles.Help = "Tinker Tools Hilfe"
German.Titles.Settings = "Einstellungen"
German.Titles.TransferValues = "Werte übergeben an:"
German.Titles.Reskin = "Oberfläche Ersetzen"
German.Titles.Selection = "Auswahl"
German.Titles.MaterialList = "Materialliste"

----------------------------------------
--Text
----------------------------------------
German.Text = {}
German.Text.Yaw = "Yaw"
German.Text.Pitch = "Pitch"
German.Text.Roll = "Roll"
German.Text.Scale = "Größe"
German.Text.NothingSelected = "Nichts ausgewählt"
German.Text.NrSelectItems = "Anzahl Gegenstände:"
German.Text.MultiSelectItems = "%d Gegenstände ausgewählt"
German.Text.Offset = "Abstand"
German.Text.OffsetMultiItems = "Reihe mehrerer Kopien"
German.Text.FlickerReduce = "Flimmerreduktion"
German.Text.UseNewItems = "Neue Gegenstände"
German.Text.SelectionPivot = "Spezieller Drehpunkt"
German.Text.NrItems = "Anz. Kopien"
German.Text.Bags = "Taschen"
German.Text.BankBags = "Bank"
--German.Text.Vaults = "Vaults"
German.Text.DefaultSets = "Standard Sets"
German.Text.SavedSets = "Gespeich. Sets" -- >>==<<
German.Text.TbxSets = "Tbx Sets"
German.Text.Name = "Name"
German.Text.Search = "Suche"
German.Text.LoadOrigionalLocation = "An ursprüngl. Position"
German.Text.UseRefPoint = "Referenzpunkt benutzen"
German.Text.Absolute = "Absolut"
German.Text.Relative = "Relativ"
German.Text.MoveAsGroup = "Als Gruppe"
German.Text.LocalAxes = "Lokale Achsen"
German.Text.Type = "Form"
German.Text.Orientation = "Ausrichtung"
German.Text.Word = "Wort"
German.Text.Font = "Schriftart"
German.Text.Size = "Größe"
German.Text.Skin = "Oberfläche"
German.Text.Horizontal = "Horizontal platzieren"
German.Text.Vertical = "Vertikal platzieren"
German.Text.ConsoleMessages = "Konsolen-Nachrichten"
German.Text.WindowStyle = "Fenster-Stil"
German.Text.RestoreTools = "Geöffnete Tools merken beim schließen\ndes Hauptfensters"
German.Text.NotIdleNotification = "Der vorherige Vorgan wurde noch nicht beendet.\nSoll der laufende Vorgang abgebrochen werden?"
German.Text.ConfirmDeleteSet = "Gegenstands-Set '%s' löschen?"
German.Text.ConfirmOverwrite = "Das Set '%s' existiert bereits.\nDieses Set überschreiben?"
German.Text.ConfirmUsePosition = "Die ursprüngliche Position dieses Sets ist %.1fm entfernt.\nDen Vorgang fortsetzen?"
German.Text.ConfirmPickup = "Sollen alle ausgewählten Gegenstände eingesammelt werden?"
German.Text.ConfirmInvSelect = "Bearbeitung zu vieler Gegenstände kann Verbindung unterbrechen.\n%d Gegenstände auswählen?"
German.Text.Invert = "Umgekehrte Richtung"
German.Text.OldSkin = "Alte Oberfläche"
German.Text.NewSkin = "Neue Oberfläche"
German.Text.Tile = "Quadrat"
German.Text.Rectangle = "Rechteck"
German.Text.Triangle = "Dreieck"
German.Text.Plank = "Planke"
German.Text.Cube = "Würfel"
German.Text.Sphere = "Kugel"
German.Text.Pole = "Pfosten"
German.Text.Disc = "Scheibe"
German.Text.NewName = "Neuer Name"
German.Text.Category = "Kategorie"
German.Text.AnySkin = "<Beliebige Oberfläche>"
German.Text.Multiplier = "Multiplikator"

----------------------------------------
--Prints
----------------------------------------
German.Prints = {}
--Main
German.Prints.DimensionOnly = "Dieses Addon ist nur für die Benutzung innerhalb von Dimensionen gedacht."
German.Prints.ProcessFinished = "Vorgang Beendet."
German.Prints.SetFinished = "Item set \"%s\" ist geladen and ausgewählt."
German.Prints.PasteFinished = "Alle Gegenstände sind platziert und ausgewählt."
German.Prints.WordFinished = "Das Wort ist platziert und ausgewählt."
--Copy / Paste
German.Prints.Copy_SelectItem = "Bitte einen Gegenstand auswählen um Attribute zu kopieren."
German.Prints.NumbersOnly = "Bitte nur numerische Werte eingeben."
German.Prints.CopyFirst = "Bitte vor dem Einfügen erst etwas kopieren."
German.Prints.SelectItemSource = "Bitte mindestens eine Quelle für neue Gegenstände auswählen."
German.Prints.NotPasteInventory = "Zwischenablage kann nicht eingefügt werden - folgende Gegenstände fehlen im Inventar:"
German.Prints.NotPasteSelection = "Zwischenablage kann nicht eingefügt werden - folgende Gegenstände fehlen in der Auswahl:"
--Tribal Magic
German.Prints.NoRoundTable = "Du hast scheinbar keinen Runden Stammestisch in deinem Inventar!"
--Alfiebet
German.Prints.SelectFont = "Wähle eine Schriftart."
German.Prints.SelectSize = "Wähle eine Größe."
German.Prints.SelectSkin = "Wähle eine Oberfläche."
German.Prints.OnlyLetters = "Es sind nur Buchstaben für ein Wort erlaubt."
German.Prints.TypeWord = "Bitte zuerst ein Wort eingeben."
German.Prints.WordMissingItems = "Das Wort kann nicht erstellt werden - folgende Gegenstände fehlen im Inventar:"
German.Prints.WordNeededItems = "Folgende Gegenstände werden benötigt um das Wort \"%s\" zu erstellen:"
German.Prints.WordCouldNotPrint = "Die Materialien konnten nicht aufgelistet werden."
--Import/Export
German.Prints.SetNotFound = "Item set \"%s\" nicht gefunden."
German.Prints.SelectExport = "Du mußt ein Set auswählen um es zu exportieren."
German.Prints.Exported = "Item set \"%s\" exportiert."
German.Prints.SelectImport = "Du mußt ein Set auswählen um es zu importieren."
German.Prints.Imported = "Item set \"%s\" importiert."
German.Prints.TextHint = "<Text Eingabe/Ausgabe>\nCtrl+C: Kopieren\nCtrl+V: Einfgüen\nCtrl+A: Alles auswählen\n"
--Load / Save
German.Prints.Saved = "Item set \"%s\" gespeichert."
German.Prints.MinOneItem = "Es muß mindestens ein Gegenstand ausgewählt sein um zu speichern."
German.Prints.EnterName = "Es wird ein Name benötigt um das Set zu speichern."
German.Prints.LoadNeededItems = "Folgende Gegenstände werden benötigt um \"%s\" zu laden:"
German.Prints.LoadPrintMats = "Wähle ein Set um dessen Materialliste auszugeben."
German.Prints.LoadSelectSet = "Wähle ein Set um es zu laden."
German.Prints.NotLoadedBags = "Set kann nicht geladen werden - folgende Gegenstände fehlen im Inventar:"
German.Prints.NotLoadedSelection = "Set kann nicht geladen werden - folgende Gegenstände fehlen in der Auswahl:"
German.Prints.SetLoaded = "Item set \"%s\" geladen."
German.Prints.SetRemoved = "Item set \"%s\" gelöscht."
German.Prints.NotRemoved = "\"%s\" konnte nicht gelöscht werden - kein Set mit diesem Namen vorhanden."
German.Prints.RemoveSelectSet = "Wähle ein Set um es zu löschen."
German.Prints.CopiedClipboard =  "Item set \"%s\" wurde in die Zwischenablage von \"Kopieren & Einfügen\" kopiert."
German.Prints.PickRefPoint =  "Bitte zuerst einen Referenzpunkt wählen."
German.Prints.NoRefPointWarn =  "Dieses Item Set hat keinen Referenzpunkt. Stattdessen wird der Mittelpunkt benutzt."
--Measurements
German.Prints.SelectType = "Wähle eine Form."
German.Prints.SelectOrientation = "Wähle eine Ausrichtung."
German.Prints.TypeSize = "Wähle eine Größe."
German.Prints.SizeC = "Die Größe muß im Bereich von %.2f bis %.1f liegen."
German.Prints.Selection1 = "Transformierte Modi benötigen einen ausgewählten Gegenstand."
German.Prints.Selection2 = "Auswahl-Delta benötigt zwei ausgewählte Gegenstände."
--Move, Rotate, Scale
German.Prints.ModifyPosition = "Bitte wähle einen Gegenstand aus um dessen Position zu verändern."
German.Prints.ModifyRotation = "Bitte wähle einen Gegenstand aus um dessen Rotation zu verändern."
German.Prints.ModifyScale = "Bitte wähle einen Gegenstand aus um dessen Größe zu verändern."
--Reskin
German.Prints.ClipboardEmpty = "Die Zwischenablage von \"Kopieren & Einfügen\" ist leer."
German.Prints.Summary = "Zusammenfassung der Ersetzungen:"
