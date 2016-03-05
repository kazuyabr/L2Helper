#include-once
#include <findimagecoords.au3>
#include <getHeroStatus.au3>

HotKeySet("{ESC}", "Term")

Func Term()
	Exit
EndFunc

Func Craft($item, $count, $useRecharge)
	Opt("SendKeyDownDelay", 30)
	$crafterName = IniRead("config.ini", "craft", "CrafterName", "")
	$rechargerName = IniRead("config.ini", "craft", "RechargerName", "")
	$rechargeTimeout = IniRead("config.ini", "craft", "RechargeTimeout", "")
	$rechargeCount = IniRead("config.ini", "craft", "RechargeCount", "")
	$regenTimeout = IniRead("config.ini", "craft", "RegenTimeout", "")
	WinActivate($crafterName)
	WinWaitActive($crafterName)
	Send("{ENTER}/stand{ENTER}")
	Sleep(2000)
	Send("{ENTER}/useskill Dwarven Craft{ENTER}")
	Sleep(1000)
	Send("{ENTER}/sit{ENTER}")
	$coords = findImageCoords($item, "center", True)
	MouseClick("left", $coords[0], $coords[1], 2)
	$coords = findImageCoords("createButton", "center", True)
	MouseMove($coords[0], $coords[1])
	$iCraft = Floor($count/IniRead("craft.ini", $item, "count", ""))
	While $iCraft > 0
		WinActivate($crafterName)
		WinWaitActive($crafterName)
		$mp = getHeroStatus($crafterName, "mp")

		If $mp < 20 Then
			If $useRecharge = True Then
				WinActivate($rechargerName)
				WinWaitActive($rechargerName)
				If getHeroStatus($rechargerName, "mp") > 30 Then
					Send("{Enter}/stand{ENTER}")
					Sleep(2000)
					Send("{Enter}/target " & $crafterName & "{ENTER}")
					For $i = 1 To $rechargeCount
						Send("{Enter}/useskill Recharge{ENTER}")
						Sleep($rechargeTimeout)
					Next
				Else
					Send("{Enter}/sit{ENTER}")
					Sleep($regenTimeout)
				EndIf
			Else
				Sleep($regenTimeout)
			EndIf
		Else
			MouseClick("left", $coords[0], $coords[1])
			$iCraft -= 1
		EndIf
	WEnd
EndFunc