#SingleInstance, Force
#MaxThreadsPerHotKey 2
FileEncoding UTF-8
SendMode Input
SetWorkingDir, %A_ScriptDir%
SetTitleMatchMode 2
DetectHiddenWindows, On
Thread, interrupt, 0
global version := 4.42
global iniFile := "wc3rpgLoaderData.ini"
global KeyWaiting := False
global GUIShow := False
global OverlayShow := False
global WC3Chating := False
global SettingsHistory := []
global Tools := False
;force run as admin
if not A_IsAdmin
    Run *RunAs "%A_ScriptFullPath%"
;Includes the specified file inside the compiled version of the script.
FileCreateDir, Images
FileInstall, Images\SearchIcon.png, Images\SearchIcon.png
FileInstall, Images\Inventory.jpg, Images\Inventory.jpg
FileInstall, Images\Spells.jpg, Images\Spells.jpg

;fill up missing data if first run
initial()
;GUI
;-------------------------------------------Loader Tab---------------------------------------------------
Gui, Color, DCDCDC
Gui, Add, Tab3, x0 y20 w380 h240 vSubLoader, TWrpg
;--------------- For TWRPG ---------------
Gui, Tab, TWRPG
Gui, Add, Text, x20 y50, Hero:
Gui, Add, DropDownList, y+5 w340 R20 vHeroChoice
Gui, Add, Checkbox, y+10 vConvertToggle gGetSetCheckBoxValue, -Convert for Warcraft III Reforged
Gui, Add, Button, x20 y+10 w150 h30 gtwrpg +Default, Load
Gui, Add, Button, x+20 w170 h30 gHerosEditorButton, Add/Edit/Delete
Gui, Add, Text, x20 y+10 , TWRPG Folder:
Gui, Add, Edit, x20 y+10 w310 h30 R1 vTWrpgFolderAddress ReadOnly, % IniRead("Address", "TWrpgFolder")
Gui, Add, Picture, x+10 w20 h20 vTWrpgFolder gGetSetFolder, Images\SearchIcon.png
Gui, Add, Button, x20 y+10 w150 h30 gScanSaveFiles, Scan Save Files
;-------------------------------------------Tools Tab-------------------------------------------------------
Gui, Color, DCDCDC
Gui, Add, Tab3, x0 y20 w380 h240 vSubTool, Inventory|QuickCast|Probe|NoMouse|
;--------------- For Inventory ---------------
Gui, Tab, Inventory
Gui, Add, Picture, x20 y50 Icon , Images\Inventory.jpg
Gui, Font, s12
Gui, Add, Text, x+10 y50 , Enable
Gui, Add, Text, y+20 , CheckBox above button for `nQuick Cast
Gui, Font, s8
Gui, Add, Checkbox, x225 y55 w13 h13 gGetSetCheckBoxValue vInventoryToggle
Gui, Add, Button, x29 y90 w50 h20 gGetSetKey vNumpad7
Gui, Add, Button, x+21 w50 h20 gGetSetKey vNumpad8
Gui, Add, Button, x29 y+50 w50 h20 gGetSetKey vNumpad4
Gui, Add, Button, x+21 w50 h20 gGetSetKey vNumpad5
Gui, Add, Button, x29 y+50 w50 h20 gGetSetKey vNumpad1
Gui, Add, Button, x+21 w50 h20 gGetSetKey vNumpad2
Gui, Add, CheckBox, x47 y70 w13 h13 gGetSetCheckBoxValue vNumpad7QuickCast
Gui, Add, CheckBox, x+58 w13 h13 gGetSetCheckBoxValue vNumpad8QuickCast
Gui, Add, CheckBox, x47 y+56 w13 h13 gGetSetCheckBoxValue vNumpad4QuickCast
Gui, Add, CheckBox, x+58 w13 h13 gGetSetCheckBoxValue vNumpad5QuickCast
Gui, Add, CheckBox, x47 y+56 w13 h13 gGetSetCheckBoxValue vNumpad1QuickCast
Gui, Add, CheckBox, x+58 w13 h13 gGetSetCheckBoxValue vNumpad2QuickCast
;--------------- For Quick Cast ---------------
Gui, Tab, QuickCast
Gui, Add, Picture, x20 y50 Icon , Images\Spells.jpg
Gui, Font, s12
Gui, Add, Text, x+10 y50 , Enable
Gui, Font, s8
Gui, Add, Checkbox, x350 y55 w13 h13 gGetSetCheckBoxValue vQuickCastToggle
Gui, Add, Button, x31 y92 w50 h20 gGetSetKey vQuickCast1
Gui, Add, Button, x+14 w50 h20 gGetSetKey vQuickCast2
Gui, Add, Button, x+13 w50 h20 gGetSetKey vQuickCast3
Gui, Add, Button, x+14 w50 h20 gGetSetKey vQuickCast4
Gui, Add, Button, x31 y+43 w50 h20 gGetSetKey vQuickCast5
Gui, Add, Button, x+14 w50 h20 gGetSetKey vQuickCast6
Gui, Add, Button, x+13 w50 h20 gGetSetKey vQuickCast7
Gui, Add, Button, x+14 w50 h20 gGetSetKey vQuickCast8
Gui, Add, Button, x31 y+43 w50 h20 gGetSetKey vQuickCast9 
Gui, Add, Button, x+14 w50 h20 gGetSetKey vQuickCast10
Gui, Add, Button, x+13 w50 h20 gGetSetKey vQuickCast11
Gui, Add, Button, x+14 w50 h20 gGetSetKey vQuickCast12
;----------------- For Probes -----------------
Gui, Tab, Probe
Gui, Add, Picture, x20 y60 Icon , Images\Chaika.png
Gui, Add, Picture, x+20 y90 w50 h50 Icon , Images\Probe.png
Gui, Add, Picture, x+10 w50 h50 Icon , Images\Probe.png
Gui, Add, Picture, x+10 w50 h50 Icon , Images\Probe.png
Gui, Font, s12
Gui, Add, Text, x170 y60 , Enable
Gui, Font, s8
Gui, Add, Checkbox, x+10 y65 w13 h13 gGetSetCheckBoxValue vProbeToggle
Gui, Add, Button, x165 y140 w50 h20 gGetSetKey vProbe1
Gui, Add, Button, x+13 w50 h20 gGetSetKey vProbe2
Gui, Add, Button, x+13 w50 h20 gGetSetKey vProbe3
;---------------- For No Mouse -----------------
Gui, Tab, NoMouse
Gui, Add, Picture, w150 h150 y+20 Icon , Images\Mouse.png
Gui, Font, s12
Gui, Add, Text, x170 y60 , Enable
Gui, Font, s8
Gui, Add, Checkbox, x+10 y65 w13 h13 gGetSetCheckBoxValue vNoMouseToggle
Gui, Add, Button, x28 y80 w50 h20 gGetSetKey vNoMouse1
Gui, Add, Button, x+18 w50 h20 gGetSetKey vNoMouse2

GuiControl, Hide, SubTool
;-------------------------------------------Setting Tab-------------------------------------------------------
Gui, Color, DCDCDC
Gui, Add, Tab3, x0 y20 w380 h240 vSubSetting, Settings|Hotkeys
;--------------- For Settings ---------------
Gui, Tab, Settings
Gui, Font, s12
Gui, Add, Text, x10 y50, Disable All during chat (wc3 only)
Gui, Add, Text, y+0, Drop powders at start
Gui, Add, Text, y+0, Disable Hotkeys' Native Functions
Gui, Add, Text, y+0, Ex: Alt+q or space if assigned
Gui, Add, Text, y+0, Hide GUI on start
Gui, Add, Text, y+0, Hide Overlay on start
Gui, Add, Text, y+0, % "Newest version:`t`t`t`t " . GetNewVersionTag()
Gui, Font, s8
Gui, Add, Checkbox, x300 y55 gGetSetCheckBoxValue vDisableAll
Gui, Add, Checkbox, y+5 gGetSetCheckBoxValue vDropPowders
Gui, Add, Checkbox, y+25 gGetSetCheckBoxValue vDisableAllNativeFunctions
Gui, Add, Checkbox, y+5 gGetSetCheckBoxValue vHideGuiOnStart
Gui, Add, Checkbox, y+5 gGetSetCheckBoxValue vHideOverlayOnStart
;--------------- For Hotkeys ---------------
Gui, Tab, Hotkeys
Gui, Font, s12
Gui, Add, Text, x10 y50, Tools Enable/Disable
Gui, Add, Text, y+0, Show/Hide
Gui, Add, Text, y+0, Overlay Show/Hide
Gui, Add, Text, y+0, Pause Game
Gui, Add, Text, y+0, Unsign Hotkey
Gui, Add, Text, y+0, Exit
Gui, Font, s8
Gui, Add, Button, x300 y50 w70 h20 gGetSetKey vToolToggle
Gui, Add, Button, y+0 w70 h20 gGetSetKey vShowHideMain
Gui, Add, Button, y+0 w70 h20 gGetSetKey vShowHideOverlay
Gui, Add, Button, y+0 w70 h20 gGetSetKey vPauseGame
Gui, Add, Button, y+0 w70 h20 disabled, Right Click
Gui, Add, Button, y+0 w70 h20 disabled, Alt+ESC

GuiControl, Hide, SubSetting
;-------------------------------------------Main Tab-------------------------------------------------------
Gui, Add, Tab2, x0 y0 w380 h260 gTabSwitched vMainTab, Loader|Host|Tools|Settings
;---- For Hosting
Gui, Tab, Host
Gui, Add, Text, x20 y30 , Pick:
Gui, Add, ComboBox, y+5 w100 R10 vBotChoice gOnSelectBot
Gui, Add, Checkbox, x+10 vGameAnnounceToggle gGetSetCheckBoxValue, Announce Game Lobby Enable/Disable
Gui, Add, Text, x20 y+20 , Map Load Command:
Gui, Add, Edit, y+5 w100 h20 vBotCommand
Gui, Add, Checkbox, x+10 vBotCommandToggle gGetSetCheckBoxValue, Enable/Disable
Gui, Add, Text, x20 y+20 , Game Name:
Gui, Add, Edit, y+5 w100 h20 vGN
Gui, Add, Checkbox, x+10 vGameNamePlusToggle gGetSetCheckBoxValue, Game Name + 1 Enable/Disable
Gui, Add, Button, x20 y+30 w100 h30 gPriv, Private
Gui, Add, Button, x+20 w100 h30 gPub, Public
Gui, Add, Button, x+20 w100 h30 gDeleteBot, Delete Bot History
;-----------------------------------------Hero Editor-------------------------------------------------------
Gui, 2: Color, DCDCDC
Gui, 2: Add, Text, x10 y10, Hero:
Gui, 2: Add, ComboBox, y+5 w340 R20 vHeroChoice gOnSelectHero
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
Gui, 3: Add, Text, vActiveTool x0 y0 , % "Tools: " ((Tools) ? ("Enabled") : ("Disabled"))
Gui, 3: Color, EEAA99
WinSet, TransColor, EEAA99

;GetSetAll
GetSetLoader()
GetSetHost()
GetSetHeros()
GetSetBots()
GetSetInventories()
GetSetSettings()
GetSetQuickCast()
GetSetProbe()
GetSetNoMouse()

;Show Gui on Start
GUIShow := GetGuiValue("1", "HideGuiOnStart")
OverlayShow := GetGuiValue("1", "HideOverlayOnStart")

Gosub, ShowHideMain
Gosub, ShowHideOverlay
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
    {
        ToolTip("Downloading Save File From Cloud Service")
        code := DownloadFileFromUrl(IniRead("TWrpgHeros", GetGuiValue(A_Gui,"HeroChoice")))
    }

    if not ErrorLevel{
        ;Close Gui
        Gui, Cancel
        Gui, Submit
        GUIShow := False

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
        sleep 1500
        tw_skills()
    }
    else
    {
        ;Error Page
        if(InStr(result, "<html>"))
            Run, %URL%
        MsgBox, "File Does Not Exist"
    }

    ;update ini file
    IniWrite, %ConvertToggle%, %iniFile%, Settings, ConvertToggle
Return
;----------------------------------------------------------------------------------
tw_skills(){
    SendInput, {Esc 2}{F1 2}
    if(GetGuiValue("1", "DropPowders"))
        Sleep, 500
    Else
        Sleep, 50
    SendInput, {Ctrl down}{1}{9}{0}{Ctrl up}
    ; drop powders at start
    if(GetGuiValue("1", "DropPowders"))
    {
        SendMode, Event
        WinGetPos, , , Width, Height, Warcraft III
        MouseClickDrag, Left, % Width * 0.45, % Height * 0.35, % Width * 0.55, % Height * 0.55, 1
        SendInput, {Tab}
        Sleep, 100
        SendInput, {e}
        Sleep, 100
        SendInput, {e}{9}{0}
        SendMode, Input
    }
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
    GUIShow := False
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
    if(GameAnnounceToggle){
        WC3Chat("Game Name: "GN)
    }
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
    GUIShow := False
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
    if(GameAnnounceToggle){
        WC3Chat("Game Name: "GN)
    }
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
    GuiControl, Hide, SubLoader
    GuiControl, Hide, SubTool
    GuiControl, Hide, SubSetting

    if(MainTab = "Loader")
        GuiControl, Show, SubLoader
    else if(MainTab = "Tools")
        GuiControl, Show, SubTool
    else if(MainTab = "Settings")
        GuiControl, Show, SubSetting

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
    Gui, 2:Show, AutoSize, TWrpg Heroes Editor
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
    ; temporary disable hotkey
    currentTab=
    if(MainTab = "Tools")
        currentTab := SubTool
    else
        currentTab := MainTab

    OrginalKey := IniRead(currentTab, A_GuiControl)
    if(OrginalKey != "")
    {
        if(!InStr(A_GuiControl, "Toggle"))
            Hotkey, IfWinActive, Warcraft III

        Hotkey, %OrginalKey%, %A_GuiControl%, Off
    }

    ToolTip("Please assign a key to "A_GuiControl, -999999)
    ; Wait a key press
    input := % KeyWaitAny("V E C M")
    if(input = -1) ;still waiting key to assign for previous button
    {
        GuiControl,, %A_GuiControl%, % GetHotkeyName(IniRead(currentTab, A_GuiControl)) ;update gui
        ToolTip("Please finish assigning previous button or right click it to unsign that button")
        return
    }
    if(input = "$Escape") ; escape key to cancel
    {
        GuiControl,, %A_GuiControl%, % GetHotkeyName(IniRead(currentTab, A_GuiControl)) ;update gui
        ToolTip("Canceled")
        return
    }
    if(InStr(A_GuiControl, "Probe")) && (RegExMatch(input, "\W+[1-8]") = 0 && input != "") ; probes only can assign with numbers
    {
        GuiControl,, %A_GuiControl%, % GetHotkeyName(IniRead(currentTab, A_GuiControl)) ;update gui
        ToolTip("Probes only can assign with numbers 1-8")
        return
    }
    if(InStr(GetHotkeys(), input) && input != "") ;check duplication
    {
        ToolTip(GetHotkeyName(input) . " is used ")
        ; re-enable hotkey
        if(OrginalKey != "")
            Hotkey, % OrginalKey, %A_GuiControl%, On
    }
    else
    {
        ;update ini file
        IniWrite, %input%, %IniFile%, %currentTab%, %A_GuiControl%
        ;refresh
        GetSetInventories()
        GetSetSettings()
        GetSetQuickCast()
        GetSetProbe()
        GetSetNoMouse()
        ToolTip(GetHotkeyName(IniRead(currentTab, A_GuiControl)) . " Assigned to " . A_GuiControl)
    }
return

GetSetCheckBoxValue:
    Gui, Submit, Nohide
    if(MainTab = "Tools")
        IniWrite, % GetGuiValue(A_Gui, A_GuiControl), %iniFile%, %SubTool%, %A_GuiControl%
    Else
        IniWrite, % GetGuiValue(A_Gui, A_GuiControl), %iniFile%, %MainTab%, %A_GuiControl%
return

; right click any gui
GuiContextMenu:
    Gui, Submit, Nohide
    ; unsign hotkey
    if(InStr(GetHotkeys(), GetGuiValue("1", A_GuiControl)) && (GetGuiValue("1", A_GuiControl) != "")) ; filter gui with ini data only
    {
        ; if gui contains a hotkey
        currentTab=
        if(MainTab = "Tools" && InStr(IniRead(SubTool, A_GuiControl), "$"))
            currentTab := SubTool
        Else
            currentTab := MainTab

        if(InStr(IniRead(currentTab, A_GuiControl), "$"))
        {
            GuiControl,, A_GuiControl, % ""
            Hotkey, % IniRead(currentTab, A_GuiControl), %A_GuiControl%, Off ; disable hotkey
            IniWrite, % "", %IniFile%, %currentTab%, %A_GuiControl% ;update ini file
            ;refresh
            GetSetInventories()
            GetSetSettings()
            GetSetQuickCast()
            GetSetProbe()
            GetSetNoMouse()
            ToolTip(A_GuiControl . " unsigned")
        }
    }
Return

;------------------------------------Functions-------------------------------------
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
    if(clientVersion < 2.2) ; 2.2 bug fix, add pause
    {
        IniWrite, % "", %iniFile%, Inventory, Numpad2
        IniWrite, $Pause, %iniFile%, Settings, PauseGame
    }
    if(clientVersion < 2.3) ; 2.3 changed autocast to quickcast
    {
        IniDelete, %iniFile%, Inventory, Numpad1AutoCast
        IniDelete, %iniFile%, Inventory, Numpad2AutoCast
        IniDelete, %iniFile%, Inventory, Numpad4AutoCast
        IniDelete, %iniFile%, Inventory, Numpad5AutoCast
        IniDelete, %iniFile%, Inventory, Numpad7AutoCast
        IniDelete, %iniFile%, Inventory, Numpad8AutoCast
    }
    if(clientVersion < 3.0) ; 3.0 add quick cast
    {
        IniWrite, $F3, %iniFile%, QuickCast, QuickCastToggle
        IniWrite, $~6, %iniFile%, QuickCast, ProbeQuickCast1
        IniWrite, $~7, %iniFile%, QuickCast, ProbeQuickCast2
        IniWrite, $~8, %iniFile%, QuickCast, ProbeQuickCast3
        IniWrite, $~a, %iniFile%, QuickCast, QuickCast1
        IniWrite, $~p, %iniFile%, QuickCast, QuickCast2
        IniWrite, $~d, %iniFile%, QuickCast, QuickCast3
        IniWrite, $~t, %iniFile%, QuickCast, QuickCast4
        IniWrite, $~f, %iniFile%, QuickCast, QuickCast5
        IniWrite, $~q, %iniFile%, QuickCast, QuickCast6
        IniWrite, $~w, %iniFile%, QuickCast, QuickCast7
        IniWrite, $~e, %iniFile%, QuickCast, QuickCast8
        IniWrite, $~r, %iniFile%, QuickCast, QuickCast9
    }
    if(clientVersion < 3.5) ; 3.5 I missed a few data to save
    {
        IniWrite, 1, %iniFile%, Loader, ConvertToggle
        IniWrite, 1, %iniFile%, Host, BotCommandToggle
        IniWrite, 1, %iniFile%, Host, GameNamePlusToggle
    }
    if(clientVersion < 4.1) ; 4.1 Add hide gui and overlay settings on start
    {
        IniWrite, 0, %iniFile%, Settings, HideGuiOnStart
        IniWrite, 0, %iniFile%, Settings, HideOverlayOnStart
    }
    if(clientVersion < 4.13) ; 4.13 add announce game lobby in chat option
    {
        IniWrite, 1, %iniFile%, Host, GameAnnounceToggle
    }
    if(clientVersion < 4.15) ; 4.15 combine inventory and quickcast to Tools
    {
        IniWrite, 1, %iniFile%, Inventory, InventoryToggle
        IniWrite, 1, %iniFile%, QuickCast, QuickCastToggle
        IniWrite, $F2, %iniFile%, Settings, ToolToggle
    }
    if(clientVersion < 4.2) ; 4.2 moved probes quickcast now has an independent tab
    {
        IniDelete, %iniFile%, QuickCast, ProbeQuickCast1
        IniDelete, %iniFile%, QuickCast, ProbeQuickCast2
        IniDelete, %iniFile%, QuickCast, ProbeQuickCast3
        IniWrite, 0, %iniFile%, Probe, ProbeToggle
        IniWrite, $~6, %iniFile%, Probe, Probe1
        IniWrite, $~7, %iniFile%, Probe, Probe2
        IniWrite, % "", %iniFile%, Probe, Probe3
        IniWrite, $~m, %iniFile%, QuickCast, QuickCast1
        IniWrite, % "", %iniFile%, QuickCast, QuickCast2
        IniWrite, % "", %iniFile%, QuickCast, QuickCast3
        IniWrite, $~a, %iniFile%, QuickCast, QuickCast4
        IniWrite, $~p, %iniFile%, QuickCast, QuickCast5
        IniWrite, $~d, %iniFile%, QuickCast, QuickCast6
        IniWrite, $~t, %iniFile%, QuickCast, QuickCast7
        IniWrite, $~f, %iniFile%, QuickCast, QuickCast8
        IniWrite, $~q, %iniFile%, QuickCast, QuickCast9
        IniWrite, $~w, %iniFile%, QuickCast, QuickCast10
        IniWrite, $~e, %iniFile%, QuickCast, QuickCast11
        IniWrite, $~r, %iniFile%, QuickCast, QuickCast12
    }
    if(clientVersion < 4.3) ; 4.3 add No Mouse
    {
        IniWrite, 0, %iniFile%, NoMouse, NoMouseToggle
        IniWrite, % "", %iniFile%, NoMouse, NoMouse1
        IniWrite, % "", %iniFile%, NoMouse, NoMouse2
    }
    if(clientVersion < 4.4) ; 4.4 added drop powders at start
    {
        IniWrite, 0, %iniFile%, Settings, DropPowders
    }
    IniWrite, %version%, %iniFile%, Settings, Version ; update client version
}

GetSetLoader()
{
    OutputVar := IniRead("Loader") ;get all lines in section
    lines := StrSplit(OutputVar, "`n") ;split by newline
    Loop % lines.MaxIndex()
    {
        keyValue := StrSplit(lines[A_Index], "=") ; split line to key and value
        GuiControl, 1:, % keyValue[1] , % GetHotkeyName(keyValue[2]) ; update gui
    }
}

