#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Icons\Main.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <GuiComboBox.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <File.au3>
#include <Date.au3>

; General Variables
Global $g_hDllIcons = @ScriptDir & "\dllImages.dll"
Global Enum $g_IconMain = 1, $g_IconAndroid, $g_IconApply, $g_IconConfig, $g_IconFolder, $g_IconReload
;Global $g_sProfilePath = ""
Global $g_sProfileINI = ""
Global $g_aAllAccountsNames, $g_aSectionValues
Global $g_iProfileCount = 0
Global $g_sProfilePath = FileSelectFolder("Select the Profiles Folder", @DesktopDir)

If @error Then
	MsgBox($MB_OK, "", "No folder was selected.")
	Exit
EndIf

Global $g_iButtonCount = 0
Global $aProfileFolders = _FileListToArray($g_sProfilePath, "*", $FLTA_FOLDERS)
Global $g_aSelectedProfiles[0] ; Ein Array, um ausgewählte Profile zu speichern
Global $itabselected = 0

If @error = 1 Then
	MsgBox($MB_OK, "", "The path is invalid.")
	Exit
EndIf

Global $defaultprofile = ""

;Global $hGUI = GUICreate("MBR Config INI Tool v1.0.0", 613, 903, -1, -1)

; UI
Global $UiForm = GUICreate("MBR Config INI Tool v1.0.1", 613, 740, -1, -1)
GUISetIcon($g_hDllIcons, $g_IconMain)

; TOP
GUICtrlCreateGroup("General Profile Settings", 8, 0, 457, 81)
Global $lbldefaultprofile = GUICtrlCreateLabel("defaultprofile", 16, 25, 64, 17)
Global $cmbDefaultProfile = GUICtrlCreateCombo("", 82, 22, 137, 25)
GUICtrlSetData($cmbDefaultProfile, "", "")
Global $lblglobalthreads = GUICtrlCreateLabel("globalthreads", 16, 58, 67, 17)
Global $txtglobalthreads = GUICtrlCreateInput("..", 88, 55, 41, 21)
GUICtrlSetLimit($txtglobalthreads, 2)
Global $lbladbpath = GUICtrlCreateLabel("adb.path", 144, 58, 46, 17)
Global $txtabdpath = GUICtrlCreateInput("....", 192, 55, 265, 21)
Global $btnAndroidSet = GUICtrlCreateButton("Apply", 423, 10, 36, 36, BitOR($BS_ICON, $WS_GROUP))
GUICtrlSetTip($btnAndroidSet, "Apply to profile.ini")
GUICtrlSetImage($btnAndroidSet, $g_hDllIcons, $g_IconAndroid)
GUICtrlCreateGroup("", -99, -99, 1, 1)

; PROFILE
Global $cmbProfileNames = GUICtrlCreateCombo("", 472, 55, 137, 25)
GUICtrlSetData($cmbProfileNames, "", "")
Global $lblLoadProfile = GUICtrlCreateLabel("Select a Profile Settings", 480, 37, 115, 17)
Global $IconConfig = GUICtrlCreateIcon($g_hDllIcons, $g_IconConfig, 520, 5, 32, 32, BitOR($SS_NOTIFY, $WS_GROUP))


GUICtrlCreateGroup("Settings", 8, 89, 601, 169, -1, $WS_EX_TRANSPARENT)
Global $tbAllSettings = GUICtrlCreateTab(10, 104, 597, 152)
GUICtrlSetResizing($tbAllSettings, $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)


Global $tbSettings = 0, $tbDebug = 0, $tbDeleteFiles = 0, $tbOther = 0, $tbAndroid = 0, $tbWait4CC = 0, $tbWait4CCSpell = 0, $tbFriendlyChallenge = 0, $tbPlanned = 0, $tbAttack = 0, $tbAutoUpgrade = 0, $tbBoost = 0, $tbBotHumanization = 0, $tbBuilderBase = 0, $tbCapital = 0, $tbChatbot = 0, $tbClanCastle = 0, $tbCSVSpeed = 0, $tbDeleteFiles = 0, $tbDonate = 0, $tbDropOrder = 0, $tbEndBattle = 0, $tbFMGoblinXP = 0, $tbFriendlyChallenge = 0, $tbGTFO = 0, $tbLang = 0, $tbLevelSiege = 0, $tbLevelTroop = 0, $tbNotify = 0, $tbProfileSCID = 0, $tbRequest = 0, $tbRequestCC4SiegeMachine = 0, $tbRequestCC4Troop = 0, $tbRequestCC4Spell = 0, $tbSearch = 0, $tbShareAttack = 0, $tbSiege = 0, $tbSmartFarm = 0, $tbSmartMilk = 0, $tbSmartZap = 0, $tbSpells = 0, $tbStickToTrainPage = 0, $tbTroop = 0, $tbUpgrade = 0, $tbWalls = 0, $tbWarPreparation = 0

