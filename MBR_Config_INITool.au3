#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Icons\Main.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

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
Global $g_hDllIcons = @ScriptDir &"\dllImages.dll"
Global Enum $g_IconMain = 1 , $g_IconAndroid , $g_IconApply , $g_IconConfig , $g_IconFolder , $g_IconReload
Global $g_sProfilePath = ""
Global $g_sProfileINI = ""
Global $g_aAllAccountsNames , $g_aSectionValues

; UI
Global $UiForm = GUICreate("MBR Config INI Tool v1.0.0", 613, 303, -1, -1)
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

; TABS
GUICtrlCreateGroup("Settings", 8, 89, 601, 169, -1, $WS_EX_TRANSPARENT)
	Global $tbAllSettings = GUICtrlCreateTab(10, 104, 597, 152)
		GUICtrlSetResizing($tbAllSettings, $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)

	Global $tbSettings = 0, $tbDebug = 0, $tbDeleteFiles = 0, $tbOther = 0, $tbAndroid = 0
	Global $cmbKeySettings = 0, $cmbKeyDebug = 0, $cmbKeyDeleteFiles = 0, $cmbKeyOther = 0, $cmbKeyAndroid = 0
	Global $txtValueSettings = 0, $txtValueDebug = 0, $txtValueDeleteFiles = 0, $txtValueOther = 0, $txtAndroid = 0
	Global $g_aBtnReloadSettings = 0, $g_aBtnReloadDebug = 0, $g_aBtnReloadDeleteFiles = 0, $g_aBtnReloadOther = 0, $g_aBtnReloadAndroid = 0
	Global $lblValueSettings = 0, $lblValueDebug = 0, $lblValueDeleteFiles = 0, $lblValueOther = 0, $lblValueAndroid = 0
	Global $lblValuetSettings = 0, $lblValuetDebug = 0, $lblValuetDeleteFiles = 0, $lblValuetOther = 0, $lblValuetAndroid = 0
	Global $g_lblHelp[5]
	Global $lblHelpGeneral 		= ("General Variables" & @CRLF)
	Global $lblHelpDebug 		= ("Debug Variables" & @CRLF)
	Global $lblHelpDeleteFiles 	= ("Delete Files Variables" & @CRLF)
	Global $lblHelpOther 		= ("Other Variables" & @CRLF)
	Global $lblHelpAndroid 		= ("Android Variables" & @CRLF)

	Global $g_aTitles 		= ["General", "Debug", "DeleteFiles", "Other", "Android"]
	Global $g_aTabs 		= [$tbSettings, $tbDebug, $tbDeleteFiles, $tbOther, $tbAndroid]
	Global $g_aCmbKey 		= [$cmbKeySettings, $cmbKeyDebug, $cmbKeyDeleteFiles, $cmbKeyOther, $cmbKeyAndroid]
	Global $g_aTxtValue 	= [$txtValueSettings, $txtValueDebug, $txtValueDeleteFiles, $txtValueOther, $txtAndroid]
	Global $g_aBtnReload 	= [$g_aBtnReloadSettings, $g_aBtnReloadDebug, $g_aBtnReloadDeleteFiles, $g_aBtnReloadOther, $g_aBtnReloadAndroid]
	Global $g_alblValue 	= [$lblValueSettings, $lblValueDebug, $lblValueDeleteFiles, $lblValueOther, $lblValueAndroid]
	Global $g_alblVar 		= [$lblValuetSettings, $lblValuetDebug, $lblValuetDeleteFiles, $lblValuetOther, $lblValuetAndroid]
	Global $g_lblHelpInfo	= [$lblHelpGeneral, $lblHelpDebug, $lblHelpDeleteFiles , $lblHelpOther, $lblHelpAndroid]


	For $i = 0 To UBound($g_aTitles) - 1
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
			$g_lblHelp[$i] = GUICtrlCreateEdit("", 375 + 7, 152, 210, 89,  BitOr($ES_READONLY, $WS_VSCROLL, $ES_AUTOVSCROLL))
			GUICtrlSetData($g_lblHelp[$i] , $g_lblHelpInfo[$i])
		GUICtrlCreateGroup("", -99, -99, 1, 1)
	Next

	GUICtrlCreateTabItem("")
GUICtrlCreateGroup("", -99, -99, 1, 1)

