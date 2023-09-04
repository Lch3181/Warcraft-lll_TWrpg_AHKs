#Requires AutoHotkey v2.0
#Include wc3rpgTool.ahk
#Include Helper.ahk

class Overlay {
    overlayGui := Gui
    textGui := Gui.Text

    __New() {
        this.overlayGui := Gui("AlwaysOnTop -SysMenu Owner LastFound -Caption")
        this.textGui := this.overlayGui.AddText("w100 h80", "Tool: " (toolEnabled ? "Enabled" : "Disabled"))
        this.textGui.SetFont("s12 cRed")
        this.overlayGui.BackColor := "EEAA99"
        WinSetTransColor("EEAA99", this.overlayGui.Hwnd)

        ; show hide overlay at start
        if !IniRead(iniFileName, "SettingsTab", "hideOverlayCheckbox", false) {
            this.overlayGui.Show("x0 y0")
            global showOverlay := true
        }
    }

    updateText() {
        this.textGui.Text := "Tool: " (toolEnabled ? "Enabled" : "Disabled")
    }
}