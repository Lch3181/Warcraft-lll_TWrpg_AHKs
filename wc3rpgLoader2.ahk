#SingleInstance, Force
#MaxThreadsPerHotKey 2
FileEncoding UTF-8-RAW
SendMode Input
SetWorkingDir, %A_ScriptDir%
SetTitleMatchMode 2
DetectHiddenWindows, On
SetDefaultMouseSpeed, 0
SetMouseDelay, -1
SetKeyDelay, -1
SetWinDelay, -1
SetBatchLines, -1
SetControlDelay -1
Thread, interrupt, 0
global iniFile := "wc3rpgLoaderData.ini"
;Includes the specified file inside the compiled version of the script.
FileInstall, SearchIcon.png, SearchIcon.png

;GUI
;-------------------------------------------Loader Tab---------------------------------------------------
Gui, Color, DCDCDC
Gui, Add, Tab3, x0 y20 w380 h200 vSubLoader, TWrpg|MAYBE
;--------------- For TWRPG ---------------
Gui, Tab, TWRPG
Gui, Add, Text, x20 y50, Hero:
Gui, Add, DropDownList, y+5 w340 R10 vHeroChoice
Gui, Add, Checkbox, y+10 vConvertToggle, -Convert for Warcraft III Reforged
Gui, Add, Button, x20 y+10 w150 h30 gtwrpg , Load
Gui, Add, Button, x+20 w170 h30 gHerosEditorButton, Add/Edit/Delete
Gui, Add, Text, x20 y+10 , TWRPG Folder:
Gui, Add, Edit, x20 y+10 w310 h30 R1 vTWrpgFolderAddress ReadOnly, % IniRead("Address", "TWrpgFolder")
Gui, Add, Picture, x+10 w20 h20 vTWrpgFolder gGetSetFolder, SearchIcon.png
;Gui, Add, Button,  x+10 w40 h22 vTWrpgFolder gGetSetFolder, Open
;-------------------------------------------Main Tab-------------------------------------------------------
Gui, Add, Tab2, x0 y0 w380 h220 gTabSwitched vMainTab, Loader|Host
;---- For Hosting
Gui, Tab, Host
Gui, Add, Text, x20 y30, Pick:
Gui, Add, ComboBox, y+5 w100 h150 vBotChoice gOnSelectBot
Gui, Add, Text, x20 y+10, Map Load Command:
Gui, Add, Edit, y+5 w100 h20 vBotCommand
Gui, Add, Checkbox, x+10 vBotCommandToggle, Enable/Disable
Gui, Add, Text, x20 y+10, Game Name:
Gui, Add, Edit , y+5 w100 h20 vGN
Gui, Add, Checkbox, x+10 vGameNamePlusToggle, Game Name + 1 Enable/Disable
Gui, Add, Button , x20 y+20 w100 h30 gPriv , Private
Gui, Add, Button , x+20 w100 h30 gPub , Public
Gui, Add, Button, x+20 w100 h30 gDeleteBot, Delete Bot Hostory
;-----------------------------------------Hero Editor---------------------------------------------------------
Gui, 2: Color, DCDCDC
Gui, 2: Add, Text, x10 y10, Hero:
Gui, 2: Add, ComboBox, y+5 w340 R10 vHeroChoice gOnSelectHero
Gui, 2: Add, Text, y+10, Download URL(Empty if none):
Gui, 2: Add, Edit, y+5 vURL w340 h20
Gui, 2: Add, Text, y+10, Loading String:
Gui, 2: Add, Edit, y+5 w340 h20 vLoadingString, Loading Hero1
Gui, 2: Add, Button, y+10 w100 h30 gAddHeroSubmit, Add
Gui, 2: Add, Button, x+20 w100 h30 gEditHeroSubmit, Update
Gui, 2: Add, Button, x+20 w100 h30 gDeleteHeroSubmit, Delete

;Main
;GetSetAll
GetSetAllHeros()
GetSetAllBots()

;temp debug
Gui, Show, w380 h220, Pick Your Load Code

;----------------------------------------------------------------------------------
;----------------------------------- Load Code ------------------------------------
;----------------------------------------------------------------------------------
$F8::
    Gui, Show, w380 h220, Pick Your Load Code
