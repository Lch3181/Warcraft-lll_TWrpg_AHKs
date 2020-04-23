;Warcraft III Tool
#Singleinstance Force
SetMouseDelay, 0
global _ini := "Warcraft III Tool Data.ini"
global GUIShow := True
global aQuickCall  := ["DeathFiend", "Sylvanas", "Succubus", "HellHound", "Valtora", "Ifrit", "Nereid"]
global Inventory := False
global QuickCast := False
global QuickCall := False
global NoMouse := False
global KeyWaiting := False
global TargetLocation := "0,0"
global aAFKLocations := []

Gui, Color, DCDCDC
;Quick Call Sub Tab
Gui, Add, Tab3, x0 y60 w400 h340 vSubQuickCall Hidden, 1|2|3|4|5|6|7

Gui, Tab, 1
Gui, Font, s12
Gui, Add, Edit, x10 y+10 w100 h20, Death Fiend 
Gui, Add, Text, x10 y+10, Enable/Disable
Gui, Add, CheckBox, x+5 gToggleTarge vDeathFiendToggle
Gui, Font, s8
Gui, Add, Button, x+0 w50 h20 gGetKey vDeathFiendToggleButton
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vDeathFiend1
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vDeathFiend2
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vDeathFiend3
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vDeathFiend4
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vDeathFiend5
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vDeathFiend6
Gui, Add, Edit, x+10 y153 w320 h18 vDeathFiendText1
Gui, Add, Edit,      y+12 w320 h18 vDeathFiendText2
Gui, Add, Edit,      y+12 w320 h18 vDeathFiendText3
Gui, Add, Edit,      y+12 w320 h18 vDeathFiendText4
Gui, Add, Edit,      y+12 w320 h18 vDeathFiendText5
Gui, Add, Edit,      y+12 w320 h18 vDeathFiendText6
Gui, Add, Button, x340 y+12 w50 h20 gUpdate vDeathFiendUpdate, update

Gui, Tab, 2
Gui, Font, s12
Gui, Add, Text, x+10 y+10, Enable/Disable
Gui, Add, CheckBox, x+5 gToggleTarge vSylvanasToggle
Gui, Font, s8
Gui, Add, Button, x+0 w50 h20 gGetKey vSylvanasToggleButton
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vSylvanas1
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vSylvanas2
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vSylvanas3
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vSylvanas4
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vSylvanas5
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vSylvanas6
Gui, Add, Edit, x+10 y123 w320 h18 vSylvanasText1
Gui, Add, Edit,      y+12 w320 h18 vSylvanasText2
Gui, Add, Edit,      y+12 w320 h18 vSylvanasText3
Gui, Add, Edit,      y+12 w320 h18 vSylvanasText4
Gui, Add, Edit,      y+12 w320 h18 vSylvanasText5
Gui, Add, Edit,      y+12 w320 h18 vSylvanasText6
Gui, Add, Button, x340 y+12 w50 h20 h20 gUpdate vSylvanasUpdate, update


Gui, Tab, 3
Gui, Font, s12
Gui, Add, Text, x+10 y+10, Enable/Disable
Gui, Add, CheckBox, x+5 gToggleTarge vSuccubusToggle
Gui, Font, s8
Gui, Add, Button, x+0 w50 h20 gGetKey vSuccubusToggleButton
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vSuccubus1
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vSuccubus2
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vSuccubus3
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vSuccubus4
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vSuccubus5
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vSuccubus6
Gui, Add, Edit, x+10 y123 w320 h18 vSuccubusText1
Gui, Add, Edit,      y+12 w320 h18 vSuccubusText2
Gui, Add, Edit,      y+12 w320 h18 vSuccubusText3
Gui, Add, Edit,      y+12 w320 h18 vSuccubusText4
Gui, Add, Edit,      y+12 w320 h18 vSuccubusText5
Gui, Add, Edit,      y+12 w320 h18 vSuccubusText6
Gui, Add, Button, x340 y+12 w50 h20 h20 gUpdate vSuccubusUpdate, update


