#Requires AutoHotkey v2.0
#Include Helper.ahk

class LoaderTab {
    __New(MainGui, Tab) {
        ; init tab
        Tab.UseTab("Loader")

        ; drag and drop save file
        MainGui.OnEvent("DropFiles", dropSaveFiles)

        ; files
        MainGui.AddGroupBox("Section w550", "Files")
        selectedFileDDL := MainGui.AddDropDownList("xp+20 yp+20 w160 Choose1", [])
        selectedFileDDL.OnEvent("Change", onChangeSelectedFile)
        MainGui.AddButton("x+20 w60", "Load").OnEvent("Click", load)
        MainGui.AddText("x+20 yp+5", "Drag and drop new save file to anywhere")

        ; settings
        MainGui.AddGroupBox("Section xs ys y+30 w550 h100", "Settings")
        convertNameCheckBox := MainGui.AddCheckbox("xp+20 yp+20", "Convert Name for Warcraft III Reforged")
        convertNameCheckBox.OnEvent("Click", onClickConvertNameCheckBox)
        MainGui.AddText("yp+25", "TWRPG Folder:")
        TWRPGFolder := MainGui.AddEdit("w350 r1 ReadOnly", "")
        MainGui.AddButton("x+20 w60", "Select").OnEvent("Click", selectTWRPGFolder)
        MainGui.AddButton("x+20 w60", "Open").OnEvent("Click", openTWRPGFolder)

        ; stats
        MainGui.AddGroupBox("Section xs ys y+30 w550 h350", "Stats")
        statsText := MainGui.AddEdit("xp+20 yp+20 w510 h310 ReadOnly", "")

        ; init variables
        TWRPGFolder.Text := IniRead(iniFileName, "LoaderTab", "TWRPGFolder", A_MyDocuments "\Warcraft III\CustomMapData\TWRPG")
        getSaveFileNames(IniRead(iniFileName, "LoaderTab", "selectedFile", ""))
        convertNameCheckBox.Value := IniRead(iniFileName, "LoaderTab", "convertNameCheckBox", true)

        ; hotstrings
        HotIfWinactive(WarcraftIII)
        Hotstring(":XB0:-l", loadSaveFile)
        HotIfWinactive()

        ; events
        selectTWRPGFolder(Button, Info) {
            Folder := SelectFolder()
            if Folder != "" {
                TWRPGFolder.Text := Folder
                IniWrite(TWRPGFolder.Text, iniFileName, "LoaderTab", "TWRPGFolder")
                getSaveFileNames()
            }
        }

        openTWRPGFolder(Button, Info) {
            Run(TWRPGFolder.Text)
        }


        load(Button, Info) {
            loadSaveFile()
        }

        loadSaveFile(thishotkey?) {
            path := TWRPGFolder.Text "\" selectedFileDDL.Text ".txt"

            ; save last load
            IniWrite(selectedFileDDL.Text, iniFileName, "LoaderTab", "selectedFile")

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

            wc3Chat("-convert " userName)
            for code in codes {
                wc3Chat(code)
            }
            wc3Chat("-refresh")
        }

        getSaveFileNames(choose := "") {
            fileNames := []

            for file in GetFileNamesInFolder(TWRPGFolder.Text) {
                text := FileRead(TWRPGFolder.Text "\" file)
                ; if it is a save file
                if (RegExMatch(text, '(----------(?|Hero Inventory|영웅 아이템)----------)') > 0) {
                    fileNames.Push(StrReplace(file, ".txt", ""))
                }
            }

            selectedFileDDL.Delete()
            selectedFileDDL.Add(fileNames)

            if (fileNames.Length > 0) {
                if choose == "" {
                    selectedFileDDL.Choose(1)
                } else {
                    selectedFileDDL.Choose(choose)
                }
            }

            getStats(selectedFileDDL.Text)
        }

        onChangeSelectedFile(Button, Info) {
            getStats(Button.Text)
        }

        getStats(fileName) {
            address := TWRPGFolder.Text "\" fileName ".txt"
            if not FileExist(address) {
                statsText.Text := ""
                return
            }

            text := FileRead(address)
            pattern := "s)(\tcall Preload.*)\tcall PreloadEnd\( 0\.0 \)"

            if (RegExMatch(text, pattern, &matches) > 0) {
                text := matches[1]
                text := StrReplace(text, "	call Preload", "")
                statsText.Text := text
            } else {
                statsText.Text := ""
            }
        }

        onClickConvertNameCheckBox(Button, Info) {
            IniWrite(Button.Value, iniFileName, "LoaderTab", "convertNameCheckBox")
        }

        dropSaveFiles(GuiObj, GuiCtrlObj, FileArray, X, Y) {
            if (Tab.Text != "Loader") {
                return
            }

            fileNames := []
            for file in FileArray {
                if InStr(file, ".txt") {
                    FileCopy(file, TWRPGFolder.Text "\", 1)
                    split := StrSplit(file, "\")
                    fileNames.Push(StrReplace(split.Pop(), ".txt", ""))
                }
            }
            if (fileNames.Length > 0) {
                MsgBox("Added: `n" Join("`n", fileNames*))
                getSaveFileNames(fileNames[1])
            }
        }
    }
}