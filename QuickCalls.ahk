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
Gui, Add, Text, vGuide x200 y0, F6:On/Off J:Sylvanas, K:Succubus, L:Hellhound, Shift+J:DeathFiend, Shift+K:Valtora, Shift+L:Ifrit
Gui, Add, Text, vCurrentBoss x200 y20, Current Boss: None
Gui, Add, Text, vCurrentMini x200 y40, Current Mini: None
Gui, Add, Text, vQuickCalls x200 y60, Quick Calls: Disabled
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
	CurrentBossGUI("None")
	CurrentMiniGUI("None")
	return
}

CurrentBossGUI(Name)
{
	GuiControl, Text, CurrentBoss, Current Boss: %Name%
	return
}

CurrentMiniGUI(Name)
{
	GuiControl, Text, CurrentMini, Current Mini: %Name%
	return
}

Call(String)
{
	SendInput, {Enter}
	SendInput, {Text}>> %String% <<
	SendInput, {Enter}
	return
}

;Toggle
~Enter::
QuickCalls := False
GuiControl, Text, QuickCalls, % "Quick Calls: " ((QuickCalls) ? ("Enabled") : ("Disabled"))
return

$F6::
QuickCalls := !QuickCalls
GuiControl, Text, QuickCalls, % "Quick Calls: " ((QuickCalls) ? ("Enabled") : ("Disabled"))
return

$+J::
if(QuickCalls)
{
	Reset()
	DeathFiend:= True
	CurrentBossGUI("DF")
	return
}


$+K::
if(QuickCalls)
{
	Reset()
	Valtora:= True
	CurrentBossGUI("valt")
	return
}
$+L::
if(QuickCalls)
{
	Reset()
	Ifrit:= True
	CurrentBossGUI("Ifrit")
	return
}

;----------------------Minis----------------------

~J::
if(QuickCalls)
{
	Reset()
	Sylvanas:= True
	CurrentMiniGUI("sylv")
	return
}

~K::
if(QuickCalls)
{
	Reset()
	Succubus:= True
	CurrentMiniGUI("succ")
	return
}

~L::
if(QuickCalls)
{
	Reset()
	Hellhound:= True
	CurrentMiniGUI("HH")
	return
}

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
		Call("Coil")
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
		Call("Orbs")
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
		Call("33333")
	}
	else if(Hellhound)
	{
		Call("HH NEEDS HELP")
	}
	else if(DeathFiend)
	{
		Call("30% GET READY")
	}
	else if(Valtora)
	{
		
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
		Call("4444444 Arrow")
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
		Call("SLYV READY")
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