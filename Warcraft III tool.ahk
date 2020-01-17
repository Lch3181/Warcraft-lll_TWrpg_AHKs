;Warcraft III Tool
#Singleinstance Force
global _ini := "Warcraft III Tool Data.ini"
global GUIShow := True
global aQuickCall  := ["DeathFiend", "Sylvanas", "Succubus", "HellHound", "Valtora", "Ifrit", "Nereid"]
global Inventory := False
global QuickCast := False
global QuickCall := False
global NoMouse := False
global KeyWaiting := False

Gui, Color, DCDCDC
;Quick Call Sub Tab
Gui, Add, Tab3, x0 y60 w400 h340 vSubQuickCall Hidden, Death Fiend|Sylvanas|Succubus|Hell Hound|Valtora|Ifrit|Nereid

Gui, Tab, Death Fiend
Gui, Font, s12
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
Gui, Add, Edit, x+10 y123 w320 h18 vDeathFiendText1
Gui, Add, Edit,      y+12 w320 h18 vDeathFiendText2
Gui, Add, Edit,      y+12 w320 h18 vDeathFiendText3
Gui, Add, Edit,      y+12 w320 h18 vDeathFiendText4
Gui, Add, Edit,      y+12 w320 h18 vDeathFiendText5
Gui, Add, Edit,      y+12 w320 h18 vDeathFiendText6
Gui, Add, Button, x340 y+12 w50 h20 gUpdate vDeathFiendUpdate, update

Gui, Tab, Sylvanas
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


Gui, Tab, Succubus
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


Gui, Tab, Hell Hound
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


Gui, Tab, Valtora
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


Gui, Tab, Ifrit
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


Gui, Tab, Nereid
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
Gui, Add, Tab2, x0 y0 w400 h400 gTabSwitched vMainTab, Inventory|Quick Cast|Quick Call|No Mouse|Setting

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
Gui, Add, Picture, y+40 Icon1, Spells.jpg
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
Gui, Add, Picture, w100 h100 y+40 Icon1, Mouse.png
Gui, Font, s12
Gui, Add, Text, x10 y30, Enable/Disable
Gui, Font, s8
Gui, Add, Button, x+10 w50 h20 gGetKey vNoMouseToggle
Gui, Add, Button, x8 y60 w50 h20 gGetKey vNoMouse1
Gui, Add, Button, x+8 w50 h20 gGetKey vNoMouse2

Gui, Tab, Setting
Gui, Font, s12
Gui, Add, Text, x10 y30, Show/Hide
Gui, Font, s8
Gui, Add, Button, x+10 w50 h20 gGetKey vShowHideMain

Gui, Tab

gui, show, w400 h400

;Toggles Gui
Gui, 2: +LastFound +AlwaysOnTop -Caption
Gui, 2: Font, s15
Gui, 2: Font, cRed
Gui, 2: Add, Text, vActiveInventory x0 y0 , % "Inventory:   " ((Inventory) ? ("Enabled") : ("Disabled"))
Gui, 2: Add, Text, vActiveQuickCast x0 y20, % "Quick Cast: " ((QuickCast) ? ("Enabled") : ("Disabled"))
Gui, 2: Add, Text, vActiveQuickCall x0 y40, % "Quick Call: " ((QuickCall) ? ("Enabled") : ("Disabled"))
Gui, 2: Add, Text, vTarget x+5, No Target  
Gui, 2: Add, Text, vActiveNoMouse   x0 y60, % "No Mouse: " ((NoMouse) ? ("Enabled") : ("Disabled"))
Gui, 2: Color, EEAA99
WinSet, TransColor, EEAA99
Gui, 2: Show, x0 y0

init()

return ;End Main

