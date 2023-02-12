#Requires AutoHotkey v2.0
#Include Helper.ahk

class LoaderTab {
    __New(MainGui, Tab) {
        ; init tab
        Tab.UseTab("Loader")

        ; drag and drop save file
        MainGui.OnEvent("DropFiles", dropSaveFiles)

        ; files
        MainGui.AddGroupBox("w550", "Files")
        selectedFileDDL := MainGui.AddDropDownList("xp+20 yp+20 w160 Choose1", [])
        selectedFileDDL.OnEvent("Change", onChangeSelectedFile)
        MainGui.AddButton("x+20 w60", "Load").OnEvent("Click", loadSaveFile)
        MainGui.AddText("x+20 yp+5", "Drag and drop new save file to anywhere")

        ; settings
        MainGui.AddGroupBox("xp-280 yp+50 w550 h100", "Settings")
        convertNameCheckBox := MainGui.AddCheckbox("xp+20 yp+20", "Convert Name for Warcraft III Reforged")
        convertNameCheckBox.OnEvent("Click", onClickConvertNameCheckBox)
        MainGui.AddText("yp+25", "TWRPG Folder:")
        TWRPGFolder := MainGui.AddEdit("w350 r1 ReadOnly", "")
        MainGui.AddButton("x+20 w60", "Select").OnEvent("Click", selectTWRPGFolder)
        MainGui.AddButton("x+20 w60", "Open").OnEvent("Click", openTWRPGFolder)

        ; stats
        MainGui.AddGroupBox("xp-470 yp+50 w550 h350", "Stats")
        statsText := MainGui.AddEdit("xp+20 yp+20 w510 h310 ReadOnly", "")

        ; init variables
        TWRPGFolder.Text := IniRead(iniFileName, "LoaderTab", "TWRPGFolder", A_MyDocuments "\Warcraft III\CustomMapData\TWRPG")
        getSaveFileNames()
        convertNameCheckBox.Value := IniRead(iniFileName, "LoaderTab", "convertNameCheckBox", true)
        selectedFileDDL.Choose(IniRead(iniFileName, "LoaderTab", "selectedFile", 0))

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


        loadSaveFile(Button, Info) {
        }

        getSaveFileNames(choose := 1) {
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
                selectedFileDDL.Choose(choose)
            }

            getStats(selectedFileDDL.Text)
        }

        onChangeSelectedFile(Button, Info) {
            IniWrite(Button.Text, iniFileName, "LoaderTab", "selectedFile")
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