#NoTrayIcon
#include <Constants.au3>
#include <GUIConstantsEx.au3>
#include <ButtonConstants.au3>
#include <TreeViewConstants.au3>


Local $hGUI = GUICreate("L2Helper", 250, 150)
$list = GUICtrlCreateTreeView(10, 10, 150, 130, $TVS_CHECKBOXES)
$char1 = GUICtrlCreateTreeViewItem("Char1", $list)
$char2 = GUICtrlCreateTreeViewItem("Char2", $list)
$char3 = GUICtrlCreateTreeViewItem("Char3", $list)
$char4 = GUICtrlCreateTreeViewItem("Char4", $list)
$checkAllButton = GUICtrlCreateButton("Check all", 180, 10)
GUISetState(@SW_SHOW, $hGUI)

Local $iMsg = 0
While 1
   $iMsg = GUIGetMsg()
   If $iMsg = $GUI_EVENT_CLOSE Then
	  ExitLoop
   EndIf
   If $iMsg = $checkAllButton Then
	  GUICtrlSetState($char1, $GUI_CHECKED)
	  GUICtrlSetState($char2, $GUI_CHECKED)
	  GUICtrlSetState($char3, $GUI_CHECKED)
	  GUICtrlSetState($char4, $GUI_CHECKED)
	  EndIf

WEnd

GUIDelete($hGUI)