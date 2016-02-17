#include-once
#include "BmpSearch.au3"
#include <ScreenCapture.au3>
#include <GDIPlus.au3>
#include <WinAPI.au3>

Func FindImageCoords($name)
	MouseMove(0, 0)
	$image = 'res\img\' & $name & '.bmp'

	_GDIPlus_Startup()
	_ScreenCapture_SetBMPFormat(0)
	_ScreenCapture_Capture('tmp.bmp')
	$source = _GDIPlus_BitmapCreateFromFile('tmp.bmp')
	$hSource = _GDIPlus_BitmapCreateHBITMAPFromBitmap($source)
	$find = _GDIPlus_BitmapCreateFromFile($image)
	$hFind = _GDIPlus_BitmapCreateHBITMAPFromBitmap($find)
	$aCoords = _BmpSearch($hSource, $hFind, 1)

	$hImage = _GDIPlus_ImageLoadFromFile($image)
	$imageSize = _GDIPlus_ImageGetDimension($hImage)

	_GDIPlus_BitmapDispose($source)
	_GDIPlus_BitmapDispose($find)
	_GDIPlus_ImageDispose($hImage)
	_WinAPI_DeleteObject($hSource)
	_WinAPI_DeleteObject($hFind)
	_GDIPlus_Shutdown()
	FileDelete("tmp.bmp")

	If @error Then
		Return False
	Else
		Local $coords[2]
		$coords[0] = $aCoords[1][2] + ($imageSize[0] / 2)
		$coords[1] = $aCoords[1][3] + ($imageSize[1] / 2)
		Return $coords
	EndIf
EndFunc