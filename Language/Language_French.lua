local Dta = select(2, ...)

Dta.Lang.French = {}
local French = Dta.Lang.French
----------------------------------------
--Help
----------------------------------------

---Intro------------------------------------------------------------------
French.Intro = {}
French.Intro.Label = "Introduction"
French.Intro.Text1 = "\
Bonjour Dimensioneurs et Dimensionneuses,\
\
Cet add-on est dans la lignée de dimension tools, initialement crée par Kikimora.\
\
Voici un résumé de ce que Tinker Tools peut offrir:\
\
<u>Fonctionnalités de Tinker Tools:</u>\
- Tinker Tools occupe moins de place sur votre écran quand vous élaborez\
  vos dimensions. Tous les outils sont accessibles en cliquant sur les boutons\
  disponibles sur la fenêtre principale.\
\
- Avec Tinker Tools vous pouvez déplacer, redimensionner ou faire pivoter\
  des centaines d'objets d'un seul coup sans aucun problème! (mais gardez à \
  l'esprit que plus vous manipulerez d'objets d'un seul coup, plus le \
  processus sera long.) \
\
- Avec le module Copier/Coller de Tinker Tools, vous pouvez copier 1 objet\
  et le coller de multiples fois avec ou sans décalage dans votre dimension.\
  Les objets pourront provenir de vos sacs et/ou de votre banque.\
\
- Avec le module Charger/Sauvegarder, vous pouvez maintenant choisir\
  d'utiliser les sets par défaut, ou vos propres sets préalablement sauvegardés.\
  Une des nouvelles fonctions du module Charger/Sauvegarder est la possibilité\
  de sauvegardé un set et d'en placer de multiples copies avec un décalage sur les\
  axes X, Y et Z.\
\
- Le module Import/Export vous permet d'exporter des sets dans un fichier\
  que vous pouvez partager avec vos amis. Ils pourront les récupérer dans leurs\
  liste de sets sauvegardés grâce à la fonction d'import.\
\
Merci et amusez vous à construire des Dimensions de rêve!"

French.Intro.Text2 = ""
French.Intro.Text3 = ""

---Main-------------------------------------------------------------------
French.Main = {}
French.Main.Label = "Fenêtre principale"
French.Main.Text1 = "\
La fenêtre principale est celle que vous avez à l'ouverture de l'add-on.\
C'est la seule fenêtre visible par défaut. Elle donne des informations\
basiques à propos des objets sélectionnés. Elle contient également les\
boutons permettant d'ouvrir tous les autres modules de Tinker Tools.\
\
Tinker Tools ne peut être ouvert que dans les dimensions."

French.Main.Text2 = "\
<u>Buttons:</u>\
- ?: Ouvre l'aide (que vous avez sous les yeux).\
- Translation: Ouvre la fenêtre du module Translation.\
- Rotation: Ouvre la fenêtre du module Rotation.\
- Taille: Ouvre la fenêtre du module Taille (aggrandissement et réduction).\
- Copier / Coller: Ouvre la fenêtre du module Copier et coller.\
- Charger / Sauv.: Ouvre la fenêtre du module Charger et Sauvegarder.\
- Import / Export: Ouvre la fenêtre du module Impoter / Exporter.\
- Tribal Magic: Ouvre la fenêtre du module Tribal Magic.\
- Calc. align.: Ouvre la fenêtre du module calculateur d'alignement."

French.Main.Text3 = ""

---Move-------------------------------------------------------------------
French.Move = {}
French.Move.Label = "Translation"
French.Move.Text1 = "\
Le module Translation est celui qui permet de régler la position des\
objets sélectionnés."

French.Move.Text2 = "\
<u>Descriptions:</u>\
- X: Règle les coordonnées de l'axe X.\
- Y: Règle les coordonnées de l'axe Y.\
- Z: Règle les coordonnées de l'axe Z.\
- Absolu: Déplace le(s) objet(s) aux coordonnées absolues X,Y,Z.\
- Relatif: Déplace le(s) objet(s) à partir de la position actuelle de l'objet\
  suivant les coordonnées relatives X,Y,Z.\
- Déplacer: Déplace le(s) objet(s).\
- Reset: Reset la position de l'objet à votre emplacement actuel."

French.Move.Text3 = ""

