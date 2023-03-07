#Requires AutoHotkey v2.0
#Include wc3rpgTool.ahk
#Include Helper.ahk
#Include RegisterHotkey.ahk

class ToolTab {
    tabName := "ToolTab"
    focusedHotKey := Gui.Control
    settings := [Gui.Control]
    newHK := Map()

    __New(MainGui, Tab) {
        ; init tab
        Tab.UseTab("Tool")
        Tab.OnEvent("Change", onChnageTab)

        ; remap spells
        MainGui.AddGroupBox("Section w340 h540", "Remap Spells")

        ; new
        MainGui.AddGroupBox("xp+10 yp+15 w320 h250", "New")

        newSpellHK1 := MainGui.AddText("xp+10 yp+20 w60 h60 Border vnewSpellHK1", "M")
        newSpellHK2 := MainGui.AddText("x+20 w60 h60 Border vnewSpellHK2", "S")
        newSpellHK3 := MainGui.AddText("x+20 w60 h60 Border vnewSpellHK3", "H")
        newSpellHK4 := MainGui.AddText("x+20 w60 h60 Border vnewSpellHK4", "A")

        newSpellHK5 := MainGui.AddText("xp-240 y+20 w60 h60 Border vnewSpellHK5", "P")
        newSpellHK6 := MainGui.AddText("x+20 w60 h60 Border vnewSpellHK6", "D")
        newSpellHK7 := MainGui.AddText("x+20 w60 h60 Border vnewSpellHK7", "T")
        newSpellHK8 := MainGui.AddText("x+20 w60 h60 Border vnewSpellHK8", "F")

        newSpellHK9 := MainGui.AddText("xp-240 y+20 w60 h60 Border vnewSpellHK9", "Q")
        newSpellHK10 := MainGui.AddText("x+20 w60 h60 Border vnewSpellHK10", "W")
        newSpellHK11 := MainGui.AddText("x+20 w60 h60 Border vnewSpellHK11", "E")
        newSpellHK12 := MainGui.AddText("x+20 w60 h60 Border vnewSpellHK12", "R")

        ; original
        MainGui.AddGroupBox("xp-250 y+20 w320 h250", "Orignal")

        originalSpellHK1 := MainGui.AddText("xp+10 yp+20 w60 h60 Border voriginalSpellHK1", "M")
        originalSpellHK2 := MainGui.AddText("x+20 w60 h60 Border voriginalSpellHK2", "S")
        originalSpellHK3 := MainGui.AddText("x+20 w60 h60 Border voriginalSpellHK3", "H")
        originalSpellHK4 := MainGui.AddText("x+20 w60 h60 Border voriginalSpellHK4", "A")

        originalSpellHK5 := MainGui.AddText("xp-240 y+20 w60 h60 Border voriginalSpellHK5", "P")
        originalSpellHK6 := MainGui.AddText("x+20 w60 h60 Border voriginalSpellHK6", "D")
        originalSpellHK7 := MainGui.AddText("x+20 w60 h60 Border voriginalSpellHK7", "T")
        originalSpellHK8 := MainGui.AddText("x+20 w60 h60 Border voriginalSpellHK8", "F")

        originalSpellHK9 := MainGui.AddText("xp-240 y+20 w60 h60 Border voriginalSpellHK9", "Q")
        originalSpellHK10 := MainGui.AddText("x+20 w60 h60 Border voriginalSpellHK10", "W")
        originalSpellHK11 := MainGui.AddText("x+20 w60 h60 Border voriginalSpellHK11", "E")
        originalSpellHK12 := MainGui.AddText("x+20 w60 h60 Border voriginalSpellHK12", "R")

        ; remap inventory
        MainGui.AddGroupBox("Section xs ys x+40 w190 h280", "Remap Inventory")

        inventoryHK1 := MainGui.AddText("xp+25 yp+35 w60 h60 Border vinventoryHK1", "1")
        inventoryHK2 := MainGui.AddText("x+20 w60 h60 Border vinventoryHK2", "2")
        inventoryHK3 := MainGui.AddText("xp-80 y+20 w60 h60 Border vinventoryHK3", "3")
        inventoryHK4 := MainGui.AddText("x+20 w60 h60 Border vinventoryHK4", "4")
        inventoryHK5 := MainGui.AddText("xp-80 y+20 w60 h60 Border vinventoryHK5", "5")
        inventoryHK6 := MainGui.AddText("x+20 w60 h60 Border vinventoryHK6", "6")

        ; remap mouse
        MainGui.AddGroupBox("Section xs ys y+30 w190 h120", "Remap Mouse")

        MainGui.AddText("xp+25 yp+20 w60", "Left Click")
        MainGui.AddText("x+20 w60", "Right Click")

        mouseHK1 := MainGui.AddText("xs+25 yp+20 w60 h60 Border vmouseHK1")
        mouseHK2 := MainGui.AddText("x+20 w60 h60 Border vmouseHK2")

        ; settings
        MainGui.AddGroupBox("Section xs ys y+30 w190 h125", "Settings")
        MainGui.AddText("xp+20 yp+20", "Enable: ")
        enableRemapSpells := MainGui.AddCheckbox("xp+0 y+10 -TabStop venableRemapSpells", "Remap Spells")
        enableRemapInventory := MainGui.AddCheckbox("xp+0 y+10 -TabStop venableRemapInventory", "Remap Inventory")
        enableRemapMouse := MainGui.AddCheckbox("xp+0 y+10 -TabStop venableRemapMouse", "Remap Mouse")

        this.settings := [
            enableRemapSpells,
            enableRemapInventory,
            enableRemapMouse
        ]

        for setting in this.settings {
            setting.OnEvent("Click", onClickCheckbox)

            setting.Value := IniRead(iniFileName, "ToolTab", setting.Name, 1)
        }

        this.newHK := Map(
            newSpellHK1, RegisterHotkey(),
            newSpellHK2, RegisterHotkey(),
            newSpellHK3, RegisterHotkey(),
            newSpellHK4, RegisterHotkey(),
            newSpellHK5, RegisterHotkey(),
            newSpellHK6, RegisterHotkey(),
            newSpellHK7, RegisterHotkey(),
            newSpellHK8, RegisterHotkey(),
            newSpellHK9, RegisterHotkey(),
            newSpellHK10, RegisterHotkey(),
            newSpellHK11, RegisterHotkey(),
            newSpellHK12, RegisterHotkey(),
            originalSpellHK1, RegisterHotkey(),
            originalSpellHK2, RegisterHotkey(),
            originalSpellHK3, RegisterHotkey(),
            originalSpellHK4, RegisterHotkey(),
            originalSpellHK5, RegisterHotkey(),
            originalSpellHK6, RegisterHotkey(),
            originalSpellHK7, RegisterHotkey(),
            originalSpellHK8, RegisterHotkey(),
            originalSpellHK9, RegisterHotkey(),
            originalSpellHK10, RegisterHotkey(),
            originalSpellHK11, RegisterHotkey(),
            originalSpellHK12, RegisterHotkey(),
            inventoryHK1, RegisterHotkey(),
            inventoryHK2, RegisterHotkey(),
            inventoryHK3, RegisterHotkey(),
            inventoryHK4, RegisterHotkey(),
            inventoryHK5, RegisterHotkey(),
            inventoryHK6, RegisterHotkey(),
            mouseHK1, RegisterHotkey(),
            mouseHK2, RegisterHotkey()
        )

        for gui, hk in this.newHK {
            gui.Opt("0x200 Center")
            gui.SetFont("s12 w550")
            gui.OnEvent("Click", onClickHK)

            ; get set hotkey
            inihk := IniRead(iniFileName, this.tabName, gui.Name, "")
            if !inihk && gui.Text {
                inihk := "$" StrLower(gui.Text)
                gui.Text := ReadableHotkey(inihk)
            } else if !inihk {
                writeHotkeyIni(StrLower(gui.Text), gui)
            }

            ; quickcast
            if InStr(gui.Name, "newSpellHK") || InStr(gui.Name, "inventoryHK") {
                gui.OnEvent("ContextMenu", onRightClickHK)

                ; write quickcast to ini
                writeQuickcastIni(gui)
            }


            ; register hotkey
            quickcast := IniRead(iniFileName, this.tabName, gui.Name "Quickcast", false)
            switch true {
                case InStr(gui.Name, "newSpellHK"):
                    RegExMatch(gui.Name, "(\d+)", &pos)
                    originalKey := IniRead(iniFileName, this.tabName, "originalSpellHK" pos[1], "")

                    this.newHK.Set(gui, RegisterHotkey(inihk, remapSpell.Bind(originalKey, quickcast), WarcraftIII, this.settings[1].Value))
                case InStr(gui.Name, "inventoryHK"):
                    switch gui.Name {
                        case "inventoryHK1":
                            this.newHK.Set(gui, RegisterHotkey(inihk, remapSpell.Bind("Numpad7", quickcast), WarcraftIII, this.settings[2].Value))
                        case "inventoryHK2":
                            this.newHK.Set(gui, RegisterHotkey(inihk, remapSpell.Bind("Numpad8", quickcast), WarcraftIII, this.settings[2].Value))
                        case "inventoryHK3":
                            this.newHK.Set(gui, RegisterHotkey(inihk, remapSpell.Bind("Numpad4", quickcast), WarcraftIII, this.settings[2].Value))
                        case "inventoryHK4":
                            this.newHK.Set(gui, RegisterHotkey(inihk, remapSpell.Bind("Numpad5", quickcast), WarcraftIII, this.settings[2].Value))
                        case "inventoryHK5":
                            this.newHK.Set(gui, RegisterHotkey(inihk, remapSpell.Bind("Numpad1", quickcast), WarcraftIII, this.settings[2].Value))
                        case "inventoryHK6":
                            this.newHK.Set(gui, RegisterHotkey(inihk, remapSpell.Bind("Numpad2", quickcast), WarcraftIII, this.settings[2].Value))
                        default:
                            return
                    }
                case InStr(gui.Name, "mouseHK"):
                    switch gui.Name {
                        case "mouseHK1":
                            this.newHK.Set(gui, RegisterHotkey(inihk, remapMouse.Bind("Left"), WarcraftIII, this.settings[3].Value))
                        case "mouseHK2":
                            this.newHK.Set(gui, RegisterHotkey(inihk, remapMouse.Bind("Right"), WarcraftIII, this.settings[3].Value))
                        default:
                    }
                default:
            }
        }

        ; var
        ih.OnEnd := endCaptureInput

        ; events
        onClickHK(Button, Info) {
            ; remove existing text
            Button.Text := ""
            IniWrite("", iniFileName, "ToolTab", Button.Name)

            ; disable old hotkey
            try {
                HK := this.remapedHK.Get(Button)
                HK.enabled := false
                HK.registerHotkey()
            }
            
            ; capture input
            this.focusedHotKey := Button

            if InStr(Button.Name, "originalSpellHK") {
                KeyWaitAny()
            } else {
                KeyWaitCombo()
            }
        }

        onRightClickHK(Button, Item, IsRightClick, X, Y) {
            writeQuickcastIni(Button, true)
        }

        endCaptureInput(inputObj) {
            if (WinActive(MainGui.Title) && Tab.Text == "Tool") {
                ; captured input
                hk := ih.EndMods . ih.EndKey
                this.focusedHotKey.Text := ReadableHotkey(hk)

                ; write ini
                writeHotkeyIni(hk, this.focusedHotKey)

                writeQuickcastIni(this.focusedHotKey)

                this.registerHotkeys()
            }
        }

        onClickCheckbox(Button, Info) {
            IniWrite(Button.Value, iniFileName, "ToolTab", Button.Name)
            this.registerHotkeys()
        }

        onChnageTab(Tab, Info) {
            ih.Stop()
            if Tab.Text == "Tool" {
                ih.OnEnd := endCaptureInput
            }
        }

        ; functions
        writeHotkeyIni(Hotkey, TextGui) {
            if (TextGui.Text) {
                ; write hk settings to ini
                if InStr(TextGui.Name, "originalSpellHK") {
                    ; original spells are not hotkey
                    IniWrite(Hotkey, iniFileName, "ToolTab", TextGui.Name)
                } else {
                    ;  add "$" to hotkey
                    IniWrite("$" Hotkey, iniFileName, "ToolTab", TextGui.Name)
                }
            } else {
                ; write empty key
                IniWrite("", iniFileName, "ToolTab", TextGui.Name)
            }
        }

        writeQuickcastIni(TextGui, reverse := false) {
            if InStr(TextGui.Name, "originalSpellHK") || InStr(TextGui.Name, "mouseHK") {
                return
            }

            ; quickcast enabled = green else black
            iniHK := IniRead(iniFileName, "ToolTab", TextGui.Name, "")

            if IniRead(iniFileName, "ToolTab", TextGui.Name "Quickcast", "") != "" {
                iniQuickcast := IniRead(iniFileName, "ToolTab", TextGui.Name "Quickcast", true)
                if (iniQuickcast && reverse) || (!iniQuickcast && !reverse) {
                    TextGui.SetFont("cBlack")
                    IniWrite(false, iniFileName, "ToolTab", TextGui.Name "Quickcast")
                } else {
                    TextGui.SetFont("cGreen")
                    IniWrite(true, iniFileName, "ToolTab", TextGui.Name "Quickcast")
                }
            } else {
                IniWrite(true, iniFileName, "ToolTab", TextGui.Name "Quickcast")
                TextGui.SetFont("cGreen")
            }
        }

        ; hotkey functions
        remapSpell(originalKey, quickcast) {
            SendInput("{" originalKey "}")
            if quickcast {
                SendInput("{Ctrl Down}{9}{0}{Ctrl Up}")
                MouseClick("Left")
                SendInput("{9}{0}")
            }
        }

        remapMouse(originalKey) {
            MouseClick(originalKey)
        }
    }

    updateHotkeys() {
        for gui, hk in this.newHK {
            hk.updateHotkey()
        }
    }
}