Return
;----------------------------------------------------------------------------------
twrpg:

    ;Set last loaded hero
    IniWrite, % GetGuiValue(A_Gui,"HeroChoice"), %iniFile%, LastLoaded, Hero

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

    ;Read save file
    if(IniRead("TWrpgHeros", GetGuiValue(A_Gui,"HeroChoice")) = "") ;if URL is empty, load from PC
        FileRead, code, % IniRead("Address", "TWrpgFolder")"\"GetGuiValue(A_Gui,"HeroChoice")".txt"
    else ;if URL exist
        code := DownloadFileFromUrl(IniRead("TWrpgHeros", GetGuiValue(A_Gui,"HeroChoice")))

    if not ErrorLevel{
        ;Close Gui
        Gui, Cancel
        Gui, Submit

        temp := StrReplace(code, "-load", "-load", count) ;find all load codes

        res := RegExMatch(code, "(User Name|아이디):\s((?:[^""]|\\"")*)", Match) ;find character name
        charName := Match2

        ;output to wc3 chat
        WC3Chat(IniRead("LoadingString", GetGuiValue(A_Gui,"HeroChoice")))
        OutputDebug, % code
        OutputDebug, % charName
        if(charName != "" && GetGuiValue(A_Gui, "Convert"))
            WC3Chat("-convert "charName)
        sleep, 100

        i := 1
        while(i <= count){
            pos := InStr(code, "-load",, 1, i)
            result := RegExMatch(code, "-load [a-zA-Z\d\?@#$%&-]*", Match, pos)
            char := Match

            WC3Chat(char)

            i := i + 1
        }
        WC3Chat("-refresh")
        code =
        sleep 3000
        tw_skills()
    }
    else
    {
        MsgBox, "File Does Not Exist"
    }

    ;update ini file
    IniWrite, %ConvertToggle%, %iniFile%, Settings, ConvertToggle
Return
;----------------------------------------------------------------------------------
tw_skills(){
    SendInput, {F1 2}
    Sleep, 100
    SendInput, {Ctrl down}{1}{Ctrl up}
    Sleep, 100
    SendInput, {Esc}{o}
    sleep, 25
    SendInput, {t}{q}{w}{e}{r}
}
;----------------------------------------------------------------------------------
Plus:
    Gui, Submit, NoHide
    result := RegExMatch(GN, "([a-zA-Z]+)(\d*)", Match)
    name := Match1
    number := Match2

    hasZero := RegExMatch(number, "^([0])(\d{1})", Digit)
    isNine := RegExMatch(Digit2, "([9])")
    number += 1
    if(hasZero && !isNine){
        GN = %name%0%number%
    }
    else{
        GN = %name%%number%
    }
    GuiControl,, GN, %GN%
Return
;----------------------------------------------------------------------------------
Pub:
    Gui, Cancel
    Gui, Submit
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
    ;output to wc3 chat
    if(GameNamePlusToggle)
        Gosub, Plus
    if(BotCommandToggle)
    {
        WC3Chat("/w " . BotChoice . " " . BotCommand)
        Sleep, 2000
    }
    WC3Chat("/w " . BotChoice . " !pub " . GN)
    WC3Chat("Game Name: "GN)
    ; update inifile
    IniWrite, %GN%, %iniFile%, LastLoaded, GameName
    IniWrite, %BotChoice%, %iniFile%, LastLoaded, Bot
    IniWrite, %BotCommand%, %iniFile%, TWrpgBots, %BotChoice%
    IniWrite, %BotCommandToggle%, %iniFile%, Settings, BotCommandToggle
    IniWrite, %GameNamePlusToggle%, %iniFile%, Settings, GameNamePlusToggle
Return
;----------------------------------------------------------------------------------
Priv:
    Gui, Cancel
    Gui, Submit
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
    ;output to wc3 chat
    if(GameNamePlusToggle)
        Gosub, Plus
    if(BotCommandToggle)
    {
        WC3Chat("/w " . BotChoice . " " . BotCommand)
        Sleep, 2000
    }
    WC3Chat("/w " . BotChoice . " !priv " . GN)
    WC3Chat("Game Name: "GN)
    ; update inifile
    IniWrite, %GN%, %iniFile%, LastLoaded, GameName
    IniWrite, %BotChoice%, %iniFile%, LastLoaded, Bot
    IniWrite, %BotCommand%, %iniFile%, TWrpgBots, %BotChoice%
    IniWrite, %BotCommandToggle%, %iniFile%, Settings, BotCommandToggle
    IniWrite, %GameNamePlusToggle%, %iniFile%, Settings, GameNamePlusToggle
