;Warcraft III Tool
#InstallKeybdHook
#KeyHistory 20
global _ini := "data.ini"
global Inventory := False

Gui, Color, DCDCDC ;Default BG Color
;Tabs
Gui, Add, Tab3, x0 y0 w400 h400 +BackgroundTrans, Inventory|Quick Cast|Quick Call|Pantom Blade|Settings 

Gui, Tab, Inventory
Gui, Add, Picture, y+50 Icon1, Inventory.jpg
Gui, Font, s12
Gui, Add, Text, x20 y30, Enable/Disable
Gui, Add, Button, x+10 w50 h20 gGetKey vInventoryToggle
Gui, Add, Button, x21 y112 w50 h20 gGetKey vInventory1
Gui, Add, Button, x+21 w50 h20 gGetKey vInventory2
Gui, Add, Button, x21 y+50 w50 h20 gGetKey vInventory3
Gui, Add, Button, x+21 w50 h20 gGetKey vInventory4
Gui, Add, Button, x21 y+50 w50 h20 gGetKey vInventory5
Gui, Add, Button, x+21 w50 h20 gGetKey vInventory6

gui, show, w400 h400 ;Display Gui

Gui, 2: +LastFound +AlwaysOnTop -Caption
Gui, 2: Font, s15
Gui, 2: Font, cRed
Gui, 2: Add, Text, vActiveInventory x0 y0, % "Inventory: " ((Inventory) ? ("Enabled") : ("Disabled"))
Gui, 2: Color, EEAA99
WinSet, TransColor, EEAA99
Gui, 2: Show, x0 y0

;read write data
init()
{
	if !FileExist(_ini)
	{
		Iniwrite, f2, %_ini%, Inventory, InventoryToggle
		Loop, 6
		{
			Iniwrite, %A_Index%, %_ini%, Inventory, Inventory%A_Index%
		}
	}
	if FileExist(_ini)
	{
		Iniread, Output, %_ini%, Inventory, InventoryToggle
		GuiControl,, InventoryToggle, %Output%
		HotKey, $%Output%, InventoryToggle, On
		Loop, 6
		{
			Iniread, Output, %_ini%, Inventory, Inventory%A_Index%
			GuiControl,, Inventory%A_Index%, %Output%
			HotKey, $%Output%, Inventory%A_Index%, On
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
	return ih.EndKey
}

SetInventoryHotKeys(Key, Value)
{
	Iniwrite, %Value%, %_ini%, Inventory, %Key%
	HotKey, $%Value%, %Key%, On
	msgbox, %Value%, %Key%
	return
}

GetKey:
	Duplicate := False
	SingleKey = % KeyWaitAny("V")
	if(ErrorLevel = "Timeout" or SingleKey = "")
		return
	Loop, 6
	{
		Iniread, Output, %_ini%, Inventory, Inventory%A_Index%
		if SingleKey = %Output%
		{
			Duplicate = True
			Break
		}
	}
	if !Duplicate
	{
		GuiControlGet, Value,, %A_GuiControl%
		HotKey, $%Value%, off
		GuiControl,, %A_GuiControl%, %SingleKey%
		SetInventoryHotKeys(A_GuiControl, SingleKey)
	}
	else
	{
		Msgbox, %SingleKey% is used
	}
	return
	
InventoryToggle:
Inventory := !Inventory
GuiControl, 2: Text, ActiveInventory, % "Inventory: " ((Inventory) ? ("Enabled") : ("Disabled"))
return

Inventory1:
if(Inventory)
	SendInput {Numpad7}
else
	Send {1}
return

Inventory2:
if(Inventory)
	SendInput {Numpad8}
else
	Send {2}
return

Inventory3:
if(Inventory)
	SendInput {Numpad4}
else
	Send {3}
return

Inventory4:
if(Inventory)
	SendInput {Numpad5}
else
	Send {4}
return

Inventory5:
if(Inventory)
	SendInput {Numpad1}
else
	Send {5}
return

Inventory6:
if(Inventory)
	SendInput {Numpad2}
else
	Send {6}
return

GuiEscape:
GuiClose:
ExitApp
return