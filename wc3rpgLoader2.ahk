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
global KeyWaiting := False
global GUIShow := True
global OverlayShow := True
global inventory := False
;Includes the specified file inside the compiled version of the script.
FileCreateDir, Images
FileInstall, Images\SearchIcon.png, Images\SearchIcon.png
FileInstall, Images\Inventory.jpg, Images\Inventory.jpg

;fill up missing data if first run
initial()

;GUI
;-------------------------------------------Loader Tab---------------------------------------------------
Gui, Color, DCDCDC
Gui, Add, Tab3, x0 y20 w380 h240 vSubLoader, TWrpg
;--------------- For TWRPG ---------------
Gui, Tab, TWRPG
Gui, Add, Text, x20 y50, Hero:
Gui, Add, DropDownList, y+5 w340 R10 vHeroChoice
Gui, Add, Checkbox, y+10 vConvertToggle, -Convert for Warcraft III Reforged
Gui, Add, Button, x20 y+10 w150 h30 gtwrpg , Load
Gui, Add, Button, x+20 w170 h30 gHerosEditorButton, Add/Edit/Delete
Gui, Add, Text, x20 y+10 , TWRPG Folder:
Gui, Add, Edit, x20 y+10 w310 h30 R1 vTWrpgFolderAddress ReadOnly, % IniRead("Address", "TWrpgFolder")
Gui, Add, Picture, x+10 w20 h20 vTWrpgFolder gGetSetFolder, Images\SearchIcon.png
Gui, Add, Button, x20 y+10 w150 h30 gScanSaveFiles, Scan Save Files
;-------------------------------------------Main Tab-------------------------------------------------------
Gui, Add, Tab2, x0 y0 w380 h260 gTabSwitched vMainTab, Loader|Host|Inventory|Settings
;---- For Hosting
Gui, Tab, Host
Gui, Add, Text, x20 y30 , Pick:
Gui, Add, ComboBox, y+5 w100 R10 vBotChoice gOnSelectBot
Gui, Add, Text, x20 y+10 , Map Load Command:
Gui, Add, Edit, y+5 w100 h20 vBotCommand
Gui, Add, Checkbox, x+10 vBotCommandToggle, Enable/Disable
Gui, Add, Text, x20 y+10 , Game Name:
Gui, Add, Edit, y+5 w100 h20 vGN
Gui, Add, Checkbox, x+10 vGameNamePlusToggle, Game Name + 1 Enable/Disable
Gui, Add, Button, x20 y+20 w100 h30 gPriv, Private
Gui, Add, Button, x+20 w100 h30 gPub, Public
Gui, Add, Button, x+20 w100 h30 gDeleteBot, Delete Bot History
;-----------------------------------------Inventory---------------------------------------------------------
Gui, Tab, Inventory
Gui, Add, Picture, x20 y40 Icon , Images\Inventory.jpg
Gui, Font, s12
Gui, Add, Text, x+10 y40 , Enable/Disable
Gui, Add, Text, y+0 , CheckBox for Auto Cast
Gui, Font, s8
Gui, Add, Button, x285 y40 w50 h20 gGetSetKey vInventoryToggle
Gui, Add, Button, x29 y80 w50 h20 gGetSetKey vNumpad7
Gui, Add, Button, x+21 w50 h20 gGetSetKey vNumpad8
Gui, Add, Button, x29 y+50 w50 h20 gGetSetKey vNumpad4
Gui, Add, Button, x+21 w50 h20 gGetSetKey vNumpad5
Gui, Add, Button, x29 y+50 w50 h20 gGetSetKey vNumpad1
Gui, Add, Button, x+21 w50 h20 gGetSetKey vNumpad2
Gui, Add, CheckBox, x47 y60 w13 h13 gGetSetCheckBoxValue vNumpad7AutoCast
Gui, Add, CheckBox, x+58 w13 h13 gGetSetCheckBoxValue vNumpad8AutoCast
Gui, Add, CheckBox, x47 y+56 w13 h13 gGetSetCheckBoxValue vNumpad4AutoCast
Gui, Add, CheckBox, x+58 w13 h13 gGetSetCheckBoxValue vNumpad5AutoCast
Gui, Add, CheckBox, x47 y+56 w13 h13 gGetSetCheckBoxValue vNumpad1AutoCast
Gui, Add, CheckBox, x+58 w13 h13 gGetSetCheckBoxValue vNumpad2AutoCast
;-----------------------------------------Settings----------------------------------------------------------
Gui, Tab, Settings
Gui, Font, s12
Gui, Add, Text, x10 y30, Show/Hide
Gui, Add, Text, y+0, Overlay Show/Hide
Gui, Add, Text, y+0, Unsign Hotkey
Gui, Add, Text, y+0, Exit
Gui, Add, Text, y+0, Disable All on Enter
Gui, Add, Text, y+0, Disable Hotkeys' Native Functions
Gui, Add, Text, y+0, Ex: Alt+q if assigned
Gui, Font, s8
Gui, Add, Button, x300 y30 w50 h20 gGetSetKey vShowHideMain
Gui, Add, Button, y+0 w50 h20 gGetSetKey vShowHideOverlay
Gui, Add, Button, y+0 w50 h20 disabled, ESC
Gui, Add, Button, y+0 w50 h20 disabled, Alt+ESC
Gui, Add, Checkbox, y+5 gGetSetCheckBoxValue vDisableAll 
Gui, Add, Checkbox, y+20 gGetSetCheckBoxValue vDisableAllNativeFunctions 
;-----------------------------------------Hero Editor-------------------------------------------------------
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
;-----------------------------------------Toggle Gui--------------------------------------------------------
;Toggles Gui
Gui, 3: +LastFound +AlwaysOnTop -Caption
Gui, 3: Font, s12
Gui, 3: Font, cRed
Gui, 3: Add, Text, vActiveInventory x0 y0 , % "Inventory: " ((inventory) ? ("Enabled") : ("Disabled"))
;Gui, 3: Add, Text, vActiveQuickCast x0 y+0, % "Auto Cast: " ((QuickCast) ? ("Enabled") : ("Disabled"))
;Gui, 3: Add, Text, vActiveQuickCall x0 y+0, % "Quick Call: " ((QuickCall) ? ("Enabled") : ("Disabled"))
;Gui, 3: Add, Text, vTarget x+5 w100, No Target
;Gui, 3: Add, Text, vActiveNoMouse   x0 y+0, % "No Mouse: " ((NoMouse) ? ("Enabled") : ("Disabled"))
Gui, 3: Color, EEAA99
WinSet, TransColor, EEAA99
Gui, 3: Show, x0 y0

