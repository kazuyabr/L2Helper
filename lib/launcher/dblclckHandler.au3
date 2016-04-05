;Doubleclick in listview handler
Global $iDblClck_Speed = RegRead('HKEY_CURRENT_USER\Control Panel\Mouse', 'DoubleClickSpeed')
$iDblClick_Dummy = GUICtrlCreateDummy()
GUIRegisterMsg($WM_NOTIFY, 'WM_NOTIFY')

Func WM_NOTIFY($hWnd, $MsgID, $wParam, $lParam)
	Local $stNMHDR, $iCode

	$stNMHDR = DllStructCreate($tagNMHDR, $lParam)
	If @error Then Return 0

	$iCode = DllStructGetData($stNMHDR, 'Code')

	If $wParam = $charList And $iCode = $NM_DBLCLK Then
		GUICtrlSendToDummy($iDblClick_Dummy)
	EndIf

	Return $GUI_RUNDEFMSG
EndFunc