Gui, Tab, 4
Gui, Font, s12
Gui, Add, Text, x+10 y+10, Enable/Disable
Gui, Add, CheckBox, x+5 gToggleTarge vHellHoundToggle
Gui, Font, s8
Gui, Add, Button, x+0 w50 h20 gGetKey vHellHoundToggleButton
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vHellHound1
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vHellHound2
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vHellHound3
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vHellHound4
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vHellHound5
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vHellHound6
Gui, Add, Edit, x+10 y123 w320 h18 vHellHoundText1
Gui, Add, Edit,      y+12 w320 h18 vHellHoundText2
Gui, Add, Edit,      y+12 w320 h18 vHellHoundText3
Gui, Add, Edit,      y+12 w320 h18 vHellHoundText4
Gui, Add, Edit,      y+12 w320 h18 vHellHoundText5
Gui, Add, Edit,      y+12 w320 h18 vHellHoundText6
Gui, Add, Button, x340 y+12 w50 h20 h20 gUpdate vHellHoundUpdate, update


Gui, Tab, 5
Gui, Font, s12
Gui, Add, Text, x+10 y+10, Enable/Disable
Gui, Add, CheckBox, x+5 gToggleTarge vValtoraToggle
Gui, Font, s8
Gui, Add, Button, x+0 w50 h20 gGetKey vValtoraToggleButton
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vValtora1
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vValtora2
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vValtora3
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vValtora4
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vValtora5
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vValtora6
Gui, Add, Edit, x+10 y123 w320 h18 vValtoraText1
Gui, Add, Edit,      y+12 w320 h18 vValtoraText2
Gui, Add, Edit,      y+12 w320 h18 vValtoraText3
Gui, Add, Edit,      y+12 w320 h18 vValtoraText4
Gui, Add, Edit,      y+12 w320 h18 vValtoraText5
Gui, Add, Edit,      y+12 w320 h18 vValtoraText6
Gui, Add, Button, x340 y+12 w50 h20 h20 gUpdate vValtoraUpdate, update


Gui, Tab, 6
Gui, Font, s12
Gui, Add, Text, x+10 y+10, Enable/Disable
Gui, Add, CheckBox, x+5 gToggleTarge vIfritToggle
Gui, Font, s8
Gui, Add, Button, x+0 w50 h20 gGetKey vIfritToggleButton
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vIfrit1
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vIfrit2
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vIfrit3
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vIfrit4
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vIfrit5
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vIfrit6
Gui, Add, Edit, x+10 y123 w320 h18 vIfritText1
Gui, Add, Edit,      y+12 w320 h18 vIfritText2
Gui, Add, Edit,      y+12 w320 h18 vIfritText3
Gui, Add, Edit,      y+12 w320 h18 vIfritText4
Gui, Add, Edit,      y+12 w320 h18 vIfritText5
Gui, Add, Edit,      y+12 w320 h18 vIfritText6
Gui, Add, Button, x340 y+12 w50 h20 h20 gUpdate vIfritUpdate, update


Gui, Tab, 7
Gui, Font, s12
Gui, Add, Text, x+10 y+10, Enable/Disable
Gui, Add, CheckBox, x+5 gToggleTarge vNereidToggle
Gui, Font, s8
Gui, Add, Button, x+0 w50 h20 gGetKey vNereidToggleButton
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vNereid1
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vNereid2
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vNereid3
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vNereid4
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vNereid5
Gui, Add, Button, x10 y+10 w50 h20 gGetKey vNereid6
Gui, Add, Edit, x+10 y123 w320 h18 vNereidText1
Gui, Add, Edit,      y+12 w320 h18 vNereidText2
Gui, Add, Edit,      y+12 w320 h18 vNereidText3
Gui, Add, Edit,      y+12 w320 h18 vNereidText4
Gui, Add, Edit,      y+12 w320 h18 vNereidText5
Gui, Add, Edit,      y+12 w320 h18 vNereidText6
Gui, Add, Button, x340 y+12 w50 h20 h20 gUpdate vNereidUpdate, update

Gui, Tab

;Main Tab
Gui, Font, s8
Gui, Add, Tab2, x0 y0 w400 h400 gTabSwitched vMainTab, Inventory|Quick Cast|Quick Call|No Mouse|AFK Farm|Setting

