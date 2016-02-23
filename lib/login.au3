Func Login($login, $pass, $name)
    $startZeroPixel = 1212604
    $endZeroPixel = 526344
    Global $windowName = $name

	Run(IniRead("config.ini", "settings", "l2.exe", ""))
    WinWaitActive("c4classic.ru")
    Global $windowHandle = WinGetHandle(IniRead("config.ini", "settings", "WindowName", ""))

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
			ExitLoop
		EndIf

		ControlSend($windowHandle, "", "", "{ENTER}")
		ControlSend($windowHandle, "", "", "{TAB}")
		Sleep(1000)
	WEnd
EndFunc