#include-once
#include <findimagecoords.au3>

;parameter - hp, mp or cp
Func getHeroStatus($windowHandle, $parameter)
	$leftBarZeroCoord = findimagecoords("charStatusLeft", "lefttop", $windowHandle, False)
	If $leftBarZeroCoord = False Then Return False
	$startX = $leftBarZeroCoord[0] + 16
	Switch $parameter
		Case "cp"
			$y = $leftBarZeroCoord[1] + 25
			$fullColor = 0xC68E31
		Case "hp"
			$y = $leftBarZeroCoord[1] + 39
			$fullColor = 0xD60831
		Case "mp"
			$y = $leftBarZeroCoord[1] + 53
			$fullColor = 0x0071CE
	EndSwitch
	$RightBarZeroCoord = findimagecoords("charStatusRight", "lefttop", $windowHandle, False)
	$endX = $RightBarZeroCoord[0] - 4
	$barFull = 0
	$barEmpty = 0
	;Step 15 - check every 15 pixel for speed purpose(more than x3 faster compared Step 1)
	;If need more accuaracy - decrease Step(in munimum size, bar have 150pixels)
	For $x = $startX To $endX Step 15
		$pixel = PixelGetColor($x, $y)
		if $pixel = $fullColor Then
			$barFull += 1
		Else
			$barEmpty += 1
		EndIf
	Next
	Return Round((100/($barEmpty+$barFull)) * $barFull)
EndFunc