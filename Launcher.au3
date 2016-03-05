#NoTrayIcon
#include <Constants.au3>
#include <GUIConstantsEx.au3>
#include <ButtonConstants.au3>
#include <MsgBoxConstants.au3>
#include <ListviewConstants.au3>
#include <StructureConstants.au3>
#include <WindowsConstants.au3>
#include <lib/hotkeys.au3>

;Reading all accounts info from ini
$charactersRaw = IniReadSection("config.ini", "Characters")
If @error Then
	MsgBox($MB_OK, "Ошибка", "config.ini не найден, либо пуст")
	Exit
EndIf
$charsCount = $charactersRaw[0][0]
Local $chars[$charsCount][4]

;Drawing GUI
Local $hGUI = GUICreate("L2Helper", 300, 250)
Local $idTab = GUICtrlCreateTab(0, 0, 300, 250)
Local $laun = GUICtrlCreateTabItem("Launcher")
$list = GUICtrlCreateListView('Имя персонажа', 5, 25, 130, 220, BitOR($LVS_NOCOLUMNHEADER, $LVS_SINGLESEL), $LVS_EX_CHECKBOXES)
For $i = 1 To $charsCount
	$tmp = StringSplit($charactersRaw[$i][1], ":")
	$chars[$i - 1][1] = $tmp[1]
	$chars[$i - 1][2] = $tmp[2]
	$chars[$i - 1][3] = $tmp[3]
	$chars[$i - 1][0] = GUICtrlCreateListViewItem($chars[$i - 1][3], $list)
Next
$checkAllButton = GUICtrlCreateButton("Выделить все", 180, 25, 100, 25)
$uncheckAllButton = GUICtrlCreateButton("Снять выделение", 180, 50, 100, 25)
$runButton = GUICtrlCreateButton("Запуск", 180, 75, 100, 25)
GUICtrlCreateTabItem("")
GUISetState(@SW_SHOW, $hGUI)

;Doubleclick in listview handler
Global $iDblClck_Speed = RegRead('HKEY_CURRENT_USER\Control Panel\Mouse', 'DoubleClickSpeed')
$iDblClick_Dummy = GUICtrlCreateDummy()
GUIRegisterMsg($WM_NOTIFY, 'WM_NOTIFY')

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
			$charID = GUICtrlRead($list)
			For $i = 0 To $charsCount - 1
				If $chars[$i][0] = $charID Then
					Run("L2Helper.exe " & $chars[$i][1] & " " & $chars[$i][2] & " " & $chars[$i][3])
				EndIf
			Next
		Case $runButton
			For $i = 0 To $charsCount - 1
				If GUICtrlRead($chars[$i][0], $GUI_READ_EXTENDED) = $GUI_CHECKED Then
					$pid = Run("L2Helper.exe " & $chars[$i][1] & " " & $chars[$i][2] & " " & $chars[$i][3], '', @SW_SHOW, $STDOUT_CHILD)
					While 1
						If StdoutRead($pid) <> '' Then ExitLoop
						Sleep(1)
					WEnd
				EndIf
			Next
		Case $GUI_EVENT_CLOSE
			ExitLoop
	EndSwitch
WEnd

GUIDelete($hGUI)

Func WM_NOTIFY($hWnd, $MsgID, $wParam, $lParam)
	Local $stNMHDR, $iCode

	$stNMHDR = DllStructCreate($tagNMHDR, $lParam)
	If @error Then Return 0

	$iCode = DllStructGetData($stNMHDR, 'Code')

	If $wParam = $list And $iCode = $NM_DBLCLK Then
		GUICtrlSendToDummy($iDblClick_Dummy)
	EndIf

	Return $GUI_RUNDEFMSG
EndFunc
