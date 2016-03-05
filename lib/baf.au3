HotKeySet("{ESC}", "term")
Func Term()
	Exit
EndFunc



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
EndFunc   ;==>Baf

Local $baflist[] = ["Acumen", "Berserker Spirit"]
Baf("Praudmoore", "Praudmoore", 2500, $baflist)
Baf("Praudmoore", "Whisperwind", 1900, $baflist)
Local $baflist[] = ["Bless the Body", "Regeneration", "Magic Barrier", "Shield", "Holy Weapon", "Berserker Spirit", "Might", "Focus", "Haste", "Wind Walk"]
Baf("Praudmoore", "Bronzebeard", 1900, $baflist)
Local $baflist[] = ["Guidance", "Death Whisper", "Vampiric Rage"]
Baf("Whisperwind", "Bronzebeard", 1900, $baflist)
WinActivate("Bronzebeard")