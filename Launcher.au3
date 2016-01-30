#NoTrayIcon
#include <Constants.au3>
#include <GUIConstantsEx.au3>

$charactersRaw = IniReadSection("config.ini", "Characters")
$y = 10
$charsCount = $charactersRaw[0][0]
$width = $charsCount * 27 + 17
Local $chars[$charsCount][4]

;GUI draw
Local $hGUI = GUICreate("L2Helper", 120, $width)
For $i = 1 to $charsCount
   $tmp = StringSplit($charactersRaw[$i][1], ":")
   $chars[$i - 1][1] = $tmp[1]
   $chars[$i - 1][2] = $tmp[2]
   $chars[$i - 1][3] = $tmp[3]
   $chars[$i - 1][0] = GUICtrlCreateButton($chars[$i - 1][3], 10, $y, 100)
   $y = $y + 27
   Next
GUISetState(@SW_SHOW, $hGUI)

Local $iMsg = 0
While 1
   $iMsg = GUIGetMsg()
   If $iMsg > 0 Then
	  For $i = 0 To $charsCount - 1
		 If $iMsg = $chars[$i][0] Then
			Run("L2Helper.exe " & $chars[$i][1]& " " & $chars[$i][2]& " " & $chars[$i][3])
		 EndIf
	  Next
   ElseIf $iMsg = $GUI_EVENT_CLOSE Then
	  ExitLoop
   EndIf
WEnd

GUIDelete($hGUI)
