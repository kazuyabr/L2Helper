#NoTrayIcon
#include <lib/login.au3>
#include <StringConstants.au3>
#include <MsgBoxConstants.au3>

If $cmdLine[0] = 0 Then
	MsgBox($MB_OK, "Ошибка", "Используйте Launcher.exe для запуска")
	Exit
EndIf


If Not Login($cmdLine[1], $cmdLine[2], $cmdLine[3]) Then
	MsgBox($MB_OK, "Ошибка", "Окно L2 было закрыто в процессе загрузки")
	Exit
EndIf
$windowSize = WinGetClientSize($windowHandle)
WinSetTitle($windowHandle, "", $windowName)
ConsoleWrite('LoadEnd')

;Main cycle where we waiting commands from launcher(in future versions)
While (WinGetState($windowHandle) <> 0)
	;Keep window name
	WinSetTitle($windowHandle, "", $windowName)
	Sleep(1)
WEnd
