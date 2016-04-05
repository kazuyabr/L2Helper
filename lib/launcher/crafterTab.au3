#include-once
#include <ListViewConstants.au3>
#include <EditConstants.au3>
#include <GuiListView.au3>
#include <Array.au3>
#include <AutoItConstants.au3>


$recipesList = IniReadSectionNames("craft.ini")
Const $traderCapacity = 111760

_ArrayDelete($recipesList, 0)
GUICtrlCreateTabItem("Crafter")
$craftList = GUICtrlCreateListView('Recipe', 5, 25, 70, 195, BitOR($LVS_NOCOLUMNHEADER, $LVS_SINGLESEL, $LVS_SHOWSELALWAYS))
For $recipe In $recipesList
	GUICtrlCreateListViewItem($recipe, $craftList)
Next

GUICtrlCreateLabel("Amount:", 82, 27)
$craftCount = GUICtrlCreateInput('', 113, 25, 80, 20, $ES_NUMBER)

GUICtrlCreateLabel("Stock:", 82, 54)
$stockCount = GUICtrlCreateInput('0', 113, 52, 80, 20, $ES_NUMBER)

$maxForSelectedButton = GUICtrlCreateButton("Max count", 205, 50, 80)
$calculateResButton = GUICtrlCreateButton("Calc resources", 113, 80, 80)
$useRecharcherCheckBox = GUICtrlCreateCheckbox("Use recharger", 205, 25)
$startCraftButton = GUICtrlCreateButton("Craft it!", 205, 80, 80)
$roundCraftCountButton = GUICtrlCreateButton("Round", 113, 110, 80)

$craftCalcList = GUICtrlCreateListView("Item   |Count", 80, 150, 120, 70)

GUICtrlCreateTabItem("")

Func ReadSelectedRecipe()
	Global $selectedRecipe = StringReplace(GUICtrlRead(GUICtrlRead($craftList)), '|', '')

	If $selectedRecipe = '0' Then
		LogWrite("Select recipe")
		Return False
	EndIf

	Return IniReadSection("craft.ini", $selectedRecipe)
EndFunc

Func MaxCountButton()
	$recipe = ReadSelectedRecipe()
	If $recipe = False Then Return False
	$maxCount = Floor((($traderCapacity / $recipe[4][1]) - GUICtrlRead($stockCount)) / $recipe[3][1]) * $recipe[3][1]
	GUICtrlSetData($craftCount, $maxCount)
EndFunc

Func CalcResButton()
	$recipe = ReadSelectedRecipe()
	If $recipe = False Then Return False
	RoundButton()
	$craftIterations = GUICtrlRead($craftCount) / $recipe[3][1]
	_GUICtrlListView_DeleteAllItems($craftCalcList)
	GUICtrlCreateListViewItem($recipe[1][0] & '|' & $craftIterations * $recipe[1][1], $craftCalcList)
	GUICtrlCreateListViewItem($recipe[2][0] & '|' & $craftIterations * $recipe[2][1], $craftCalcList)
EndFunc

Func RoundButton()
	$recipe = ReadSelectedRecipe()
	If $recipe = False Then Return False
	GUICtrlSetData($craftCount, Floor(GUICtrlRead($craftCount) / $recipe[3][1]) * $recipe[3][1])
	Return True
EndFunc

Func CraftItButton()
	$roundResult = RoundButton()
	If GUICtrlRead($craftCount) = 0 Then
		LogWrite("Amount must be > 0")
		return False
	EndIf
	If $roundResult = False Then Return False

	$command = "craft;" & $selectedRecipe & ";" & GUICtrlRead($craftCount) & ";" & _IsChecked($useRecharcherCheckBox)
	$crafterName = IniRead("config.ini", "craft", "CrafterName", "")
	For $i= 0 To $charsCount - 1
		If $chars[$i][3] = $crafterName Then
			SetError(0)
			StdinWrite($chars[$i][4], $command)
			If @error Then LogWrite("Crafter window not running")
			ExitLoop
		EndIf
	Next
EndFunc

Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc