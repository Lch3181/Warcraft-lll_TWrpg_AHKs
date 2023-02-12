#Requires AutoHotkey v2.0
#Include Helper.ahk
#Include LoaderTab.ahk
#Include MapTab.ahk

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
Tab := MainGui.AddTab3("W580 H580 Choose1", ["Loader", "Tool", "Host", "Map", "Settings"])
LoaderTab(MainGui, Tab)
MapTab(MainGui, Tab)
MainGui.Show("W600 H600")