#Requires AutoHotkey v2.0
#Include Helper.ahk
#Include wc3rpgTool.ahk

class HotkeyTab {
    tabName := "HotkeyTab"
    hotkeys := Map()
    focusedHotKey := Gui.Button

    __New(MainGui, Tab) {
        ; init tab
        Tab.UseTab("Hotkeys")

        ; toggle tool
        toggleToolButton := MainGui.AddButton("x+20 y+20 w120 h20 Section Border 0x200 Center vtoggleToolButton", "F2 / F10")
        MainGui.AddText("x+20 yp+2", "Toggle On / Off Tool In WC3")

        ; toggle on off tool if chatting
        toggleChatting := MainGui.AddText("xs y+20 w120 h20 Section Border 0x200 Center Disabled vtoggleChatting", "Enter")
        MainGui.AddText("x+20 yp+2", "If Tool is Enabled, Toggle On / Off Tool In WC3 for Messaging")

        ; toggle on tool if it was chatting
        toggleOnTool := MainGui.AddText("xs y+20 w120 h20 Section Border 0x200 Center Disabled vtoggleOnTool", "Left Click / Esc")
        MainGui.AddText("x+20 yp+2", "If Tool is Enabled, Toggle On Tool in WC3 for Closing Message Box")

        ; hide main gui
        hideMain := MainGui.AddText("xs y+20 w120 h20 Section Border 0x200 Center Disabled vhideMain", "Esc")
        MainGui.AddText("x+20 yp+2", "Hide Main Window")

        ; show hide main gui hotkey
        showhideMainButton := MainGui.AddButton("xs y+20 w120 h20 Section Border 0x200 Center vshowhideMainButton", "F8")
        MainGui.AddText("x+20 yp+2", "Show / Hide Main Window")

        ; show hide overlay gui hotkey
        showhideOverlayButton := MainGui.AddButton("xs y+20 w120 h20 Section Border 0x200 Center vshowhideOverlayButton", "F7")
        MainGui.AddText("x+20 yp+2", "Show / Hide Overlay")

        ; pause game
        pauseGameButton := MainGui.AddButton("xs y+20 w120 h20 Section Border 0x200 Center vpauseGameButton", "Pause")
        MainGui.AddText("x+20 yp+2", "Pause Game In WC3")

        ; register hotkey
        registerHotkeyButton := MainGui.AddText("xs y+20 w120 h20 Section Border 0x200 Center Disabled vregisterHotkeyButton", "Left Click")
        MainGui.AddText("x+20 yp+2", "Remove and Register Hotkey in Tool")

        ; toggle on off quickcast
        toggleQuickcast := MainGui.AddText("xs y+20 w120 h20 Section Border 0x200 Center Disabled vtoggleQuickcast", "Right Click")
        MainGui.AddText("x+20 yp+2", "Toggle On Off Quickcast in Tool")

        ; exit app
        exitApp := MainGui.AddText("xs y+20 w120 h20 Section Border 0x200 Center Disabled vexitApp", "Alt + Esc")
        MainGui.AddText("x+20 yp+2", "Exit App")

        ; var
        hkGuis := [
            toggleToolButton,
            toggleChatting,
            toggleOnTool,
            hideMain,
            showhideMainButton,
            showhideOverlayButton,
            pauseGameButton,
            registerHotkeyButton,
            toggleQuickcast,
            exitApp
        ]

        for hkGui in hkGuis {
            hkGui.SetFont("s10")
            hkGui.OnEvent("Click", onClick)

            ; getset hotkeys
            if hkGui.Enabled {
                inihk := IniRead(iniFileName, this.tabName, hkGui.Name, "ERROR")
                if inihk == "ERROR" {
                    switch hkGui.Name {
                        case "toggleToolButton":
                            inihk := "$F2"
                        case "showhideMainButton":
                            inihk := "$F8"
                        case "showhideOverlayButton":
                            inihk := "$F7"
                        case "pauseGameButton":
                            inihk := "$Pause"
                        default:
                    }
                }
                hkGui.Text := ReadableHotkey(inihk)
                registerHK(hkGui, inihk)
            }
        }

        ; events
        onClick(Button, Info) {
            ; remove existing text
            Button.Text := ""
            IniWrite("", iniFileName, this.tabName, Button.Name)

            ; disable old hotkey
            try {
                hk := this.hotkeys.Get(Button)
                hk.enable := false
                hk.updateHotkey()
            }

            ; capture input
            this.focusedHotKey := Button
            ih.OnEnd := onEndCaptureInput

            KeyWaitCombo()
        }

        onEndCaptureInput(inputObj) {
            if (WinActive(MainGui.Title) && Tab.Text == "Hotkeys") {
                ; captured input
                hk := "$" ih.EndMods . ih.EndKey
                this.focusedHotKey.Text := ReadableHotkey(hk)

                ; write ini
                IniWrite(hk, iniFileName, this.tabName, this.focusedHotKey.Name)

                registerHK(this.focusedHotKey, hk)
            }
        }

        ; functions
        registerHK(gui, hk) {
            switch true {
                case InStr(gui.Name, "toggleToolButton"):
                    if ReadableHotkey(hk) {
                        gui.Text := ReadableHotkey(hk) " / F10"
                    } else {
                        gui.Text := "F10"
                    }
                    this.hotkeys.Set(gui, RegisterHotkey(hk, toggleTool, WarcraftIII, true))
                case InStr(gui.Name, "showhideMainButton"):
                    this.hotkeys.Set(gui, RegisterHotkey(hk, showHideMainGui, , true))
                case InStr(gui.Name, "showhideOverlayButton"):
                    this.hotkeys.Set(gui, RegisterHotkey(hk, showHideOverlay, , true))
                case InStr(gui.Name, "pauseGameButton"):
                    this.hotkeys.Set(gui, RegisterHotkey(hk, pauseGame, WarcraftIII, true))
            }
        }
    }
}