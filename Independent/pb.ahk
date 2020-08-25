;pb
global pb := false
global DuringT := false

Gui, Font, s12
Gui, Font, cRed
Gui, Add, Text, vActive x0 y0, % "pb: " ((pb) ? ("Enabled") : ("Disabled"))
Gui, +LastFound +AlwaysOnTop -Caption
Gui, Color, EEAA99
WinSet, TransColor, EEAA99
Gui, Show, x0 y45
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
		if (DuringT)
		{
			SendInput, {w}
			Sleep, 50
			SendInput, {e}
			Sleep, 50
		}
	}
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
		sleep, 50
		SetTimer, T_DurationTimer, -8000
		DuringT := True
	}
}
return

T_DurationTimer:
DuringT := false
return

~Enter::
pb := false
GuiControl, Text, Active, % "pb: " ((pb) ? ("Enabled") : ("Disabled"))
return

f5::
pb := !pb
GuiControl, Text, Active, % "pb: " ((pb) ? ("Enabled") : ("Disabled"))
return