Gui, Tab, Inventory
Gui, Add, Picture, y+50 Icon1, Images\Inventory.jpg
Gui, Font, s12
Gui, Add, Text,   x10 y30, Enable/Disable
Gui, Add, Text,   x10 y50, CheckBox for Quick Cast
Gui, Font, s8
Gui, Add, Button, x120 y30 w50 h20      gGetKey vInventoryToggle
Gui, Add, Button, x21 y112 w50 h20 gGetKey vInventory1
Gui, Add, Button, x+21 w50 h20     gGetKey vInventory2
Gui, Add, Button, x21 y+50 w50 h20 gGetKey vInventory3
Gui, Add, Button, x+21 w50 h20     gGetKey vInventory4
Gui, Add, Button, x21 y+50 w50 h20 gGetKey vInventory5
Gui, Add, Button, x+21 w50 h20     gGetKey vInventory6
Gui, Add, CheckBox, x39 y95 w13 h13  gGetSetCheckBoxValue vInventoryQuickCast1
Gui, Add, CheckBox, x+58 w13 h13     gGetSetCheckBoxValue vInventoryQuickCast2
Gui, Add, CheckBox, x39 y+56 w13 h13 gGetSetCheckBoxValue vInventoryQuickCast3
Gui, Add, CheckBox, x+58 w13 h13     gGetSetCheckBoxValue vInventoryQuickCast4
Gui, Add, CheckBox, x39 y+56 w13 h13 gGetSetCheckBoxValue vInventoryQuickCast5
Gui, Add, CheckBox, x+58 w13 h13     gGetSetCheckBoxValue vInventoryQuickCast6

Gui, Tab, Quick Cast
Gui, Add, Picture, y+40 Icon1, Images\Spells.jpg
Gui, Font, s12
Gui, Add, Text,   x10 y30, Enable/Disable
Gui, Font, s8
Gui, Add, Button, x+10 w50 h20     gGetKey vQuickCastToggle
Gui, Add, Button, x27 y118 w61 h20 gGetKey vQuickCast1
Gui, Add, Button, x+17 w61 h20 	   gGetKey vQuickCast2
Gui, Add, Button, x+17 w61 h20 	   gGetKey vQuickCast3
Gui, Add, Button, x+17 w61 h20 	   gGetKey vQuickCast4
Gui, Add, Button, x27 y+57 w61 h20 gGetKey vQuickCast5
Gui, Add, Button, x+17 w61 h20     gGetKey vQuickCast6
Gui, Add, Button, x+17 w61 h20     gGetKey vQuickCast7
Gui, Add, Button, x+17 w61 h20     gGetKey vQuickCast8
Gui, Add, Button, x27 y+57 w61 h20 gGetKey vQuickCast9
Gui, Add, Button, x+17 w61 h20     gGetKey vQuickCast10
Gui, Add, Button, x+17 w61 h20     gGetKey vQuickCast11
Gui, Add, Button, x+17 w61 h20     gGetKey vQuickCast12

Gui, Tab, Quick Call
Gui, Font, s12
Gui, Add, Text, x10 y30, Enable/Disable
Gui, Font, s8
Gui, Add, Button, x+10 w50 h20 gGetKey vQuickCallToggle

Gui, Tab, No Mouse
Gui, Add, Picture, w100 h100 y+40 Icon1, Images\Mouse.png
Gui, Font, s12
Gui, Add, Text, x10 y30, Enable/Disable
Gui, Font, s8
Gui, Add, Button, x+10 w50 h20 gGetKey vNoMouseToggle
Gui, Add, Button, x8 y60 w50 h20 gGetKey vNoMouse1
Gui, Add, Button, x+8 w50 h20 gGetKey vNoMouse2

Gui, Tab, AFK Farm
Gui, Font, s8
Gui, Add, Text, x10 y+10, Enable/Disable
Gui, Add, Checkbox, x+5 vAFKFarmToggle
Gui, Add, Text, x10 y+10, Setup farming rotation by using Shift + A
Gui, Add, Text, x10 y+10, Add Location
Gui, Add, Button, x+10 w50 h20 gGetKey vAddAFKLocation
Gui, Add, Text, x10 y+10, Start adding 500 loops (Escape to interupt)
Gui, Add, Button, x+10 w50 h20 gGetKey vAFKLoop
Gui, Add, Text, x10 y+10, Clear Locations
Gui, Add, Button, x+10 w50 h20 gClearLocations, clear
Gui, Add, Text, x10 y+10 vLocationsLabel, Locations (00)
Gui, Add, Edit, x10 y+10 r14 w135 ReadOnly vAFKLocations


