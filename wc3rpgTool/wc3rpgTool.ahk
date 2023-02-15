#Requires AutoHotkey v2.0
#Include Helper.ahk
#Include LoaderTab.ahk
#Include MapTab.ahk
#Include ToolTab.ahk
#Include HostTab.ahk
#Include overlay.ahk
#Include Settings.ahk

toolEnabled := true
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
Tab := MainGui.AddTab3("x0 y0 W580 H580 -Theme Choose1", ["Loader", "Tool", "Host", "Map", "Settings"])
LoaderTab(MainGui, Tab)
tool := ToolTab(MainGui, Tab)
HostTab(MainGui, Tab)
MapTab(MainGui, Tab)
Settings(MainGui, Tab)
ol := Overlay()
if !IniRead(iniFileName, "Settings", "hideMain", false) {
    MainGui.Show("W580 H580")
    showMainGui := true
}

MainGui.OnEvent("Close", onCloseGui)

; events
onCloseGui(GuiObj) {
    global showMainGui := false
}

; common hotkeys
; show hide main gui
$~f8::
{
    global
    showMainGui := !showMainGui
    if showMainGui {
        MainGui.Show("W580 H580")
    } else {
        MainGui.Hide()
    }
}

; show hide overlay
$~f7::
{
    global
    showOverlay := !showOverlay
    if showOverlay {
        ol.overlayGui.Show()
    } else {
        ol.overlayGui.Hide()
    }
}

; exit app alt+esc
$!esc:: ExitApp

; wc3 hotkeys
#HotIf WinActive(WarcraftIII)
; toggle tool
$~f2::
$~f10::
$~+Enter::    ; Shift Enter
$~NumpadEnter::    ; numpad Enter
$~Enter::    ; Regular Enter
{
    global
    toolEnabled := !toolEnabled
    ol.updateText()
    tool.registerHotkeys()
}

; pause game
$~Pause::
{
    SendInput("{f10}{m}{f10}")
}

; enable tool If chatting was canceled
$~LButton::    ; Left Click - Might be problematic if user clicks in UI area instead of play area
$~Esc::    ; Escape
{
    global
    toolEnabled := true
    ol.updateText()
    tool.registerHotkeys()
}
#HotIf