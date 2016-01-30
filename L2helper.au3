#NoTrayIcon
#include <lib/login.au3>
#include <StringConstants.au3>

If $cmdLine[0] = 0 Then
   Exit
EndIf


Login($cmdLine[1], $cmdLine[2], $cmdLine[3])
$windowSize = WinGetClientSize($windowHandle)

;Main cycle where we waiting commands from launcher(in future versions)
While (WinGetState($windowHandle) <> 0)
   ;Keep window name
   WinSetTitle ($windowHandle, "", $windowName)
   Sleep(1)
WEnd