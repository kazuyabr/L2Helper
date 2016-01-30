#include <GUIConstantsEx.au3>

Global $aiElement[5][5] = [['login1', 'pass1', 'Nickname1', '', ''], _
                        ['login2', 'pass2', 'Nickname2', '', ''], _
                        ['login3', 'pass3', 'Nickname3', '', ''], _
                        ['login4', 'pass4', 'Nickname4', '', ''], _
                        ['login5', 'pass5', 'Nickname5', '', '']]

$hGUI = GUICreate('L2Windows', 150, 185)
$iC = 20
For $i = 0 To 4
    $aiElement[$i][3] = GUICtrlCreateButton($aiElement[$i][2] & ' [Отключен]', 10, $iC, 130)
    $iC += 30
Next
GUISetState()

While 1
    $iMsg = GUIGetMsg()
    Switch $iMsg
        Case $aiElement[0][3] To $aiElement[4][3]
            $iNum = $iMsg - 3
            Login($aiElement[$iNum][0], $aiElement[$iNum][1], $aiElement[$iNum][2], $iNum)
        Case $GUI_EVENT_CLOSE
            ExitLoop
    EndSwitch
   
    For $i = 0 To 4
        If $aiElement[$i][4] Then
            If WinGetState($aiElement[$i][4]) Then
                If WinGetTitle($aiElement[$i][4]) <> $aiElement[$i][2] Then WinSetTitle($aiElement[$i][4], '', $aiElement[$i][2])
            Else
                $aiElement[$i][4] = ''
                GUICtrlSetData($aiElement[$i][3], $aiElement[$i][2] & ' [Отключен]')
                GUICtrlSetState($aiElement[$i][3], $GUI_ENABLE)
            EndIf
        EndIf
    Next
WEnd

GUIDelete($hGUI)


Func Login($login, $pass, $name, $iN)
    Run('C:\Games\Lineage 2\system\l2.exe')
    $hWnd = WinWaitActive('Lineage 2')

    SendKeepActive($hWnd)
    Sleep(2000) ;       |
    Send($login) ;      |
    Send('{TAB}') ;     |
    Send($pass) ;       |
    Sleep(1000) ;       |
    Send('{ENTER}') ;   |
    Sleep(2000) ;       |
    Send('{TAB}') ;     | => Учтите, что здесь скрипт в течении 7,5 секунд не будет откликаться
    Sleep(1000) ;       |
    Send('{ENTER}') ;   |
    Sleep(500) ;        |
    Send('{ENTER}') ;   |
    Sleep(500) ;        |
    Send('{ENTER}') ;   |
    Sleep(500) ;        |
    Send('{ENTER}') ;   |
    SendKeepActive('')

    WinSetTitle($hWnd, '', $name)
    GUICtrlSetData($iN + 3, $name & ' <Работает>')
    GUICtrlSetState($iN + 3, $GUI_DISABLE)
    $aiElement[$iN][4] = $hWnd
EndFunc   ;==>Login