Gui, Tab, Setting
Gui, Font, s12
Gui, Add, Text, x10 y30, Show/Hide
Gui, Add, Text,     y+0, Suspend
Gui, Add, Text,     y+0, Reload
Gui, Add, Text,     y+0, Exit
Gui, Add, Text,     y+0, Lazy LM Ult
Gui, Font, s8
Gui, Add, Button, x100 y30 w50 h20 gGetKey vShowHideMain
Gui, Add, Button,      y+0 w50 h20 disabled, Alt+S
Gui, Add, Button,      y+0 w50 h20 disabled, Alt+R
Gui, Add, Button,      y+0 w50 h20 disabled, Alt+ESC
Gui, Add, Checkbox,    y+5 vLazyLMToggle

Gui, Tab

gui, show, w400 h400

;Toggles Gui
Gui, 2: +LastFound +AlwaysOnTop -Caption
Gui, 2: Font, s10
Gui, 2: Font, cRed
Gui, 2: Add, Text, vActiveInventory x0 y0 , % "Inventory: " ((Inventory) ? ("Enabled") : ("Disabled"))
Gui, 2: Add, Text, vActiveQuickCast x0 y+0, % "Quick Cast: " ((QuickCast) ? ("Enabled") : ("Disabled"))
Gui, 2: Add, Text, vActiveQuickCall x0 y+0, % "Quick Call: " ((QuickCall) ? ("Enabled") : ("Disabled"))
Gui, 2: Add, Text, vTarget x+5, No Target
Gui, 2: Add, Text, vActiveNoMouse   x0 y+0, % "No Mouse: " ((NoMouse) ? ("Enabled") : ("Disabled"))
Gui, 2: Color, EEAA99
WinSet, TransColor, EEAA99
Gui, 2: Show, x0 y0

init()

return ;End Main

;Functions
init()
{
	;Inventory
	IniGetSetHotKey(_ini, "Keys", "InventoryToggle", "F2")
	Loop, 6
	{
		IniGetSetHotKey(_ini, "Keys", "Inventory"A_Index, "$~"A_Index)
		IniGetSetHotKey(_ini, "InventoryQuickCast", "InventoryQuickCast"A_Index, 0, False)
	}
	;Quick Cast
	IniGetSetHotKey(_ini, "Keys", "QuickCastToggle", "F3")
	static aQuickCast := ["m","","","a","p","d","t","f","q","w","e","r"]
	For index, element in aQuickCast
	{
		IniGetSetHotKey(_ini, "Keys", "QuickCast"A_Index, "$~"element)
	}
	;Quick Call
	IniGetSetHotKey(_ini, "Keys", "QuickCallToggle", "F4")
	static aBossToggle= ["h", "j", "k", "l", "", "", ""]
	static aBossText  = ["z", "x", "c", "v", "b", "n"]
	static DeathFiend = ["> > Coil < <", "> > Howl < <", "> > 30% Get Ready < <", "> > 20% Procig < <", "> > DF Ready < <", "> > GO < <"]
	static Sylvanas   = ["> > 111 < <","> > 222 < <","> > 333 < <","> > 44444 < <","> > Sylv Ready < <","> > GO < <"]
	static Succubus   = ["> > Teleport < <","> > Wave < <","","","> > Succ Ready < <","> > GO < <"]
	static HellHound  = ["> > Charging < <","> > Orbs < <","> > HH Help < <","","> > HH Ready < <","> > GO < <"]
	static Valtora    = ["> > Guard Break < <","> > Aids < <","> > Manget Died < <","> > Link Died < <","> > Hammer < <",""]
	static Ifrit      = ["> > ELS < <","> > Bombs < <","> > Procig/Cleansig Bombs < <","> > Charging < <","",""]
	static Nereid     = ["","","","","",""]
	For _count, boss in aQuickCall
	{
		IniGetSetHotKey(_ini, "keys", boss . "ToggleButton", "$~" . aBossToggle[_count])
		For index, element in %boss%
		{
			IniGetSetHotKey(_ini, boss, boss . index, "$~" . abossText[index]) ;Boss Key
			IniGetSetHotKey(_ini, boss, boss . "Text" . index, element, False) ;Boss Text
		}
	}
	;No Mouse
	IniGetSetHotKey(_ini, "Keys", "NoMouseToggle", "F5")
	IniGetSetHotKey(_ini, "Keys", "NoMouse1", "")
	IniGetSetHotKey(_ini, "Keys", "NoMouse2", "$space")
	;AFK Farm
	IniGetSetHotKey(_ini, "Keys", "AddAFKLocation", "$~u")
	IniGetSetHotKey(_ini, "Keys", "AFKLoop", "$~i")
	;Setting
	IniGetSetHotKey(_ini, "Keys", "ShowHideMain", "F7")
}

