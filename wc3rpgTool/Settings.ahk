#Requires AutoHotkey v2.0
#Include wc3rpgTool.ahk

class Settings {
    tabName := "SettingsTab"
    hotkeys := [Gui.Text]
    checkboxes := [Gui.CheckBox]

    __New(MainGui, Tab) {
        ; init tab
        Tab.UseTab("Settings")

        ; enable tool at start
        enableToolonStartCheckbox := MainGui.AddCheckbox("xs y+20 Section venableToolonStartCheckbox -TabStop", "Enable Tool at Start")

        ; enable tool after load
        enableToolAfterLoadCheckbox := MainGui.AddCheckbox("xs y+20 Section venableToolAfterLoad -TabStop", "Enable Tool After Loading Savefile")

        ; summon bag after load
        summonBagAfterLoadCheckbox := MainGui.AddCheckbox("xs y+20 Section vsummonBagAfterLoad -TabStop", "Summon bag After Loading Savefile")

        ; show main window at start
        hideMainCheckbox := MainGui.AddCheckbox("xs y+20 Section vhideMainCheckbox -TabStop", "Hide Main Window at Start")

        ; show overlay at start
        hideOverlayCheckbox := MainGui.AddCheckbox("xs y+20 Section vhideOverlayCheckbox -TabStop", "Hide Overlay at Start")

        ; auto toggle tool on enter (for messaging in game)
        autoToggleToolCheckbox := MainGui.AddCheckbox("xs y+20 Section vautoToggleToolCheckbox -TabStop", "Auto Toggle Tool on Enter / Left Click / Esc (For Messaging in Game)")

        ; key delay
        MainGui.AddText("xs y+20", "Delay between keys(ms): ")
        keyDelayTextbox := MainGui.AddEdit("x+10 yp-3 Number Limit2 -WantReturn vkeyDelay -TabStop w50", "10")
        applyButton := MainGui.AddButton("x+10 w120 h20 -TabStop", "Apply")
        applyButton.SetFont("s10 w500")
        applyButton.OnEvent("Click", onClickApply)

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
            enableToolonStartCheckbox,
            enableToolAfterLoadCheckbox,
            summonBagAfterLoadCheckbox,
            hideMainCheckbox,
            hideOverlayCheckbox,
            autoToggleToolCheckbox
        ]

        for checkbox in this.checkboxes {
            checkbox.OnEvent("Click", onClickCheckbox)
            checkbox.Value := IniRead(iniFileName, this.tabName, checkbox.Name, false)
        }

        ; events
        onClickCheck(Button, Info) {
            newestVersion := getNewestVersionTag()
            message := "The Newest Version is " newestVersion "`nDownload and Install New Version?"
            if version == newestVersion {
                message := "Current Version is the Newest"
            }

            ; output message box
            result := MsgBox(message, "Check Updates" , "OC Owner" MainGui.Hwnd)

            if result == "OK" && version != newestVersion {
                downloadNewVersion(newestVersion)
            }
        }

        onClickReset(Button, Info) {
            try {
                try FileDelete(A_ScriptDir "\" iniFileName)
                Reload
            }
        }

        onClickApply(Button, Info) {
            delay := keyDelayTextbox.text
            if IsInteger(delay) {
                SetKeyDelay(Integer(keyDelayTextbox.text))
                IniWrite(Integer(delay), iniFileName, this.tabName, "keyDelay")
                ToolTip("updated")
                SetTimer () => ToolTip(), -5000
            } else {
                ToolTip("key delay has to be a number")
                SetTimer () => ToolTip(), -5000
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

            return version
        }

        downloadNewVersion(version) {
            target := "wc3rpgTool.exe"
            if !A_Is64bitOS {
                target := "wc3rpgTool_86.exe"
            }

            downloadUrl := "https://github.com/Lch3181/Warcraft-lll_TWrpg_AHKs/releases/download/" version "/" target
            downloadTo := A_Temp "\" target

            Download(downloadUrl, downloadTo)

            batFileNameLocation := A_Temp "\wc3tooldownload.bat"

            try FileDelete(batFileNameLocation)
            FileAppend
            (
                "@ECHO OFF
                taskkill /f /im " A_ScriptName "
                ROBOCOPY `"" A_Temp "`" `"" A_ScriptDir "`" " target "
                start /d " A_ScriptDir " " A_ScriptDir "\" target
            ), batFileNameLocation

            Run(batFileNameLocation, , "Hide")

            ExitApp
        }
    }
}