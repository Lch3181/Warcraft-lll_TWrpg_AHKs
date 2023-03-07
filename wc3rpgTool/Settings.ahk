#Requires AutoHotkey v2.0
#Include Helper.ahk

class Settings {
    hotkeys := [Gui.Text]
    checkboxes := [Gui.CheckBox]

    __New(MainGui, Tab) {
        ; init tab
        Tab.UseTab("Settings")

        ; show main window at start
        hideMainCheckbox := MainGui.AddCheckbox("xs y+20 Section vhideMain -TabStop", "Hide Main Window at Start")

        ; show overlay at start
        hideOverlayCheckbox := MainGui.AddCheckbox("xs y+20 Section vhideOverlay -TabStop", "Hide Overlay at Start")

        ; reset settings button
        resetButton := MainGui.AddButton("xs y+20 w120 h20 -TabStop", "Reset")
        resetButton.SetFont("s10 w500")
        resetButton.OnEvent("Click", onClickReset)
        MainGui.AddText("x+20 yp+2", "Initialize All Settings")

        ; var

        this.checkboxes := [
            hideMainCheckbox,
            hideOverlayCheckbox
        ]

        for checkbox in this.checkboxes {
            checkbox.OnEvent("Click", onClickCheckbox)
            checkbox.Value := IniRead(iniFileName, "Settings", checkbox.Name, false)
        }

        ; events
        onClickReset(Button, Info) {
            try {
                OutputDebug(A_ScriptDir "\" iniFileName)
                FileDelete(A_ScriptDir "\" iniFileName)
                Reload
            }
        }

        onClickCheckbox(Button, Info) {
            IniWrite(Button.Value, iniFileName, "Settings", Button.Name)
        }
    }
}