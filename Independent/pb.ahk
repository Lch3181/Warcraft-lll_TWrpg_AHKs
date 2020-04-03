;pb
global pb := false

Gui, Font, s15
Gui, Font, cRed
Gui, Add, Text, vActive x0 y0, % "pb: " ((pb) ? ("Enabled") : ("Disabled"))
Gui, +LastFound +AlwaysOnTop -Caption
Gui, Color, EEAA99
WinSet, TransColor, EEAA99
Gui, Show, x0 y60
return

$~a::
if(pb)
{
	loop
	{
		if !GetKeyState("a", "P")
			break
		SendInput, {a}
		Sleep, 50
	}
}
return

$w::
if(pb)
{
	loop
	{
		if !GetKeyState("w", "P")
			break
		SendInput, {q}
		Sleep, 50
		SendInput, {w}
		Sleep, 50
		SendInput, {a}
		Sleep, 50
	}
}
else
{
	SendInput, {w}
}
return

~d::
if(pb)
{
	MouseClick, Left
}
return

~t::
if(pb)
{
	loop, 5
	{
		SendInput, {Numpad1}
		SendInput, {5}
		sleep, 50
	}
}
return

~Enter::
pb := false
GuiControl, Text, Active, % "pb: " ((pb) ? ("Enabled") : ("Disabled"))
return

f5::
pb := !pb
GuiControl, Text, Active, % "pb: " ((pb) ? ("Enabled") : ("Disabled"))
return