---Rotate------------------------------------------------------------*2/41_è-----
French.Rotate = {}
French.Rotate.Label = "Rotation"
French.Rotate.Text1 = "\
Le module rotation est l'outil grâce auquel vous pouvez régler l'inclinaison\
des objets sélectionnés.\
Information importante à propos des rotations effectuées avec l'add-on:\
Aucun moyen n'a pour le moment été trouvé pour permettre la rotation d'un \
groupe d'objets. Ce qui signifie que si vous tentez de faire pivoter un \
groupe d'objets, vous obtiendrez la même rotation pour chaque objet séparé\
mais vous n'aurez pas une rotation globale de l'ensemble."

French.Rotate.Text2 = "\
<u>Description:</u>\
- Rot Y: Règle l'inclinaison sur l'axe Y.\
- Rot X: Règle l'inclinaison sur l'axe X.\
- Rot Z: Règle l'inclinaison sur l'axe Z.\
- Absolu: Règle l'inclinaison de(s) objet(s) aux valeurs absolues d'inclinaison\
  renseignées suivants les axes X, Y et Z.\
- Relatif: Règle l'inclinaison de(s) objet(s) relativement à leur inclinaison \
  initiale.\
  Par exemple, si initialement, l'objet sélectionné a une inclinaison de 20° \
  suivant l'axe X, alors, si il est noté 20 dans Rot X, alors au final, l'objet\
  prendra une inclinaison de 40° suivant l'axe des X.\
- Pivoter: Fais pivoter les objets selon les paramètres spécifiés.\
- Reset: Réinitialise l'inclinaison de l'objet aux valeures / 0, 0, 0."

French.Rotate.Text3 = ""

---Scale------------------------------------------------------------------
French.Scale = {}
French.Scale.Label = "Taille"
French.Scale.Text1 = "\
Le module Taille vous permet de régler la taille de vos objets (aggrandissement\
et réduction)."

French.Scale.Text2 = "\
<u>Description:</u>\
- Taille: Indiquez la taille souhaité de(s) objet(s) sélectionnés.\
- Absolu: Règle la taille de(s) objet(s) à la valeur indiqué.\
- Relatif: Règle la taille de(s) objet(s) relativement à la valeur indiquée\
  (la taille finale sera la somme de la taille indiquée et de la taille initiale)\
- Dimensionner: Modifie la taille de l'objet suivant les critères indiqués.\
- Reset: Réinitialise la taille de l'objet à 1."

French.Scale.Text3 = ""

---Copy and Paste---------------------------------------------------------
French.CopyandPaste = {}
French.CopyandPaste.Label = "Copier et coller"
French.CopyandPaste.Text1 = "\
Le module Copier/coller peut être utilisé pour copier les caractéristiques\
d'un objet et les transférer à un autre objet de la dimensions ou pour placer\
de multiples copies de l'objet dans votre dimension, en y appliquant ou non un\
décalage. Les objets pourront provenir de vos sacs ou de votre banque."

French.CopyandPaste.Text2 = "\
Vous pouvez activer ou désactiver n'importe quel décalage en cliquant \
simplement sur la case à cocher qui se trouve devant les zones de texte.\
Ainsi, vous pouvez choisir quelles caractéristiques seront transférées\
au(x) autre(s) objet(s).\
\
<u>Description:</u>\
- Décalage X, Y, Z: Paramètre le décalage sur les axes X, Y, Z pour le(s) \
  objet(s) sélectionnés pour un transfert de caractéristiques ou pour ceux \
  qui seront nouvellement placés dans votre Dimension.\
- Décalage Rot X, Rot Y, Rot Z: Paramètre le décalage en rotation sur les \
  axes X, Y, Z pour le(s) objet(s) sélectionnés pour un transfert de \
  caractéristiques ou pour ceux qui seront nouvellement placés dans votre\
  Dimension.\
- Décalage Taille: Paramètre la variation de taille pour le(s) objet(s) \
  sélectionnés pour un transfert de caractéristiques ou pour ceux qui seront\
  nouvellement placés dans votre Dimension.\
- Copier: Copie les caractéristiques de l'objet sélectionné.\
- Coller: Colle les caractéristiques de l'objet sélectionné ou place une copie \
  de(s) objet(s) (tiré de vos sacs ou de votre banque) dans votre dimension.\
- Décalage objets multiples: Permet la copie du décalage à l'ensemble des objets\
  sélectionnés ou à l'ensemble des objets nouvellement placés. Celà prends à\
  chaque fois, la position du dernier objet placé et applique le décalage à partir\
  de cette position, et ainsi de suite.\
  Celà peut par exemple servir à créer des murs parfaitements droit!\
- Utiliser nvx objets: Autorise le placement de nouveaux objets dans votre \
  Dimension. Les objets seront pris dans vos sacs ou dans votre banque."

