#include-once
#include <findimagecoords.au3>

;parameter - hp, mp or cp
Func getHeroStatus($windowHandle, $parameter)
	$leftBarZeroCoord = findimagecoords("charStatusLeft", "lefttop", False)
	$startX = $leftBarZeroCoord[0] + 16
	Switch $parameter
		Case "cp"
			$y = $leftBarZeroCoord[1] + 26
			$fullColor = 0xC68E31
		Case "hp"
			$y = $leftBarZeroCoord[1] + 40
			$fullColor = 0xD60831
		Case "mp"
			$y = $leftBarZeroCoord[1] + 54
			$fullColor = 0x0071CE
	EndSwitch
	$RightBarZeroCoord = findimagecoords("charStatusRight", "lefttop", False)
	$endX = $RightBarZeroCoord[0] - 4
	$barFull = 0
	$barEmpty = 0
	;Step 10 - check every 10 pixel for speed purpose(more than x3 faster compared Step 1)
	;If need more accuaracy - decrease Step
	For $x = $startX To $endX Step 10
		$pixel = PixelGetColor($x, $y)
		if $pixel = $fullColor Then
			$barFull += 1
		Else
			$barEmpty += 1
		EndIf
	Next
	Return Round((100/($barEmpty+$barFull)) * $barFull)
EndFunc