#Requires AutoHotkey v2.0
#Include Helper.ahk

class HostTab {
    __New(MainGui, Tab) {
        ; init tab
        Tab.UseTab("Host")

        ;
        MainGui.AddText("", "Placeholder")
    }
}