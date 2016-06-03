#include-once
#include "findimagecoords.au3"
#include "getHeroStatus.au3"
#include "secondaryFunc.au3"
;Error codes: 1 - can't find $item image on screen, 2 - can't find create button on screen
; 3 - can't find crafter status bar, 4 - cant find recharger status bar, 5 - interrupted by the user
Func Craft($item, $count, $useRecharge)
	SetError(0)
	$crafterName = IniRead("config.ini", "craft", "CrafterName", "")
	$crafterHandle = WinGetHandle($crafterName)
	$regenTimeout = IniRead("config.ini", "craft", "RegenTimeout", "")
	if $useRecharge Then
		$rechargerHandle = WinGetHandle(IniRead("config.ini", "craft", "RechargerName", ""))
		$rechargeTimeout = IniRead("config.ini", "craft", "RechargeTimeout", "")
		$rechargeCount = IniRead("config.ini", "craft", "RechargeCount", "")
		$rechargerSitFlag = 0
		WinActivate($rechargerHandle)
		WinWaitActive($rechargerHandle)
		Send("{Enter}/stand{ENTER}")
		Sleep(500)
		Send("{Enter}/target " & $crafterName & "{ENTER}")
	EndIf

	WinActivate($crafterHandle)
	WinWaitActive($crafterHandle)
	Send("{ENTER}/stand{ENTER}")
	Sleep(2000)
	Send("{ENTER}/useskill Dwarven Craft{ENTER}")
	Sleep(1000)
	Send("{ENTER}/sit{ENTER}")
	$coords = findImageCoords($item, "center", $crafterHandle, True)
	If $coords = False Then
		SetError(1)
		Return False
	EndIf
	MouseClick("left", $coords[0], $coords[1], 2)
	$coords = findImageCoords("createButton", "center", $crafterHandle,  True)
	If $coords = False Then
		SetError(2)
		Return False
	EndIf
	MouseMove($coords[0], $coords[1])
	$iCraft = $count/IniRead("craft.ini", $item, "count", "")


	While $iCraft > 0
		WinActivate($crafterHandle)
		WinWaitActive($crafterHandle)
		$mp = getHeroStatus($crafterHandle, "mp")
		If $mp = False Then
			SetError(3)
			Return False
		EndIf

		If $mp < 30 Then
			If $useRecharge Then
				WinActivate($rechargerHandle)
				WinWaitActive($rechargerHandle)
				$mp = getHeroStatus($rechargerHandle, "mp")
				If $mp = False Then
					SetError(4)
					Return False
				EndIf
				If $mp  > 30 Then
					If $rechargerSitFlag = 1 Then
						Send("{Enter}/stand{ENTER}")
						$rechargerSitFlag = 0
						Sleep(2000)
					EndIf
					For $i = 1 To $rechargeCount
						Send("{Enter}/useskill Recharge{ENTER}")
						Sleep($rechargeTimeout)
					Next
				Else
					Send("{Enter}/sit{ENTER}")
					$rechargerSitFlag = 1
					ConsoleWrite("Waiting mp regeneneration for " & $regenTimeout/60000 & " min")
					Sleep($regenTimeout)
				EndIf
			Else
				ConsoleWrite("Waiting mp regeneneration for " & $regenTimeout/60000 & " min")
				Sleep($regenTimeout)
			EndIf
		Else
			MouseClick("left", $coords[0], $coords[1])
			$iCraft -= 1
		EndIf
	WEnd
	Return True
EndFunc

Func StartTrade($crafter, $trader, $item)
	$crafterHandle = HWnd(IniRead($tempfile, "windowHandles", $crafter, ""))
	;TODO Имя окна и имя крафтера не совпадает
	$traderHandle = HWnd(IniRead($tempfile, "windowHandles", $trader, ""))
	$price = IniRead("craft.ini", $item, "price", "")
	$message = StringUpper($item) & " " & $price

	;Give all crafted production from crafter to trader
	;Give all adena from trader to crafter
	WinActivate($crafterHandle)
	WinWaitActive($crafterHandle)
	ClickCloseButton($crafterHandle)
	Send("{ENTER}/stand{ENTER}")
	Sleep(500)
	Send("{ENTER}/target " & $trader & "{ENTER}")
	Sleep(500)
	Send("{ENTER}/trade{ENTER}")
	WinActivate($traderHandle)
	WinWaitActive($traderHandle)
	ClickYesButton($traderHandle)
	$coords = FindImageCoords("adena", "center", $traderHandle, True)
	MouseClick("left", $coords[0], $coords[1], 2)
	giveAll($traderHandle)
	WinActivate($crafterHandle)
	WinWaitActive($crafterHandle)
	$coords = FindImageCoords($item, "center", $crafterHandle, True)
	MouseClick("left", $coords[0], $coords[1], 2)
	giveAll($traderHandle)
	ClickOkButton($crafterHandle)
	WinActivate($traderHandle)
	WinWaitActive($traderHandle)
	ClickOkButton($traderHandle)

	;start trade all recieving production from crafter
	Send("{ENTER}/vendor{ENTER}")
	Sleep(500)
	$coord = FindImageCoords($item, "center", $traderHandle, True)
	MouseClick("left", $coords[0], $coords[1], 2)
	Send($price)
	ClickOkButton($traderHandle)
	giveAll($traderHandle)
	SetTradeMessage($traderHandle, $message)
	TradeStart($traderHandle)
	Send("{ENTER}offline{ENTER}")
	Sleep(500)
	WinClose($traderHandle)

	Return True
EndFunc