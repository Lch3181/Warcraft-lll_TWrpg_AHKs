#Requires AutoHotkey v2.0
#Include wc3rpgTool.ahk
#Include Helper.ahk

class Overlay {
    textGui := Gui.Text

    __New() {
        overlayGui := Gui("AlwaysOnTop -SysMenu Owner LastFound -Caption")
        this.textGui := overlayGui.AddText("w100 h80", "Tool: " (toolEnabled ? "Enabled" : "Disabled"))
        this.textGui.SetFont("s12 cRed")
        overlayGui.BackColor := "EEAA99"
        WinSetTransColor("EEAA99", overlayGui.Hwnd)
        overlayGui.Show("x0 y0")
    }

    updateText() {
        this.textGui.Text := "Tool: " (toolEnabled ? "Enabled" : "Disabled")
    }
}