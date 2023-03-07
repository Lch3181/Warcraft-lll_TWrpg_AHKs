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

        
        ; check update button
        checkButton := MainGui.AddButton("xs y+20 w120 h20 -TabStop", "Check")
        checkButton.SetFont("s10 w500")
        checkButton.OnEvent("Click", onClickCheck)
        MainGui.AddText("x+20 yp+2", "Check updates")

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
        onClickCheck(Button, Info) {
            getNewestVersionTag()
        }

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

        ; function
        getNewestVersionTag() {
            whr := ComObject("WinHttp.WinHttpRequest.5.1")
            whr.Open("GET", "https://github.com/Lch3181/Warcraft-lll_TWrpg_AHKs/tags", true)
            whr.Send()
            ; Using 'true' above and the call below allows the script to remain responsive.
            whr.WaitForResponse()
            text := whr.ResponseText

            ; regex the version
            pattern := '\/Lch3181\/Warcraft-lll_TWrpg_AHKs\/releases\/tag\/(.*)\" data'
            if (RegExMatch(text, pattern, &Matches) <= 0) {
                return
            }
            version := Matches[1]

            ; output message box
            result := MsgBox("The Newest Version is " version "`nOpen Download Page?", "Check Updates" , "OC Owner" MainGui.Hwnd)

            if result == "OK" {
                Run("https://github.com/Lch3181/Warcraft-lll_TWrpg_AHKs/releases")
            }
        }
    }
}