GetSetHost()
{
    OutputVar := IniRead("Host") ;get all lines in section
    lines := StrSplit(OutputVar, "`n") ;split by newline
    Loop % lines.MaxIndex()
    {
        keyValue := StrSplit(lines[A_Index], "=") ; split line to key and value
        GuiControl, 1:, % keyValue[1] , % GetHotkeyName(keyValue[2]) ; update gui
    }
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
        if(keyValue[2] != "") && (InStr(keyValue[1], "ShowHide") || InStr(keyValue[1], "PauseGame") || InStr(keyValue[1], "ToolToggle"))
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
        if(keyValue[2] != "" && !InStr(keyValue[1], "QuickCast") && (!InStr(keyValue[1], "Toggle")))
        {
            Hotkey, IfWinActive, Warcraft III
                Hotkey, % keyValue[2], % keyValue[1], On
        }
        Hotkey, IfWinActive ; end if wc3 for hotkeys

    }
}

GetSetQuickCast()
{
    OutputVar := IniRead("QuickCast") ;get all lines in section
    lines := StrSplit(OutputVar, "`n") ;split by newline
    Loop % lines.MaxIndex()
    {
        keyValue := StrSplit(lines[A_Index], "=") ; split line to key and value
        GuiControl, 1:, % keyValue[1] , % GetHotkeyName(keyValue[2]) ; update gui
        ; assign hotkeys to labels
        if(keyValue[2] != "" && (!InStr(keyValue[1], "Toggle")))
        {
            Hotkey, IfWinActive, Warcraft III
                Hotkey, % keyValue[2], % keyValue[1], On
        }
        Hotkey, IfWinActive ; end if wc3 for hotkeys

    }
}

