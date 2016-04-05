#include-once
#include <AutoItConstants.au3>

Func runInstance()
	logWrite($chars[$i][3] & ' running...')
	$chars[$i][4] = Run("L2Helper.exe " & $chars[$i][1] & " " & $chars[$i][2] & " " & $chars[$i][3], '', @SW_SHOW, BitOR($STDOUT_CHILD, $STDIN_CHILD))
	If $chars[$i][4] = 0 Then
		logWrite("L2Helper.exe not found")
		return False
	EndIf

	While 1
		$data = StdoutRead($chars[$i][4])
		If $data <> '' Then
			logWrite($data)
			ExitLoop
		EndIf
		Sleep(1)
	WEnd
EndFunc
