#Requires AutoHotkey v2.0
#Include Helper.ahk
#Include LoaderTab.ahk
#Include MapTab.ahk

;GUI
MainGui := Gui()
Tab := MainGui.AddTab3("W580 H580 Choose4", ["Loader", "Tool", "Host", "Map", "Settings"])
LoaderTab(MainGui, Tab)
MapTab(MainGui, Tab)
MainGui.Show("W600 H600")