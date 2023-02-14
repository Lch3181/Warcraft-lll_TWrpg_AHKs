#Requires AutoHotkey v2.0
#Include Helper.ahk

class Settings {
    __New(MainGui, Tab) {
        ; init tab
        Tab.UseTab("Settings")

        ; toggle tool
        MainGui.AddHotkey("Section Disabled", "f2")
        MainGui.AddText("x+20 yp+2", "Toggle Tool On Off")

        ; show hide main gui hotkey
        MainGui.AddHotkey("xs y+20 Section Disabled", "f8")
        MainGui.AddText("x+20 yp+2", "Show / Hide Main Window")

        ; show hide overlay gui hotkey
        Maingui.AddHotkey("xs y+20 Section Disabled", "f7")
        MainGui.AddText("x+20 yp+2", "Show / Hide Overlay")

        ; reset settings button
        resetButton := MainGui.AddButton("xs y+20 w60", "reset")
        resetButton.OnEvent("Click", onClickReset)
        MainGui.AddText("x+20 yp+2", "initialize all settings")

        ; events
        onClickReset(Button, Info) {
            try {
                OutputDebug(A_ScriptDir "\" iniFileName)
                FileDelete(A_ScriptDir "\" iniFileName)
                Reload
            }
        }
    }
}