Global $cmbKeySettings = 0, $cmbKeyDebug = 0, $cmbKeyDeleteFiles = 0, $cmbKeyOther = 0, $cmbKeyAndroid = 0, $cmbKeyWait4CC = 0, $cmbKeyWait4CCSpell = 0, $cmbKeyFriendlyChallenge = 0, $cmbKeyPlanned = 0, $cmbKeyAttack = 0, $cmbKeyAutoUpgrade = 0, $cmbKeyBoost = 0, $cmbKeyBotHumanization = 0, $cmbKeyBuilderBase = 0, $cmbKeyCapital = 0, $cmbKeyChatbot = 0, $cmbKeyClanCastle = 0, $cmbKeyCSVSpeed = 0, $cmbKeyDeleteFiles = 0, $cmbKeyDonate = 0, $cmbKeyDropOrder = 0, $cmbKeyEndBattle = 0, $cmbKeyFMGoblinXP = 0, $cmbKeyFriendlyChallenge = 0, $cmbKeyGTFO = 0, $cmbKeyLang = 0, $cmbKeyLevelSiege = 0, $cmbKeyLevelTroop = 0, $cmbKeyNotify = 0, $cmbKeyProfileSCID = 0, $cmbKeyRequest = 0, $cmbKeyRequestCC4SiegeMachine = 0, $cmbKeyRequestCC4Troop = 0, $cmbKeyRequestCC4Spell = 0, $cmbKeySearch = 0, $cmbKeyShareAttack = 0, $cmbKeySiege = 0, $cmbKeySmartFarm = 0, $cmbKeySmartMilk = 0, $cmbKeySmartZap = 0, $cmbKeySpells = 0, $cmbKeyStickToTrainPage = 0, $cmbKeyTroop = 0, $cmbKeyUpgrade = 0, $cmbKeyWalls = 0, $cmbKeyWarPreparation = 0

Global $txtValueSettings = 0, $txtValueDebug = 0, $txtValueDeleteFiles = 0, $txtValueOther = 0, $txtAndroid = 0, $txtWait4CC = 0, $txtWait4CCSpell = 0, $txtFriendlyChallenge = 0, $txtPlanned = 0, $txtAttack = 0, $txtAutoUpgrade = 0, $txtBoost = 0, $txtBotHumanization = 0, $txtBuilderBase = 0, $txtCapital = 0, $txtChatbot = 0, $txtClanCastle = 0, $txtCSVSpeed = 0, $txtDeleteFiles = 0, $txtDonate = 0, $txtDropOrder = 0, $txtEndBattle = 0, $txtFMGoblinXP = 0, $txtFriendlyChallenge = 0, $txtGTFO = 0, $txtLang = 0, $txtLevelSiege = 0, $txtLevelTroop = 0, $txtNotify = 0, $txtProfileSCID = 0, $txtRequest = 0, $txtRequestCC4SiegeMachine = 0, $txtRequestCC4Troop = 0, $txtRequestCC4Spell = 0, $txtSearch = 0, $txtShareAttack = 0, $txtSiege = 0, $txtSmartFarm = 0, $txtSmartMilk = 0, $txtSmartZap = 0, $txtSpells = 0, $txtStickToTrainPage = 0, $txtTroop = 0, $txtUpgrade = 0, $txtWalls = 0, $txtWarPreparation = 0

