#Requires AutoHotkey v2.0
#Include Helper.ahk
#Include LoaderTab.ahk
#Include MapTab.ahk
#Include ToolTab.ahk
#Include HotStringTab.ahk
#Include HostTab.ahk
#Include overlay.ahk
#Include HotkeysTab.ahk
#Include Settings.ahk

ProcessSetPriority "High"
SetKeyDelay IniRead(iniFileName, "SettingsTab", "keyDelay", 10)

version := "v1.4.4"
toolEnabled := true
toolEnableHistory := true
chatting := false
showMainGui := false
showOverlay := false

;force run as admin
if not A_IsAdmin {
    try {
        if A_IsCompiled
            Run '*RunAs "' A_ScriptFullPath '" /restart'
        else
            Run '*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"'
    }
    ExitApp
}

;GUI
MainGui := Gui()
MainGui.Title := "wc3rpgTool " version
Tab3 := MainGui.AddTab3("x0 y0 W580 H580 -Theme -TabStop Choose1", ["Loader", "Tool", "Hotstring", "Host", "Map", "Hotkeys", "Settings"])
loader := LoaderTab(MainGui, Tab3)
tool := ToolTab(MainGui, Tab3)
hs := HotStringTab(MainGui, Tab3)
HostTab(MainGui, Tab3)
MapTab(MainGui, Tab3)
HotkeyTab(MainGui, Tab3)
Settings(MainGui, Tab3)
ol := Overlay()
if !IniRead(iniFileName, "SettingsTab", "enableToolonStartCheckbox", false) {
    toggleTool()
}
if !IniRead(iniFileName, "SettingsTab", "hideMainCheckbox", false) {
    MainGui.Show("W580 H580")
    showMainGui := true
}

MainGui.OnEvent("Close", onCloseGui)


; events
onCloseGui(GuiObj) {
    global showMainGui := false
}

; functions
toggleTool() {
    global
    toolEnabled := !toolEnabled
    ol.updateText()
    tool.updateHotkeys()
    hs.updateHotStrings()
}

showHideMainGui() {
    global
    showMainGui := !showMainGui
    if showMainGui {
        ; reload loader tab
        loader.updateFileList()
        Tab3.Choose("Loader")
        MainGui.Show("W580 H580")
    } else {
        MainGui.Hide()
    }
}

showHideOverlay() {
    global
    showOverlay := !showOverlay
    if showOverlay {
        ol.overlayGui.Show("x0 y0")
    } else {
        ol.overlayGui.Hide()
    }
}

pauseGame() {
    SendInput("{f10}{m}{f10}")
}

; common hotkeys
#HotIf WinActive(MainGui.Title)
; hide main gui
$~Esc::
{
    global
    showMainGui := false
    MainGui.Hide()

}
#HotIf

; exit app alt+esc
$!esc:: ExitApp

; wc3 hotkeys
#HotIf WinActive(WarcraftIII)
; toggle tool
$~f10::
{
    toggleTool()
}
$~+Enter::    ; Shift Enter
$~NumpadEnter::    ; numpad Enter
$~Enter::    ; Regular Enter
{
    global
    if !IniRead(iniFileName, "SettingsTab", "autoToggleToolCheckbox", false) {
        return
    }
    if !chatting {
        chatting := true
        toolEnableHistory := toolEnabled
        toolEnabled := false
    } else {
        chatting := false
        toolEnabled := toolEnableHistory
    }
    ol.updateText()
    tool.updateHotkeys()
    hs.updateHotStrings()
}

; enable tool If chatting was canceled
$~LButton::    ; Left Click - Might be problematic if user clicks in UI area instead of play area
$~Esc::    ; Escape
{
    global
    if chatting {
        chatting := false
        toolEnabled := toolEnableHistory
    }
    ol.updateText()
    tool.updateHotkeys()
    hs.updateHotStrings()
}
#HotIf