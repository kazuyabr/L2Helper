#include-once
#include "BmpSearch.au3"
#include <ScreenCapture.au3>
#include <GDIPlus.au3>
#include <WinAPI.au3>

;$name - image name from res/img/ folder
;$position - center, lefttop, leftbottom, righttop, rightbottom
;return array where [0] - x, [1] - y coordinate
Func FindImageCoords($name, $position, $mouseFromScreen)
	If $mouseFromScreen = True Then MouseMove(@DesktopWidth, @DesktopHeight)
	$image = 'res\img\' & $name & '.bmp'

	_GDIPlus_Startup()
	_ScreenCapture_SetBMPFormat(0)
	_ScreenCapture_Capture('tmp.bmp')
	$source = _GDIPlus_BitmapCreateFromFile('tmp.bmp')
	$hSource = _GDIPlus_BitmapCreateHBITMAPFromBitmap($source)
	$find = _GDIPlus_BitmapCreateFromFile($image)
	$hFind = _GDIPlus_BitmapCreateHBITMAPFromBitmap($find)
	$aCoords = _BmpSearch($hSource, $hFind, 1)

	_GDIPlus_BitmapDispose($source)
	_GDIPlus_BitmapDispose($find)
	_WinAPI_DeleteObject($hSource)
	_WinAPI_DeleteObject($hFind)
	_GDIPlus_Shutdown()
	FileDelete("tmp.bmp")

	If @error Then
		Return False
	Else
		Local $coords[2]
		Switch $position
			Case "center"
				$coords[0] = Round($aCoords[1][2] + ($aCoords[1][0] / 2))
				$coords[1] = Round($aCoords[1][3] + ($aCoords[1][1] / 2))
			Case "lefttop"
				$coords[0] = $aCoords[1][2]
				$coords[1] = $aCoords[1][3]
			Case "leftbottom"
				$coords[0] = $aCoords[1][2]
				$coords[1] = $aCoords[1][3] + $aCoords[1][1]
			Case "righttop"
				$coords[0] = $aCoords[1][2] + $aCoords[1][0]
				$coords[1] = $aCoords[1][3]
			Case "rightbottom"
				$coords[0] = $aCoords[1][2] + $aCoords[1][0]
				$coords[1] = $aCoords[1][3] + $aCoords[1][1]
		EndSwitch
		Return $coords
	EndIf
EndFunc   ;==>FindImageCoords
