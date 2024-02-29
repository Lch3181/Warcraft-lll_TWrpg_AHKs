#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
GUIShow := true
global iniFile := % A_WorkingDir . "\tkok.ini"
global TKoKFolder =
global heroes = 
global AccountName = 
global AccountCode =
global HeroCode1 = 
global HeroCode2 =

;get default TKoK Folder
if FileExist(A_MyDocuments . "\Warcraft III\CustomMapData\TKoK_Save_Files\TKoK_3.5.15")
    TKoKFolder := % A_MyDocuments . "\Warcraft III\CustomMapData\TKoK_Save_Files\TKoK_3.5.15"
Else
{
    MsgBox TKoK folder not found
    ExitApp
}

;gui
Gui, Add, Text, y+10, Account:
Gui, Add, Text, y+10 w100 vName, Name: 
Gui, Add, Text, y+10 w100 vAPT, APT: 
Gui, Add, Text, y+10 w100 vDEDIPTS, DEDI PTS: 
Gui, Add, Text, y+10, Hero:
Gui, Add, DropDownList, y+5 r15 gOnSelectHero vTKoKHeroes

Gui, Add, Text, y+10, Wisp:
Gui, Add, Edit, y+10 w40 h20 vWisp Limit1 Number, "0"
Gui, Add, Text, y+10, Fate Card:
Gui, Add, Edit, y+10 w40 h20 vFateCard Limit2 Number, "0"

Gui, Add, Text, x10 y+10 w100 vLevel, Level: 
Gui, Add, Text, y+10 w100 vExp, Exp: 
Gui, Add, Text, y+10 w100 vGold, Gold: 
Gui, Add, Text, y+10 w100 vStarGlass, Star Glass: 
Gui, Add, Button, y+10 gLoadTKoK, Load
Gui, Add, Button, x+10 gLoadAccount, Load Account

;main
GetSetAccount()
GetSetHeroes()
GetHeroInfo()
GetQuickStart()

Gui, Show, w140 h390, TKoK Loader

;end main
Return

;functions
GetSetAccount()
{
    ;get a list of files
    FileList = 
    Loop, Files, % TKoKFolder . "\*.txt"
        FileList .= A_LoopFileTimeModified "`t" A_LoopFileName "`n"
    Sort, FileList, `n ;sort by date
    ; get newest file
    Loop, Parse, FileList, `n
    {
        if (A_LoopField = "") ; Omit the last linefeed (blank item) at the end of the list.
            continue
        StringSplit, FileItem, A_LoopField, %A_Tab% ; Split into two parts at the tab char.
    }
    FileRead, OutputVar, % TKoKFolder . "\" . FileItem2 ;read file
    ;find apt
    res := RegExMatch(OutputVar, "APT: (.*)", Match)
    GuiControl,, APT, % "APT: " . Match1 ;update gui
    ;find dedi pts
    res := RegExMatch(OutputVar, "DEDI PTS: (.*)", Match)
    GuiControl,, DEDIPTS, % "DEDI PTS: " . Match1 ;update gui
    ;find account load code
    res := RegExMatch(OutputVar, "(-la.*)", Match)
    AccountCode := Match1
}
GetSetHeroes()
{
    Loop, Files, % TKoKFolder . "\*", D
    {
        heroes .= A_LoopFileName . "|"
        if(A_Index = 1)
            heroes .= "|"
    }
    GuiControl,, TKoKHeroes, % heroes
}

