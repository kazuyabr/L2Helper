@echo off
"C:\Program Files (x86)\AutoIt3\Aut2Exe\Aut2exe.exe" /in L2helper.au3 /out compiled\L2Helper.exe
"C:\Program Files (x86)\AutoIt3\Aut2Exe\Aut2exe.exe" /in Launcher.au3 /out compiled\Launcher.exe /icon res\l2.ico
copy config.ini compiled\config.ini /y
"C:\Program Files\WinRAR\rar.exe" a compiled\L2Helper.rar compiled\*.* -ep -df