; BOTTOM
GUICtrlCreateGroup("", 8, 256, 600, 39, $BS_FLAT)
	Global $btnApplyAll = GUICtrlCreateButton("Apply to All", 520, 266, 75, 25, $WS_GROUP)
		GUICtrlSetTip($btnApplyAll, "Apply to [ALLProfiles]\Config.ini")
	Global $btnApplyCurrent = GUICtrlCreateButton("Apply Current", 440, 266, 75, 25, $WS_GROUP)
		GUICtrlSetTip($btnApplyCurrent, "Apply to [Profile]\Config.ini")
	Global $btnReload = GUICtrlCreateButton("MBR Folder", 40, 266, 75, 25, $WS_GROUP)
		GUICtrlSetTip($btnReload, "Select the Profile Folder")
	Global $lblProfilePath = GUICtrlCreateLabel("", 117, 272, 275, 17)
		GUICtrlSetColor($lblProfilePath, 0xFF0000)
	Global $IconFolder = GUICtrlCreateIcon($g_hDllIcons, $g_IconFolder, 13, 265, 24, 24, BitOR($SS_NOTIFY, $WS_GROUP))
	Global $IconApply = GUICtrlCreateIcon($g_hDllIcons, $g_IconApply, 410, 266, 24, 24, BitOR($SS_NOTIFY, $WS_GROUP))
GUICtrlCreateGroup("", -99, -99, 1, 1)

GUISetState(@SW_SHOW)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $btnReload
			SelectBotFolder()
		Case $btnApplyCurrent
			ApplyCurrent()
		Case $btnApplyAll
			ApplyToAll()
		case $tbAllSettings
			ConsoleWrite("Tab " & $g_aTitles[GUICtrlRead($tbAllSettings)] & " Selected" & @CRLF)
		Case $g_aBtnReload[0], $g_aBtnReload[1], $g_aBtnReload[2], $g_aBtnReload[3], $g_aBtnReload[4]
			LoadKeys()
		case $g_aCmbKey[0], $g_aCmbKey[1], $g_aCmbKey[2], $g_aCmbKey[3], $g_aCmbKey[4]
			LoadValues()
	EndSwitch
WEnd

Func SetLog($g_lblHelp , $Text)
	Local $gettxt =  @HOUR & ":" &@MIN & ":" & @SEC &  " - " & $Text & @CRLF
	GUICtrlSetData($g_lblHelp , $gettxt, 1)
EndFunc

Func SelectBotFolder()
	Local $IniSets = @ScriptDir & "\config.ini"
	Local $initialdir = @DesktopDir

	If FileExists(@ScriptDir & "\Profiles" )  then  $initialdir = @ScriptDir & "\Profiles"

	If FileExists($IniSets) Then
		$g_sProfilePath = IniRead($IniSets, "Set", "Path", "")
	Else
		$g_sProfilePath = FileSelectFolder ("Select the .\Profiles Folder" , $initialdir )
		If @error Then
			; Display the error message.
			MsgBox($MB_OK, "", "No folder was selected.")
			Return
		EndIf
		IniWrite($IniSets, "Set", "Path", $g_sProfilePath)
	EndIf

	$g_sProfileINI = $g_sProfilePath & "\profile.ini"
	GUICtrlSetData($lblProfilePath,  $g_sProfilePath)
	local $defaultprofile = LoadGeneralProfileFile()
	LoadAllProfiles($defaultprofile)
EndFunc

Func LoadGeneralProfileFile()
	Local $defaultprofile = IniRead($g_sProfileINI, "general" , "defaultprofile" , "")
	Local $globalthreads = IniRead($g_sProfileINI, "general" , "globalthreads" , "")
	If $globalthreads <> "" then GUICtrlSetData ($txtglobalthreads , $globalthreads )
	Local $abdpath = IniRead($g_sProfileINI, "general" , "adb.path" , "")
	If $abdpath <> "" then GUICtrlSetData ($txtabdpath , $abdpath )
	Return $defaultprofile
EndFunc

Func LoadAllProfiles($defaultprofile)
	$g_aAllAccountsNames = _FileListToArray($g_sProfilePath, "*", $FLTA_FOLDERS)
	If @error = 1 Then
		MsgBox($MB_OK, "", "Path was invalid.")
		Exit
	EndIf
	If $g_aAllAccountsNames[0] = 0 then return
	Local $sSTring , $defaultstring = ""
	For $i = 1 to Ubound($g_aAllAccountsNames) -1
		$sSTring &= $g_aAllAccountsNames[$i] & "|"
		If $g_aAllAccountsNames[$i] = $defaultprofile then
			$defaultstring = $g_aAllAccountsNames[$i]
		EndIf
	Next
	$sSTring = StringTrimRight($sSTring, 1)
	GUICtrlSetData($cmbProfileNames, $sSTring, $defaultprofile)
	If $defaultstring <> "" then GUICtrlSetData($cmbDefaultProfile, $sSTring, $defaultprofile)
EndFunc

