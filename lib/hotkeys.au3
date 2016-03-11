HotKeySet("{F1}", 'WindowSwitch')
HotKeySet("{F2}", 'WindowSwitch')
HotKeySet("{F3}", 'WindowSwitch')
HotKeySet("{F4}", 'WindowSwitch')
HotKeySet("{F5}", 'WindowSwitch')
HotKeySet("^{F1}", 'WindowBind')
HotKeySet("^{F2}", 'WindowBind')
HotKeySet("^{F3}", 'WindowBind')
HotKeySet("^{F4}", 'WindowBind')
HotKeySet("^{F5}", 'WindowBind')

Func WindowSwitch()
	$nickname = IniRead('config.ini', 'Hotkeys', @HotKeyPressed, '')
	if WinExists($nickname) Then
		WinActivate($nickname)
		WinWaitActive($nickname)
		;need for remove focus from chat window
		MouseClick("right")
	EndIf
EndFunc

Func WindowBind()
	$hotkey = StringReplace(@HotKeyPressed, '^', '')
	IniWrite('config.ini', 'Hotkeys', $hotkey, ' ' & WinGetTitle(''))
EndFunc