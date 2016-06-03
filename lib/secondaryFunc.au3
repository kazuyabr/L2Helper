Func giveAll($windowHandle)
	$coords = FindImageCoords("allButton", "lefttop", $windowHandle, True)
	MouseClick("left", $coords[0] + 10, $coords[1] + 5)
	Sleep(500)
	MouseClick("left", $coords[0] - 201, $coords[1])
	Sleep(500)
EndFunc

Func ClickYesButton($windowHandle)
	$coords = FindImageCoords("yesButton", "center", $windowHandle, True)
	MouseClick("left", $coords[0], $coords[1])
	Sleep(500)
EndFunc

Func ClickCloseButton($windowHandle)
	$coords = FindImageCoords("closeButton", "center", $windowHandle, True)
	MouseClick("left", $coords[0], $coords[1])
	Sleep(500)
EndFunc

Func ClickOkButton($windowHandle)
	$coords = FindImageCoords("okButton", "center", $windowHandle, True)
	MouseClick("left", $coords[0], $coords[1])
	Sleep(500)
EndFunc

Func SetTradeMessage($windowHandle, $message)
	$coords = FindImageCoords("tradeMessageButton", "center", $windowHandle, True)
	MouseClick("left", $coords[0], $coords[1])
	Sleep(500)
	Send($message)
	ClickOkButton($windowHandle)
EndFunc

Func TradeStart($windowHandle)
	$coords = FindImageCoords("tradeStartButton", "center", $windowHandle, True)
	MouseClick("left", $coords[0], $coords[1])
	Sleep(500)
EndFunc