Global $g_aBtnReloadSettings = 0, $g_aBtnReloadDebug = 0, $g_aBtnReloadDeleteFiles = 0, $g_aBtnReloadOther = 0, $g_aBtnReloadAndroid = 0, $g_aBtnReloadWait4CC = 0, $g_aBtnReloadWait4CCSpell = 0, $g_aBtnReloadFriendlyChallenge = 0, $g_aBtnReloadPlanned = 0, $g_aBtnReloadAttack = 0, $g_aBtnReloadAutoUpgrade = 0, $g_aBtnReloadBoost = 0, $g_aBtnReloadBotHumanization = 0, $g_aBtnReloadBuilderBase = 0, $g_aBtnReloadCapital = 0, $g_aBtnReloadChatbot = 0, $g_aBtnReloadClanCastle = 0, $g_aBtnReloadCSVSpeed = 0, $g_aBtnReloadDeleteFiles = 0, $g_aBtnReloadDonate = 0, $g_aBtnReloadDropOrder = 0, $g_aBtnReloadEndBattle = 0, $g_aBtnReloadFMGoblinXP = 0, $g_aBtnReloadFriendlyChallenge = 0, $g_aBtnReloadGTFO = 0, $g_aBtnReloadLang = 0, $g_aBtnReloadLevelSiege = 0, $g_aBtnReloadLevelTroop = 0, $g_aBtnReloadNotify = 0, $g_aBtnReloadProfileSCID = 0, $g_aBtnReloadRequest = 0, $g_aBtnReloadRequestCC4SiegeMachine = 0, $g_aBtnReloadRequestCC4Troop = 0, $g_aBtnReloadRequestCC4Spell = 0, $g_aBtnReloadSearch = 0, $g_aBtnReloadShareAttack = 0, $g_aBtnReloadSiege = 0, $g_aBtnReloadSmartFarm = 0, $g_aBtnReloadSmartMilk = 0, $g_aBtnReloadSmartZap = 0, $g_aBtnReloadSpells = 0, $g_aBtnReloadStickToTrainPage = 0, $g_aBtnReloadTroop = 0, $g_aBtnReloadUpgrade = 0, $g_aBtnReloadWalls = 0, $g_aBtnReloadWarPreparation = 0

Global $lblValueSettings = 0, $lblValueDebug = 0, $lblValueDeleteFiles = 0, $lblValueOther = 0, $lblValueAndroid = 0, $lblValueWait4CC = 0, $lblValueWait4CCSpell = 0, $lblValueFriendlyChallenge = 0, $lblValuePlanned = 0, $lblValueAttack = 0, $lblValueAutoUpgrade = 0, $lblValueBoost = 0, $lblValueBotHumanization = 0, $lblValueBuilderBase = 0, $lblValueCapital = 0, $lblValueChatbot = 0, $lblValueClanCastle = 0, $lblValueCSVSpeed = 0, $lblValueDeleteFiles = 0, $lblValueDonate = 0, $lblValueDropOrder = 0, $lblValueEndBattle = 0, $lblValueFMGoblinXP = 0, $lblValueFriendlyChallenge = 0, $lblValueGTFO = 0, $lblValueLang = 0, $lblValueLevelSiege = 0, $lblValueLevelTroop = 0, $lblValueNotify = 0, $lblValueProfileSCID = 0, $lblValueRequest = 0, $lblValueRequestCC4SiegeMachine = 0, $lblValueRequestCC4Troop = 0, $lblValueRequestCC4Spell = 0, $lblValueSearch = 0, $lblValueShareAttack = 0, $lblValueSiege = 0, $lblValueSmartFarm = 0, $lblValueSmartMilk = 0, $lblValueSmartZap = 0, $lblValueSpells = 0, $lblValueStickToTrainPage = 0, $lblValueTroop = 0, $lblValueUpgrade = 0, $lblValueWalls = 0, $lblValueWarPreparation = 0
Global $g_lblHelp[50]

