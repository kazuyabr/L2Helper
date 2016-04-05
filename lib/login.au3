#include-once
#include "utils\getHwndFromPID.au3"
#include "findImageCoords.au3"
;@error codes: 1 - exe not found, 2 - window is closing during login process
;3 - can't find enter button on screen more than 1 minute
;4 - can't find char status bar on screen more than 1 minute
Func Login($login, $pass, $name)
	SetError(0)
	;VMWare have several differences in work
	$vmware = ProcessExists("vmtoolsd.exe")

	Global $windowName = $name
	$pid = Run(IniRead("config.ini", "settings", "l2.exe", ""))
	If $pid = 0 Then
		SetError(1)
		Return False
	EndIf

	If $vmware > 0 Then
		WinWaitActive("Warning")
		Send("{ENTER}")
	EndIf

	Global $windowHandle = _GetHWNDFromPID($pid, "c4classic.ru")
	WinWaitActive($windowHandle)

	$timer = TimerInit()
	While 1
		If not WinExists($windowHandle) Then
			SetError(2)
			Return False
		EndIf

		$enterButton = findImageCoords("enterButton", "lefttop", $windowHandle, True)
		If $enterButton <> False Then
			ExitLoop
		EndIf

		If TimerDiff($timer) > 60000 Then
			SetError(3)
			Return False
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

	$timer = TimerInit()
	While 1
		If Not WinExists($windowHandle) Then
			SetError(2)
			Return False
		EndIf

		$charStatusLeft = findImageCoords("charStatusLeft", "lefttop", $windowHandle, True)
		If $charStatusLeft <> False Then
			Return True
		EndIf

		If TimerDiff($timer) > 60000 Then
			SetError(4)
			Return False
		EndIf

		ControlSend($windowHandle, "", "", "{ENTER}")
		ControlSend($windowHandle, "", "", "{TAB}")
		Sleep(1000)
	WEnd
EndFunc