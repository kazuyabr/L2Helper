#include-once
#include <ListViewConstants.au3>

GUICtrlCreateTabItem("Launcher")
$charList = GUICtrlCreateListView('Character Name  ', 5, 25, 140, 220, BitOR($LVS_NOCOLUMNHEADER, $LVS_SINGLESEL), $LVS_EX_CHECKBOXES)
For $i = 1 To $charsCount
	$tmp = StringSplit($charactersRaw[$i][1], ":")
	$chars[$i - 1][1] = $tmp[1]
	$chars[$i - 1][2] = $tmp[2]
	$chars[$i - 1][3] = $tmp[3]
	$chars[$i - 1][0] = GUICtrlCreateListViewItem($chars[$i - 1][3], $charList)
Next
$checkAllButton = GUICtrlCreateButton("Check all", 180, 25, 100, 25)
$uncheckAllButton = GUICtrlCreateButton("Uncheck all", 180, 50, 100, 25)
$runButton = GUICtrlCreateButton("Run", 180, 75, 100, 25)
GUICtrlCreateTabItem("")