Global $lblHelpGeneral = "General Variables" & @CRLF
Global $lblHelpDebug = "Debug Variables" & @CRLF
Global $lblHelpDeleteFiles = "Delete Files Variables" & @CRLF
Global $lblHelpOther = "Other Variables" & @CRLF
Global $lblHelpAndroid = "Android Variables" & @CRLF
Global $lblHelpWait4CC = "Wait4CC Variables" & @CRLF
Global $lblHelpWait4CCSpell = "Wait4CCSpell Variables" & @CRLF
Global $lblHelpFriendlyChallenge = "Friendly Challenge Variables" & @CRLF
Global $lblHelpPlanned = "Planned Variables" & @CRLF
Global $lblHelpAttack = "Attack Variables" & @CRLF
Global $lblHelpAutoUpgrade = "Auto Upgrade Variables" & @CRLF
Global $lblHelpBoost = "Boost Variables" & @CRLF
Global $lblHelpBotHumanization = "Bot Humanization Variables" & @CRLF
Global $lblHelpBuilderBase = "BuilderBase Variables" & @CRLF
Global $lblHelpCapital = "Capital Variables" & @CRLF
Global $lblHelpChatbot = "Chatbot Variables" & @CRLF
Global $lblHelpClanCastle = "Clan Castle Variables" & @CRLF
Global $lblHelpCSVSpeed = "CSV Speed Variables" & @CRLF
Global $lblHelpDeleteFiles = "Delete Files Variables" & @CRLF
Global $lblHelpDonate = "Donate Variables" & @CRLF
Global $lblHelpDropOrder = "Drop Order Variables" & @CRLF
Global $lblHelpEndBattle = "End Battle Variables" & @CRLF
Global $lblHelpFMGoblinXP = "FM GoblinXP Variables" & @CRLF
Global $lblHelpFriendlyChallenge = "Friendly Challenge Variables" & @CRLF
Global $lblHelpGTFO = "GTFO Variables" & @CRLF
Global $lblHelpLang = "Lang Variables" & @CRLF
Global $lblHelpLevelSiege = "Level Siege Variables" & @CRLF
Global $lblHelpLevelTroop = "Level Troop Variables" & @CRLF
Global $lblHelpNotify = "Notify Variables" & @CRLF
Global $lblHelpProfileSCID = "Profile SCID Variables" & @CRLF
Global $lblHelpRequest = "Request Variables" & @CRLF
Global $lblHelpRequestCC4SiegeMachine = "Request CC4 Siege Machine Variables" & @CRLF
Global $lblHelpRequestCC4Troop = "Request CC4 Troop Variables" & @CRLF
Global $lblHelpSearch = "Search Variables" & @CRLF
Global $lblHelpShareAttack = "Share Attack Variables" & @CRLF
Global $lblHelpSiege = "Siege Variables" & @CRLF
Global $lblHelpSmartFarm = "Smart Farm Variables" & @CRLF
Global $lblHelpSmartMilk = "Smart Milk Variables" & @CRLF
Global $lblHelpSmartZap = "Smart Zap Variables" & @CRLF
Global $lblHelpSpells = "Spells Variables" & @CRLF
Global $lblHelpStickToTrainPage = "Stick To Train Page Variables" & @CRLF
Global $lblHelpTroop = "Troop Variables" & @CRLF
Global $lblHelpUpgrade = "Upgrade Variables" & @CRLF
Global $lblHelpWalls = "Walls Variables" & @CRLF
Global $lblHelpWarPreparation = "War Preparation Variables" & @CRLF
Global $lblHelpCollectors = "Collectors Variables" & @CRLF
Global $lblHelpRequestCC4Spell = "Request CC4 Spell Variables" & @CRLF

Global $g_aTitles[50] = ["General", "Debug", "DeleteFiles", "Other", "Android", "Wait4CC", "Wait4CCSpell", "FriendlyChallenge", "Planned", "Attack", "AutoUpgrade", "Boost", "Bot Humanization", "BuilderBase", "Capital", "Chatbot", "ClanCastle", "CSVSpeed", "Donate", "DropOrder", "EndBattle", "FM GoblinXP", "GTFO", "Lang", "LevelSiege", "LevelTroop", "Notify", "ProfileSCID", "Request", "RequestCC4SiegeMachine", "RequestCC4Troop", "Search", "Collectors", "RequestCC4Spell", "ShareAttack", "Siege", "SmartFarm", "SmartMilk", "SmartZap", "Spells", "StickToTrainPage", "Troop", "Upgrade", "Walls", "War Preparation"]



; Initialize dynamic arrays
Global $g_aTabs[0]
Global $g_alblValue[0]
Global $g_alblVar[0]
Global $g_aCmbKey[0]
Global $g_aTxtValue[0]
Global $g_aBtnReload[0]
Global $g_lblHelp[0]
Global $g_lblHelpInfo[0]

For $i = 0 To UBound($g_aTitles) - 1
    ; Redimension arrays with UBound + 1
    ReDim $g_aTabs[UBound($g_aTabs) + 1]
    ReDim $g_alblValue[UBound($g_alblValue) + 1]
    ReDim $g_alblVar[UBound($g_alblVar) + 1]
    ReDim $g_aCmbKey[UBound($g_aCmbKey) + 1]
    ReDim $g_aTxtValue[UBound($g_aTxtValue) + 1]
    ReDim $g_aBtnReload[UBound($g_aBtnReload) + 1]
    ReDim $g_lblHelp[UBound($g_lblHelp) + 1]
    ReDim $g_lblHelpInfo[UBound($g_lblHelpInfo) + 1]

    $g_aTabs[$i] = GUICtrlCreateTabItem($g_aTitles[$i])
    $g_alblValue[$i] = GUICtrlCreateLabel("Value", 249, 149, 31, 17)
    GUICtrlSetBkColor($g_alblValue[$i], 0xFFFFFF)
    $g_alblVar[$i] = GUICtrlCreateLabel("Variable Key", 80, 149, 63, 17)
    GUICtrlSetBkColor($g_alblVar[$i], 0xFFFFFF)
    $g_aCmbKey[$i] = GUICtrlCreateCombo("", 25, 169, 177, 85)
    GUICtrlSetData($g_aCmbKey[$i], "", "")
    $g_aTxtValue[$i] = GUICtrlCreateInput("Value", 209, 168, 121, 21)
    $g_aBtnReload[$i] = GUICtrlCreateButton("Reload", 335, 162, 36, 36, BitOR($BS_ICON, $WS_GROUP))
    GUICtrlSetImage($g_aBtnReload[$i], $g_hDllIcons, $g_IconReload)
    GUICtrlCreateGroup("Help", 375, 135, 223, 115)
    $g_lblHelp[$i] = GUICtrlCreateEdit("", 375 + 7, 152, 210, 89, BitOR($ES_READONLY, $WS_VSCROLL, $ES_AUTOVSCROLL))
    GUICtrlSetData($g_lblHelp[$i], $g_lblHelpInfo[$i])
    GUICtrlCreateGroup("", -99, -99, 1, 1)