;GetSetAll
GetSetHeros()
GetSetBots()
GetSetInventories()
GetSetSettings()

;Show Gui on Start
Gui, Show, w380 h260, WC3 RPG Tool
return

;----------------------------------------------------------------------------------
;----------------------------------- Load Code ------------------------------------
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
    ;refresh gui
    GetSetBots()
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
    ;refresh gui
    GetSetBots()
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

ScanSaveFiles:
    Gui, Submit, NoHide
    ToolTip("Scanning all files. . .")
    files = 
    Loop % IniRead("Address", SubLoader . "Folder")"\*.*" ; in each file in folder
    {
        FileRead, OutputVar, % IniRead("Address", SubLoader . "Folder") . "\" . A_LoopFileName
        if(RegExMatch(OutputVar, "((?|User Name|아이디):\s(?:[^""]|\\"")*)") > 0) ; if it is a save file
            files .= StrReplace(A_LoopFileName, ".txt") . "`n"
    }
    ToolTip("Finished Scanning all files")
    ;promote user to add all the heros
    MsgBox, 4, Would you like to add all those heros?, %files%
    IfMsgBox Yes
    {
        Loop % IniRead("Address", SubLoader . "Folder")"\*.*" ; in each file in folder
        {
            FileRead, OutputVar, % IniRead("Address", SubLoader . "Folder") . "\" . A_LoopFileName
            if(RegExMatch(OutputVar, "((?|User Name|아이디):\s(?:[^""]|\\"")*)") > 0) ; if it is a save file
                IniWrite, % "", %iniFile%, % SubLoader . "Heros", % StrReplace(A_LoopFileName, ".txt")
        }
        GetSetHeros()
    }
    else
        ToolTip("Canceled")
return

HerosEditorButton:
    Gui, 2:Show, AutoSize, TWrpg Heros Editor
return