French.CopyandPaste.Text3 = "\
<u>Description des options:</u>\
- Sacs: Les objets à placer seront pris dans vos sacs.\
- Sacs banque: Les objets à placer seront pris dans les sacs de votre banque.\
- Coffre: Les objets à placer seront pris dans vos coffres de banque.\
- Nb. d'objets: Celà n'apparait que quand Décalage objets multiple et Utiliser\
  nvx objets sont activés en même temps. Celà offre la possibilité de copier\
  plusieurs objets depuis vos sacs ou votre banque. Le module vérifiera si vous\
  possédez suffisement d'exemplaires de l'objet et dans le cas contraire, vous \
  serez informé du nombre maximum d'objets que vous pourrez placer."


---Load and Save----------------------------------------------------------
French.LoadandSave = {}
French.LoadandSave.Label = "Charger et Sauvegarder"
French.LoadandSave.Text1 = "\
Le module Chargement/Sauvegarde est là pour sauvegarder les ensembles (ou set)\
d'objets que vous avez élaborés, pour vous permettre ensuite de les recréer\
ailleurs, dans la même dimension, ou dans une dimension différente (dans\
laquelle vous disposez des droits d'édition)."

French.LoadandSave.Text2 = "\
<u>Description:</u>\
- Nom (zone de texte):  Entrez le nom du set que vous souhaitez sauvegarder.\
- Sauv. Set: Sauvegarde le set dans un fichier.\
- Sets de base: Vous offre la possibilité de charger les ensembles de base \
  offerts par Kikimora et l'équipe de RiftDreamDimensions.\
  Ces ensembles sont des outils crées pour vous aider dans vos créations.\
\
  Pour un guide détaillé sur comment utiliser ces outils, rendez-vous sur \
  http://RiftDreamDimensions.com et jettez un oeuil au fichier PDF \
  Dimension Tools (Anglais uniquement).\
\
- Sets Sauv. : Vous offre la possibilité de charger vos propres ensembles\
  préalablement sauvegardés, dans votre dimension.\
- Sets Tbx : Vous offre la possibilité de charger vos anciens ensembles\
  provenant de l'add-on Dimension Toolbox.\
  Des explications sont disponibles plus loin dans cette aide.\
- Nom (Menu déroulant): Une liste de tous les ensembles sauvegardés. La liste\
  diffère suivant la case cochée (sets de base, sets sauvegardés, sets tbx).\
- Charger Set: Charge l'ensemble sélectionné dans votre dimension, en utilisant\
  les objets sélectionnés ou en prenant les objets dans votre sac.\
- Liste objets: Liste les objets requis pour le set sélectionné.\
- Utiliser nvx objets: Autorise l'utilisation d'objets depuis vos sacs.\
\
Ces fonctions ne sont disponibles que quand Sets Sauv. ou Sets Tbx sont cochés.\
- Supprimer Set: Supprime le set sélectionné (Uniquement avec Sets Sauv.) .\
- Charger au point d'origine: Si cette case est cochée, l'ensemble sera chargé\
  aux coordonnées qu'il avait lors de sa sauvegarde initiale. Dans le cas \
  contraire, l'ensemble sera chargé non loin de votre position actuelle.\
- Placer plusieures copies du Set: Cette fonction offre la possibilité de \
  charger de multiples copies de l'ensemble dans votre dimension et de déterminer\
  un décalage sur les axes X,Y et Z entre les différents exemplaires de l'ensemble\
  chargé.\
\
Les options suivantes sont illustrées dans l'image ci-dessous.\
- Nb. Copies: Indique le nombre de copies que vous souhaitez placer dans \
  votre dimension.\
-X: Paramètre le décalage sur l'axe X .\
-Y: Paramètre le décalage sur l'axe Y .\
-Z: Paramètre le décalage sur l'axe Z ."

