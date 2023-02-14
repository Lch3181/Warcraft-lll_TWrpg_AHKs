#Requires AutoHotkey v2.0
#Include wc3rpgTool.ahk
#Include Helper.ahk

class ToolTab {
    focusedHotKey := Gui.Control
    settings := [Gui.Control]
    allHK := [Gui.Control]
    remapedKeys := Map()
    quickCastMap := Map()

    __New(MainGui, Tab) {
        ; init tab
        Tab.UseTab("Tool")

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
        enableRemapSpells := MainGui.AddCheckbox("xp+0 y+10 venableRemapSpells", "Remap Spells")
        enableRemapInventory := MainGui.AddCheckbox("xp+0 y+10 venableRemapInventory", "Remap Inventory")
        enableRemapMouse := MainGui.AddCheckbox("xp+0 y+10 venableRemapMouse", "Remap Mouse")

        this.settings := [
            enableRemapSpells,
            enableRemapInventory,
            enableRemapMouse
        ]

        for setting in this.settings {
            setting.OnEvent("Click", onClickCheckbox)

            setting.Value := IniRead(iniFileName, "ToolTab", setting.Name, 1)
        }

        this.allHk := [
            newSpellHK1,
            newSpellHK2,
            newSpellHK3,
            newSpellHK4,
            newSpellHK5,
            newSpellHK6,
            newSpellHK7,
            newSpellHK8,
            newSpellHK9,
            newSpellHK10,
            newSpellHK11,
            newSpellHK12,
            originalSpellHK1,
            originalSpellHK2,
            originalSpellHK3,
            originalSpellHK4,
            originalSpellHK5,
            originalSpellHK6,
            originalSpellHK7,
            originalSpellHK8,
            originalSpellHK9,
            originalSpellHK10,
            originalSpellHK11,
            originalSpellHK12,
            inventoryHK1,
            inventoryHK2,
            inventoryHK3,
            inventoryHK4,
            inventoryHK5,
            inventoryHK6,
            mouseHK1,
            mouseHK2
        ]

        for HK in this.allHk {
            HK.Opt("-Tabstop 0x200 Center")
            HK.SetFont("s8 w600")
            HK.OnEvent("Click", onClickHK)

            ; hotkey
            iniHK := IniRead(iniFileName, "ToolTab", HK.Name, "")

            if iniHK {
                ; update gui
                iniHK := ReadableHotkey(iniHK)
                HK.Text := iniHK
            } else {
                ; write hotkey to ini
                writeHotkeyIni(StrLower(HK.Text), HK)
            }

            ; quickcast
            if InStr(HK.Name, "newSpellHK") || InStr(HK.Name, "inventoryHK") {
                HK.OnEvent("ContextMenu", onRightClickHK)

                ; write quickcast to ini
                writeQuickcastIni(HK)
            }
        }

        ; var
        ih.OnEnd := endCaptureInput

        this.registerHotkeys()

        ; events
        onClickHK(Button, Info) {
            ; remove existing text
            Button.Text := ""
            IniWrite("", iniFileName, "ToolTab", Button.Name)
            inihk := IniRead(iniFileName, "ToolTab", Button.Name, "")
            this.setRemapedHotkeys()

            ; disable old hotkey
            HotIfWinactive(WarcraftIII)
            try {
                Hotkey(inihk, "Off")
            }
            HotIfWinactive()

            ; capture input
            this.focusedHotKey := Button
            if not ih.InProgress {
                KeyWaitCombo()
            }
        }

        onRightClickHK(Button, Item, IsRightClick, X, Y) {
            ; quickcast enabled = green else black
            writeQuickcastIni(Button, true)
        }

        endCaptureInput(inputObj) {
            if (WinActive(A_ScriptName) && Tab.Text == "Tool") {
                ; captured input
                hk := ih.EndMods . ih.EndKey
                this.focusedHotKey.Text := ReadableHotkey(hk)

                ; write ini
                writeHotkeyIni(hk, this.focusedHotKey)

                this.registerHotkeys()
            }
        }

        onClickCheckbox(Button, Info) {
            IniWrite(Button.Value, iniFileName, "ToolTab", Button.Name)
            this.registerHotkeys()
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
            ; quickcast enabled = green else black
            iniHK := IniRead(iniFileName, "ToolTab", TextGui.Name, "")

            if IniRead(iniFileName, "ToolTab", TextGui.Name "Quickcast", "") != "" {
                iniQuickcast := IniRead(iniFileName, "ToolTab", TextGui.Name "Quickcast", true)
                if (iniQuickcast && reverse) || (!iniQuickcast && !reverse) {
                    TextGui.SetFont("cBlack")
                    this.quickCastMap.Set(iniHK, false)
                    IniWrite(false, iniFileName, "ToolTab", TextGui.Name "Quickcast")
                } else {
                    TextGui.SetFont("cGreen")
                    this.quickCastMap.Set(iniHK, true)
                    IniWrite(true, iniFileName, "ToolTab", TextGui.Name "Quickcast")
                }
            } else {
                this.quickCastMap.Set(iniHK, true)
                IniWrite(true, iniFileName, "ToolTab", TextGui.Name "Quickcast")
                TextGui.SetFont("cGreen")
            }
        }
    }

