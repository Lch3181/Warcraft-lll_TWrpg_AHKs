#Requires AutoHotkey v2.0
#Include wc3rpgTool.ahk
#Include Helper.ahk

class LoaderTab {
    tabName := "LoaderTab"
    fileList := Gui.ListView
    filter := ""
    TWRPGFolder := Gui.Edit
    showHidden := false
    hiddenFilesMap := Map()
    
    __New(MainGui, Tab) {
        ; init tab
        Tab.UseTab("Loader")

        ; drag and drop save file
        MainGui.OnEvent("DropFiles", dropSaveFiles)

        ; loader
        MainGui.AddGroupBox("Section w550", "Load")
        SelectedFile := MainGui.AddText("xp+20 yp+25 w100", "")
        MainGui.AddButton("x+20 ys+20 w100 default", "Load").OnEvent("Click", loadButton)
        MainGui.AddText("x+20 yp+5", "Drag and drop new save file to anywhere")

        ; hot strings
        MainGui.AddGroupBox("xs ys y+25 Section w550 h100", "Hotstrings")
        MainGui.AddText("xp+20 yp+25 w200 h20 Border 0x200 Center", "-l (filename) / -load (filename)").SetFont("s10")
        MainGui.AddText("x+20 yp+2", "wc3 ingame command to Load (optional filename) or selected file")

        MainGui.AddText("xs+20 y+20 w200 h20 Border 0x200 Center", "-ll / -loadlast").SetFont("s10")
        MainGui.AddText("x+20 yp+2", "wc3 ingame command to Load Last Loaded Save File")
        

        ; files
        MainGui.AddGroupBox("Section xs ys y+30 w550 h265", "Files")
        MainGui.AddText("xp+20 yp+20 w510", "Search: ")
        MainGui.AddEdit("xs+20 y+5 w510 -TabStop", this.filter).OnEvent("Change", onChangeFilterText)
        this.fileList := MainGui.AddListView("xs+20 y+10 w510 h180 Sort -TabStop", ["Name", "Date", "Hidden Date", "Status", "Loading Message"])
        this.fileList.OnEvent("Click", onClickRow)
        this.fileList.OnEvent("DoubleClick", onDoubleClickRow)
        this.fileList.OnEvent("ContextMenu", onRightClickRow)

        ; file Menu
        fileMenu := Menu()
        fileMenu.Add("Open", fileMenuOpenFile)
        fileMenu.Add()
        fileMenu.Add("Add Loading Message", fileMenuAddLoadingMessage)
        fileMenu.Add()
        fileMenu.Add("Hide File", fileMenuHideFile)
        fileMenu.Add("Show File", fileMenuShowFile)
        fileMenu.Add("Show / Hide Hidden Files", fileMenuShowHideHiddenFiles)

        ; settings
        MainGui.AddGroupBox("Section xs ys y+20 w550 h100", "Settings")
        convertNameCheckBox := MainGui.AddCheckbox("xp+20 yp+20 -TabStop", "Convert Name for Warcraft III Reforged")
        convertNameCheckBox.OnEvent("Click", onClickConvertNameCheckBox)
        MainGui.AddText("yp+25", "TWRPG Folder:")
        this.TWRPGFolder := MainGui.AddEdit("w350 r1 ReadOnly -TabStop", "")
        MainGui.AddButton("x+20 w60 -TabStop", "Select").OnEvent("Click", selectButton)
        MainGui.AddButton("x+20 w60 -TabStop", "Open").OnEvent("Click", openButton)

        ; init variables
        sortAsc := false
        lvSelectedRow := 0
        this.showHidden := false
        hiddenFilesAddress := A_ScriptDir "\HiddenFiles.txt"
        hiddenFilesArray := []
        this.hiddenFilesMap := Map()

        getHiddenFiles()
        SelectedFile.Text := IniRead(iniFileName, this.tabName, "selectedFile", "N/A")
        this.TWRPGFolder.Text := IniRead(iniFileName, this.tabName, "TWRPGFolder", A_MyDocuments "\Warcraft III\CustomMapData\TWRPG")
        convertNameCheckBox.Value := IniRead(iniFileName, this.tabName, "convertNameCheckBox", true)
        this.updateFileList()

        ; hotstrings
        HotIfWinactive(WarcraftIII)
        Hotstring(":*XB0:-l", loadSaveFileHK)
        Hotstring(":*XB0:-load", loadSaveFileHK)
        #Hotstring EndChars `n
        Hotstring(":XB0:-ll", loadLastSaveFileHistoryHK)
        Hotstring(":XB0:-loadlast", loadLastSaveFileHistoryHK)
        #Hotstring
        HotIfWinactive()

        ; events
        selectButton(Button, Info) {
            Folder := SelectFolder()
            if Folder != "" {
                this.TWRPGFolder.Text := Folder
                IniWrite(this.TWRPGFolder.Text, iniFileName, this.tabName, "TWRPGFolder")
                this.updateFileList()
            }
        }

        openButton(Button, Info) {
            Run(this.TWRPGFolder.Text)
        }

        loadButton(Button, Info) {
            loadSaveFile()
        }

        onClickConvertNameCheckBox(CheckBox, Info) {
            IniWrite(CheckBox.Value, iniFileName, this.tabName, "convertNameCheckBox")
        }

        dropSaveFiles(GuiObj, GuiCtrlObj, FileArray, X, Y) {
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

            this.updateFileList()
        }

        onChangeFilterText(Edit, Info) {
            this.filter := Edit.Text
            this.updateFileList()
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
            Run(this.TWRPGFolder.Text "\" SelectedFile.Text)
        }

        fileMenuAddLoadingMessage(*) {
            ; get filename
            file := this.fileList.GetText(lvSelectedRow)

            ; get existing message if any
            message := IniRead(iniFileName, this.tabName, file, "")

            ; promote for input
            IB := InputBox("Enter the message you want to show when loading", "Loading Message", "h100", message)
            if IB.Result == "Cancel" {
                return
            }

            ; store message
            IniWrite(IB.Value, iniFileName, this.tabName, file)
            this.updateFileList()
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

        loadSaveFileHK(thishotkey?) {
            outputVar := GetInput()
            if !outputVar {
                outputVar := SelectedFile.Text
            } else if SubStr(outputVar, 1, 1) == " " {
                outputVar := SubStr(outputVar, 2)
            } else {
                return
            }
            
            if !InStr(outputVar, ".txt") {
                outputVar .= ".txt"
            }
            loadSaveFile(false, outputVar)
        }

        loadLastSaveFileHistoryHK(thishotkey?) {
            loadSaveFile(true)
        }

        ; functions
        loadSaveFile(lastSaveFile := false, saveFileName := SelectedFile.Text) {
            global showMainGui := false
            if lastSaveFile {
                saveFileName := IniRead(iniFileName, this.tabName, "selectedFile", SelectedFile.Text)
            }
            path := this.TWRPGFolder.Text "\" saveFileName

            ; save last load
            IniWrite(selectedFile.Text, iniFileName, this.tabName, "selectedFile")

            ; read save file
            if not FileExist(path) {
                ToolTip("File does not exist")
                SetTimer () => ToolTip(), -5000
                return
            }

            MainGui.Hide()

            ; read file
            text := FileRead(path, "UTF-8")
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

            ; loading message
            message := IniRead(iniFileName, this.tabName, saveFileName, "")
            if message {
                wc3Chat(message)
            }
            ; convert name
            if convertNameCheckBox.Value {
                wc3Chat("-convert " userName)
            }
            ; loadcodes
            for code in codes {
                Sleep(200)
                wc3Chat(code)
            }
            ; clean screen
            wc3Chat("-refresh")

            ; bind hero to 1
            Sleep(1000)
            ControlSend("{f1}{Ctrl Down}{1}{Ctrl Up}",, WarcraftIII)

            ; summon bag after loading
            if IniRead(iniFileName, "SettingsTab", "summonBagAfterLoad", false) {
                ControlSend("{Esc}",, WarcraftIII)
            }
            
            ; enable tool after loading
            if IniRead(iniFileName, "SettingsTab", "enableToolAfterLoad", false) {
                global toolEnabled := false
                toggleTool()
            }
        }

        getHiddenFiles() {
            try {
                hiddenFilesString := FileRead(hiddenFilesAddress, "UTF-8")
                hiddenFilesArray := StrSplit(hiddenFilesString, "`n")
                for hiddenFile in hiddenFilesArray {
                    this.hiddenFilesMap.Set(hiddenFile, 0)
                }
            }
        }
    }

    updateFileList() {
        this.fileList.Delete()
        hasLoadingMessage := false

        Loop Files, this.TWRPGFolder.Text "\*.txt" {
            if (this.filter && !InStr(A_LoopFileName, this.filter)) {
                continue
            }
            status := ""

            ; skip black listed file
            if this.hiddenFilesMap.Has(A_LoopFileName) {
                if !this.showHidden {
                    continue
                }

                status := "Hidden"
            }

            ; skip non save file
            text := FileRead(A_LoopFileFullPath, "UTF-8")
            if (RegExMatch(text, '(----------(?|Hero Inventory|영웅 아이템)----------)') == 0) {
                continue
            }

            ; get loading message
            message := IniRead(iniFileName, this.tabName, A_LoopFileName, "")
            if message {
                hasLoadingMessage := true
            }

            this.fileList.Add(, A_LoopFileName, FormatTime(A_LoopFileTimeModified, "MM/dd/yyyy   hh:mm tt"), A_LoopFileTimeModified, status, message)
        }

        this.fileList.ModifyCol(1, "Auto")
        this.fileList.ModifyCol(2, "Auto")
        this.fileList.ModifyCol(3, 0)
        if !this.showHidden {
            this.fileList.ModifyCol(4, 0)
        } else {
            this.fileList.ModifyCol(4, 60)
        }
        if !hasLoadingMessage {
            this.fileList.ModifyCol(5, 0)
        } else {
            this.fileList.ModifyCol(5, "Auto")
        }
    }
}