French.LoadandSave.Text3 = "\
Sets Tbx est une fonction particulière. Par défaut, la liste est vide, mais \
pour les utilisateurs de l'ancien add-on Toolbox, celà offre l'opportunité de\
récupérer dans Tinker Tools, les ensembles sauvegardés avec Toolbox.\
\
Pour récupérer vos anciens ensembles dans dimensions tools, \
veuillez suivre les étapes suivantes:\
1: Trouvez le fichier tbx.lua File, qui se trouve dans:\
   /Users/[VotreNom]/Documents/RIFT/Interface/Saved/[VotreCompteRift]\
   /SavedVariables\
2: Copiez le fichier txb.lua dans le même répertoire.\
3: Renommer le nouveau fichier en tbx_Import.lua\
4: Démarrez Rift. Vous devriez avoir accès à vos ensembles sauvergardé sous\
   Toolbox dans Dimension Tools. Il ne reste plus qu'à les charger pour les \
   placer dans vos dimensions!\
\
Attention! Il est impossible de supprimer les sets de la liste Sets Tbx.\
Il est donc recommandé d'aller dans Toolbox et de supprimer les sets dont \
vous ne souhaitez pas vous servir dans Dimension Tools avant de suivre les\
étapes ci dessus."


---Import and Export------------------------------------------------------
French.ImportandExport = {}
French.ImportandExport.Label = "Importer et Exporter"
French.ImportandExport.Text1 = "\
Le module Import / Export Sets permet de partager vos ensembles d'objets \
(sets) avec d'autres personnes.\
La sauvegarde et le chargement se feront à partir d'un fichier nommé:\
Dimtools_Export.lua\
Il peut être trouvé à l'emplacement suivant:\
/Users/[VotreNom]/Documents/RIFT/Interface/Saved/SavedVariables"

French.ImportandExport.Text2 = "\
<u>Description:</u>\
- Saved Sets: Affiche vos sets sauvergardés de Dimension Tools dans\
  le premier menu déroulant.\
- Tbx Sets: Affiche vos sets sauvergardés de Toolbox dans le premier\
  menu déroulant.\
- Nom (Premier menu déroulant): Vous pouvez sélectionner ici le set\
  qui sera exporté.\
- Exporter: Exporte le set sélectionné vers le fichier.\
- Nom (Second menu déroulant): Vous pouvez sélectionner ici l'un des\
  sets importables.\
- Importer: Importe le set sélectionné dans votre propre liste de sets\
  sauvegardés et supprime ce dernier du fichier d'exportation.\
\
Pour transmettre un ou plusieurs sets, vous devez d'abord les exporter\
puis, vous déconnecter du jeu ou taper [/reloadui] dans le chat de Rift\
pour sauvegarder le fichier. Après celà vous pouvez envoyer le fichier\
Dimtools_Export.lua qui se trouve dans:\
/Users/[VotreNom]/Documents/RIFT/Interface/Saved/SavedVariables\
\
Quand vous recevez un ou plusieurs set dans un fichier Dimtools_Export.lua\
Vous devez le copier dans le répertoire SavedVariables qui se trouve dans:\
/Users/[VotreNom]/Documents/RIFT/Interface/Saved/SavedVariables\
Vous devez ensuite lancer le jeu et utiliser la fonction d'importation\
pour récupérer le ou les sets dans votre liste de sets sauvegardés.\
Attention! Vous ne pouvez pas copier le fichier si le jeu est lancé.\
Rift n'accepte pas que l'on écrase un fichier quand vous êtes connecté\
au jeu."

French.ImportandExport.Text3 = ""

---Tribal Magic-----------------------------------------------------------
French.TribalMagic = {}
French.TribalMagic.Label = "Tribal Magic"
French.TribalMagic.Text1 = "\
Tribal Magic est l'add-on Magic Carpet crée par AladdinRift intégré \
directement dans Dimension Tools.\
Une petite modification a été effectué, l'objet nécessaire est une\
Table Tribale Ronde au lieu d'un Tapis ocre .\
La Table Tribale Ronde étant plus petite, elle permet de voler et d'observer\
les environs en voyant moins les bords de l'objet sur lequel vous volez."

French.TribalMagic.Text2 = "\
<u>Description:</u>\
- Placer: Place une Table Tribale Ronde dans votre dimension pour voler dessus.\
- Prendre: Récupère la Table Tribale Ronde utilisée.\
- 0: Applani la Table Tribale Ronde. Ainsi vous pouvez vous déplacer librement\
  en restant à l'altitude actuelle.\
- +1 à +4: Change l'angle d'inclinaison de la Table Tribale Ronde. Plus le nombre\
  est elevé, plus vous prendrez de l'altitude (+) rapidement dans votre dimension.\
- -1 à -4: Change l'angle d'inclinaison de la Table Tribale Ronde. Plus le nombre\
  est petit, plus vous perdrez de l'altitude (-) rapidement dans votre dimension."