GetSetProbe()
{
    OutputVar := IniRead("Probe") ;get all lines in section
    lines := StrSplit(OutputVar, "`n") ;split by newline
    Loop % lines.MaxIndex()
    {
        keyValue := StrSplit(lines[A_Index], "=") ; split line to key and value
        GuiControl, 1:, % keyValue[1] , % GetHotkeyName(keyValue[2]) ; update gui
        ; assign hotkeys to labels
        if(keyValue[2] != "" && (!InStr(keyValue[1], "Toggle")))
        {
            Hotkey, IfWinActive, Warcraft III
                Hotkey, % keyValue[2], % keyValue[1], On
        }
        Hotkey, IfWinActive ; end if wc3 for hotkeys

    }
}

GetSetNoMouse()
{
    OutputVar := IniRead("NoMouse") ;get all lines in section
    lines := StrSplit(OutputVar, "`n") ;split by newline
    Loop % lines.MaxIndex()
    {
        keyValue := StrSplit(lines[A_Index], "=") ; split line to key and value
        GuiControl, 1:, % keyValue[1] , % GetHotkeyName(keyValue[2]) ; update gui
        ; assign hotkeys to labels
        if(keyValue[2] != "" && (!InStr(keyValue[1], "Toggle")))
        {
            Hotkey, IfWinActive, Warcraft III
                Hotkey, % keyValue[2], % keyValue[1], On
        }
        Hotkey, IfWinActive ; end if wc3 for hotkeys

    }
}

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
return Value
}