;Functions
;read write data
init()
{
	;write .ini
	if !FileExist(_ini)
	{
		;Inventory
		Iniwrite, F2, %_ini%, Keys, InventoryToggle
		Loop, 6
		{
			Iniwrite, %A_Index%, %_ini%, Keys, Inventory%A_Index%
			Iniwrite, 0, %_ini%, InventoryQuickCast, InventoryQuickCast%A_Index%			
		}
		;Quick Cast
		Iniwrite, F3, %_ini%, Keys, QuickCastToggle
		aQuickCast := ["m","","","a","p","d","t","f","q","w","e","r"]
		For index, element in aQuickCast
		{
			Iniwrite, %element%, %_ini%, Keys, QuickCast%A_Index%
		}
		;Quick Call
		Iniwrite, F4, %_ini%, Keys, QuickCallToggle
		static aBossToggle := ["h", "j", "k", "l", "", "", ""]
		static DeathFiend := [{z:"> > Coil < <"}, {x:"> > Howl < <"}, {c:"> > 30% Get Ready < <"}, {v:"> > 20% Procing < <"}, {b:"> > DF Ready < <"}, {n:"> > GO < <"}]
		static Sylvanas   := [{z:"> > 111 < <"},{x:"> > 222 < <"},{c:"> > 333 < <"},{v:"> > 44444 < <"},{b:"> > Svly Ready < <"},{n:"> > GO < <"}]
		static Succubus   := [{z:"> > Teleport < <"},{x:"> > Wave < <"},{c:""},{v:""},{b:"> > Succ Ready < <"},{n:"> > GO < <"}]
		static HellHound  := [{z:"> > Charging < <"},{x:"> > Orbs < <"},{c:"> > HH Help < <"},{v:""},{b:"> > HH Ready < <"},{n:"> > GO < <"}]
		static Valtora    := [{z:"> > Guard Break < <"},{x:"> > Aids < <"},{c:"> > Magnet Died < <"},{v:"> > Link Died < <"},{b:"> > Hammer < <"},{n:""}]
		static Ifrit      := [{z:"> > ELS < <"},{x:"> > Bombs < <"},{c:"> > Procing/Cleansing Bombs < <"},{v:"> > Charging < <"},{b:""},{n:""}]
		static Nereid     := [{z:""},{x:""},{c:""},{v:""},{b:""},{n:""}]
		For _count, boss in aQuickCall
		{
			IniWrite, % aBossToggle[_count], %_ini%, %boss%, % Boss . "ToggleButton"
			For index, element in %boss%
			{
				For key, value in % element
				{
					Iniwrite, %key%:%value%, %_ini%, %boss%, % boss . index
				}
			}		
		}
		;No Mouse
		Iniwrite, F5, %_ini%, Keys, NoMouseToggle
		aNoMouse := ["space",""]
		For index, element in aNoMouse
		{
			Iniwrite, %element%, %_ini%, Keys, NoMouse%A_Index%
		}
		;Setting
		Iniwrite, F7, %_ini%, Keys, ShowHideMain
	}
	;read .ini
	if FileExist(_ini)
	{
		aObject := [{}]
		;Inventory
		IniReadSetHotKey(_ini, "Keys", "InventoryToggle")
		Loop, 6
		{
			IniReadSetHotKey(_ini, "Keys", "Inventory"A_Index)
			Iniread, Output, %_ini%, InventoryQuickCast, InventoryQuickCast%A_Index%
		}
		;QuickCast
		IniReadSetHotKey(_ini, "Keys", "QuickCastToggle")
		Loop, 12
		{
			IniReadSetHotKey(_ini, "Keys", "QuickCast"A_Index)
		}
		;QuickCall
		IniReadSetHotKey(_ini, "Keys", "QuickCallToggle")
		For _count, boss in aQuickCall
		{
			IniReadSetHotKey(_ini, boss, Boss . "ToggleButton")
			Loop, 6
			{
				Iniread, Output, %_ini%, %boss%, % boss . A_Index
				aObject[A_Index, StrSplit(Output, "`:").1] := StrSplit(Output, "`:").2
			}
			For index, element in aObject
			{
				For key, value in % element
				{
					GuiControl,, % boss . index, %key%
					GuiControl,, % boss . "Text" . index, %value%
				}
			}
		}

		;No Mouse
		IniReadSetHotKey(_ini, "Keys", "NoMouseToggle")
		Loop, 2
		{
			IniReadSetHotKey(_ini, "Keys", "NoMouse"A_Index)
		}
		;Setting
		IniReadSetHotKey(_ini, "Keys", "ShowHideMain")
	}
	return
}