French.TribalMagic.Text3 = ""

---Chance Log-------------------------------------------------------------
French.ChanceLog = {}
French.ChanceLog.Label = "Notes de Mise à jour"
French.ChanceLog.Text1 = "\
Notes de mise à jour régulières et détaillés à l'adresse:\
https://github.com/Lynx3d/dimension_tools/commits/master\
et dans le fichier changelog.txt"

French.ChanceLog.Text2 = ""
French.ChanceLog.Text3 = ""

---Reskin-----------------------------------------------------------------
French.Reskin = {}
French.Reskin.Label = "Reskin"
French.Reskin.Text1 = "\
Le module reskin change l'apparence (skin) de vos blocs de construction.\
Celà fonctionne avec le copier / coller donc avant de commencer, vous \
devez copier quelquechose. (Vous pouvez aussi copier un set enregistré!) \
Un fois terminé, vous pouvez coller la structure reskinnée."
French.Reskin.Text2 = "\
<u>Description:</u>\
- Ancien Skin: Le skin à remplacer.\
- Nouveau Skin: Le skin qui remplacera l'ancien.\
- Checkboxes: Sélectionner le type de blocs de construction à reskinner.\
- Appliquer: Appliique les changements dans le presse papier et affiche un résumé."
French.Reskin.Text3 = ""
---Afterword--------------------------------------------------------------
French.Afterword = {}
French.Afterword.Label = "Remerciements"
French.Afterword.Text1 = "\
Remerciements à l'équipe de Rift Dream Dimensions pour m'avoir soutenue\
dans la création de cet add-on et pour l'avoir bêta-testé.\
\
J'espère que vous apprécierez cet add-on et que vous créerez des choses\
merveilleuses avec.\
Pour toute question, remarque, signalement de bug ou autre chose que vous\
souhaiteriez partager avec nous à propos de cet add-on, visitez\
 http://riftdreamdimensions.com/  (site anglophone)\
\
Remerciements spéciaux:\
AladdinRift, pour avoir autorisé l'utilisation du code de Magic Carpet pour \
l'intégrer à Dimension Tools.\
\
Traducteurs:\
Aeryle, Traduction Française.\
Sven, Traduction Allemande. (En cours)\
Merci d'avoir proposé votre aide pour la traduction de Dimension Tools\
et pour le travail de traduction effectué.\
\
Un petit mot d'Aeryle:\
Celà a été un réel plaisir de traduire cet add-on.\
J'espère pour vous l'apprécierez et que cette traduction vous\
permettra d'utiliser cet add-on avec plus d'aisance!\
\
Websites:\
http://inhousegaming.com/ - Pour suivre les jeux Trion. (site anglophone)\
http://www.curse.com/addons/rift - Pour trouver cet add-on et plein d'autres."

French.Afterword.Text2 = ""
French.Afterword.Text3 = ""

---Offset Calc.-----------------------------------------------------------
French.OffsetCalc = {}
French.OffsetCalc.Label = "Calc. Align."
French.OffsetCalc.Text1 = "\
Le calculateur d'alignement est un outil que vous pouvez utiliser pour \
déterminer le décalage requis entre les blocs de construction pour qu'ils\
aient l'air parfaitement alignés les uns par rapport aux autres.\
Cet outil est né suite aux questions à propos de la détermination du \
décalage entre blocs de construction."

French.OffsetCalc.Text2 = "\
- Type: Coississez ici le type d'objet pour lequel calculer l'alignement.\
  Types supportés: Poteau, Carreau, Cube, Planche et Rectangle.\
- Orientation:  Choississez ici l'orientation de l'objet.\
  Orientations supportées:\
  Défaut: Rot Y, Rot X et Rot Z toutes à 0\
  Rot Y 90: Rot Y à 90, Rot X et Rot Z à 0\
  Rot X 90: Rot X à 90, Rot Y et Rot Z à 0\
  Rot Z 90: Rot Z à 90, Rot Y et Rot X à 0\
- Taille: Indiquez ici la taille de l'objet.\
- Calculer: Calcule le décalage à appliquer.\
- X: Le décalage sur l'axe X.\
- Y: Le décalage sur l'axe Y.\
- Z: Le décalage sur l'axe Z."

French.OffsetCalc.Text3 = ""

