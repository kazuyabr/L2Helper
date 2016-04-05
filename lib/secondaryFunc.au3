Func giveAll($windowHandle)
	$coord = FindImageCoords("allButton", "lefttop", $traderHandle, True)
	MouseClick("left", $coords[0], $coords[1])
	MouseClick("left", $coords[0] - 201, $coords[1])
EndFunc

Func ClickYesButton($windowHandle)
	$coords = FindImageCoords("yesButton", "center", $windowHandle, True)
	MouseClick("left", $coords[0], $coords[1])
EndFunc

Func ClickCloseButton($windowHandle)
	$coords = FindImageCoords("closeButton", "center", $windowHandle, True)
	MouseClick("left", $coords[0], $coords[1])
EndFunc

Func ClickOkButton($windowHandle)
	$coords = FindImageCoords("okButton", "center", $windowHandle, True)
	MouseClick("left", $coords[0], $coords[1])
EndFunc