IniGetSetHotKey(iniFileName, iniSection, iniKey, _HotKey, isHotKey := True)
{
	Iniread, Output, %iniFileName%, %iniSection%, %iniKey%
	if(Output != "ERROR")
	{
		GuiControl,, %iniKey%, % RegExReplace(Output, "[\$~]", "")
		if(isHotKey && RegExReplace(Output, "[\$~]", "") != "")
			Hotkey, %Output%, %iniKey%, On
	}
	else
	{
		Iniwrite, %_HotKey%, %iniFileName%, %iniSection%, %iniKey%
		IniGetSetHotKey(iniFileName, iniSection, iniKey, _HotKey, isHotKey)
	}
}

IniSetHotKey(iniFileName, iniSection, iniKey, _HotKey)
{
	Iniwrite, %_HotKey%, %iniFileName%, %iniSection%, %iniKey%
	IniGetSetHotKey(iniFileName, iniSection, iniKey, _HotKey)
}

KeyWaitAny(Options:="")
{
	if(!KeyWaiting)
	{
		KeyWaiting := True
		ih := InputHook(Options)
		ih.KeyOpt("{All}", "ES") ; End and Suppress
		ih.KeyOpt("{LCtrl}{RCtrl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}", "-ES") ; Exclude the modifiers
		ih.Start()
		ErrorLevel := ih.Wait() ; Store EndReason in ErrorLevel
		KeyWaiting := False
		switch ih.EndKey
		{
		case "Escape":
			return ""
		case "space":
			return "$space"
		default:
			return "$~" . ih.EndMods . ih.EndKey
		}
	}
	else
	{
		return -1
	}
}

SetHotKeys(Key, Value, Section)
{
	Iniwrite, %Value%, %_ini%, %Section%, %Key%
	HotKey, $%Value%, %Key%, On
}

GetSetQuickCallHotKey(Name)
{
	Loop, 6
	{
		HotKey, % "$" . GetGuiValue(Name . A_Index), % Name . A_Index
	}
}
	
GetGuiValue(GuiID)
{
	GuiControlGet, Value,, %GuiID%
	return %Value%
}

GetHotKey()
{
	return % "{" . RegExReplace(A_ThisHotkey, "[\$~]", "") . "}"
}

GetQuickCallText()
{
	return % SubStr(A_ThisLabel, 1, StrLen(A_ThisLabel) - 1) . "Text" . SubStr(A_ThisLabel, -0)
}

Call(String)
{
	SendInput, {Enter}
	SendInput, {Text}%String%
	SendInput, {Enter}
}

ResetTargetToggles(Exclude:="")
{
	For index, boss in aQuickCall
	{
		if(boss . "Toggle" = Exclude)
			continue
		GuiControl,, % boss . "Toggle", 0
	}
}

ShowAFKLocations(array)
{
	_string := ""
	for index, element in aAFKLocations
	{
		_string := % _string . element . "`n"
	}
	return % _string
}

LazyLMUlt(CurrentLocation)
{
	_pos1 := StrSplit(CurrentLocation, ",")
	_pos2 := StrSplit(TargetLocation, ",")
	; Move away from target for max Ult range
	SendInput, {e}
	sleep, 50
	MouseClick, Right, % _pos1[1], % _pos1[2], 3
	Sleep, 300
	; Toggle E again to interupt spell
	SendInput, {e}
	; Use Ult on Target
	MouseMove, % _pos2[1], % _pos2[2]
	SendInput, {f}
	MouseClick, Left
}