IniReadSetHotKey(IniFile, IniSection, Key)
{
	Iniread, Output, %_ini%, %IniSection%, %Key%
	GuiControl,, %Key%, %Output%
	HotKey, $%Output%, %Key%, On
}

KeyWaitAny(Options:="")
{
	if(!KeyWaiting)
	{
		KeyWaiting := True
		ih := InputHook(Options)
		ih.KeyOpt("{All}", "ES") ; End and Suppress
		ih.Start()
		ErrorLevel := ih.Wait()
		KeyWaiting := False
		if(ih.EndKey = "Escape")
			return ""
		return ih.EndKey		
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
	return % "{" . SubStr(A_ThisHotKey, 2, StrLen(A_ThisHotKey)) . "}"
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
	OriginalHotKey := GetGuiValue(A_GuiControl)
	GuiControl,, %A_GuiControl%, Editing
	SingleKey = % KeyWaitAny("V E C M")
	if(SingleKey = -1)
	{
		GuiControl,, %A_GuiControl%, %OriginalHotKey%
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
		HotKey, $%OriginalHotKey%, off
		GuiControl,, %A_GuiControl%, %SingleKey%
		if (InStr(A_GuiControl, "ToggleButton") >= 1)
			SetHotKeys(A_GuiControl, SingleKey, SubStr(A_GuiControl, 1, StrLen(A_GuiControl) - 12))
		else
			SetHotKeys(A_GuiControl, SingleKey, "Keys")
		
		;For User
		if(SingleKey = "")
			msgbox, % "Unsigned " . A_GuiControl
		else
			msgbox, % SingleKey . " is assgined to " . A_GuiControl
	}
	else
	{
		GuiControl,, %A_GuiControl%, %OriginalHotKey%
		Msgbox, %SingleKey% is used
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
		Iniwrite, % GetGuiValue(Name . A_Index) . "`:" GetGuiValue(Name . "Text" . A_Index), %_ini%, %Name%, % Name . A_Index
	}
	return

;HotKey's Label
;Inventory
InventoryToggle:
Inventory := !Inventory
GuiControl, 2: Text, ActiveInventory, % "Inventory:   " ((Inventory) ? ("Enabled") : ("Disabled"))
return

Inventory1:
if(Inventory)
{
	SendInput {Numpad7}
	if(GetGuiValue("InventoryQuickCast1"))
		MouseClick, Left
}
else
	SendInput, % GetHotKey()
return

Inventory2:
if(Inventory)
{
	SendInput {Numpad8}
	if(GetGuiValue("InventoryQuickCast2"))
		MouseClick, Left
}
else
	SendInput, % GetHotKey()
return

Inventory3:
if(Inventory)
{
	SendInput {Numpad4}
	if(GetGuiValue("InventoryQuickCast3"))
		MouseClick, Left
}
else
	SendInput, % GetHotKey()
return

Inventory4:
if(Inventory)
{
	SendInput {Numpad5}
	if(GetGuiValue("InventoryQuickCast4"))
		MouseClick, Left
}
else
	SendInput, % GetHotKey()
return

Inventory5:
if(Inventory)
{
	SendInput {Numpad1}
	if(GetGuiValue("InventoryQuickCast5"))
		MouseClick, Left
}
else
	SendInput, % GetHotKey()
return

Inventory6:
if(Inventory)
{
	SendInput {Numpad2}
	if(GetGuiValue("InventoryQuickCast6"))
		MouseClick, Left
}
else
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
else
	SendInput, % GetHotKey()
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
if(QuickCast)
{
	SendInput, % GetHotKey()
	MouseClick, Left
}
else
	SendInput, % GetHotKey()
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
else
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
else
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
else
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
else
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
else
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
else
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
else
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
else
	SendInput, % GetHotKey()
return

NoMouse2:
if(NoMouse)
	MouseClick, Right
else
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

;Common
~Enter::
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

^r::
reload
return

^esc::
ExitApp
return
