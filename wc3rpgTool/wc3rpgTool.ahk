#Requires AutoHotkey v2.0
#Include Helper.ahk
#Include LoaderTab.ahk
#Include MapTab.ahk
#Include ToolTab.ahk
#Include overlay.ahk

toolEnabled := true

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
Tab := MainGui.AddTab3("x0 y0 W580 H580 -Theme Choose2", ["Loader", "Tool", "Host", "Map", "Settings"])
LoaderTab(MainGui, Tab)
tool := ToolTab(MainGui, Tab)
MapTab(MainGui, Tab)
ol := Overlay()
MainGui.Show("W580 H580")

; common hotkeys
#HotIf WinActive(WarcraftIII)
$~+Enter::    ; Shift Enter
$~NumpadEnter::    ; numpad Enter
$~Enter::    ; Regular Enter
{
    global
    toolEnabled := !toolEnabled
    ol.updateText()
    tool.registerHotkeys()
}

; If chatting was canceled
$~LButton::    ; Left Click - Might be problematic if user clicks in UI area instead of play area
$~Esc::    ; Escape
{
    global
    toolEnabled := true
    tool.registerHotkeys()
}
#HotIf WinActive("")

; exit app alt+esc
$!esc:: ExitApp