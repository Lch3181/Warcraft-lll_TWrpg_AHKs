;pb

Gui, Font, s15
Gui, Font, cRed
Gui, Add, Text, vActive x0 y0, % "pb: " ((A_IsSuspended) ? ("Enabled") : ("Disabled"))
Gui, +LastFound +AlwaysOnTop -Caption
Gui, Color, EEAA99
WinSet, TransColor, EEAA99
Gui, Show, x0 y60
return

$~a::
loop
{
	if !GetKeyState("a", "P")
		break
	SendInput, {a}
	Sleep, 50
}   	
return

$d::
loop
{
	if !GetKeyState("d", "P")
		break
    SendInput, {q}
	Sleep, 50
	SendInput, {w}
	Sleep, 50
	SendInput, {a}
	Sleep, 50
}
return

~Enter::
Gosub, f5

f5::
Suspend, permit
GuiControl, Text, Active, % "pb: " ((A_IsSuspended) ? ("Enabled") : ("Disabled"))
Suspend

