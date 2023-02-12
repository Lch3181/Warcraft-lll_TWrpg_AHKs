#Requires AutoHotkey v2.0
#Include Helper.ahk

class MapTab {
    mapFolder := A_MyDocuments "\Warcraft III\Maps\Download"
    sortAsc := false

    __New(MainGui, Tab) {
        ; init tab
        Tab.UseTab("Map")

        ; drag and drop map
        MainGUI.OnEvent("DropFiles", dropMap)

        ; info
        MainGui.AddGroupBox("w550", "Info")
        MainGui.AddText("xp+20 yp+25", "Drag and drop new map to anywhere")

        ; settings
        MainGui.AddGroupBox("xp-20 yp+50 w550 h80", "Settings")
        MainGui.AddText("xp+20 yp+25", "Map Folder:")
        mapFolderTextField := MainGui.AddEdit("w350 ReadOnly", this.mapFolder)
        MainGui.AddButton("x+20 w60", "Select").OnEvent("Click", selectMapFolder)
        MainGui.AddButton("x+20 w60", "Open").OnEvent("Click", openMapFolder)
        ; maps
        MainGui.AddGroupBox("xp-470 yp+50 w550 h370", "Maps")
        MainGui.AddText("xp+20 yp+20", "Map Filter:")
        filterTextField := MainGui.AddEdit("w350", "twrpg")
        filterTextField.OnEvent("Change", onChangeMapFilter)
        mapList := MainGui.AddListView("yp+30 w510 h280 SortDesc", ["Name", "Date", "Hidden Date", "Size(MB)"])
        mapList.OnEvent("ColClick", onClickCol)
        updateMapList(filterTextField.text)

        ; events
        selectMapFolder(Button, Info) {
            Folder := SelectFolder()
            if Folder != "" {
                this.mapFolder := Folder
                mapFolderTextField.Text := Folder
                updateMapList(filterTextField.text)
            }
        }

        openMapFolder(Button, Info) {
            Run(this.mapFolder)
        }

        onChangeMapFilter(Button, Info) {
            updateMapList(Button.Text)
        }

        updateMapList(filter) {
            if (filter == "") {
                return
            }

            mapList.Delete()

            Loop Files, this.mapFolder "\*.w3x" {
                if (InStr(A_LoopFileName, filter)) {
                    mapList.Add(, A_LoopFileName, FormatTime(A_LoopFileTimeCreated, "MM/dd/yyyy hh/mm tt"), A_LoopFileTimeCreated, Format("{:.2f}", A_LoopFileSizeKB / 1024))
                }
            }

            mapList.ModifyCol
            mapList.ModifyCol(3, 0)
            mapList.ModifyCol(4, 80)
        }

        onClickCol(ListView, Info) {
            if (Info == 2) {
                ListView.ModifyCol(3, this.sortAsc ? "Sort" : "SortDesc")
                this.sortAsc := !this.sortAsc
            }
        }

        dropMap(GuiObj, GuiCtrlObj, FileArray, X, Y) {
            if (Tab.Text != "Map") {
                return
            }

            fileNames := []
            for file in FileArray {
                if InStr(file, ".w3x") {
                    FileCopy(file, this.mapFolder "\", 1)
                    split := StrSplit(file, "\")
                    fileNames.Push(StrReplace(split.Pop(), ".w3x", ""))
                }
            }
            if (fileNames.Length > 0) {
                updateMapList(filterTextField.text)
                MsgBox("Added: `n" Join("`n", fileNames*))
            }
        }
    }
}