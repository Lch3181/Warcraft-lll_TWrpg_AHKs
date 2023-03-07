#Requires AutoHotkey v2.0

class HotkeyTab {
    hotkeys := [Gui.Text]

    __New(MainGui, Tab) {
        ; init tab
        Tab.UseTab("Hotkeys")

        ; toggle tool
        toggleTool := MainGui.AddText("x+20 y+20 w120 h20 Section Border 0x200 Center Disabled", "F2 / F10")
        MainGui.AddText("x+20 yp+2", "Toggle On / Off Tool In WC3")

        ; toggle on off tool if chatting
        toggleChatting := MainGui.AddText("xs y+20 w120 h20 Section Border 0x200 Center Disabled", "Enter")
        MainGui.AddText("x+20 yp+2", "If Tool is Enabled, Toggle On / Off Tool In WC3 for Messaging")

        ; toggle on tool if it was chatting
        toggleOnTool := MainGui.AddText("xs y+20 w120 h20 Section Border 0x200 Center Disabled", "Left Click / Esc")
        MainGui.AddText("x+20 yp+2", "If Tool is Enabled, Toggle On Tool in WC3 for Closing Message Box")

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
        MainGui.AddText("x+20 yp+2", "Remove and Register Hotkey in Tool")

        ; toggle on off quickcast
        toggleQuickcast := MainGui.AddText("xs y+20 w120 h20 Section Border 0x200 Center Disabled", "Right Click")
        MainGui.AddText("x+20 yp+2", "Toggle On Off Quickcast in Tool")

        ; exit app
        exitApp := MainGui.AddText("xs y+20 w120 h20 Section Border 0x200 Center Disabled", "Alt + Esc")
        MainGui.AddText("x+20 yp+2", "Exit App")

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
    }
}