Next



GUICtrlCreateTabItem("")
GUICtrlCreateGroup("", -99, -99, 1, 1)

; PROFILE
;Global $cmbProfileNames = GUICtrlCreateCombo("", 472, 55, 137, 25)
;GUICtrlSetData($cmbProfileNames, "", "")
;Global $lblLoadProfile = GUICtrlCreateLabel("Select a Profile Settings", 480, 37, 115, 17)

; Checkboxes
;Global $iProfileCount = UBound($aProfileFolders) - 1
Global $iCol = 0
Global $iRow = 0

; Is a bad coding using an array with fixed number when you are not using all that [80]
Global $aProfileCheckboxes[0] ; Create an array to store checkbox controls
Global $g_asProfilesNames[0] ; just to store as profiles names
Global $g_aProfileSelected[0] ; Deklariere und initialisiere das Array
Global $g_aButtons[0] ; Maximum number of buttons
Global $g_aProfiles[0]

For $i = 1 To UBound($aProfileFolders) - 1
	; ReDims array >> redimension
	ReDim $aProfileCheckboxes[UBound($aProfileCheckboxes) + 1]
	ReDim $g_aProfileSelected[UBound($g_aProfileSelected) + 1]
	ReDim $g_asProfilesNames[UBound($g_asProfilesNames) + 1]
	ReDim $g_aButtons[UBound($g_aButtons) + 1]
	ReDim $g_aProfiles[UBound($g_aProfiles) + 1]

	$aProfileCheckboxes[UBound($aProfileCheckboxes) - 1] = GUICtrlCreateCheckbox($aProfileFolders[$i], 20 + $iCol * 100, 310 + $iRow * 20, 100, 15)
	$g_aProfileSelected[UBound($g_aProfileSelected) - 1] = False
	$g_asProfilesNames[UBound($g_asProfilesNames) - 1] = ""

	$iCol += 1
	If $iCol >= 5 Then
		$iCol = 0
		$iRow += 1
	EndIf
Next

LogConsole("$aProfileCheckboxes : " & UBound($aProfileCheckboxes))
LogConsole("$g_aProfileSelected : " & UBound($g_aProfileSelected))

GUICtrlCreateGroup("", -99, -99, 1, 1)

; BOTTOM
GUICtrlCreateGroup("", 8, 256, 600, 39, $BS_FLAT)
Global $btnApplyAll = GUICtrlCreateButton("Apply to All", 390, 266, 75, 25, $WS_GROUP)     ; Vertauschte Position
GUICtrlSetTip($btnApplyAll, "Apply to [ALLProfiles]\Config.ini")
Global $btnApplySelected = GUICtrlCreateButton("Apply to Selected", 480, 266, 100, 25, $WS_GROUP)     ; Vertauschte Position
GUICtrlSetTip($btnApplySelected, "Apply to the selected profile")
Global $btnReload = GUICtrlCreateButton("MBR Folder", 40, 266, 75, 25, $WS_GROUP)
GUICtrlSetTip($btnReload, "Select the Profile Folder")
Global $lblProfilePath = GUICtrlCreateLabel("", 117, 272, 275, 17)
GUICtrlSetColor($lblProfilePath, 0xFF0000)
Global $IconFolder = GUICtrlCreateIcon($g_hDllIcons, $g_IconFolder, 13, 265, 24, 24, BitOR($SS_NOTIFY, $WS_GROUP))
Global $IconApply = GUICtrlCreateIcon($g_hDllIcons, $g_IconApply, 350, 266, 24, 24, BitOR($SS_NOTIFY, $WS_GROUP))
GUICtrlSetTip($btnApplySelected, "Apply to the selected profile")

GUICtrlCreateGroup("", 8, 256, 600, 39, $BS_FLAT)

GUISetState(@SW_SHOW)

