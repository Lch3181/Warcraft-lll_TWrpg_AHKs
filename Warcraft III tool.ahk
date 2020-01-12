;Warcraft III Tool
global _ini := "Warcraft III Tool Data.ini"
global Inventory := False
global QuickCast := False
global NoMouse := False
global KeyWaiting := False
#InstallMouseHook

;Main Gui
Gui, Color, DCDCDC
Gui, Add, Tab3, x0 y0 w400 h400 +BackgroundTrans, Inventory|Quick Cast|Quick Call|No Mouse|Setting

Gui, Tab, Inventory
Gui, Add, Picture, y+50 Icon1, Inventory.jpg
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

Gui, Tab, No Mouse
Gui, Add, Picture, w100 h100 y+40 Icon1, Mouse.png
Gui, Font, s12
Gui, Add, Text, x10 y30, Enable/Disable
Gui, Font, s8
Gui, Add, Button, x+10 w50 h20 gGetKey vNoMouseToggle
Gui, Add, Button, x8 y60 w50 h20 gGetKey vNoMouse1
Gui, Add, Button, x+8 w50 h20 gGetKey vNoMouse2

gui, show, w400 h400

;Toggles Gui
Gui, 2: +LastFound +AlwaysOnTop -Caption
Gui, 2: Font, s15
Gui, 2: Font, cRed
Gui, 2: Add, Text, vActiveInventory x0 y0 , % "Inventory: " ((Inventory) ? ("Enabled") : ("Disabled"))
Gui, 2: Add, Text, vActiveQuickCast x0 y+0, % "Quick Cast: " ((QuickCast) ? ("Enabled") : ("Disabled"))
Gui, 2: Add, Text, vActiveNoMouse   x0 y+0, % "No Mouse: " ((NoMouse) ? ("Enabled") : ("Disabled"))
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
		;No Mouse
		Iniwrite, F4, %_ini%, Keys, NoMouseToggle
		aNoMouse := ["space",""]
		For index, element in aNoMouse
		{
			Iniwrite, %element%, %_ini%, Keys, NoMouse%A_Index%
		}
	}
	;read .ini
	if FileExist(_ini)
	{
		;Inventory
		Iniread, Output, %_ini%, Keys, InventoryToggle
		GuiControl,, InventoryToggle, %Output%
		HotKey, $%Output%, InventoryToggle, On
		Loop, 6
		{
			Iniread, Output, %_ini%, Keys, Inventory%A_Index%
			GuiControl,, Inventory%A_Index%, %Output%
			HotKey, $%Output%, Inventory%A_Index%, On
			Iniread, Output, %_ini%, InventoryQuickCast, InventoryQuickCast%A_Index%
			
		}
		;QuickCast
		Iniread, Output, %_ini%, Keys, QuickCastToggle
		GuiControl,, QuickCastToggle, %Output%
		HotKey, $%Output%, QuickCastToggle, On
		Loop, 12
		{
			Iniread, Output, %_ini%, Keys, QuickCast%A_Index%
			GuiControl,, QuickCast%A_Index%, %Output%
			HotKey, $%Output%, QuickCast%A_Index%, On
		}
		;No Mouse
		Iniread, Output, %_ini%, Keys, NoMouseToggle
		GuiControl,, NoMouseToggle, %Output%
		HotKey, $%Output%, NoMouseToggle, On
		Loop, 2
		{
			Iniread, Output, %_ini%, Keys, NoMouse%A_Index%
			GuiControl,, NoMouse%A_Index%, %Output%
			HotKey, $%Output%, NoMouse%A_Index%, On
		}
	}
	return
}

KeyWaitAny(Options:="")
{
	if(!KeyWaiting)
	{
		KeyWaiting := True
		ih := InputHook(Options)
		ih.KeyOpt("{All}", "ES") ; End and Suppress
		ih.Start()
		ih.OnKeyDown := Func("OnKeyDown")
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

OnKeyDown(ih, vk, sc)
{
	msgbox, %vk% %sc%
}

SetHotKeys(Key, Value, Section)
{
	Iniwrite, %Value%, %_ini%, Keys, %Key%
	HotKey, $%Value%, %Key%, On
	return
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

;Labels
GetKey:
	Duplicate := False
	SingleKey = % KeyWaitAny("B V I E")
	if(SingleKey = -1)
		return
	;check Duplication
	
	Loop, Read, %_ini%
	{
		if A_LoopReadLine contains = 
		{
			StringSplit, Field, A_LoopReadLine, = 
			Iniread, Output, %_ini%, Keys, %Field1%
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
		HotKey, $%Value%, off
		GuiControl,, %A_GuiControl%, %SingleKey%
		SetHotKeys(A_GuiControl, SingleKey, "Keys")
	}
	else
	{
		Msgbox, %SingleKey% is used
	}
	return
	
GetSetCheckBoxValue:
	Iniwrite, % GetGuiValue(A_GuiControl), %_ini%, InventoryQuickCast, %A_GuiControl%
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
	MouseClick, Left
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

;Common

GuiEscape:
GuiClose:
Gui, Hide
return

^r::
reload
return

^esc::
ExitApp
return
