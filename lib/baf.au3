Func Baf($bafferName, $targetName, $timeout, $bafs)

	$bafferHandle = WinGetHandle($bafferName)
	$targetHandle = WinGetHandle($targetName)
	WinActivate($bafferHandle)
	WinWaitActive($bafferHandle)
	Send("/target " & $targetName & "{ENTER}")
	Sleep(100)
	For $baf In $bafs
		Send("{ENTER}")
		Send("/useskill " & $baf & "{ENTER}")
		Sleep(3000)
		Next
EndFunc

local $bafs1[] = ["Acumen", "Berserker Spirit", "Wind Walk"]

Baf("Praudmoore", "Praudmoore", 1000, $bafs1)
Baf("Praudmoore", "Whisperwind", 1000, $bafs1)
local $bafs2[] = ["Resist Wind", "Vampiric Rage"]
Baf("Whisperwind", "Wildhummer", 1000, $bafs2)
local $bafs3[] = ["Bless the Body", "Regeneration", "Bless the Soul", "Magic Barrier", "Shield", "Holy Weapon", "Berserker Spirit", "Might", "Focus", "Haste", "Guidance", "Death Whisper", "Bless Shield", "Wind Walk"]
Baf("Praudmoore", "Wildhummer", 1000, $bafs3)