DownloadFileFromUrl(URL)
{
    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    whr.Open("GET", URL, false)
    whr.Send()

    arr := whr.ResponseBody
    pData := NumGet(ComObjValue(arr) + 8 + A_PtrSize)
    length := arr.MaxIndex() + 1
    result := StrGet(pData, length, "utf-8")
return result
}

WC3Chat(String)
{
    SendInput, {Enter}
    SendInput, {Text}%String%
    SendInput, {Enter}
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
        if(ih.EndMods != "" || RegExMatch(ih.EndKey, "\w{2}") > 0) ; disable key native function for combined hotkeys and function keys
        {
            return "$" . ih.EndMods . ih.EndKey
        }
        else ; send key include the hotkey
            return "$~" . ih.EndMods . ih.EndKey
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
    HotkeyNames := [["+","Shift+"], ["<^>!","AltGr+"], ["<","L"], [">","R"], ["!","Alt+"], ["^","Ctrl+"], ["#","Win+"], ["$",""], ["~",""], ["Pause", "Pause/Break"]]
    for key, value in HotkeyNames
    {
        Hotkey := StrReplace(Hotkey, value[1], value[2])
    }
return Hotkey
}

GetNewVersionTag()
{
    result := DownloadFileFromUrl("https://github.com/Lch3181/Warcraft-lll_TWrpg_AHKs/tags")
    RegExMatch(result, "tag\/([\W\d]+)"">", match)
return match1
}