---Alfiebet-----------------------------------------------------------
French.Alfiebet = {}
French.Alfiebet.Label = "Alfiebet"
French.Alfiebet.Text1 = "\
En visitant des dimensions, une des choses qui se remarque est que les \
joueurs écrivent des mots à l'aide de différents objets. Certains sont lisibles,\
d'autres sont difficilement déchiffrables, nottement ceux utilisant des\
objets lumineux. Ce qu'il faut noter c'est que dans tous les cas, les\
joueurs veulent écrire des mots dans leurs dimensions et transmettre un message\
aux visiteurs dimensionnels. C'est la raison pour laquelle l'équipe\
RiftDreamDimensions a eu l'idée d'intégrer un générateur de mots dans\
Dimension Tools. Après beaucoup de réflexion et de travail, l'équipe\
RiftDreamDimensions a crée des polices d'écriture pour atteindre cet objectif,\
et nous avons réussi à créer cet outil pour que tout le monde puisse écrire\
dans les dimensions."

French.Alfiebet.Text2 = "\
- Mot : Vous pouvez écrire ici le mot que vous souhaitez voir dans votre \
        dimension.\
        - Celà ne marche qu'avec les lettres de A à Z.\
		Pas de caractères spéciaux, ni d'accents.\
- Police : Vous pouvez choisir la poilce d'écriture à utiliser.\
- Taille : Vous pouvez choisir la taille de la police d'écriture.\
- Skin : Vous pouvez choisir la matière de votre mot et donc son apparence\
        (issue des blocs de construction).\
- Horizontal: Ecrit le mot horizontalement suivant l'axe X.\
- Vertical: Ecrit le mot verticalement suivant l'axe Y.\
- Charger mot: Ecrit le mot dans votre dimension.\
- Liste objets: Donne la liste des objets requis dans la fenêtre de chat.\
        Cette liste sera adaptée au skin et à la police choisie."

French.Alfiebet.Text3 = ""

----------------------------------------
--Buttons
----------------------------------------
French.Buttons = {}
French.Buttons.MoveWindow = "Translation"
French.Buttons.RotateWindow = "Rotation"
French.Buttons.ScaleWindow = "Taille"
French.Buttons.CopyPaste = "Copier / Coller"
French.Buttons.LoadSave = "Charger / Sauv."
French.Buttons.ImportExport = "Import / Export"
French.Buttons.TribalMagic = "Tribal Magic"
French.Buttons.OffsetCalc = "Calc. Align."
French.Buttons.Reskin = "Reskin"
French.Buttons.Selection = "Sélection"
French.Buttons.Copy = "Copier"
French.Buttons.Paste = "Coller"
French.Buttons.Pick = "Choisir"
French.Buttons.Import = "Importer"
French.Buttons.ImportText = "Importer Texte"
French.Buttons.Export = "Exporter"
French.Buttons.ExportText = "Exporter Texte"
French.Buttons.Place = "Placer"
French.Buttons.PickUp = "Prendre"
French.Buttons.SaveSet = "Sauv. Set"
French.Buttons.LoadSet = "Charger Set"
French.Buttons.RemoveSet = "Supprimer Set"
French.Buttons.PrintMaterials = "Liste Objets"
French.Buttons.ToClipboard = "Presse-papier"
French.Buttons.Move = "Déplacer"
French.Buttons.Reset = "Reset"
French.Buttons.Rotate = "Pivoter"
French.Buttons.Scale = "Dimensionner"
French.Buttons.Calculate = "Calculer"
French.Buttons.Detect = "Détecter"
French.Buttons.Transfer = "Transférer"
French.Buttons.LoadWord = "Charger mot"
French.Buttons.Yes = "Oui"
French.Buttons.No = "Non"
French.Buttons.OK = "OK"
French.Buttons.Cancel = "ANNULER"
French.Buttons.Apply = "Appliquer"
French.Buttons.More = "Plus..."
French.Buttons.Less = "Moins..."
French.Buttons.InvertSelection = "Inverser"

----------------------------------------
--Menus
----------------------------------------
French.Menus = {}
French.Menus.WindowStyle = { "Par défaut", "Sans bordures" }
French.Menus.ItemType = {
	"Cube",
	"Planche",
	"Poteau",
	"Rectangle",
	"Carreau",
	"Plancher",
	"Plancher de hall",
	"Plancher à large lattes"
}
French.Menus.Orientation = {
	"Défaut",
	"Rot X 90°",
	"Rot Y 90°",
	"Rot Z 90°",
	"Rot X & Rot Y 90°",
	"Rot X & Rot Z 90°",
	"Sélection Delta",
	"Offset X transformé",
	"Offset Y transformé",
	"Offset Z transformé"
}

