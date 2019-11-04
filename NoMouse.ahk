;NoMouse
NoMouse:=False

Gui, Font, s15
Gui, Font, cRed
Gui, Add, Text, vActive x0 y0, % "No Mouse: " ((NoMouse) ? ("Enabled") : ("Disabled"))
Gui, +LastFound +AlwaysOnTop -Caption
Gui, Color, EEAA99
WinSet, TransColor, EEAA99
Gui, Show, x0 y40
return

$space::
if(NoMouse)
	MouseClick, Right
else
	SendInput, {space}
~Enter::
Gosub, f4

f4::
NoMouse := !NoMouse
GuiControl, Text, Active, % "No Mouse: " ((NoMouse) ? ("Enabled") : ("Disabled"))
return