Func LoadKeys()
	ConsoleWrite("-- LoadKeys --" & @CRLF)
	Local $profile = GUICtrlRead($cmbProfileNames, $GUI_READ_EXTENDED)
	ConsoleWrite("Profile: " & $profile & @CRLF)
	Local $itabselected = GUICtrlRead($tbAllSettings)
	Local $sSection = $g_aTitles[$itabselected]
	ConsoleWrite("Section: " & $sSection & @CRLF)
	Local $sKey = $g_aCmbKey[$itabselected]

	Local $path = $g_sProfilePath & "\" & $profile & "\config.ini"
	; ConsoleWrite("$path: " & $path & @CRLF)
	$g_aSectionValues = ""
	$g_aSectionValues = IniReadSection ($path, $sSection)
	; ConsoleWrite("$g_aSectionValues: " & _ArrayToString($g_aSectionValues) & @CRLF)
	If @error then return
	Local $sSTring = ""
	For $i = 1 to UBound($g_aSectionValues) -1
		$sSTring &= $g_aSectionValues[$i][0] & "|" ; Key
	Next
	$sSTring = StringTrimRight($sSTring, 1)
	GUICtrlSetData($g_aCmbKey[$itabselected], "", "")
	GUICtrlSetData($g_aCmbKey[$itabselected], $sSTring, $g_aSectionValues[1][0])
	GUICtrlSetData($g_aTxtValue[$itabselected] , $g_aSectionValues[1][1])
	SetLog($g_lblHelp[$itabselected], "Load Keys")
EndFunc

Func LoadValues()
	ConsoleWrite("-- LoadValues --" & @CRLF)
	Local $profile = GUICtrlRead($cmbProfileNames, $GUI_READ_EXTENDED)
	ConsoleWrite("Profile: " & $profile & @CRLF)
	Local $itabselected = GUICtrlRead($tbAllSettings)
	Local $sSection = $g_aTitles[$itabselected]
	ConsoleWrite("Section: " & $sSection & @CRLF)
	Local $sKey = GUICtrlRead($g_aCmbKey[$itabselected], $GUI_READ_EXTENDED)
	Local $path = $g_sProfilePath & "\" & $profile & "\config.ini"
	Local $value = Iniread($path, $sSection, $sKey, "")
	ConsoleWrite("Key: " & $sKey & " | Value: " & $value & @CRLF)
	GUICtrlSetData($g_aTxtValue[$itabselected] , $value)
	SetLog($g_lblHelp[$itabselected], "Load " & $sKey & "="& $value)
EndFunc

Func ApplyCurrent()
	ConsoleWrite("-- ApplyCurrent --" & @CRLF)
	Local $profile = GUICtrlRead($cmbProfileNames, $GUI_READ_EXTENDED)
	ConsoleWrite("Profile: " & $profile & @CRLF)
	Local $itabselected = GUICtrlRead($tbAllSettings)
	Local $sSection = $g_aTitles[$itabselected]
	Local $sKey = GUICtrlRead($g_aCmbKey[$itabselected], $GUI_READ_EXTENDED)
	Local $value = GUICtrlRead($g_aTxtValue[$itabselected])
	Local $path = $g_sProfilePath & "\" & $profile & "\config.ini"
	IniWrite($path, $sSection, $sKey, $value)
	SetLog($g_lblHelp[$itabselected], "Aplly Current: ")
	SetLog($g_lblHelp[$itabselected], $sKey & "=" & $value)
EndFunc

Func ApplyToAll()
	ConsoleWrite("-- ApplyToAll --" & @CRLF)
	Local $itabselected = GUICtrlRead($tbAllSettings)
	Local $sSection = $g_aTitles[$itabselected]
	ConsoleWrite("Section: " & $sSection & @CRLF)
	Local $sKey = GUICtrlRead($g_aCmbKey[$itabselected], $GUI_READ_EXTENDED)
	ConsoleWrite("Key: " & $sKey & @CRLF)
	Local $sValue = GUICtrlRead($g_aTxtValue[$itabselected])
	ConsoleWrite("Value: " & $sValue & @CRLF)

	; All profiles
	If $g_aAllAccountsNames[0] = 0 then return
	For $i = 1 to Ubound($g_aAllAccountsNames) -1
		ConsoleWrite("Profile: " & $g_aAllAccountsNames[$i] & @CRLF)
		Local $path = $g_sProfilePath & "\" & $g_aAllAccountsNames[$i] & "\config.ini"
		IniWrite($path, $sSection, $sKey, $sValue)
	Next
	SetLog($g_lblHelp[$itabselected], "Aplly 2 All: ")
	SetLog($g_lblHelp[$itabselected], $sKey & "=" & $sValue)
EndFunc