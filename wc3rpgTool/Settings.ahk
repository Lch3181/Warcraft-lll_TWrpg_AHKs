#Requires AutoHotkey v2.0

class Settings {
    tabName := "SettingsTab"
    hotkeys := [Gui.Text]
    checkboxes := [Gui.CheckBox]

    __New(MainGui, Tab) {
        ; init tab
        Tab.UseTab("Settings")

        ; enable tool after load
        enableToolAfterLoadCheckbox := MainGui.AddCheckbox("xs y+20 Section venableToolAfterLoad -TabStop", "Enable Tool After Loading Savefile")

        ; summon bag after load
        summonBagAfterLoadCheckbox := MainGui.AddCheckbox("xs y+20 Section vsummonBagAfterLoad -TabStop", "Summon bag After Loading Savefile")

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
            enableToolAfterLoadCheckbox,
            summonBagAfterLoadCheckbox,
            hideMainCheckbox,
            hideOverlayCheckbox
        ]

        for checkbox in this.checkboxes {
            checkbox.OnEvent("Click", onClickCheckbox)
            checkbox.Value := IniRead(iniFileName, this.tabName, checkbox.Name, false)
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
            IniWrite(Button.Value, iniFileName, this.tabName, Button.Name)
        }
    }
}