AddHeroSubmit:
    ;get rpg name for loader
    WinGetActiveTitle, OutputVar
    OutputVar := RegExReplace(OutputVar, "^(.*?)\s.*", "$1")
    ;check if inputs are correct
    result := FileExistCheck()
    if(result != 1 && result != "")
    {
        MsgBox, 1, % GetGuiValue(A_Gui,"HeroChoice")".txt", % result
        IfMsgBox, OK
        {
            ; update ini file
            IniWrite, % GetGuiValue(A_Gui,"HeroChoice"), %iniFile%, LastLoaded, Hero
            IniWrite, % GetGuiValue(A_Gui,"URL"), %iniFile%, % OutputVar "Heros", % GetGuiValue(A_Gui,"HeroChoice")
            IniWrite, % GetGuiValue(A_Gui,"LoadingString"), %iniFile%, LoadingString, % GetGuiValue(A_Gui,"HeroChoice")
            ToolTip(GetGuiValue(A_Gui, "HeroChoice") . " Updated")
            GetSetHeros()
        }
        else IfMsgBox, Cancel
        {
            ToolTip("Canceled")
        }
        ;close gui
        Gui, Hide
    }
    else
    {
        MsgBox, File Does Not Exist`, Please Double Check.
        ToolTip
    }
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
    GetSetHeros()
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
    GetSetBots()
return

GetSetKey:
    Gui, Submit, Nohide
    ; disable hotkey
    Hotkey, % IniRead(MainTab, A_GuiControl), %A_GuiControl%, Off
    ToolTip("Please assign a key to "A_GuiControl, -999999)
    ; Wait a key press
    input := % KeyWaitAny("V E C M")
    if(input = -1) ;still waiting key to assign for previous button
    {
        GuiControl,, %A_GuiControl%, % GetHotkeyName(IniRead(MainTab, A_GuiControl)) ;update gui
        ToolTip("Please finish assigning previous button or click ESC to unsign that button")
        return
    }
    if(InStr(GetHotkeys(), input) && input != "") ;check duplication
    {
        ToolTip(GetHotkeyName(input) . " is used ")
        ; re-enable hotkey
        Hotkey, % IniRead(MainTab, A_GuiControl), %A_GuiControl%, On
    }
    else
    {
        IniWrite, %input%, %IniFile%, %MainTab%, %A_GuiControl% ;update ini file
        GetSetInventories() ; refresh inventory tab
        ToolTip(GetHotkeyName(IniRead(MainTab, A_GuiControl)) . " Assigned to " . A_GuiControl)
    }
return

GetSetCheckBoxValue:
    Gui, Submit, Nohide
    IniWrite, % GetGuiValue("1", A_GuiControl), %iniFile%, %MainTab%, %A_GuiControl%
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

initial()
{
    clientVersion := IniRead("Settings", "Version")
    if(clientVersion < 2.0) ; 2.0 initial and inventory added
    {
        ;Address
        IniWrite, % A_MyDocuments . "\Warcraft III\CustomMapData\TWRPG", %iniFile%, Address, TWrpgFolder
        ;LastLoaded
        IniWrite, Hero1, %iniFile%, LastLoaded, Hero
        IniWrite, leebot, %iniFile%, LastLoaded, Bot
        IniWrite, game name, %iniFile%, LastLoaded, GameName
        ;TWrpgHeros
        IniWrite, % "", %iniFile%, TWrpgHeros, Hero1
        ;LoadingString
        IniWrite, Loading Hero1, %iniFile%, LoadingString, Hero1
        ;TWrpgBots
        IniWrite, !load twre, %iniFile%, TWrpgBots, leebot
        ;Inventory
        IniWrite, $F2, %iniFile%, Inventory, InventoryToggle
        IniWrite, $~1, %iniFile%, Inventory, Numpad7
        IniWrite, $~2, %iniFile%, Inventory, Numpad8
        IniWrite, $~3, %iniFile%, Inventory, Numpad4
        IniWrite, $~4, %iniFile%, Inventory, Numpad5
        IniWrite, $~5, %iniFile%, Inventory, Numpad1
        ;Settings
        IniWrite, 2.0, %iniFile%, Settings, Version ; update client version the first time
        IniWrite, 1, %iniFile%, Settings, ConvertToggle
        IniWrite, 1, %iniFile%, Settings, BotCommandToggle
        IniWrite, 1, %iniFile%, Settings, GameNamePlusToggle
        IniWrite, 1, %iniFile%, Settings, DisableAll
        IniWrite, 1, %iniFile%, Settings, DisableAllNativeFunctions
        IniWrite, $F8, %iniFile%, Settings, ShowHideMain
        ;2.0 relocated files
        if FileExist("SearchIcon.png")
            FileDelete, SearchIcon.png
    }
    if(clientVersion < 2.1) ; 2.1 show hide overlay added
    {
        IniWrite, $F7, %iniFile%, Settings, ShowHideOverlay
    }
    IniWrite, 2.1, %iniFile%, Settings, Version ; update client version
}

GetSetSettings()
{
    OutputVar := IniRead("Settings") ;get all lines in section
    lines := StrSplit(OutputVar, "`n") ;split by newline
    Loop % lines.MaxIndex()
    {
        keyValue := StrSplit(lines[A_Index], "=") ; split line to key and value
        GuiControl, 1:, % keyValue[1] , % GetHotkeyName(keyValue[2]) ; update gui
        ; assign hotkeys to labels
        if(keyValue[2] != "" && InStr(keyValue[1], "ShowHide"))
        {
            Hotkey, % keyValue[2], % keyValue[1], On
        }
    }
}

