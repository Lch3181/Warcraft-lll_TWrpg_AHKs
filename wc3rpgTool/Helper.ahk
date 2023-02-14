#Requires AutoHotkey v2.0
global iniFileName := "wc3rpgToolData.ini"
global WarcraftIII := "Warcraft III"
global ih := InputHook("V","{Esc}")

KeyWaitCombo()
{
    ih.VisibleNonText := false
    ih.KeyOpt("{All}", "E")  ; End
    ; Exclude the modifiers
    ih.KeyOpt("{LCtrl}{RCtrl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}", "-E")
    ih.Start()
    ErrorLevel := ih.Wait()  ; Store EndReason in ErrorLevel
    return ih.EndMods . ih.EndKey  ; Return a string like <^<+Esc
}

ReadableHotkey(hotkey) {
    hotkeyMap1 := Map(
        "<", "L", 
        ">", "R")

    hotkeyMap2 := Map(
        "#", "Win + ", 
        "!", "Alt + ", 
        "^", "Ctrl + ",
        "+", "Shift + "
    )

    hotkey := StrUpper(hotkey)
    for key, value in hotkeyMap1 {
        hotkey := StrReplace(hotkey, "$~", "")
        hotkey := StrReplace(hotkey, key, value)
    }
    for key, value in hotkeyMap2 {
        newHotkey := StrReplace(hotkey, key, value)
        if newHotkey != hotkey {
            hotkey := newHotkey
            break
        }
    }
    return hotkey
}

SelectFolder() {
    Folder := DirSelect(, 0)
    return Folder
}

GetFileNamesInFolder(path) {
    fileNames := []
    loop files path "\*.txt" {
        fileNames.Push(A_LoopFileName)
    }
    return fileNames
}

Join(sep, params*) {
    for index, param in params
        str .= param . sep
    return SubStr(str, 1, -StrLen(sep))
}

ON_EN_SETFOCUS(wParam, lParam, msg, hwnd)
{
    static EM_SETSEL   := 0x00B1
    static EN_SETFOCUS := 0x0100
    critical
    if ((wParam >> 16) = EN_SETFOCUS) {
        DllCall("user32\HideCaret", "ptr", lParam)
        DllCall("user32\PostMessage", "ptr", lParam, "uint", EM_SETSEL, "ptr", -1, "ptr", 0)
    }
}

; sendinput
wc3Chat(Text) {
    if WinExist(WarcraftIII) && !WinActivate(WarcraftIII) {
        WinActivate
    } else {
        ToolTip("Warcraft III not found")
        SetTimer () => ToolTip(), -5000
        return
    }
    ControlSend("{Enter}",, WarcraftIII)
    ControlSend("{Text}" Text,, WarcraftIII)
    ControlSend("{Enter}",, WarcraftIII)
}