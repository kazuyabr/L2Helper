Func Login($login, $pass, $name)
	$startZeroPixel = 1212604
	$endZeroPixel = 526344
	Global $windowName = $name
	$pid = Run(IniRead("config.ini", "settings", "l2.exe", ""))
	Global $windowHandle = _GetHWNDFromPID($pid, IniRead('config.ini', 'Settings', 'WindowName', ''))
	WinWaitActive($windowHandle)
	;Wait while game loading
	While 1
		If not WinExists($windowHandle) Then
			Return False
		EndIf
		$pixel = PixelGetColor(0, 0, $windowHandle)
		If $startZeroPixel = $pixel Then
			ExitLoop
		EndIf
		Sleep(100)
	WEnd

	;Default 5 ms delay to small for login window and with 5ms to much bugs
	Opt('SendKeyDownDelay', IniRead("config.ini", "settings", "LoginKeyDelay", ""))
	;Login
	ControlSend($windowHandle, "", "", $login)
	ControlSend($windowHandle, "", "", "{TAB}")
	ControlSend($windowHandle, "", "", $pass)
	Opt('SendKeyDownDelay', 5)
	While 1
		If Not WinExists($windowHandle) Then
			Return False
		EndIf

		$pixel = PixelGetColor(0, 0, $windowHandle)
		If $endZeroPixel = $pixel Then
			Return True
		EndIf

		ControlSend($windowHandle, "", "", "{ENTER}")
		ControlSend($windowHandle, "", "", "{TAB}")
		Sleep(1000)
	WEnd
EndFunc

;Getting window handle from pid and title. I dont know why all wont work when I'm use only pid, without window title.
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