#NoTrayIcon
#include <Constants.au3>
#include <GUIConstantsEx.au3>
#include <Array.au3>

Local $characters = IniReadSection("config.ini", "Characters")
$y = 10
$charsCount = $characters[0][0]
$width = $charsCount * 27 + 17
;+1 because we dont use 0 index in cycle(it stores number of key=value pairs)
Local $buttonsId[$charsCount + 1]
Local $char[$charsCount + 1][4]

;GUI draw
Local $hGUI = GUICreate("L2Helper", 120, $width)
For $i = 1 to $charsCount
   $temp = StringSplit($characters[$i][1], ":")
   $char[$i][1] = $temp[1]
   $char[$i][2] = $temp[2]
   $char[$i][3] = $temp[3]
   $char[$i][0] = GUICtrlCreateButton($char[$i][3], 10, $y, 100)
   $y = $y + 27
Next
GUISetState(@SW_SHOW, $hGUI)

_ArrayDisplay($char)
Do
Until GUIGetMsg() = -3