;Tools
ToolToggle:
    Tools := !Tools ; toggle Tools
    Gui, Submit, Nohide
    GuiControl, 3: Text, ActiveTool, % "Tools: " ((Tools) ? ("Enabled") : ("Disabled")) ;update GUI
return

;Inventory
Numpad7:
Numpad2:
Numpad1:
Numpad5:
Numpad4:
Numpad8:
    if(Tools && InventoryToggle)
        SendInput, {%A_ThisLabel%}
    if(Tools && InventoryToggle && GetGuiValue("1", A_ThisLabel . "QuickCast") = 1)
    {
        SendInput, {CtrlDown}{9}{0}{CtrlUp}
        MouseClick, Left
        SendInput, {9}{0}
    }
    else if (!GetGuiValue("1", "DisableAllNativeFunctions") && !Tools && !InStr(A_ThisHotKey, "~")) ; send hotkey when native function is blocked and inventory is disabled
    {
        if(RegExMatch(A_ThisHotKey, "\w{2}") != 0 || InStr(A_ThisHotkey, "space") != 0) ; Function keys F1~F12 or space
            SendInput, % "{" . RegExReplace(A_ThisHotKey, "[$<>]", "") . "}"
        else ; Combined keys ex: ALT+T
            Send, % RegExReplace(A_ThisHotKey, "[$<>]", "")
    }
