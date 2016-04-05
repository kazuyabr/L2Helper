#NoTrayIcon
#include <Constants.au3>
#include <GUIConstantsEx.au3>
#include <StructureConstants.au3>
#include "lib\launcher\hotkeys.au3"

;Reading all accounts info from ini
$charactersRaw = IniReadSection("config.ini", "Characters")
If @error Then
	MsgBox($MB_OK, "Error", "config.ini not found or empty")
	Exit
EndIf
$charsCount = $charactersRaw[0][0]

;[0] - ControlID, [1] - Login, [2] - Password, [3] - Window name, [4] - PID
Global $chars[$charsCount][5]
Global $i
#include "lib\launcher\runInstance.au3"

;Drawing GUI
Local $hGUI = GUICreate("L2Helper", 300, 410)
GUICtrlCreateTab(0, 0, 300, 250)

;Launcher tab
#include "lib/launcher/launcherTab.au3"

;Crafter tab
#include "lib/launcher/crafterTab.au3"

;LogWindow
#include "lib/launcher/logWindow.au3"

GUISetState(@SW_SHOW, $hGUI)

;Doubleclick in listview handler
#include "lib/launcher/dblclckHandler.au3"

;Main cycle
While 1
	Switch GUIGetMsg()
		Case $checkAllButton
			For $i = 0 To $charsCount - 1
				GUICtrlSetState($chars[$i][0], $GUI_CHECKED)
			Next

		Case $uncheckAllButton
			For $i = 0 To $charsCount - 1
				GUICtrlSetState($chars[$i][0], $GUI_UNCHECKED)
			Next

		Case $iDblClick_Dummy
			$charID = GUICtrlRead($charList)
			For $i = 0 To $charsCount - 1
				If $chars[$i][0] = $charID Then
					runInstance()
				EndIf
			Next

		Case $runButton
			For $i = 0 To $charsCount - 1
				If GUICtrlRead($chars[$i][0], $GUI_READ_EXTENDED) = $GUI_CHECKED Then
					runInstance()
				EndIf
			Next

		Case $maxForSelectedButton
			MaxCountButton()

		Case $calculateResButton
			CalcResButton()

		Case $roundCraftCountButton
			RoundButton()

		Case $startCraftButton
			CraftItButton()

		Case $GUI_EVENT_CLOSE
			ExitLoop
	EndSwitch

	;read messages from running windows
	For $i = 0 To $charsCount - 1
		$data = StdoutRead($chars[$i][4])
		If $data <> '' Then LogWrite($data)
	Next
WEnd

GUIDelete($hGUI)