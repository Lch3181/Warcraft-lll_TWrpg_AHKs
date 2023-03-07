#Requires AutoHotkey v2.0
#Include wc3rpgTool.ahk
#Include Helper.ahk

class RegisterHotkey {
    key := ""
    function := ""
    targetWindow := ""
    enable := false

    __New(key := "", function := "", targetWindow := "", enable := false) {
        this.key := key
        this.function := function
        this.targetWindow := targetWindow
        this.enable := enable

        if key {
            this.updateHotkey()
        }
    }

    updateHotkey() {
        if !this.key {
            return
        }

        HotIfWinactive(this.targetWindow)
        if !toolEnabled || !this.enable {
            try {
                Hotkey(this.key, hotkeyFunction, "Off")
            }
        } else {
            Hotkey(this.key, hotkeyFunction, "On")
        }
        HotIfWinactive()

        hotkeyFunction(thisHotkey) {
            this.function.Call()
        }
    }
}