return

;QuickCast
QuickCast1:
QuickCast2:
QuickCast3:
QuickCast4:
QuickCast5:
QuickCast6:
QuickCast7:
QuickCast8:
QuickCast9:
QuickCast10:
QuickCast11:
QuickCast12:
    if(Tools && QuickCastToggle)
    {
        SendInput, {CtrlDown}{9}{0}{CtrlUp}
        MouseClick, Left
        SendInput, {9}{0}
    }
Return

;Probes
Probe1:
Probe2:
Probe3:
    if(Tools && ProbeToggle)
    {
        MouseClick, Right
        SendInput, {9}{0}
    }
    else if (!GetGuiValue("1", "DisableAllNativeFunctions") && !Tools && !InStr(A_ThisHotKey, "~")) ; send hotkey when native function is blocked and inventory is disabled
    {
        if(RegExMatch(A_ThisHotKey, "\w{2}") != 0 || InStr(A_ThisHotkey, "space") != 0) ; Function keys F1~F12 or space
            SendInput, % "{" . RegExReplace(A_ThisHotKey, "[$<>]", "") . "}"
        else ; Combined keys ex: ALT+T
            Send, % RegExReplace(A_ThisHotKey, "[$<>]", "")
    }
Return

;No Mouse
NoMouse1:
    if(Tools && NoMouseToggle)
    {
        MouseClick, Left
    }
    else if (!GetGuiValue("1", "DisableAllNativeFunctions") && !InStr(A_ThisHotKey, "~")) && (!Tools || !NoMouseToggle) ; send hotkey when native function is blocked and inventory is disabled
    {
        if(RegExMatch(A_ThisHotKey, "\w{2}") != 0 || InStr(A_ThisHotkey, "space") != 0) ; Function keys F1~F12 or space
            SendInput, % "{" . RegExReplace(A_ThisHotKey, "[$<>]", "") . "}"
        else ; Combined keys ex: ALT+T
            Send, % RegExReplace(A_ThisHotKey, "[$<>]", "")
    }
