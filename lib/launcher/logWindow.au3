#include-once
#include <GUIEdit.au3>
#include <ScrollBarConstants.au3>
#include <EditConstants.au3>
#include <WindowsConstants.au3>

$logWindow = GUICtrlCreateEdit('', 0, 255, 300, 150, BitOR($ES_READONLY, $WS_VSCROLL))

Func logWrite($data)
	$iEnd = StringLen(GUICtrlRead($logWindow))
	_GUICtrlEdit_SetSel($logWindow, $iEnd, $iEnd)
	_GUICtrlEdit_Scroll($logWindow, $SB_SCROLLCARET)

	If GUICtrlRead($logWindow) = '' Then
		GUICtrlSetData($logWindow, $data, 1)
	Else
		GUICtrlSetData($logWindow, @CRLF & $data, 1)
	EndIf
EndFunc