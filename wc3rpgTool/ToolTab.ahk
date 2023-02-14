#Requires AutoHotkey v2.0
#Include Helper.ahk

class ToolTab {
    focusedHotKey := Gui.Control

    __New(MainGui, Tab) {
        ; init tab
        Tab.UseTab("Tool")

        ; remap spells
        MainGui.AddGroupBox("Section w340 h540", "Remap Spells")

        ; new
        MainGui.AddGroupBox("xp+10 yp+15 w320 h250", "New")

        newSpellHK1  := MainGui.AddText("xp+10 yp+20 w60 h60 Border vnewSpellHK1", "M")
        newSpellHK2  := MainGui.AddText("x+20 w60 h60 Border vnewSpellHK2", "S")
        newSpellHK3  := MainGui.AddText("x+20 w60 h60 Border vnewSpellHK3", "H")
        newSpellHK4  := MainGui.AddText("x+20 w60 h60 Border vnewSpellHK4", "A")

        newSpellHK5  := MainGui.AddText("xp-240 y+20 w60 h60 Border vnewSpellHK5", "P")
        newSpellHK6  := MainGui.AddText("x+20 w60 h60 Border vnewSpellHK6", "D")
        newSpellHK7  := MainGui.AddText("x+20 w60 h60 Border vnewSpellHK7", "T")
        newSpellHK8  := MainGui.AddText("x+20 w60 h60 Border vnewSpellHK8", "F")

        newSpellHK9  := MainGui.AddText("xp-240 y+20 w60 h60 Border vnewSpellHK9", "Q")
        newSpellHK10 := MainGui.AddText("x+20 w60 h60 Border vnewSpellHK10", "W")
        newSpellHK11 := MainGui.AddText("x+20 w60 h60 Border vnewSpellHK11", "E")
        newSpellHK12 := MainGui.AddText("x+20 w60 h60 Border vnewSpellHK12", "R")

        ; original
        MainGui.AddGroupBox("xp-250 y+20 w320 h250", "Orignal")

        originalSpellHK1  := MainGui.AddText("xp+10 yp+20 w60 h60 Border voriginalSpellHK1", "M")
        originalSpellHK2  := MainGui.AddText("x+20 w60 h60 Border voriginalSpellHK2", "S")
        originalSpellHK3  := MainGui.AddText("x+20 w60 h60 Border voriginalSpellHK3", "H")
        originalSpellHK4  := MainGui.AddText("x+20 w60 h60 Border voriginalSpellHK4", "A")
 
        originalSpellHK5  := MainGui.AddText("xp-240 y+20 w60 h60 Border voriginalSpellHK5", "P")
        originalSpellHK6  := MainGui.AddText("x+20 w60 h60 Border voriginalSpellHK6", "D")
        originalSpellHK7  := MainGui.AddText("x+20 w60 h60 Border voriginalSpellHK7", "T")
        originalSpellHK8  := MainGui.AddText("x+20 w60 h60 Border voriginalSpellHK8", "F")
 
        originalSpellHK9  := MainGui.AddText("xp-240 y+20 w60 h60 Border voriginalSpellHK9", "Q")
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
        MainGui.AddCheckbox("xp+0 y+10", "Remap Spells")
        MainGui.AddCheckbox("xp+0 y+10", "Remap Inventory")
        MainGui.AddCheckbox("xp+0 y+10", "Remap Mouse")

        allHk := [
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

        for HK in allHk {
            HK.Opt("-Tabstop 0x200 Center")
            HK.SetFont("s8 w600")
            HK.OnEvent("Click", onClickHK)

            ; quickcast
            if !InStr(HK.Name, "originalSpellHK") {
                HK.OnEvent("ContextMenu", onRightClickHK)
                if IniRead(iniFileName, "ToolTab", HK.Name "Quickcast", true) {
                    HK.SetFont("cGreen")
                }
            }
            
            ; hotkey
            iniHK := IniRead(iniFileName, "ToolTab", HK.Name, HK.Text)
            iniHK := ReadableHotkey(iniHK)
            HK.Text := iniHK
        }

        ; var
        ih.OnEnd := setHotkey
        
        ; events
        onClickHK(Button, Info) {
            Button.Text := ""
            this.focusedHotKey := Button
            if not ih.InProgress {
                IniWrite("", iniFileName, "ToolTab", Button.Name)    
                KeyWaitCombo()
            }
        }

        onRightClickHK(Button, Item, IsRightClick, X, Y) {
            ; quickcast enabled = green else red
            quickcast := IniRead(iniFileName, "ToolTab", Button.Name "Quickcast", true)
            if quickcast {
                Button.SetFont("cBlack")
                IniWrite(false, iniFileName, "ToolTab", Button.Name "Quickcast")
            } else {
                Button.SetFont("cGreen")
                IniWrite(true, iniFileName, "ToolTab", Button.Name "Quickcast")
            }
        }

        setHotkey(inputObj) {
            if (WinActive(A_ScriptName)) {
                hk := ih.EndMods . ih.EndKey
                this.focusedHotKey.Text := ReadableHotkey(hk)
                IniWrite(hk, iniFileName, "ToolTab", this.focusedHotKey.Name)    
            }
        }
    }
}