;Labels
TabSwitched:
	Gui, Submit, Nohide
	if(MainTab = "Quick Call")
	{
		GuiControl, Show, SubQuickCall
	}
	else
	{
		GuiControl, Hide, SubQuickCall
	}
	Gui, +LastFound
	Winset, Redraw
	return

GetKey:
	Duplicate := False
	;Set GuiValue for temporary
	Iniread, output, %_ini%, Keys, %A_GuiControl%
	if (output = "ERROR")
		output := ""
	OriginalHotKey := % output
	GuiControl,, %A_GuiControl%, Editing
	SingleKey = % KeyWaitAny("V E C M")
	if(SingleKey = -1)
	{
		GuiControl,, %A_GuiControl%, % RegExReplace(OriginalHotKey, "[\$~+]", "")
		return
	}
	;check Duplication
	Loop, Read, %_ini%
	{
		if A_LoopReadLine contains = 
		{
			StringSplit, Field, A_LoopReadLine, = 
			Iniread, Output, %_ini%, Keys, %Field1%
			if (InStr(A_LoopReadLine, "[DeathFiend]") >= 1) ;Only check upto before QuickCall
			{
				Break
			}
			if (SingleKey = Output) && (Output != "") || (Duplicate)
			{
				Duplicate = True
				Break
			}
		}
	}
	if !Duplicate
	{
		GuiControlGet, Value,, % A_GuiControl
		if(OriginalHotKey != "")
			HotKey, %OriginalHotKey%, off
		GuiControl,, %A_GuiControl%, %SingleKey%
		IniSetHotKey(_ini, "Keys", A_GuiControl, SingleKey)
		;For User
		if(SingleKey = "")
		{
			ToolTip, % "Unsigned " . A_GuiControl
			SetTimer, RemoveToolTip, -5000
		}
		else
		{
			ToolTip, % RegExReplace(SingleKey, "[\$~+]", "") . " is assgined to " . A_GuiControl
			SetTimer, RemoveToolTip, -5000
		}
	}
	else
	{
		GuiControl,, %A_GuiControl%, % RegExReplace(OriginalHotKey, "[\$~+]", "")
		ToolTip, % RegExReplace(SingleKey, "[\$~+]", "") . " is used"
		SetTimer, RemoveToolTip, -5000
	}
	return
	
GetSetCheckBoxValue:
	Iniwrite, % GetGuiValue(A_GuiControl), %_ini%, InventoryQuickCast, %A_GuiControl%
	return

ToggleTarge:
	if (GetGuiValue(A_GuiControl))
	{
		ResetTargetToggles(A_GuiControl)
		GuiControl, 2: Text, Target, % SubStr(A_GuiControl, 1, StrLen(A_GuiControl) - 6)
		GetSetQuickCallHotKey(SubStr(A_GuiControl, 1, StrLen(A_GuiControl) - 6))
	}
	else
		GuiControl, 2: Text, Target, % "No Target"
	return

Update:
	Loop, 6
	{
		Name := % SubStr(A_GuiControl, 1, StrLen(A_GuiControl) - 6)
		Iniwrite, % GetGuiValue(Name . "Text" . A_Index), %_ini%, %Name%, % Name . "Text" . A_Index
	}
	return

ClearLocations:
aAFKLocations := []
GuiControl,, LocationsLabel, Locations (00)
GuiControl,, AFKLocations, % ShowAFKLocations(aAFKLocations)
return

RemoveToolTip:
ToolTip
return

;HotKey's Label
;Inventory
InventoryToggle:
Inventory := !Inventory
GuiControl, 2: Text, ActiveInventory, % "Inventory: " ((Inventory) ? ("Enabled") : ("Disabled"))
return

Inventory1:
if(Inventory)
{
	SendInput {Numpad7}
	if(GetGuiValue("InventoryQuickCast1"))
		MouseClick, Left
}
else if(GetHotKey() = "{space}")
	SendInput, % GetHotKey()
return

Inventory2:
if(Inventory)
{
	SendInput {Numpad8}
	if(GetGuiValue("InventoryQuickCast2"))
		MouseClick, Left
}
else if(GetHotKey() = "{space}")
	SendInput, % GetHotKey()
return

