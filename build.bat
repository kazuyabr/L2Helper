@echo off
"C:\Program Files (x86)\AutoIt3\Aut2Exe\Aut2exe.exe" /in L2helper.au3 /out program\L2Helper.exe
"C:\Program Files (x86)\AutoIt3\Aut2Exe\Aut2exe.exe" /in Launcher.au3 /out program\Launcher.exe /icon res\l2.ico
xcopy res\img program\res\img\ /Y
copy craft.ini program