;Toggles var
QuickCast := False

;GUI for toggle on off script
Gui, 3: +LastFound +AlwaysOnTop -Caption
Gui, 3: Font, s15
Gui, 3: Font, cRed
Gui, 3: Add, Text, vActiveQuickCast x0 y20, % "Quick Cast: " ((QuickCast) ? ("Enabled") : ("Disabled")), x0 y10
Gui, 3: Color, EEAA99
WinSet, TransColor, EEAA99
Gui, 3: Show, x0 y0

f3::
QuickCast := !QuickCast
GuiControl, 3: Text, ActiveQuickCast, % "QuickCast: " ((QuickCast) ? ("Enabled") : ("Disabled"))
return

~q::
if(QuickCast)
{
	MouseClick, Left
}
return

~w::
if(QuickCast)
{
	MouseClick, Left
}
return

~e::
if(QuickCast)
{
	MouseClick, Left
}
return

~r::
if(QuickCast)
{
	MouseClick, Left
}
return

~t::
if(QuickCast)
{
	MouseClick, Left
}
return

~f::
if(QuickCast)
{
	MouseClick, Left
}
return

$1::
if(QuickCast)
{
	SendInput, {Numpad7}
	MouseClick, Left
}

$2::
if(QuickCast)
{
	SendInput, {Numpad8}
	MouseClick, Left
}

^esc::
exit