Inventory3:
if(Inventory)
{
	SendInput {Numpad4}
	if(GetGuiValue("InventoryQuickCast3"))
		MouseClick, Left
}
else if(GetHotKey() = "{space}")
	SendInput, % GetHotKey()
return

Inventory4:
if(Inventory)
{
	SendInput {Numpad5}
	if(GetGuiValue("InventoryQuickCast4"))
		MouseClick, Left
}
else if(GetHotKey() = "{space}")
	SendInput, % GetHotKey()
return

Inventory5:
if(Inventory)
{
	SendInput {Numpad1}
	if(GetGuiValue("InventoryQuickCast5"))
		MouseClick, Left
}
else if(GetHotKey() = "{space}")
	SendInput, % GetHotKey()
return

Inventory6:
if(Inventory)
{
	SendInput {Numpad2}
	if(GetGuiValue("InventoryQuickCast6"))
		MouseClick, Left
}
else if(GetHotKey() = "{space}")
	SendInput, % GetHotKey()
return

InventoryQuickCast1:
InventoryQuickCast2:
InventoryQuickCast3:
InventoryQuickCast4:
InventoryQuickCast5:
InventoryQuickCast6:
if(Inventory)
	MouseClick, Left
return

;Quick Cast
QuickCastToggle:
QuickCast := !QuickCast
GuiControl, 2: Text, ActiveQuickCast, % "Quick Cast: " ((QuickCast) ? ("Enabled") : ("Disabled"))
return

QuickCast1:
QuickCast2:
QuickCast3:
QuickCast4:
QuickCast5:
QuickCast6:
QuickCast7:
QuickCast8:
QuickCast9:
QuickCast10:
QuickCast11:
QuickCast12:
if (RegExReplace(A_ThisHotkey, "[\$~]", "") = "f" && GetGuiValue("LazyLMToggle") && QuickCast) ;Lazy LM Ult
	{
		MouseGetPos, xpos, ypos
		LazyLMUlt(xpos . "," . ypos)
	}
else if(QuickCast)
	{
		SendInput, % GetHotKey()
		MouseClick, Left
	}
else if (GetHotKey() = "{space}")
	{
		SendInput, % GetHotKey()
	}
if (RegExReplace(A_ThisHotkey, "[\$~]", "") = "r") ;Get Target location for Lazy LM Ult
	{
		MouseGetPos, xpos, ypos
		TargetLocation := % xpos . "," . ypos
	}
return

;Quick Call
QuickCallToggle:
QuickCall := !QuickCall
GuiControl, 2: Text, ActiveQuickCall, % "Quick Call: " ((QuickCall) ? ("Enabled") : ("Disabled"))
return 

DeathFiendToggleButton:
SylvanasToggleButton:
SuccubusToggleButton:
HellHoundToggleButton:
ValtoraToggleButton:
IfritToggleButton:
NereidToggleButton:
GuiControl,, % SubStr(A_ThisLabel, 1, StrLen(A_Thislabel) - 6), % !GetGuiValue(SubStr(A_ThisLabel, 1, StrLen(A_Thislabel) - 6))
if(GetHotKey() = "{space}")
	SendInput, % GetHotKey()
if (GetGuiValue(SubStr(A_ThisLabel, 1, StrLen(A_Thislabel) - 6)))
{
	ResetTargetToggles(SubStr(A_ThisLabel, 1, StrLen(A_Thislabel) - 6))
	GuiControl, 2: Text, Target, % SubStr(A_ThisLabel, 1, StrLen(A_Thislabel) - 12)
	GetSetQuickCallHotKey(SubStr(A_ThisLabel, 1, StrLen(A_Thislabel) - 12))
}
else
	GuiControl, 2: Text, Target, % "No Target"
return

DeathFiend1:
DeathFiend2:
DeathFiend3:
DeathFiend4:
DeathFiend5:
DeathFiend6:
if(GetGuiValue("DeathFiendToggle")) && (QuickCall)
{
	Call(GetGuiValue(GetQuickCallText()))
}
SendInput, % GetHotKey()
return

Sylvanas1:
Sylvanas2:
Sylvanas3:
Sylvanas4:
Sylvanas5:
Sylvanas6:
if(GetGuiValue("SylvanasToggle")) && (QuickCall)
{
	Call(GetGuiValue(GetQuickCallText()))
}
SendInput, % GetHotKey()
return

