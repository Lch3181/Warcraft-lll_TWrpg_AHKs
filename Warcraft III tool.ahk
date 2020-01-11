;Warcraft III Tool
global _ini := "C:\Windows\Temp\Warcraft III Tool Data.ini"
global Inventory := False
global QuickCast := False

;Main Gui
Gui, Color, DCDCDC
Gui, Add, Tab3, x0 y0 w400 h400 +BackgroundTrans, Inventory|Quick Cast|Quick Call|No Mouse|Pantom Blade|Settings 

Gui, Tab, Inventory
Gui, Add, Picture, y+50 Icon1, Inventory.jpg
Gui, Font, s12
Gui, Add, Text,   x10 y30, Enable/Disable
Gui, Add, Button, x+10 w50 h20     gGetKey vInventoryToggle
Gui, Add, Button, x21 y112 w50 h20 gGetKey vInventory1
Gui, Add, Button, x+21 w50 h20     gGetKey vInventory2
Gui, Add, Button, x21 y+50 w50 h20 gGetKey vInventory3
Gui, Add, Button, x+21 w50 h20     gGetKey vInventory4
Gui, Add, Button, x21 y+50 w50 h20 gGetKey vInventory5
Gui, Add, Button, x+21 w50 h20     gGetKey vInventory6

Gui, Tab, Quick Cast
Gui, Add, Picture, y+40 Icon1, Spells.jpg
Gui, Font, s12
Gui, Add, Text,   x10 y30, Enable/Disable
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


gui, show, w400 h400

;Toggles Gui
Gui, 2: +LastFound +AlwaysOnTop -Caption
Gui, 2: Font, s15
Gui, 2: Font, cRed
Gui, 2: Add, Text, vActiveInventory x0 y0 , % "Inventory: " ((Inventory) ? ("Enabled") : ("Disabled"))
Gui, 2: Add, Text, vActiveQuickCast x0 y20, % "Quick Cast: " ((QuickCast) ? ("Enabled") : ("Disabled"))
Gui, 2: Color, EEAA99
WinSet, TransColor, EEAA99
Gui, 2: Show, x0 y0

;read write data
init()
{
	;write
	if !FileExist(_ini)
	{
		;Inventory
		Iniwrite, F2, %_ini%, Keys, InventoryToggle
		Loop, 6
		{
			Iniwrite, %A_Index%, %_ini%, Keys, Inventory%A_Index%
		}
		;Quick Cast
		Iniwrite, F3, %_ini%, Keys, QuickCastToggle
		aQuickCast := ["m","s","h","a","p","d","t","f","q","w","e","r"]
		For index, element in aQuickCast
		{
			Iniwrite, %element%, %_ini%, Keys, QuickCast%A_Index%
		}
	}
	;read
	if FileExist(_ini)
	{
		;Inventory
		Iniread, Output, %_ini%, Keys, InventoryToggle
		GuiControl,, InventoryToggle, %Output%
		HotKey, ~%Output%, InventoryToggle, On
		Loop, 6
		{
			Iniread, Output, %_ini%, Keys, Inventory%A_Index%
			GuiControl,, Inventory%A_Index%, %Output%
			HotKey, ~%Output%, Inventory%A_Index%, On
		}
		;QuickCast
		Iniread, Output, %_ini%, Keys, QuickCastToggle
		GuiControl,, QuickCastToggle, %Output%
		HotKey, ~%Output%, QuickCastToggle, On
		Loop, 12
		{
			Iniread, Output, %_ini%, Keys, QuickCast%A_Index%
			GuiControl,, QuickCast%A_Index%, %Output%
			HotKey, ~%Output%, QuickCast%A_Index%, On
		}
	}
	return
}

init()

return ;End Main

KeyWaitAny(Options:="")
{
	ih := InputHook(Options)
	ih.KeyOpt("{All}", "ES") ; End and Suppress
	ih.Start()
	ErrorLevel := ih.Wait()
	if(ih.EndKey = "Escape")
		return ""
	return ih.EndKey
}

SetHotKeys(Key, Value, Section)
{
	Iniwrite, %Value%, %_ini%, Keys, %Key%
	HotKey, ~%Value%, %Key%
	return
}

GetKey:
	Duplicate := False
	SingleKey = % KeyWaitAny("V")
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
		HotKey, ~%Value%, off
		GuiControl,, %A_GuiControl%, %SingleKey%
		SetHotKeys(A_GuiControl, SingleKey, "Keys")
	}
	else
	{
		Msgbox, %SingleKey% is used
	}
	return

;Inventory
InventoryToggle:
Inventory := !Inventory
GuiControl, 2: Text, ActiveInventory, % "Inventory: " ((Inventory) ? ("Enabled") : ("Disabled"))
return

Inventory1:
if(Inventory)
	SendInput {Numpad7}
return

Inventory2:
if(Inventory)
	SendInput {Numpad8}
return

Inventory3:
if(Inventory)
	SendInput {Numpad4}
return

Inventory4:
if(Inventory)
	SendInput {Numpad5}
return

Inventory5:
if(Inventory)
	SendInput {Numpad1}
return

Inventory6:
if(Inventory)
	SendInput {Numpad2}
return

;Quick Cast
QuickCastToggle:
QuickCast := !QuickCast
GuiControl, 2: Text, ActiveQuickCast, % "QuickCast: " ((QuickCast) ? ("Enabled") : ("Disabled"))
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
return

GuiEscape:
GuiClose:
ExitApp
return