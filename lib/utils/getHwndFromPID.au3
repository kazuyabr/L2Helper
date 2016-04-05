func _GetHWNDFromPID($PID, $title)
	While 1
		$WinList=WinList()
		for $i=1 to $WinList[0][0]
			if WinGetProcess($WinList[$i][1])=$PID AND $WinList[$i][0] = $title then
				Return $WinList[$i][1]
			EndIf
		Next
		Sleep(100)
	WEnd
EndFunc