;LoadValues()
SelectBotFolder()
;LoadGeneralProfileFile()
;LoadAllProfiles($defaultprofile)
;LoadKeys()

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $btnReload
			SelectBotFolder()
		Case $btnApplyAll
			ApplyToAll()
		Case $btnApplySelected
			ApplyToSelected()
		Case $tbAllSettings
			Local $itabselected = GUICtrlRead($tbAllSettings)
			LogConsole("Tab " & $g_aTitles[$itabselected] & " Selected")
		Case $g_aBtnReload[0], $g_aBtnReload[1], $g_aBtnReload[2], $g_aBtnReload[3], $g_aBtnReload[4], $g_aBtnReload[5], $g_aBtnReload[6], $g_aBtnReload[7], $g_aBtnReload[8], $g_aBtnReload[9], $g_aBtnReload[10], $g_aBtnReload[11], $g_aBtnReload[12], $g_aBtnReload[13], $g_aBtnReload[14], $g_aBtnReload[15], $g_aBtnReload[16], $g_aBtnReload[17], $g_aBtnReload[18], $g_aBtnReload[19], $g_aBtnReload[20], $g_aBtnReload[21], $g_aBtnReload[22], $g_aBtnReload[23], $g_aBtnReload[24], $g_aBtnReload[25], $g_aBtnReload[26], $g_aBtnReload[27], $g_aBtnReload[28], $g_aBtnReload[29], $g_aBtnReload[30], $g_aBtnReload[31], $g_aBtnReload[32], $g_aBtnReload[33], $g_aBtnReload[34], $g_aBtnReload[35], $g_aBtnReload[36], $g_aBtnReload[37], $g_aBtnReload[38], $g_aBtnReload[39], $g_aBtnReload[40], $g_aBtnReload[41], $g_aBtnReload[42], $g_aBtnReload[43], $g_aBtnReload[44], $g_aBtnReload[45]
			$defaultprofile = LoadKeys()
			; $g_aCmbKey are the tabs , if add someone is necessary add here!!
		Case $g_aCmbKey[0], $g_aCmbKey[1], $g_aCmbKey[2], $g_aCmbKey[3], $g_aCmbKey[4], $g_aCmbKey[5], $g_aCmbKey[6], $g_aCmbKey[7], $g_aCmbKey[8], $g_aCmbKey[9], $g_aCmbKey[10], $g_aCmbKey[11], $g_aCmbKey[12], $g_aCmbKey[13], $g_aCmbKey[14], $g_aCmbKey[15], $g_aCmbKey[16], $g_aCmbKey[17], $g_aCmbKey[18], $g_aCmbKey[19], $g_aCmbKey[20], $g_aCmbKey[21], $g_aCmbKey[22], $g_aCmbKey[23], $g_aCmbKey[24], $g_aCmbKey[25], $g_aCmbKey[26], $g_aCmbKey[27], $g_aCmbKey[28], $g_aCmbKey[29], $g_aCmbKey[30], $g_aCmbKey[31], $g_aCmbKey[32], $g_aCmbKey[33], $g_aCmbKey[34], $g_aCmbKey[35], $g_aCmbKey[36], $g_aCmbKey[37], $g_aCmbKey[38], $g_aCmbKey[39], $g_aCmbKey[40], $g_aCmbKey[41], $g_aCmbKey[42], $g_aCmbKey[43], $g_aCmbKey[44], $g_aCmbKey[45]
			LoadValues()
	EndSwitch
WEnd



Func LoadProfileButtons()
	Local $aProfileFolders = _FileListToArray($g_sProfilePath, "*", $FLTA_FOLDERS)
	If @error = 1 Then
		MsgBox($MB_OK, "", "Path was invalid.")
		Return
	EndIf

	For $i = 1 To UBound($aProfileFolders) - 1
		$g_aButtons[$g_iButtonCount] = GUICtrlCreateButton($aProfileFolders[$i], 20, 475 + ($g_iButtonCount * 30), 200, 30)
		$g_iButtonCount += 1
	Next
EndFunc   ;==>LoadProfileButtons

Func LogConsole($Text)
	Local $gettxt = @HOUR & ":" & @MIN & ":" & @SEC & " - " & $Text & @CRLF
	ConsoleWrite($gettxt)
EndFunc   ;==>LogConsole

Func SetLog($g_lblHelp, $Text)
	Local $gettxt = @HOUR & ":" & @MIN & ":" & @SEC & " - " & $Text & @CRLF
	GUICtrlSetData($g_lblHelp, $gettxt, 1)
EndFunc   ;==>SetLog