Succubus1:
Succubus2:
Succubus3:
Succubus4:
Succubus5:
Succubus6:
if(GetGuiValue("SuccubusToggle")) && (QuickCall)
{
	Call(GetGuiValue(GetQuickCallText()))
}
SendInput, % GetHotKey()
return

HellHound1:
HellHound2:
HellHound3:
HellHound4:
HellHound5:
HellHound6:
if(GetGuiValue("HellHoundToggle")) && (QuickCall)
{
	Call(GetGuiValue(GetQuickCallText()))
}
SendInput, % GetHotKey()
return

Valtora1:
Valtora2:
Valtora3:
Valtora4:
Valtora5:
Valtora6:
if(GetGuiValue("ValtoraToggle")) && (QuickCall)
{
	Call(GetGuiValue(GetQuickCallText()))
}
SendInput, % GetHotKey()
return

Ifrit1:
Ifrit2:
Ifrit3:
Ifrit4:
Ifrit5:
Ifrit6:
if(GetGuiValue("IfritToggle")) && (QuickCall)
{
	Call(GetGuiValue(GetQuickCallText()))
}
SendInput, % GetHotKey()
return

Nereid1:
Nereid2:
Nereid3:
Nereid4:
Nereid5:
Nereid6:
if(GetGuiValue("NereidToggle")) && (QuickCall)
{
	Call(GetGuiValue(GetQuickCallText()))
}
SendInput, % GetHotKey()
return

;No Mouse
NoMouseToggle:
NoMouse := !NoMouse
GuiControl, 2: Text, ActiveNoMouse, % "No Mouse: " ((NoMouse) ? ("Enabled") : ("Disabled"))
return

NoMouse1:
if(NoMouse)
	MouseClick, Left
else if(GetHotKey() = "{space}")
	SendInput, % GetHotKey()
return

NoMouse2:
if(NoMouse)
	MouseClick, Right
else if(GetHotKey() = "{space}")
	SendInput, % GetHotKey()
return

;Setting
ShowHideMain:
GUIShow := !GUIShow
if (GUIShow)
	Gui, Show, w400 h400
else
	Gui, Hide
return

;AFK Farm
AddAFKLocation:
if(GetGuiValue("AFKFarmToggle"))
{
	MouseGetPos, xpos, ypos
	aAFKLocations.Push(xpos . "," . ypos)
	GuiControl,, LocationsLabel, % "Locations (" . aAFKLocations.MaxIndex() . ")"
	GuiControl,, AFKLocations, % ShowAFKLocations(aAFKLocations)
}
else if(GetHotKey() = "{space}")
	SendInput, % GetHotKey()
return

AFKLoop:
if(GetGuiValue("AFKFarmToggle"))
{
	SendInput, {Shift down}{a}
	Loop, 500
	{
		if GetKeyState("Escape", "P")
			break
		for index, element in aAFKLocations
		{
			_pos := StrSplit(element, ",")
			MouseMove, % _pos[1], % _pos[2], 0
			Sleep, 1
			MouseClick, Left
			Sleep, 1
		}
	}
	SendInput, {Shift up}
	GuiControl,, AFKFarmToggle, 0
}
else if(GetHotKey() = "{space}")
	SendInput, % GetHotKey()
return


;Common
$~Enter::
Inventory := False
QuickCast := False
QuickCall := False
NoMouse   := False
GuiControl, 2: Text, ActiveNoMouse  , % "No Mouse: " ((NoMouse) ? ("Enabled") : ("Disabled"))
GuiControl, 2: Text, ActiveQuickCast, % "Quick Cast: " ((QuickCast) ? ("Enabled") : ("Disabled"))
GuiControl, 2: Text, ActiveQuickCall, % "Quick Call: " ((QuickCall) ? ("Enabled") : ("Disabled"))
GuiControl, 2: Text, ActiveInventory, % "Inventory: " ((Inventory) ? ("Enabled") : ("Disabled"))
return

GuiEscape:
GuiClose:
GUIShow := False
Gui, Hide
return

!r::
reload
return

!s::
suspend
return

!esc::
ExitApp
return
