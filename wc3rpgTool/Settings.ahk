#Requires AutoHotkey v2.0
#Include Helper.ahk

class Settings {
    hotkeys := [Gui.Text]
    checkboxes := [Gui.CheckBox]

    __New(MainGui, Tab) {
        ; init tab
        Tab.UseTab("Settings")

        ; toggle tool
        toggleTool := MainGui.AddText("x+20 y+20 w120 h20 Section Border 0x200 Center Disabled", "F2 / F10")
        MainGui.AddText("x+20 yp+2", "Toggle On / Off Tool In WC3")

        ; toggle on off tool if chatting
        toggleChatting := MainGui.AddText("xs y+20 w120 h20 Section Border 0x200 Center Disabled", "Enter")
        MainGui.AddText("x+20 yp+2", "If Tool is Enabled, Toggle On / Off Tool In WC3 if the User Open / Close Message Box")

        ; toggle on tool if it was chatting
        toggleOnTool := MainGui.AddText("xs y+20 w120 h20 Section Border 0x200 Center Disabled", "Left Click / Esc")
        MainGui.AddText("x+20 yp+2", "If Tool is Enabled, Toggle On Tool in WC3 if User Close Message Box")

        ; hide main gui
        hideMain := MainGui.AddText("xs y+20 w120 h20 Section Border 0x200 Center Disabled", "Esc")
        MainGui.AddText("x+20 yp+2", "Hide Main Window")

        ; show hide main gui hotkey
        showhideMain := MainGui.AddText("xs y+20 w120 h20 Section Border 0x200 Center Disabled", "F8")
        MainGui.AddText("x+20 yp+2", "Show / Hide Main Window")

        ; show hide overlay gui hotkey
        showhideOverlay := MainGui.AddText("xs y+20 w120 h20 Section Border 0x200 Center Disabled", "F7")
        MainGui.AddText("x+20 yp+2", "Show / Hide Overlay")

        ; pause game
        pauseGame := MainGui.AddText("xs y+20 w120 h20 Section Border 0x200 Center Disabled", "Pause")
        MainGui.AddText("x+20 yp+2", "Pause Game In WC3")

        ; register hotkey
        registerHotkey := MainGui.AddText("xs y+20 w120 h20 Section Border 0x200 Center Disabled", "Left Click")
        MainGui.AddText("x+20 yp+2", "Remove and Register Hotkey")

        ; toggle on off quickcast
        toggleQuickcast := MainGui.AddText("xs y+20 w120 h20 Section Border 0x200 Center Disabled", "Right Click")
        MainGui.AddText("x+20 yp+2", "Toggle On Off Quickcast")

        ; exit app
        exitApp := MainGui.AddText("xs y+20 w120 h20 Section Border 0x200 Center Disabled", "Alt + Esc")
        MainGui.AddText("x+20 yp+2", "Exit App")

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
        this.hotkeys := [
            toggleTool,
            toggleChatting,
            toggleOnTool,
            hideMain,
            showhideMain,
            showhideOverlay,
            pauseGame,
            registerHotkey,
            toggleQuickcast,
            exitApp
        ]

        for hkGui in this.hotkeys {
            hkGui.SetFont("s10 w700")
        }

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