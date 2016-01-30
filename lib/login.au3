Func Login($login, $pass, $name)
   $startZeroPixel = 1212604
   $endZeroPixel = 526344
   Global $windowName = $name

   Run(IniRead("config.ini", "settings", "l2.exe", ""))
   WinWaitActive("c4classic.ru")
   Global $windowHandle = WinGetHandle("c4classic")
   ;Wait while game loading
   While 1
	  $pixel = PixelGetColor(0, 0, $windowHandle)
	  If $startZeroPixel = $pixel Then
		 ExitLoop
	  EndIf
	  Sleep(100)
   WEnd

   ;Login
   ControlSend($windowHandle, "", "", $login)
   ControlSend($windowHandle, "", "", "{TAB}")
   ControlSend($windowHandle, "", "", $pass)
   While 1
	  $pixel = PixelGetColor(0, 0, $windowHandle)
	  If $endZeroPixel = $pixel Then
		 ExitLoop
	  Else
		 ControlSend($windowHandle, "", "", "{ENTER}")
		 ControlSend($windowHandle, "", "", "{TAB}")
	  EndIf
	  Sleep(1000)
   WEnd
EndFunc