GetSetHeros()
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
    if IniRead("Settings", "ConvertToggle") is Digit
        GuiControl, 1:, ConvertToggle, % IniRead("Settings", "ConvertToggle")
    GuiControl, 2:, HeroChoice, %TwrpgHeros%
    if(GetGuiValue("2", "HeroChoice") != "")
    {
        GuiControl, 2:, URL, % IniRead("TWrpgHeros", GetGuiValue("2", "HeroChoice"))
        GuiControl, 2:, LoadingString, % IniRead("LoadingString", GetGuiValue("2", "HeroChoice"))
    }
}

GetSetBots()
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
    if IniRead("Settings", "BotCommandToggle") is Digit
        GuiControl, 1:, BotCommandToggle, % IniRead("Settings", "BotCommandToggle")
    GuiControl, 1:, GN, % IniRead("LastLoaded", "GameName")
    if IniRead("Settings", "GameNamePlusToggle") is Digit
        GuiControl, 1:, GameNamePlusToggle, % IniRead("Settings", "GameNamePlusToggle")
}

GetSetInventories()
{
    OutputVar := IniRead("Inventory") ;get all lines in section
    lines := StrSplit(OutputVar, "`n") ;split by newline
    Loop % lines.MaxIndex()
    {
        keyValue := StrSplit(lines[A_Index], "=") ; split line to key and value
        GuiControl, 1:, % keyValue[1] , % GetHotkeyName(keyValue[2]) ; update gui
        ; assign hotkeys to labels
        if(keyValue[2] != "" && !InStr(keyValue[1], "AutoCast"))
        {
            Hotkey, % keyValue[2], % keyValue[1], On
        }
    }
}