return
NoMouse2:
    if(Tools && NoMouseToggle)
    {
        MouseClick, Right
    }
    else if (!GetGuiValue("1", "DisableAllNativeFunctions") && !InStr(A_ThisHotKey, "~")) ; send hotkey when native function is blocked and inventory is disabled
    {
        if(RegExMatch(A_ThisHotKey, "\w{2}") != 0 || InStr(A_ThisHotkey, "space") != 0) ; Function keys F1~F12 or space
            SendInput, % "{" . RegExReplace(A_ThisHotKey, "[$<>]", "") . "}"
        else ; Combined keys ex: ALT+T
            Send, % RegExReplace(A_ThisHotKey, "[$<>]", "")
    }
return

;Setting
ShowHideMain:
    GUIShow := !GUIShow
    if (GUIShow)
        Gui, Show, w380 h260, wc3 rpg Tools v%version%
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

PauseGame:
    if(WinActive("Warcraft III"))
        SendInput, {F10}{M}{F10}
return

disableCastsOnChatting(){
    WC3Chating := True
    SettingsHistory := [Tools]
    Tools := False
    GuiControl, 3: Text, ActiveTool, % "Tools: " ((Tools) ? ("Enabled") : ("Disabled"))
}

enableCastsAfterChatting(){
    WC3Chating := False
    Tools := SettingsHistory[1]
    GuiControl, 3: Text, ActiveTool, % "Tools: " ((Tools) ? ("Enabled") : ("Disabled"))
}

;Common
#IfWinActive, Warcraft III ; set hotkey only work for wc3
$~+Enter:: ; Shift Enter
$~NumpadEnter:: ; numpad Enter
$~Enter:: ; Regular Enter
    if(GetGuiValue("1", "DisableAll") && WC3Chating = False)
    {
        disableCastsOnChatting()
    }
    else if(GetGuiValue("1", "DisableAll") && WC3Chating = True)
    {
        enableCastsAfterChatting()
    }
return

; If chatting was canceled
$~LButton:: ; Left Click - Might be problematic if user clicks in UI area instead of play area
$~Esc:: ; Escape
    if(GetGuiValue("1", "DisableAll") && WC3Chating = True)
    {
        enableCastsAfterChatting()
    }
return
#IfWinActive

GuiClose:
2GuiClose:
GuiEscape:
2GuiEscape:
    Gui, %A_Gui%:Hide
    GUIShow := False
    ToolTip
return

$!esc::ExitApp