Return
;----------------------------------------------------------------------------------
;----------------------------------- Load Code ------------------------------------
;----------------------------------------------------------------------------------
;------------------------------------Labels----------------------------------------
OnSelectHero:
    GuiControl, %A_Gui%:, URL, % IniRead("TWrpgHeros", GetGuiValue(A_Gui, A_GuiControl))
    GuiControl, %A_Gui%:, LoadingString, % IniRead("LoadingString", GetGuiValue(A_Gui, A_GuiControl))
return

OnSelectBot:
    GuiControl, %A_Gui%:, BotCommand, % IniRead("TWrpgBots", GetGuiValue(A_Gui, A_GuiControl))
return

TabSwitched:
    Gui, Submit, Nohide
    if(MainTab = "Loader")
    {
        GuiControl, Show, SubLoader
    }
    else
    {
        GuiControl, Hide, SubLoader
    }
    Gui, +LastFound
    Winset, Redraw
return

GetSetFolder:
    FileSelectFolder, SelectedFolder,, 0
    if (SelectedFolder != "")
    {
        GuiControl, Text, % A_GuiControl . "Address", % SelectedFolder
        IniWrite, %SelectedFolder%, %iniFile%, Address, %A_GuiControl%
    }

return

HerosEditorButton:
    Gui, 2:Show, AutoSize, TWrpg Heros Editor
return

AddHeroSubmit:
    ;get rpg name for loader
    WinGetActiveTitle, OutputVar
    OutputVar := RegExReplace(OutputVar, "^(.*?)\s.*", "$1")
    ;check if inputs are correct
    if(FileExistCheck() != 1)
    {
        MsgBox, 1, % GetGuiValue(A_Gui,"HeroChoice")".txt", % FileExistCheck()
        IfMsgBox, OK
        {
            ; update ini file
            IniWrite, % GetGuiValue(A_Gui,"HeroChoice"), %iniFile%, LastLoaded, Hero
            IniWrite, % GetGuiValue(A_Gui,"URL"), %iniFile%, % OutputVar "Heros", % GetGuiValue(A_Gui,"HeroChoice")
            IniWrite, % GetGuiValue(A_Gui,"LoadingString"), %iniFile%, LoadingString, % GetGuiValue(A_Gui,"HeroChoice")
            ToolTip(GetGuiValue(A_Gui, "HeroChoice") . " Updated")
            GetSetAllHeros()
        }
        else IfMsgBox, Cancel
        {
            ToolTip("Canceled")
        }
    }
    else
    {
        MsgBox, File Does Not Exist`, Please Double Check.
        ToolTip
    }
    ;close gui
    Gui, Hide
return

EditHeroSubmit:
    Gosub, AddHeroSubmit
return

DeleteHeroSubmit:
    ;get rpg name from win title
    WinGetActiveTitle, OutputVar
    OutputVar := RegExReplace(OutputVar, "^(.*?)\s.*", "$1")
    ;update inifile
    IniDelete, %iniFile%, % OutputVar "Heros", % GetGuiValue(A_Gui,"HeroChoice")
    IniDelete, %iniFile%, LoadingString, % GetGuiValue(A_Gui,"HeroChoice")
    ToolTip(GetGuiValue(A_Gui, "HeroChoice") . " Deleted")
    GetSetAllHeros()
    ;close gui
    Gui, Hide
return

RemoveToolTip:
    ToolTip
return

DeleteBot:
    ; update inifile
    IniDelete, %iniFile%, LastLoaded, Bot
    IniDelete, %iniFile%, TWrpgBots, % GetGuiValue("1", "BotChoice")
    GetSetAllBots()
return

;------------------------------------Functions-------------------------------------
IniRead(Section, Key := "")
{
    IniRead, OutputVar, %iniFile%, %Section%, %Key%
    if(OutputVar = "ERROR")
        OutputVar := ""
    return OutputVar
}

GetGuiValue(GuiID, GuiVar)
{
    GuiControlGet, Value, %GuiID%:, %GuiVar%
    return %Value%
}

DownloadFileFromUrl(URL)
{
    WC3Chat("Downloading Save File From Cloud Service")
    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    whr.Open("GET", URL, false)
    whr.Send()

    arr := whr.ResponseBody
    pData := NumGet(ComObjValue(arr) + 8 + A_PtrSize)
    length := arr.MaxIndex() + 1
    result := StrGet(pData, length, "utf-8")
    ;Error Page
    if(InStr(result, "<html>"))
        Run, %URL%
    return result
}

WC3Chat(String)
{
    SendInput, {Enter}
    SendInput, {Text}%String%
    SendInput, {Enter}
}

GetSetAllHeros()
{
    TwrpgHeros := "|"
    OutputVar := IniRead("TWrpgHeros") ;get all lines in section
    lines := StrSplit(OutputVar, "`n") ;split by newline
    Loop % lines.MaxIndex()
    {
        TwrpgHeros .= StrSplit(lines[A_Index], "=")[1]"|" ;get key
        if(StrSplit(lines[A_Index], "=")[1] = IniRead("LastLoaded", "Hero")) ; set default hero by last loaded hero
            TwrpgHeros .= "|"
    }
    GuiControl, 1:, HeroChoice, %TwrpgHeros%
    GuiControl, 1:, ConvertToggle, % IniRead("Settings", "ConvertToggle")
    GuiControl, 2:, HeroChoice, %TwrpgHeros%
    if(GetGuiValue("2", "HeroChoice") != "")
    {
        GuiControl, 2:, URL, % IniRead("TWrpgHeros", GetGuiValue("2", "HeroChoice"))
        GuiControl, 2:, LoadingString, % IniRead("LoadingString", GetGuiValue("2", "HeroChoice"))
    }
}