----------------------------------------
--Titles
----------------------------------------
French.Titles = {}
French.Titles.Main = "Tinker Tools"
French.Titles.Move = "Translation"
French.Titles.Rotate = "Rotation"
French.Titles.Scale = "Taille"
French.Titles.CopyPaste = "Copier / Coller Objets"
French.Titles.LoadSave = "Charger / Sauvegarder"
French.Titles.ImportExport = "Importer / Exporter"
French.Titles.TribalMagic = "Tribal Magic"
French.Titles.OffsetCalc = "Calculateur Alignement"
French.Titles.Help = " Aide Tinker Tools"
French.Titles.Settings = "Paramètres"
French.Titles.TransferValues = "Valeurs de transfert à:"
French.Titles.Reskin = "Module Reskin"
French.Titles.Selection = "Sélection"


----------------------------------------
--Text
----------------------------------------
French.Text = {}
French.Text.Yaw = "Rot Y"
French.Text.Pitch = "Rot X"
French.Text.Roll = "Rot Z"
French.Text.Scale = "Taille"
French.Text.NothingSelected = "Pas de sélection"
French.Text.NrSelectItems = "Nb. d'objets sélect. :"
French.Text.MultiSelectItems = "%d objets sélectionnés"
French.Text.Offset = "Décalage"
French.Text.OffsetMultiItems = "Décalage objets multiples"
French.Text.FlickerReduce = "Réduction du vacillement"
French.Text.UseNewItems = "Utiliser nvx objets"
French.Text.SelectionPivot = "Pivot personnalisé"
French.Text.NrItems = "Nb. d'objets"
French.Text.Bags = "Sacs"
French.Text.BankBags = "Banque"
French.Text.Vaults = "Coffres"
French.Text.DefaultSets = "Sets de base "
French.Text.SavedSets = "Sets Sauv. "
French.Text.TbxSets = "Sets Tbx"
French.Text.Name = "Nom"
French.Text.Search = "Recherche"
French.Text.LoadOrigionalLocation = "Charger au point d'origine"
French.Text.Absolute = "Absolu"
French.Text.Relative = "Relatif"
French.Text.MoveAsGroup = "Comme un tout"
French.Text.LocalAxes = "Axes locaux"
French.Text.Type = "Type"
French.Text.Orientation = "Orientation"
French.Text.Word = "Mot"
French.Text.Font = "Police"
French.Text.Size = "Taille"
French.Text.Skin = "Skin"
French.Text.Horizontal = "Horizontal"
French.Text.Vertical = "Vertical"
French.Text.ConsoleMessages = "Fenêtre de Messages"
French.Text.WindowStyle = "Style de fenêtre"
French.Text.RestoreTools = "Se souvenir des modules ouverts\nlors de la fermeture du module principal"
French.Text.NotIdleNotification = "L'opération précédente n'est pas terminée.\n Abandonner l'opération en cours d'éxécution?"
French.Text.ConfirmDeleteSet = "Effacer l'ensemble d'objet '%s'?"
French.Text.ConfirmOverwrite = "L'ensemble '%s' existe déjà.\n Voulez-vous le remplacer?"
French.Text.ConfirmUsePosition = "Le positionnement d'origine du set est à %.1fm .\nContinuer l'opération?"
French.Text.ConfirmPickup = "Etes-vous sûr de vouloir ramasser tous les objets sélectionnés?"
French.Text.ConfirmInvSelect = "Sélectionner un grand nombre d'objets peut entrainer une déconnexion.\nSélectionner %d objets?"
French.Text.Invert = "Inverser Direction"
French.Text.OldSkin = "Ancien Skin"
French.Text.NewSkin = "Nouveau Skin"
French.Text.Tile = "Carreau"
French.Text.Rectangle = "Rectangle"
French.Text.Triangle = "Triangle"
French.Text.Plank = "Planche"
French.Text.Cube = "Cube"
French.Text.Sphere = "Sphère"
French.Text.Pole = "Poteau"
French.Text.Disc = "Disque"
French.Text.NewName = "Nouv. nom"
French.Text.Category = "Catégorie"
French.Text.Multiplier = "Multiplicateur"

