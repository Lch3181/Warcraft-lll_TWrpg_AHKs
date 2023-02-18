#Requires AutoHotkey v2.0
#Include wc3rpgTool.ahk
#Include Helper.ahk

class RemapHK {
    name := ""
    section := ""
    targetWindow := ""
    originalKey := ""
    newHotkey := ""
    defaultNewHotkey := ""
    quickcast := false
    enabled := false
    hotStrings := []

    __New(Name, Section, TargetWindow, OriginalKey := "", DefaultNewHotkey := "", Enabled := false, HotStrings := []) {
        this.name := Name
        this.section := Section
        this.targetWindow := TargetWindow
        this.originalKey := OriginalKey
        this.defaultNewHotkey := DefaultNewHotkey
        this.enabled := Enabled
        this.hotStrings := HotStrings

        this.newHotkey := IniRead(iniFileName, this.section, this.name, "")
        if !this.newHotkey && this.section != "HotStringTab" {
            this.newHotkey := this.defaultNewHotkey
            if this.defaultNewHotkey {
                IniWrite("$" this.defaultNewHotkey, iniFileName, this.section, this.name)
            } else {
                IniWrite(this.defaultNewHotkey, iniFileName, this.section, this.name)
            }
        }

        this.quickcast := IniRead(iniFileName, "ToolTab", this.name "Quickcast", false)

        this.registerHotkey()
    }

    registerHotkey() {
        if !this.newHotkey {
            return
        }

        function := hotkeyFunction
        
        ; if mouse
        if InStr(this.name, "mouseHK") {
            function := mouseFunction
        }

        ; if hot string
        if this.section == "HotStringTab" {
            function := hotstringFunction
        }

        ; register hotkey
        HotIfWinactive(this.targetWindow)
        if !toolEnabled || !this.enabled {
            try {
                Hotkey(this.newHotkey, function, "Off")
            }
        } else {
            Hotkey(this.newHotkey, function, "On")
        }
        HotIfWinactive()

        ; functions
        hotkeyFunction(thisHotkey) {
            SendInput("{" this.originalKey "}")
            sendQuickcast()
        }

        mouseFunction(thisHotkey) {
            MouseClick(this.originalKey)
        }

        sendQuickcast() {
            if this.quickcast {
                SendInput("{Ctrl Down}{9}{0}{Ctrl Up}")
                MouseClick("Left")
                SendInput("{9}{0}")
            }
        }

        hotstringFunction(thisHotkey) {
            for text in this.hotStrings {
                wc3Chat(text)
            }
        }
    }
}