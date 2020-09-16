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
Gui, Add, Tab3, x0 y20 w380 h280 vSubLoader, TWrpg|MAYBE
;--------------- For TWRPG ---------------
Gui, Tab, TWRPG
Gui, Add, Text, x20 y50, Hero:
Gui, Add, DropDownList, y+5 w340 R10 vHeroChoice
Gui, Add, Button, x20 y+10 w150 h30 gtwrpg , Load
Gui, Add, Button, x+20 w170 h30 gHerosEditorButton, Add/Edit/Delete
Gui, Add, Text, x20 y+10 , TWRPG Folder:
Gui, Add, Edit, x20 y+10 w310 h30 R1 vTWrpgFolderAddress ReadOnly, % IniRead("Address", "TWrpgFolder")
Gui, Add, Picture, x+10 w20 h20 vTWrpgFolder gGetSetFolder, SearchIcon.png
;Gui, Add, Button,  x+10 w40 h22 vTWrpgFolder gGetSetFolder, Open
;-------------------------------------------Main Tab-------------------------------------------------------
Gui, Add, Tab2, x0 y0 w380 h300 gTabSwitched vMainTab, Loader|Host
;---- For Hosting
Gui, Tab, Host
Gui, Add, Text, x20 y30, Pick:
Gui, Add, DropDownList, y+5 w100 h150 vBot , leebot|macibot|maci886|Idolbot||
Gui, Add, Text, y+10, Game Name:
Gui, Add, Edit , y+5 w100 h20 vGN , sey
Gui, Add, Button , x+0 w30 h20 gPlus , +1
Gui, Add, Text, x20 y+10, Extra Command:
Gui, Add, Edit, y+5 w100 h20 vCommand, !load twre
Gui, Add, Checkbox, x+10 w13 h13
Gui, Add, Button , x20 y+20 w100 h30 gPriv , Private
Gui, Add, Button , x+20 w100 h30 gPub , Public
Gui, Add, Text, x20 y+10, Bots:
Gui, Add, Button, y+10 w100 h30, Add
Gui, Add, Button, x+20 w100 h30, Delete
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
;Get all Heros for TWrpg
GetSetAllHeros()

;temp debug
Gui, Show, w380 h300, Pick Your Load Code

;----------------------------------------------------------------------------------
;----------------------------------- Load Code ------------------------------------
;----------------------------------------------------------------------------------
$F8::
    Gui, Show, w380 h300, Pick Your Load Code
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
        if(charName != "")
            WC3Chat("-convert "charName)
        WC3Chat("-refresh")
        sleep, 100

        i := 1
        while(i <= count){
            pos := InStr(code, "-load",, 1, i)
            result := RegExMatch(code, "-load [a-zA-Z\d\?@#$%&-]*", Match, pos)
            char := Match

            WC3Chat(char)

            i := i + 1
        }
        code =
        sleep 3000
        tw_skills()
    }
    else
    {
        MsgBox, "File Does Not Exist"
    }
Return
;----------------------------------------------------------------------------------
tw_skills()
{
    SendInput, {o}
    sleep, 25
    SendInput, {t}{q}{w}{e}{r}
}
;----------------------------------------------------------------------------------
Cancel:
    Gui, Cancel
Return
;----------------------------------------------------------------------------------
Host:
    Gui, Cancel
    Gui, 2:Show, autosize, Choose a Hostbot
Return
;----------------------------------------------------------------------------------
Plus:
    Gui, Submit, NoHide
    result := RegExMatch(GN, "([a-zA-Z]+)(\d+)", Match)
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
    SendInput, {Enter}
    SendRaw, /w %Bot% !pub %GN%
    SendInput, {Enter 2}
    SendRaw Game Name: %GN%
    SendInput {Enter}
Return
;----------------------------------------------------------------------------------
Priv:
    Gui, Cancel
    Gui, Submit
    SendInput, {Enter}
    SendRaw, /w %Bot% !priv %GN%
    SendInput, {Enter 2}
    SendRaw Game Name: %GN%
    SendInput {Enter}
Return
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------
;----------------------------------- Load Code ------------------------------------
;----------------------------------------------------------------------------------
RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
return
;------------------------------------Labels----------------------------------------
;Main Gui
OnSelectHero:
    GuiControl, %A_Gui%:, URL, % IniRead("TWrpgHeros", GetGuiValue(A_Gui, A_GuiControl))
    GuiControl, %A_Gui%:, LoadingString, % IniRead("LoadingString", GetGuiValue(A_Gui, A_GuiControl))
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
            ToolTip, % GetGuiValue(A_Gui, "HeroChoice") . " Updated"
            GetSetAllHeros()
        }
        else IfMsgBox, Cancel
        {
            ToolTip, Canceled
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
    ToolTip, % GetGuiValue(A_Gui, "HeroChoice") . " Deleted"
    GetSetAllHeros()
    ;close gui
    Gui, Hide
return

;------------------------------------Functions-------------------------------------
IniRead(Section, Key)
{
    IniRead, OutputVar, %iniFile%, %Section%, %Key%
    if(OutputVar = "ERROR")
        OutputVar := ""
    return OutputVar
}

IniReadSection(Section)
{
    IniRead, OutputVar, %iniFile%, %Section%
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
    OutputVar := IniReadSection("TWrpgHeros") ;get all lines in section
    lines := StrSplit(OutputVar, "`n") ;split by newline
    Loop % lines.MaxIndex()
    {
        TwrpgHeros .= StrSplit(lines[A_Index], "=")[1]"|" ;get key
        if(StrSplit(lines[A_Index], "=")[1] = IniRead("LastLoaded", "Hero")) ; set default hero by last loaded hero
            TwrpgHeros .= "|"
    }
    GuiControl, 1:, HeroChoice, %TwrpgHeros%
    GuiControl, 2:, HeroChoice, %TwrpgHeros%
    GuiControl, 2:, URL, % IniRead("TWrpgHeros", GetGuiValue("2", "HeroChoice"))
    GuiControl, 2:, LoadingString, % IniRead("LoadingString", GetGuiValue("2", "HeroChoice"))
}

FileExistCheck()
{
    ToolTip, Checking File Existent...
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