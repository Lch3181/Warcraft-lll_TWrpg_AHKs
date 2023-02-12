#Requires AutoHotkey v2.0
#Include Helper.ahk

class LoaderTab {
    TWRPGFolder := A_MyDocuments "\Warcraft III\CustomMapData\TWRPG"
    saveFiles := ["Hero1", "Hero2"]

    __New(MainGui, Tab) {
        ; init tab
        Tab.UseTab("Loader")

        ; drag and drop save file
        MainGui.OnEvent("DropFiles", dropSaveFiles)

        ; files
        MainGui.AddGroupBox("w550", "Files")
        selectedFileDDL := MainGui.AddDropDownList("xp+20 yp+20 w160 Choose1", this.saveFiles)
        selectedFileDDL.OnEvent("Change", getStats)
        MainGui.AddButton("x+20 w60", "Load").OnEvent("Click", loadSaveFile)
        MainGui.AddText("x+20 yp+5", "Drag and drop new save file to anywhere")

        ; settings
        MainGui.AddGroupBox("xp-280 yp+50 w550 h100", "Settings")
        convertNameCheckBox := MainGui.AddCheckbox("xp+20 yp+20", "Convert Name for Warcraft III Reforged")
        MainGui.AddText("yp+25", "TWRPG Folder:")
        TWRPGFolderTextField := MainGui.AddEdit("w350 r1 ReadOnly", this.TWRPGFolder)
        MainGui.AddButton("x+20 w60", "Select").OnEvent("Click", selectTWRPGFolder)
        MainGui.AddButton("x+20 w60", "Open").OnEvent("Click", openTWRPGFolder)

        ; stats
        MainGui.AddGroupBox("xp-470 yp+50 w550 h350", "Stats")
        statsText := MainGui.AddEdit("xp+20 yp+20 w510 h310 ReadOnly", "")

        ; init variables
        ; get twrpg folder
        TWRPGFolderTextField.Text := this.TWRPGFolder

        ; update save files drop down list
        getSaveFileNames()

        ; events
        selectTWRPGFolder(Button, Info) {
            Folder := SelectFolder()
            if Folder != "" {
                this.TWRPGFolder := Folder
                TWRPGFolderTextField.Text := Folder
            }
            return
        }

        openTWRPGFolder(Button, Info) {
            Run(this.TWRPGFolder)
            return
        }


        loadSaveFile(Button, Info) {
            return
        }

        getStats(Button, Info) {
            address := this.TWRPGFolder "\" Button.Text ".txt"
            if not FileExist(address) {
                return
            }

            text := FileRead(address)
            pattern := "s)(\tcall Preload.*)\tcall PreloadEnd\( 0\.0 \)"

            if (RegExMatch(text, pattern, &matches) > 0) {
                text := matches[1]
                text := StrReplace(text, "	call Preload", "")
                statsText.Text := text
            }
            return
        }

        getSaveFileNames(choose := 1) {
            fileNames := []

            for file in GetFileNamesInFolder(this.TWRPGFolder) {
                text := FileRead(this.TWRPGFolder "\" file)
                ; if it is a save file
                if (RegExMatch(text, '(----------(?|Hero Inventory|영웅 아이템)----------)') > 0) {
                    fileNames.Push(StrReplace(file, ".txt", ""))
                }
            }

            if (fileNames.Length > 0) {
                this.saveFiles := fileNames
                selectedFileDDL.Delete()
                selectedFileDDL.Add(this.saveFiles)
                selectedFileDDL.Choose(choose)
                getStats(selectedFileDDL, 0)
            }

            return
        }

        dropSaveFiles(GuiObj, GuiCtrlObj, FileArray, X, Y) {
            if (Tab.Text != "Loader") {
                return
            }

            fileNames := []
            for file in FileArray {
                if InStr(file, ".txt") {
                    FileCopy(file, this.TWRPGFolder "\", 1)
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