Func SelectBotFolder()
	LogConsole(" === SelectBotFolder ===")

	If $g_sProfilePath <> "" Then
		LogConsole("$g_sProfilePath selected was : " & $g_sProfilePath)
	Else
		Local $IniSets = @ScriptDir & "\config.ini"
		Local $initialdir = @DesktopDir

		If FileExists(@ScriptDir & "\Profiles") Then $initialdir = @ScriptDir & "\Profiles"

		; Überprüfen, ob der Pfad bereits ausgewählt wurde
		If $g_sProfilePath = "" Then
			$g_sProfilePath = FileSelectFolder("Select the .\Profiles Folder", $initialdir)
			ConsoleWrite("Selected Path: " & $g_sProfilePath & @CRLF)

			If @error Then
				; Anzeigen der Fehlermeldung.
				MsgBox($MB_OK, "", "No folder was selected.")
				Return
			EndIf

			IniWrite($IniSets, "Set", "Path", $g_sProfilePath)
		EndIf
	EndIf


	; Setzen Sie den MBR-Ordnerpfad auf den ausgewählten Profilpfad
	$g_sMBRFolderPath = $g_sProfilePath

	$g_sProfileINI = $g_sProfilePath & "\profile.ini"
	GUICtrlSetData($lblProfilePath, $g_sProfilePath)

	Local $defaultprofile = LoadGeneralProfileFile()
	LoadAllProfiles($defaultprofile)
EndFunc   ;==>SelectBotFolder


Func LoadGeneralProfileFile()
	LogConsole(" === LoadGeneralProfileFile ===")
	Local $defaultprofile = IniRead($g_sProfileINI, "general", "defaultprofile", "")
	Local $globalthreads = IniRead($g_sProfileINI, "general", "globalthreads", "")
	If $globalthreads <> "" Then GUICtrlSetData($txtglobalthreads, $globalthreads)
	Local $abdpath = IniRead($g_sProfileINI, "general", "adb.path", "")
	If $abdpath <> "" Then GUICtrlSetData($txtabdpath, $abdpath)
	Return $defaultprofile
EndFunc   ;==>LoadGeneralProfileFile

Func LoadAllProfiles($defaultprofile)
	LogConsole(" === LoadAllProfiles ===")
	Local $aProfileFolders = _FileListToArray($g_sProfilePath, "*", $FLTA_FOLDERS)
	LogConsole("LoadAllProfiles: " & _ArrayToString($aProfileFolders))
	If @error = 1 Then
		MsgBox($MB_OK, "", "Path was invalid.")
		Exit
	EndIf

	$g_iProfileCount = UBound($aProfileFolders) - 1

	;ReDim $g_aProfiles[$g_iProfileCount]

	If $g_iProfileCount > 0 Then
		Local $sSTring = ""
		For $i = 1 To $g_iProfileCount
			$g_aProfiles[$i - 1] = $aProfileFolders[$i]
			$sSTring &= $aProfileFolders[$i] & "|"
			$g_asProfilesNames[$i - 1] = $aProfileFolders[$i]
		Next
		$sSTring = StringTrimRight($sSTring, 1)
		LogConsole("$cmbProfileNames final string: " & $sSTring)
		GUICtrlSetData($cmbProfileNames, $sSTring, $g_aProfiles[0])
		GUICtrlSetData($cmbDefaultProfile, $sSTring, $g_aProfiles[0])
	EndIf
EndFunc   ;==>LoadAllProfiles


Func LoadKeys()
	LogConsole(" === LoadKeys ===")
	Local $profile = GUICtrlRead($cmbProfileNames, $GUI_READ_EXTENDED)
	LogConsole("Profile: " & $profile)
	Local $itabselected = GUICtrlRead($tbAllSettings)
	Local $sSection = $g_aTitles[$itabselected]
	LogConsole("$sSection: " & $sSection)

	; Clear existing data in ComboBoxes
	GUICtrlSetData($g_aCmbKey[$itabselected], "")  ; Clear the ComboBox
	GUICtrlSetData($g_aTxtValue[$itabselected], "")  ; Clear the TextBox

	Local $path = $g_sProfilePath & "\" & $profile & "\config.ini"
	$g_aSectionValues = IniReadSection($path, $sSection)

	If @error Then
		ConsoleWrite("Error reading section from INI." & @CRLF)
		Return
	EndIf

	Local $sSTring = ""

	For $i = 1 To UBound($g_aSectionValues) - 1
		$sSTring &= $g_aSectionValues[$i][0] & "|"
	Next

	$sSTring = StringTrimRight($sSTring, 1)

	GUICtrlSetData($g_aCmbKey[$itabselected], $sSTring)

	; Set focus on ComboBox and TextBox to update display
	GUICtrlSetState($g_aCmbKey[$itabselected], $GUI_FOCUS)
	GUICtrlSetState($g_aTxtValue[$itabselected], $GUI_FOCUS)

	SetLog($g_lblHelp[$itabselected], "Load Keys")