    setRemapedHotkeys() {
        for HKGui in this.allHK {
            if InStr(HKGui.Name, "newSpellHK") {
                RegExMatch(HKGui.Name, "(\d+)", &pos)
                remapedHotkey := IniRead(iniFileName, "ToolTab", HKGui.Name, "")
                originalKey := IniRead(iniFileName, "ToolTab", "originalSpellHK" pos[1], "")

                this.remapedKeys.Set(remapedHotkey, originalKey)

            } else if InStr(HKGui.Name, "inventoryHK") {
                remapedHotkey := IniRead(iniFileName, "ToolTab", HKGui.Name, "")

                switch HKGui.Name {
                    case "inventoryHK1":
                        this.remapedKeys.Set(remapedHotkey, "Numpad7")
                    case "inventoryHK2":
                        this.remapedKeys.Set(remapedHotkey, "Numpad8")
                    case "inventoryHK3":
                        this.remapedKeys.Set(remapedHotkey, "Numpad4")
                    case "inventoryHK4":
                        this.remapedKeys.Set(remapedHotkey, "Numpad5")
                    case "inventoryHK5":
                        this.remapedKeys.Set(remapedHotkey, "Numpad1")
                    case "inventoryHK6":
                        this.remapedKeys.Set(remapedHotkey, "Numpad2")
                    default:
                        return
                }
            } else if InStr(HKGui.Name, "mouseHK") {
                remapedHotkey := IniRead(iniFileName, "ToolTab", HKGui.Name, "")

                switch HKGui.Name {
                    case "mouseHK1":
                        this.remapedKeys.Set(remapedHotkey, "Left")
                    case "mouseHK2":
                        this.remapedKeys.Set(remapedHotkey, "Right")
                    default:
                        return
                }
            }
        }
        ; remove empty key
        this.remapedKeys.Delete("")
    }

    registerHotkeys() {
        this.setRemapedHotkeys()
        HotIfWinactive(WarcraftIII)

        for HK in this.allHk {
            HKName := HK.Name
            hk := IniRead(iniFileName, "ToolTab", HKName, "")
            if hk == "" {
                continue
            }

            switch true {
                case InStr(HKName, "newSpellHK"):
                    Hotkey(hk, remapSpell, "On")
                    if !toolEnabled || !this.settings[1].Value {
                        Hotkey(hk, remapSpell, "Off")
                    }
                case InStr(HKName, "inventoryHK"):
                    Hotkey(hk, remapInventory, "On")
                    if !toolEnabled || !this.settings[2].Value {
                        Hotkey(hk, remapInventory, "Off")
                    }
                case InStr(HKName, "mouseHK"):
                    Hotkey(hk, remapMouse, "On")
                    if !toolEnabled || !this.settings[3].Value {
                        Hotkey(hk, remapMouse, "Off")
                    }
                default:
                    continue
            }
        }

        HotIfWinactive()

        remapSpell(thisHotkey) {
            remapedKey := this.remapedKeys.Get(thisHotkey, "")
            SendInput("{" remapedKey "}")
            quickcast(thisHotkey)
        }
        
        remapInventory(thisHotkey) {
            remapedKey := this.remapedKeys.Get(thisHotkey)
            SendInput("{" remapedKey "}")
            quickcast(thisHotkey)
        }

        remapMouse(thisHotkey) {
            remapedKey := this.remapedKeys.Get(thisHotkey)
            MouseClick(remapedKey)
        }

        quickcast(thisHotkey) {
            if this.quickCastMap.Get(thisHotkey, false) {
                SendInput("{Ctrl Down}{9}{0}{Ctrl Up}")
                MouseClick("Left")
                SendInput("{9}{0}")
            }
        }
    }
}