#NoTrayIcon
#include <lib\login.au3>
#include <lib\craft.au3>
#include <StringConstants.au3>
#include <MsgBoxConstants.au3>
#include <array.au3>

If $cmdLine[0] = 0 Then
	MsgBox($MB_OK, "Error", "Use Launcher.exe")
	Exit
EndIf

;Default 5 ms delay to small for login window and with 5ms to much bugs in game
Opt("SendKeyDownDelay", IniRead("config.ini", "settings", "LoginKeyDelay", ""))


If Not Login($cmdLine[1], $cmdLine[2], $cmdLine[3], $cmdLine[4]) Then
	Switch @error
		Case 1
			ConsoleWrite("L2.exe not found. Check config.ini")
		Case 2
			ConsoleWrite($windowName & ' window is closed in login process')
		Case 3
			ConsoleWrite($windowName & " window error:" & @CRLF & "Can't find enter button on screen more than 1 minute")
		Case 4
			ConsoleWrite($windowName & " window error:" & @CRLF & "Can't find char status bar on screen more than 1 minute")
	EndSwitch
	Exit
EndIf

ConsoleWrite($windowName & ' successfully loaded')

;Main cycle where we waiting commands from launcher(in future versions)
While (WinGetState($windowHandle) <> 0)
	$data = ConsoleRead()
	if $data <> '' Then
		$call = StringSplit($data, ";")
		Switch $call[1]
			;[0] - parametrs amount, [1] - func name to call, [2] - recipe name, [3] - amount to craft, [4] - use recharger flag
			Case "craft"
				If $call[4] = "True" Then
					$call[4] = True
					ConsoleWrite("Start craft " & $call[2] & " in an amount " & $call[3] & " with recharger")
				Else
					$call[4] = False
					ConsoleWrite("Start craft " & $call[2] & " in an amount " & $call[3] & " without recharger")
				EndIf

				If Not Call("craft", $call[2], $call[3], $call[4]) Then
					Switch @error
						Case 1
							ConsoleWrite ("Can't find " & $call[2] & " image on screen")
						Case 2
							ConsoleWrite ("Can't find create button on screen")
						Case 3
							ConsoleWrite ("Can't find crafter status bar")
						Case 4
							ConsoleWrite ("Can't find recharger status bar")
					EndSwitch
					ConsoleWrite(@CRLF & "Craft Failed!:(")
				Else
					ConsoleWrite("Craft complete successful!")
					ConsoleWrite(@CRLF & "Starting trade...")
					If StartTrade(IniRead("config.ini", "craft", "CrafterName", ""), IniRead("Config.ini", $call[2], "trader", ""), $call[2]) = True Then
						ConsoleWrite("Trade start successful!")
					Else
						ConsoleWrite("Something went wrong... :(")
					EndIf
				EndIf
		EndSwitch
	EndIf

	;Keep window name
	WinSetTitle($windowHandle, "", $windowName)
	Sleep(1)
WEnd

ConsoleWrite ($windowName & ' was closed')