EndFunc   ;==>LoadKeys


; Load values is only from one Profile and the profile selected
Func LoadValues()
	LogConsole("-- LoadValues --")
	Local $profile = GUICtrlRead($cmbProfileNames, $GUI_READ_EXTENDED)
	;Local $profile = _GUICtrlComboBoxEx_GetItemText($cmbProfileNames
	LogConsole("Profile: " & $profile)
	Local $itabselected = GUICtrlRead($tbAllSettings)
	Local $sSection = $g_aTitles[$itabselected]
	LogConsole("Section: " & $sSection)
	Local $sKey = GUICtrlRead($g_aCmbKey[$itabselected], $GUI_READ_EXTENDED)

	For $i = 0 To UBound($g_aProfileSelected) - 1
		If $i = _GUICtrlComboBox_GetCurSel($cmbProfileNames) Then
			$g_aProfileSelected[$i] = True
		Else
			$g_aProfileSelected[$i] = False
		EndIf
	Next

	; Prüfe, welches Profil ausgewählt ist und lese de n Wert
	For $i = 1 To UBound($aProfileFolders) - 1
		If $g_aProfileSelected[$i - 1] Then
			Local $path = $g_sProfilePath & "\" & $aProfileFolders[$i] & "\config.ini"
			Local $sValue = IniRead($path, $sSection, $sKey, "")
			LogConsole("Key: " & $sKey & " | Value: " & $sValue)
			GUICtrlSetData($g_aTxtValue[$itabselected], $sValue)
			SetLog($g_lblHelp[$itabselected], "Load " & $sKey & "=" & $sValue)
			ExitLoop
		EndIf
	Next
EndFunc   ;==>LoadValues


Func ApplyToAll()
	LogConsole("-- ApplyToAll --")
	Local $itabselected = GUICtrlRead($tbAllSettings)
	Local $sSection = $g_aTitles[$itabselected]
	LogConsole("Section: " & $sSection)
	Local $sKey = GUICtrlRead($g_aCmbKey[$itabselected], $GUI_READ_EXTENDED)
	LogConsole("Key: " & $sKey)
	Local $sValue = GUICtrlRead($g_aTxtValue[$itabselected])
	LogConsole("Value: " & $sValue)

	; Loop through all profiles
	For $i = 0 To UBound($g_aProfiles) - 1
		LogConsole("Profile: " & $g_aProfiles[$i])
		Local $path = $g_sProfilePath & "\" & $g_aProfiles[$i] & "\config.ini"
		IniWrite($path, $sSection, $sKey, $sValue)
	Next

	SetLog($g_lblHelp[$itabselected], "Apply to All: " & $sKey & "=" & $sValue)
EndFunc   ;==>ApplyToAll


Func ApplyToSelected()
	LogConsole("-- ApplyToSelected --")
	Local $itabselected = GUICtrlRead($tbAllSettings)
	Local $sSection = $g_aTitles[$itabselected]
	Local $sKey = GUICtrlRead($g_aCmbKey[$itabselected], $GUI_READ_EXTENDED)
	Local $sValue = GUICtrlRead($g_aTxtValue[$itabselected])

	;Local $aSelectedProfiles = GetSelectedProfiles()

	If UBound($g_asProfilesNames) = 0 Then
		MsgBox($MB_OK, "", "No profiles selected.")
		Return
	EndIf

	; Speichere die ausgewählten Profile im globalen Array
	;$g_aSelectedProfiles = $aSelectedProfiles

	For $i = 0 To UBound($g_asProfilesNames) - 1
		;LogConsole("Profile: " & $g_asProfilesNames[$i])
		If GUICtrlRead($aProfileCheckboxes[$i]) = $GUI_CHECKED Then
			Local $path = $g_sProfilePath & "\" & $g_asProfilesNames[$i] & "\config.ini"
			IniWrite($path, $sSection, $sKey, $sValue)
			LogConsole("Profile: " & $g_asProfilesNames[$i] & " Apply to Selected: " & $sKey & "=" & $sValue)
			SetLog($g_lblHelp[$itabselected], $g_asProfilesNames[$i] & ">>" & $sKey & "=" & $sValue)
		EndIf
	Next
	;UpdateHelpBox()
EndFunc   ;==>ApplyToSelected
