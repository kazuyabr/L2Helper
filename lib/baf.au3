Func Baf($bafferName, $targetName, $timeout, $bafs)

	$bafferHandle = WinGetHandle($bafferName)
	$targetHandle = WinGetHandle($targetName)
	WinActivate($bafferHandle)
	WinWaitActive($bafferHandle)
	Sleep(500)
	Send("{ENTER}")
	Send("/target " & $targetName & "{ENTER}")
	Sleep(100)
	For $baf In $bafs
		Send("{ENTER}")
		Send("/useskill " & $baf & "{ENTER}")
		Sleep($timeout)
		Next
EndFunc