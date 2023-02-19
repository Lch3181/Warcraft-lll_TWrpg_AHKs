#Requires AutoHotkey v2.0

class HostTab {
    __New(MainGui, Tab) {
        ; init tab
        Tab.UseTab("Host")

        ;
        MainGui.AddText("", "Placeholder")
    }
}