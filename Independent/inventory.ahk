;Toggles var
global Inventory := False

;GUI for toggle on off script
Gui, 3: +LastFound +AlwaysOnTop -Caption
Gui, 3: Font, s15
Gui, 3: Font, cRed
Gui, 3: Add, Text, vActiveInventory x0 y0, % "Inventory: " ((Inventory) ? ("Enabled") : ("Disabled"))
Gui, 3: Color, EEAA99
WinSet, TransColor, EEAA99
Gui, 3: Show, x0 y0
f2::
Inventory := !Inventory
GuiControl, 3: Text, ActiveInventory, % "Inventory: " ((Inventory) ? ("Enabled") : ("Disabled"))
return

$1::
if(Inventory)
{
	SendInput {Numpad7}
}
else
	SendInput {1}
return

$2::
if(Inventory)
	SendInput {Numpad8}
else
	SendInput {2}
return

$3::
if(Inventory)
	SendInput {Numpad4}
else
	SendInput {3}
return

$4::
if(Inventory)
	SendInput {Numpad5}
else
	SendInput {4}
return

$5::
if(Inventory)
	SendInput {Numpad1}
else
	SendInput {5}
return

$6::
if(Inventory)
	SendInput {Numpad2}
else
	SendInput {6}
return

!r::reload

^esc::ExitApp

!s::suspend