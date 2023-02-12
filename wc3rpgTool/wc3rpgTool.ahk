#Requires AutoHotkey v2.0
#Include Helper.ahk
#Include LoaderTab.ahk

;GUI
MainGui := Gui()
Tab := MainGui.AddTab3("W580 H580", ["Loader", "Tool", "Host", "Settings"])
LoaderTab(MainGui, Tab)
MainGui.Show("W600 H600")