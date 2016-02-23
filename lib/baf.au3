HotKeySet ("{ESC}", "terminate")

Func Terminate()
	Exit
EndFunc



Func Baf($bafferName, $targetName, $timeout, $bafs)

	$bafferHandle = WinGetHandle($bafferName)
	$targetHandle = WinGetHandle($targetName)
	WinActivate($bafferHandle)
	WinWaitActive($bafferHandle)
	ControlSend($bafferHandle, '', '', "{ENTER}")
	ControlSend($bafferHandle, '', '', "/target " & $targetName & "{ENTER}")
	Sleep(100)
	For $baf In $bafs
		ControlSend($bafferHandle, '', '', "{ENTER}")
		ControlSend($bafferHandle, '', '', "/useskill " & $baf & "{ENTER}")
		Sleep($timeout)
		Next
EndFunc

;local $bafs1[] = ["Acumen", "Berserker Spirit", "Wind Walk"]

;Baf("Praudmoore", "Praudmoore", 2000, $bafs1)
;Baf("Praudmoore", "Whisperwind", 2000, $bafs1)
local $bafs2[] = ["EmPower"]
Baf("Whisperwind", "Whisperwind", 1000, $bafs2)
;local $bafs3[] = ["Bless the Body", "Regeneration", "Bless the Soul", "Mental Shiled", "Magic Barrier", "Shield", "Holy Weapon", "Berserker Spirit", "Concentration", "Acumen", "Bless Shield", "Wind Walk"]
;Baf("Praudmoore", "zoi", 2000, $bafs3)