FileExistCheck()
{
    ToolTip("Checking File Existent...")
    ;Read save file
    if(GetGuiValue(A_Gui,"URL") = "") ;if URL is empty, load from PC
        FileRead, code, % IniRead("Address", "TWrpgFolder")"\"GetGuiValue(A_Gui,"HeroChoice")".txt"
    else ;if URL exist
        code := DownloadFileFromUrl(GetGuiValue(A_Gui,"URL"))

    temp := StrReplace(code, "-load", "-load", count) ;count load codes

    res := RegExMatch(code, "((?|User Name|아이디):\s(?:[^""]|\\"")*)", Match) ;find character name
    if (Match1 != "")
        codeChecker .= Match1 . "`n"

    res := RegExMatch(code, "((?|Class|직업):\s(?:[^""]|\\"")*)", Match) ;find class
    if (Match1 != "")
        codeChecker .= Match1 . "`n"

    ;find all load codes
    i := 1
    while(i <= count){
        pos := InStr(code, "-load",, 1, i)
        result := RegExMatch(code, "-load [a-zA-Z\d\?@#$%&-]*", Match, pos)
        if (Match != "")
            codeChecker .= Match . "`n"

        i := i + 1
    }
    code =

    if not ErrorLevel{
        return codeChecker
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

KeyWaitAny(Options:="")
{
    if(!KeyWaiting)
    {
        KeyWaiting := True
        ih := InputHook(Options)
        ih.KeyOpt("{All}", "ES") ; End and Suppress
        ih.KeyOpt("{LCtrl}{RCtrl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}", "-ES") ; Exclude the modifiers
        ih.Start()
        ErrorLevel := ih.Wait() ; Store EndReason in ErrorLevel
        KeyWaiting := False
        OutputDebug, % "Mod: " . ih.EndMods . " Key: " . ih.EndKey
        switch ih.EndKey
        {
        case "Escape":
        return ""
    default:
        if(ih.EndMods != "" || RegExMatch(ih.EndKey, "\w{2}") > 0) ; disable key function for combined hotkeys
        {
            return "$" . ih.EndMods . ih.EndKey
        }
        else ; send key include the hotkey
            return "$~" . ih.EndMods . ih.EndKey
    }
}
else
{
    return -1
}
}

GetHotkeys()
{
    FileRead, Script, %iniFile%
    lines := StrSplit(Script, "`n") ;split by newline
    Loop % lines.MaxIndex()
    {
        value := StrSplit(lines[A_Index], "=")[2]
        if(InStr(value, "$"))
            Hotkeys .= value . ", " ;get all hotkeys from value
    }
    return Hotkeys
}

GetHotkeyName(Hotkey)
{
    HotkeyNames := [["+","Shift+"], ["<^>!","AltGr+"], ["<","L"], [">","R"], ["!","Alt+"], ["^","Ctrl+"], ["#","Win+"], ["$",""], ["~",""]]
    for key, value in HotkeyNames
    {
        Hotkey := StrReplace(Hotkey, value[1], value[2])
    }
    return Hotkey
}

;Hotkeys
;Inventory
InventoryToggle:
    inventory := !inventory ; toggle inventory
    GuiControl, 3: Text, ActiveInventory, % "Inventory: " ((inventory) ? ("Enabled") : ("Disabled")) ;update GUI
    if (!GetGuiValue("1", "DisableAllNativeFunctions")) ; send hotkey when native function is blocked
    {
        if(RegExMatch(A_ThisHotKey, "\w{2}") != 0) ; Function keys F1~F12
        SendInput, % "{" . RegExReplace(A_ThisHotKey, "[$<>]", "") . "}"
    else ; Combined keys ex: ALT+T
        Send, % RegExReplace(A_ThisHotKey, "[$<>]", "")
}
return
Numpad7:
Numpad2:
Numpad1:
Numpad5:
Numpad4:
Numpad8:
    if(inventory)
        SendInput, {%A_ThisLabel%}
    if(inventory && GetGuiValue("1", A_ThisLabel . "AutoCast") = 1)
        MouseClick, Left
    else if (!GetGuiValue("1", "DisableAllNativeFunctions") && !inventory && !InStr(A_ThisHotKey, "~")) ; send hotkey when native function is blocked and inventory is disabled
    {
        if(RegExMatch(A_ThisHotKey, "\w{2}") != 0) ; Function keys F1~F12
        SendInput, % "{" . RegExReplace(A_ThisHotKey, "[$<>]", "") . "}"
    else ; Combined keys ex: ALT+T
        Send, % RegExReplace(A_ThisHotKey, "[$<>]", "")
}
return

;Setting
ShowHideMain:
    GUIShow := !GUIShow
    if (GUIShow)
        Gui, Show, w380 h260
    else
        Gui, Hide
return

ShowHideOverlay:
    OverlayShow := !OverlayShow
    if (OverlayShow)
        Gui, 3: Show, x0 y0
    else
        Gui, 3: Hide
return

;Common
$~Enter::
    if(GetGuiValue("1", "DisableAll"))
    {
        inventory := False
        QuickCast := False
        QuickCall := False
        NoMouse := False
        ;GuiControl, 3: Text, ActiveNoMouse  , % "No Mouse: " ((NoMouse) ? ("Enabled") : ("Disabled"))
        ;GuiControl, 3: Text, ActiveQuickCast, % "Auto Cast: " ((QuickCast) ? ("Enabled") : ("Disabled"))
        ;GuiControl, 3: Text, ActiveQuickCall, % "Quick Call: " ((QuickCall) ? ("Enabled") : ("Disabled"))
        GuiControl, 3: Text, ActiveInventory, % "Inventory: " ((inventory) ? ("Enabled") : ("Disabled"))
    }
return

GuiClose:
2GuiClose:
GuiEscape:
2GuiEscape:
    Gui, %A_Gui%:Hide
    ToolTip
return

;$~!r::reload

$!esc::ExitApp