#Requires AutoHotkey v2.0
#Include Helper.ahk

class LoaderTab {
    fileList := Gui.ListView
    TWRPGFolder := Gui.Edit
    showHidden := false
    hiddenFilesMap := Map()
    
    __New(MainGui, Tab) {
        ; init tab
        Tab.UseTab("Loader")

        ; drag and drop save file
        MainGui.OnEvent("DropFiles", dropSaveFiles)

        ; info
        MainGui.AddGroupBox("Section w550", "Info")
        SelectedFile := MainGui.AddText("xp+20 yp+25 w100", "")
        MainGui.AddButton("x+20 ys+20 w100", "Load").OnEvent("Click", loadButton)
        MainGui.AddText("x+20 yp+5", "Drag and drop new save file to anywhere")

        ; files
        MainGui.AddGroupBox("Section xs ys y+30 w550 h340", "Files")
        this.fileList := MainGui.AddListView("xp+20 yp+30 w510 h280 Sort", ["Name", "Date", "Hidden Date", "Size(KB)", "Status"])
        this.fileList.OnEvent("Click", onClickRow)
        this.fileList.OnEvent("DoubleClick", onDoubleClickRow)
        this.fileList.OnEvent("ContextMenu", onRightClickRow)

        ; file Menu
        fileMenu := Menu()
        fileMenu.Add("Open", fileMenuOpenFile)
        fileMenu.Add("Hide File", fileMenuHideFile)
        fileMenu.Add("Show File", fileMenuShowFile)
        fileMenu.Add("Show / Hide Hidden Files", fileMenuShowHideHiddenFiles)

        ; settings
        MainGui.AddGroupBox("Section xs ys y+50 w550 h100", "Settings")
        convertNameCheckBox := MainGui.AddCheckbox("xp+20 yp+20", "Convert Name for Warcraft III Reforged")
        convertNameCheckBox.OnEvent("Click", onClickConvertNameCheckBox)
        MainGui.AddText("yp+25", "TWRPG Folder:")
        this.TWRPGFolder := MainGui.AddEdit("w350 r1 ReadOnly", "")
        MainGui.AddButton("x+20 w60", "Select").OnEvent("Click", selectButton)
        MainGui.AddButton("x+20 w60", "Open").OnEvent("Click", openButton)

        ; init variables
        sortAsc := false
        lvSelectedRow := 0
        this.showHidden := false
        hiddenFilesAddress := A_ScriptDir "\HiddenFiles.txt"
        hiddenFilesArray := []
        this.hiddenFilesMap := Map()

        getHiddenFiles()
        SelectedFile.Text := IniRead(iniFileName, "LoaderTab", "selectedFile", "N/A")
        this.TWRPGFolder.Text := IniRead(iniFileName, "LoaderTab", "this.TWRPGFolder", A_MyDocuments "\Warcraft III\CustomMapData\TWRPG")
        convertNameCheckBox.Value := IniRead(iniFileName, "LoaderTab", "convertNameCheckBox", true)
        this.updateFileList()

        ; hotstrings
        HotIfWinactive(WarcraftIII)
        Hotstring(":XB0:-l", loadSaveFile)
        HotIfWinactive()

        ; events
        selectButton(Button, Info) {
            Folder := SelectFolder()
            if Folder != "" {
                this.TWRPGFolder.Text := Folder
                IniWrite(this.TWRPGFolder.Text, iniFileName, "LoaderTab", "this.TWRPGFolder")
            }
        }

        openButton(Button, Info) {
            Run(this.TWRPGFolder.Text)
        }

        loadButton(Button, Info) {
            loadSaveFile()
        }

        onClickConvertNameCheckBox(CheckBox, Info) {
            IniWrite(CheckBox.Value, iniFileName, "LoaderTab", "convertNameCheckBox")
        }

        dropSaveFiles(GuiObj, GuiCtrlObj, FileArray, X, Y) {
            if (Tab.Text != "Loader") {
                return
            }

            fileNames := []
            for file in FileArray {
                if InStr(file, ".txt") {
                    FileCopy(file, this.TWRPGFolder.Text "\", 1)
                    split := StrSplit(file, "\")
                    fileNames.Push(StrReplace(split.Pop(), ".txt", ""))
                }
            }

            if (fileNames.Length > 0) {
                MsgBox("Added: `n" Join("`n", fileNames*))
            }
        }

        onClickCol(LV, Info) {
            if (Info == 2) {
                LV.ModifyCol(3, sortAsc ? "Sort" : "SortDesc")
                sortAsc := !sortAsc
            }
        }

        onClickRow(LV, Info) {
            SelectedFile.Text := LV.GetText(Info)
        }

        onDoubleClickRow(LV, Info) {
            Run(this.TWRPGFolder.Text "\" LV.GetText(Info))
        }

        onRightClickRow(LV, Info, IsRightClick, X, Y) {
            lvSelectedRow := Info
            fileMenu.Show()
        }

        fileMenuOpenFile(*) {
            SelectedFile.Text := this.fileList.GetText(lvSelectedRow)
        }

        fileMenuHideFile(*) {
            hiddenFilesArray.Push(this.fileList.GetText(lvSelectedRow))
            this.hiddenFilesMap.Set(this.fileList.GetText(lvSelectedRow), 0)
            try FileDelete(A_ScriptDir "\HiddenFiles.txt")
            FileAppend(Join("`n", hiddenFilesArray*), hiddenFilesAddress)
            this.updateFileList()
        }

        fileMenuShowFile(*) {
            try {
                this.hiddenFilesMap.Delete(this.fileList.GetText(lvSelectedRow))
                hiddenFilesArray := []
                for key, value in this.hiddenFilesMap {
                    hiddenFilesArray.Push(key)
                }
                FileDelete(A_ScriptDir "\HiddenFiles.txt")
                FileAppend(hiddenFilesArray.Length > 0 ? Join("`n", hiddenFilesArray*) : " ", hiddenFilesAddress)
                this.updateFileList()
            } catch Error as e {
                ToolTip(this.fileList.GetText(lvSelectedRow) " is not Hidden")
                SetTimer () => ToolTip(), 5000
            }
        }
        
        fileMenuShowHideHiddenFiles(*) {
            this.showHidden := !this.showHidden
            this.updateFileList()
        }

        ; functions
        loadSaveFile(thishotkey?) {
            path := this.TWRPGFolder.Text "\" selectedFile.Text

            ; save last load
            IniWrite(selectedFile.Text, iniFileName, "LoaderTab", "selectedFile")

            ; read save file
            if not FileExist(path) {
                ToolTip("File does not exist")
                SetTimer () => ToolTip(), -5000
                return
            }

            ; read file
            text := FileRead(path)
            ; count load codes
            StrReplace(text, "-load", "-load", , &count)

            ; get username
            pattern := '(User Name|아이디):\s((?:[^""]|\\"")*)'
            if (RegExMatch(text, pattern, &Matches) <= 0) {
                return
            }
            userName := Matches[2]

            ; get code
            i := 1
            codes := []
            while (i <= count) {
                pos := InStr(text, "-load", , 1, i)
                RegExMatch(text, "(-load [a-zA-Z\d\?@#$%&-]*)", &Match, pos)
                codes.Push(Match[1])

                i += 1
            }

            if WinExist(WarcraftIII) && !WinActivate(WarcraftIII) {
                WinActivate
            } else {
                ToolTip("Warcraft III not found")
                SetTimer () => ToolTip(), -5000
                return
            }        

            if convertNameCheckBox.Value {
                wc3Chat("-convert " userName)
            }
            for code in codes {
                wc3Chat(code)
            }
            wc3Chat("-refresh")
        }

        getHiddenFiles() {
            try {
                hiddenFilesString := FileRead(hiddenFilesAddress)
                hiddenFilesArray := StrSplit(hiddenFilesString, "`n")
                for hiddenFile in hiddenFilesArray {
                    this.hiddenFilesMap.Set(hiddenFile, 0)
                }
            }
        }
    }

    updateFileList() {
        this.fileList.Delete()

        Loop Files, this.TWRPGFolder.Text "\*.txt" {
            status := ""

            ; skip black listed file
            if this.hiddenFilesMap.Has(A_LoopFileName) {
                if !this.showHidden {
                    continue
                }

                status := "Hidden"
            }

            ; skip non save file
            text := FileRead(A_LoopFileFullPath)
            if (RegExMatch(text, '(----------(?|Hero Inventory|영웅 아이템)----------)') == 0) {
                continue
            }

            this.fileList.Add(, A_LoopFileName, FormatTime(A_LoopFileTimeModified, "MM/dd/yyyy   hh:mm tt"), A_LoopFileTimeModified, A_LoopFileSize, status)
        }

        this.fileList.ModifyCol
        this.fileList.ModifyCol(3, 0)
        this.fileList.ModifyCol(4, 80)
        if !this.showHidden {
            this.fileList.ModifyCol(5, 0)
        } else {
            this.fileList.ModifyCol(5, 60)
        }
    }

}