;Toggles var
global QuickCalls:= False
global Ifrit := False
global Valtora := False
global DeathFiend:= False
global Hellhound:= False
global Sylvanas:= False
global Succubus:= False

;GUI
Gui, +LastFound +AlwaysOnTop -Caption
Gui, Font, s15
Gui, Font, cRed
Gui, Add, Text, vGuide x200 y0, % "F6:On/Off J:Sylv, K:Succ, L:HH, Shift+J:DF, Shift+K:VALT, Shift+L:IFRIT"
Gui, Add, Text, vCurrentBoss x200 y20, % "Current Boss: None"
Gui, Add, Text, vCurrentMini x200 y40, % "Current Mini: None"
Gui, Add, Text, vQuickCalls x200 y60, % "Quick Calls: Disabled"
Gui, Color, EEAA99
WinSet, TransColor, EEAA99
Gui, Show, x0 y0

;Functions
Reset()
{
	Ifrit := False
	Valtora := False
	DeathFiend:= False
	Sylvanas:= False
	Succubus:= False
	Hellhound:= False
	CurrentBossGUI(null, "None")
	CurrentMiniGUI(null, "None")
	return
}

CurrentBossGUI(VName, Name)
{
	GuiControl, Text, CurrentBoss, % "Current Boss: " ((VName) ? (Name) : ("None"))
	return
}

CurrentMiniGUI(VName, Name)
{
	GuiControl, Text, CurrentMini, % "Current Mini: " ((VName) ? (Name) : ("None"))
	return
}

Call(String)
{
	SendInput, {Enter}
	SendInput, >>>-------%String%-------<<<
	SendInput, {Enter}
	return
}

;Toggle

$F6::
QuickCalls := !QuickCalls
GuiControl, Text, QuickCalls, % "Quick Calls: " ((QuickCalls) ? ("Enabled") : ("Disabled"))
return

$+J::
Reset()
DeathFiend:= True
CurrentBossGUI(DeathFiend, "DF")
return

$+K::
Reset()
Valtora:= True
CurrentBossGUI(Valtora, "VALT")
return

$+L::
Reset()
Ifrit:= True
CurrentBossGUI(Ifrit, "IFRIT")
return

;----------------------Minis----------------------

~J::
if(Quickcalls)
{
	Reset()
	Sylvanas:= True
	CurrentMiniGUI(Sylvanas, "SYLV")
}
return

~K::
if(Quickcalls)
{
	Reset()
	Succubus:= True
	CurrentMiniGUI(Succubus, "SUCC")
}
return

~L::
if(Quickcalls)
{
	Reset()
	Hellhound:= True
	CurrentMiniGUI(Hellhound, "HH")
}
return

;-----------------------Calls-----------------------


~S::
if(Quickcalls)
{
	Call("WAIT")
}
return

~D::
if(Quickcalls)
{
	Call("READY")
}
return


$+W::
if(Quickcalls)
{
	if(Valtora)
	{
		Call("TOP LINE")
	}
	else if(Ifrit)
	{
		Call("CHARGING TOP")
	}
}
return

$+A::
if(Quickcalls)
{
	if(Valtora)
	{
		Call("LEFT LINE")
	}
	else if(Ifrit)
	{
		Call("CHARGING LEFT")
	}
}
return

$+S::
if(Quickcalls)
{
	if(Valtora)
	{
		Call("BOTTOM LINE")
	}
	else if(Ifrit)
	{
		Call("CHARGING BOTTOM")
	}
}
return

$+D::
if(Quickcalls)
{
	if(Valtora)
	{
		Call("RIGHT LINE")
	}
	else if(Ifrit)
	{
		Call("CHARGING RIGHT")
	}
}
return

~Z::
if(Quickcalls)
{
	if(Sylvanas)
	{
		Call("11111")
	}
	else if(Succubus)
	{
		Call("TELEPORTING")
	}
	else if(Hellhound)
	{
		Call("CHARGING")
	}
	else if(DeathFiend)
	{
		Call("COIL")
	}
	else if(Valtora)
	{
		Call("MAGNET DIED")
	}
	else if(Ifrit)
	{
		Call("PROCCING ELS")
	}
}
return


~X::
if(Quickcalls)
{
	if(Sylvanas)
	{
		Call("22222")
	}
	else if(Succubus)
	{
		Call("WAVE")
	}
	else if(Hellhound)
	{
		Call("ORBS")
	}
	else if(DeathFiend)
	{
		Call("Howl")
	}
	else if(Valtora)
	{
		Call("LINK DIED")
	}
	else if(Ifrit)
	{
		Call("BOMBS COUNTING DOWN")
	}
}
return


~C::
if(Quickcalls)
{
	if(Sylvanas)
	{
		Call("11111")
	}
	else if(Hellhound)
	{
		Call("HH NEEDS HELP")
	}
	else if(DeathFiend)
	{
		Call("30% GET READY")
	}
	else if(Ifrit)
	{
		Call("CLEANSING BOMB")
	}
}
return

~V::
if(Quickcalls)
{
	if(Sylvanas)
	{
		Call("33333")
	}
	else if(DeathFiend)
	{
		Call("PROCCING 20%")
	}
	else if(Ifrit)
	{
		Call("GOLEM CHARGING")
	}
}
return

~B::
if(Quickcalls)
{
	if(Sylvanas)
	{
		Call("4444444 Arrow")
	}
	else if(Succubus)
	{
		Call("SUCC READY")
	}
	else if(Hellhound)
	{
		Call("HH READY")
	}
	else if(DeathFiend)
	{
		Call("DF READY")
	}
}
return

;Ctrl + Alt
^!s::Suspend
^!r::Reload

;Ctrl + Esc
^esc::ExitApp