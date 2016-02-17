#include-once
;Передать 1 параметром название рецепта а вторым количество требуемого крафта

;x and y coord items and count
Global $resultCount[2]
$sscColor = 0xAB9385
$resultCount[0] = 476;SSC
$bsscColor = 3952249
$resultCount[1] = 200;BSSC

;Передаем что крафтить и в каком количестве
Func Autocraft($item, $count)
   WinActivate("Bronzebeard")
   Send("{F11}")
   Sleep(1000)
   Send("{F12}")
   Sleep(2000)

   Switch $item
   case "SSC"
	  $coord = PixelSearch(0, 0, 1366, 768, 0xAB9385)
	  $x = $coord[0]
	  $y = $coord[1]
	  $i = $count / $resultCount[0]
   case "BSSC"
	  $coord = PixelSearch(0, 0, 1366, 768, 3952249)
	  $x = $coord[0]
	  $y = $coord[1]
	  $i = $count / $resultCount[1]
   EndSwitch

   MouseClick("left", $x, $y, 2)
   Sleep(1000)

   ;Крутить цикл и спать пока нет мп или окно не в фокусе
   While ($i <> 0 and $i > 0)
	  While 1
		 If (PixelGetColor(58, 58) = 1057858) or (WinActive("Bronzebeard") = 0) Then
			sleep(10000)
		 Else
			ExitLoop
		 EndIf
	  WEnd

	  MouseClick("left", 422, 676, 1)
	  Sleep(Random(1000, 2500, 1))
	  $i = $i - 1
   WEnd
EndFunc

Autocraft("SSC", 1000)