----------------------------------------
--Prints
----------------------------------------
French.Prints = {}
--Main
French.Prints.DimensionOnly = "Cet add-on ne s'utilise que dans les dimensions!"
French.Prints.ProcessFinished = "Processus terminé."
French.Prints.SetFinished = "Set d'objets \"%s\" chargé et sélectionné."
French.Prints.PasteFinished = "Tous les objets sont placés et sélectionnés."
French.Prints.WordFinished = "Le mot est crée et sélectionné."
--Copy / Paste
French.Prints.Copy_SelectItem = "Sélectionnez un objet pour en copier les propriétées."
French.Prints.NumbersOnly = "Entrez des valeurs numériques uniquement"
French.Prints.CopyFirst = "Copiez un objet avant de coller!"
French.Prints.SelectItemSource = "Sélectionner au moins un emplacement de stockage des nouveaux objets."
French.Prints.NotPasteInventory = "Impossible de coller - les objets suivants ne sont pas dans vos sacs:"
French.Prints.NotPasteSelection = "Impossible de coller - les objets suivants ne sont pas sélectionnés:"
--Tribal Magic
French.Prints.NoRoundTable = "Vous n'avez pas de Table tribale ronde dans votre inventaire!"
--Alfiebet
French.Prints.SelectFont = "Selectionnez une police"
French.Prints.SelectSize = "Selectionnez une taille"
French.Prints.SelectSkin = "Selectionnez un skin"
French.Prints.OnlyLetters = "Le mot ne doit contenir que des lettres (sans caractères spéciaux)."
French.Prints.TypeWord = "Tapez un mot avant tout, svp!"
French.Prints.WordMissingItems = "Impossible de créer ce mot - les objets suivants ne sont pas dans votre inventaire:"
French.Prints.WordNeededItems = "Les objets suivants sont requis pour créer le mot \"%s\":"
French.Prints.WordCouldNotPrint = "Impossible d'afficher les objets requis!"
--Import/Export
French.Prints.SetNotFound = "Set d'objets \"%s\" introuvable"
French.Prints.SelectExport = "Vous devez sélectionner un set pour l'exporter"
French.Prints.Exported = "Set d'objets \"%s\" exporté!"
French.Prints.SelectImport = "Vous devez sélectionner un set pour l'importer"
French.Prints.Imported = "Set d'objets \"%s\" importé!"
French.Prints.TextHint = "<import/export texte>\nCtrl+C: Copier\nCtrl+V: Coller\nCtrl+A: Selectionner tout\n"
--Load / Save
French.Prints.Saved = "Set d'objets \"%s\" sauvegardé!"
French.Prints.MinOneItem = "Vous devez sélectionner un ou plusieurs objets pour les sauvegarder"
French.Prints.EnterName = "Vous devez entrer un nom pour sauvegarder le set"
French.Prints.LoadNeededItems = "Les objets suivants sont requis pour charger le set \"%s\":"
French.Prints.LoadPrintMats = "Vous devez sélectionner un set pour afficher ses composants"
French.Prints.LoadSelectSet = "Vous devez sélectionner un set pour le charger"
French.Prints.NotLoadedBags = "Impossible de charger le set - les objets suivants ne sont pas dans vos sacs:"
French.Prints.NotLoadedSelection = "Impossible de charger le set - les objets suivants ne sont pas sélectionnés:"
French.Prints.SetLoaded = "Set d'objets \"%s\" chargé"
French.Prints.SetRemoved = "Set d'objets \"%s\" supprimé"
French.Prints.NotRemoved = "Impossible de supprimer \"%s\" - Ce set est introuvable"
French.Prints.RemoveSelectSet = "Vous devez sélectionner un set pour le supprimer"
French.Prints.CopiedClipboard =  "Le set d'objets \"%s\" a été copié dans le presse-papier de l'add-on."
--Measurements
French.Prints.SelectType = "Indiquez un type"
French.Prints.SelectOrientation = "Indiquez une Orientation"
French.Prints.TypeSize = "Indiquez une taille"
French.Prints.SizeC = "La taille doit être comprise entre %.2f et %.1f"
French.Prints.Selection1 = "Mode transformation nécessite un objet sélectionné."
French.Prints.Selection2 = "Selection Delta nécessite deux objets sélectionnés."
--Move, Rotate, Scale
French.Prints.ModifyPosition = "Sélectionnez un objet pour modifier sa position"
French.Prints.ModifyRotation = "Sélectionnez un objet pour modifier sa rotation"
French.Prints.ModifyScale = "Sélectionnez un objet pour modifier sa taille"
--Reskin
French.Prints.ClipboardEmpty = "Le presse papier de l'add-on est vide!"
French.Prints.Summary = "Compte-rendu du reskin:"