GetHeroInfo()
{
    ;get a list of files
    FileList = 
    Loop, Files, % TKoKFolder . "\" . GetGuiValue("1", "TKoKHeroes") . "\*.txt"
        FileList .= A_LoopFileTimeModified "`t" A_LoopFileName "`n"
    Sort, FileList, `n ;sort by date
    ; get newest file
    Loop, Parse, FileList, `n
    {
        if (A_LoopField = "") ; Omit the last linefeed (blank item) at the end of the list.
            continue
        StringSplit, FileItem, A_LoopField, %A_Tab% ; Split into two parts at the tab char.
    }
    FileRead, OutputVar, % TKoKFolder . "\" . GetGuiValue("1", "TKoKHeroes") . "\" . FileItem2 ;read file
    ;find account name
    res := RegExMatch(OutputVar, "Name: (.*)\""", Match)
    AccountName := Match1
    GuiControl,, Name, % "Name: " . Match1 ;update gui
    ;find levels
    res := RegExMatch(OutputVar, "Level: (.*)""", Match)
    GuiControl,, Level, % "Level: " . Match1 ;update gui
    ;find exp
    res := RegExMatch(OutputVar, "EXP: (.*)""", Match)
    GuiControl,, Exp, % "Exp: " . Match1 ;update gui
    ;find gold
    res := RegExMatch(OutputVar, "Gold: (.*)""", Match)
    GuiControl,, Gold, % "Gold: " . Match1 ;update gui
    ;find star glass
    res := RegExMatch(OutputVar, "Star Glass: (.*)""", Match)
    GuiControl,, StarGlass, % "Star Glass: " . Match1 ;update gui
    ;find account load code1
    res := RegExMatch(OutputVar, "(-l.*)", Match)
    HeroCode1 := Match1
    ;find account load code2
    res := RegExMatch(OutputVar, "(-l2.*)", Match)
    HeroCode2 := Match1
}

GetQuickStart() {
    GuiControl,, Wisp, % LoadNumberFromINI("wisp")
    GuiControl,, FateCard, % LoadNumberFromINI("fatecard")
}

SetQuickStart() {
    SaveNumberToINI(GetGuiValue("1", "Wisp"), "wisp")
    SaveNumberToINI(GetGuiValue("1", "FateCard"), "fatecard")
}

GetGuiValue(GuiID, GuiVar)
{
    GuiControlGet, Value, %GuiID%:, %GuiVar%
    return Value
}

WC3Chat(String)
{
    SendInput, {Enter}
    SendInput, {Text}%String%
    SendInput, {Enter}
}

; Function to save the number to an INI file
SaveNumberToINI(number, location) {
    IniWrite, %number%, %iniFile%, Storage, %location%
}

; Function to load the number from the INI file
LoadNumberFromINI(location) {
    if FileExist(iniFile) {
        IniRead, storedNumber, %iniFile%, Storage, %location%
        return storedNumber
    }
    return "0"  ; Return empty string if the INI file doesn't exist
}

;labels
OnSelectHero:
    GetSetAccount()
    GetHeroInfo()
Return

LoadAccount:
    GetSetAccount()
    GetHeroInfo() 
    SetQuickStart()

    ;Find Warcraft III and focus on it
    if WinExist("Warcraft III") 
    {
        WinActivate
    }
    else
    {
        MsgBox, Couldn't find Warcraft III
        return
    }

    ; load account only
    WC3Chat("-loadwith "AccountName)
    Sleep, 1000
    WC3Chat(AccountCode)
    Sleep, 200
    WC3Chat("-quickstart " . GetGuiValue("1", "Wisp") . " " . RTrim(GetGuiValue("1", "FateCard"), " "))

    ;close gui
    Gui, Hide
    GUIShow := False
Return

LoadTKoK:
    GetSetAccount()
    GetHeroInfo() 
    SetQuickStart()

    ;Find Warcraft III and focus on it
    if WinExist("Warcraft III") 
    {
        WinActivate
    }
    else
    {
        MsgBox, Couldn't find Warcraft III
        return
    }

    ; load hero
    WC3Chat("-loadwith "AccountName)
    Sleep, 1000
    WC3Chat(HeroCode1)
    WC3Chat(HeroCode2)
    Sleep, 2000
    WC3Chat(AccountCode)
    Sleep, 200
    WC3Chat("-quickstart " . GetGuiValue("1", "Wisp") . " " . RTrim(GetGuiValue("1", "FateCard"), " "))

    ;close gui
    Gui, Hide
    GUIShow := False
Return

;hotkey
f6::
    GUIShow := !GUIShow
    if (GUIShow)
    {
        GetSetAccount()
        GetHeroInfo()
        Gui, Show, w140 h390, TKoK Loader
    }
    else
        Gui, Hide
Return

;common
GuiClose:
GuiEscape:
    Gui, Hide
    GUIShow := False
return