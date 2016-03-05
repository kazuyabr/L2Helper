#include-once
#include <findImageCoords.au3>

Func inviteToParty($leaderName, $memberName)
	$leaderHwnd = WinGetHandle($leaderName)
	$memberHwnd = WinGetHandle($memberName)
	WinActivate($leaderHwnd)
	WinWaitActive($leaderHwnd)
	Send("/invite " & $memberName)
	Send("{ENTER}")
	WinActivate($memberHwnd)
	WinWaitActive($memberHwnd)
	$coords = FindImageCoords("yesButton")
	MouseClick("left", $coords[0], $coords[1])
	Sleep(1000)
	WinActivate($leaderHwnd)
	WinWaitActive($leaderHwnd)
EndFunc

inviteToParty("Bronzebeard", "Praudmoore")
inviteToParty("Bronzebeard", "Whisperwind")