GetSetAllBots()
{
    TwrpgBots := "|"
    OutputVar := IniRead("TWrpgBots") ;get all lines in section
    lines := StrSplit(OutputVar, "`n") ;split by newline
    Loop % lines.MaxIndex()
    {
        TwrpgBots .= StrSplit(lines[A_Index], "=")[1]"|" ;get key
        if(StrSplit(lines[A_Index], "=")[1] = IniRead("LastLoaded", "Bot")) ; set default hero by last loaded hero
            TwrpgBots .= "|"
    }
    GuiControl, 1:, BotChoice, %TwrpgBots%
    if(GetGuiValue("1", "BotChoice") != "")
        GuiControl, 1:, BotCommand, % IniRead("TwrpgBots", GetGuiValue("1", "BotChoice"))
    else
        GuiControl, 1:, BotCommand, 
    GuiControl, 1:, BotCommandToggle, % IniRead("Settings", "BotCommandToggle")
    GuiControl, 1:, GN, % IniRead("LastLoaded", "GameName")
    GuiControl, 1:, GameNamePlusToggle, % IniRead("Settings", "GameNamePlusToggle")
}

FileExistCheck()
{
    ToolTip("Checking File Existent...")
    ;Read save file
    if(IniRead("TWrpgHeros", GetGuiValue(A_Gui,"HeroChoice")) = "") ;if URL is empty, load from PC
        FileRead, code, % IniRead("Address", "TWrpgFolder")"\"GetGuiValue(A_Gui,"HeroChoice")".txt"
    else ;if URL exist
        code := DownloadFileFromUrl(IniRead("TWrpgHeros", GetGuiValue(A_Gui,"HeroChoice")))

    if not ErrorLevel{
        return code
    }
    else
    {
        return ErrorLevel ; 1(Error)
    }
}

ToolTip(String, Timer = -3000)
{
    ToolTip, %String%
    SetTimer, RemoveToolTip, %Timer%
}

;Hotkeys
GuiClose:
2GuiClose:
GuiEscape:
2GuiEscape:
    Gui, %A_Gui%:Hide
    ToolTip
return

!r::reload

^esc::ExitApp

!s::suspend