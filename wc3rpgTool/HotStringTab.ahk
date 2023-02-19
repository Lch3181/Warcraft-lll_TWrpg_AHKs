#Requires AutoHotkey v2.0
#Include Helper.ahk
#Include RemapHK.ahk

class HotStringTab {
    tabName := "HotStringTab"
    hotStringArrayMap := []
    hotStrings := []
    focused := Gui.Control

    __New(MainGui, Tab) {
        ; init tab
        Tab.UseTab("Hot String")
        Tab.OnEvent("Change", onChangeTab)

        ; assign
        MainGui.AddGroupBox("Section w550 h120", "Assign")
        MainGui.AddText("xp+20 yp+20 w100 h22", "Hotkey: ")
        MainGui.AddText("x+20", "Text: ")

        hotkeyButton := MainGui.AddButton("xs+20 y+5 w100", "")
        hotkeyButton.OnEvent("Click", onClickHotkey)
        hotStringEditGui := MainGui.AddEdit("x+20 h20 r1 w390")
        hotStringEditGui.OnEvent("Focus", onFocusEdit)

        addButton := MainGui.AddButton("xs+20 y+20 w100 h20", "Add")
        addButton.OnEvent("Click", onClickAdd)

        updateButton := MainGui.AddButton("x+20 w100", "Update")
        updateButton.OnEvent("Click", onClickUpdate)

        deleteButton := MainGui.AddButton("x+20 w100", "Delete")
        deleteButton.OnEvent("Click", onClickDelete)

        ; hot strings list view
        MainGui.AddGroupBox("xs ys y+40 w550 h390", "Hot Strings")
        hotStringLV := MainGui.AddListView("xp+20 yp+30 w510 h340 NoSort -Multi", ["Hotkey", "Text"])
        hotStringLV.OnEvent("Click", onClickRow)
        hotStringLV.ModifyCol(1, 100)
        hotStringLV.ModifyCol(2, 400)

        ; init
        ih.OnEnd := endCaptureInput
        currenHotkey := ""
        selectedRow := 0
        getHotStrings()

        ; events
        onClickHotkey(Button, Info) {
            ; remove existing text
            Button.Text := ""

            ; capture input
            if not ih.InProgress {
                this.focused := Button
                KeyWaitCombo()
            }
        }

        onFocusEdit(Edit, Info) {
            this.focused := Edit
        }

        onChangeTab(Tab, Info) {
            ih.Stop()
            if Tab.Text == "Hot String" {
                ih.OnEnd := endCaptureInput
            }
        }

        endCaptureInput(inputObj) {
            if (!WinActive(A_ScriptName) && Tab.Text != "Hot String") || this.focused != hotkeyButton {
                return
            }

            ; captured input
            currenHotkey := "$" ih.EndMods . ih.EndKey
            hotkeyButton.Text := ReadableHotkey(currenHotkey, true)
        }

        onClickAdd(Button, Info) {
            text := hotStringEditGui.Text
            hk := hotkeyButton.Text

            if !text || !hk {
                return
            }

            hotStringLV.Add(, hk, text)
            this.hotStringArrayMap.Push(Map(
                "hotkey", currenHotkey,
                "text", text))

            for index, value in this.hotStringArrayMap {
                ; write hotkey
                IniWrite(value["hotkey"], iniFileName, this.tabName, "hotkey" index)

                ;write text
                IniWrite(value["text"], iniFileName, this.tabName, "text" index)
            }

            getHotStrings()
        }

        onClickUpdate(Button, Info) {
            if !selectedRow {
                return
            }

            newText := hotStringEditGui.Text
            newhk := currenHotkey
            this.hotStringArrayMap[selectedRow]["text"] := newText
            this.hotStringArrayMap[selectedRow]["hotkey"] := newhk

            for index, value in this.hotStringArrayMap {
                ; write hotkey
                IniWrite(value["hotkey"], iniFileName, this.tabName, "hotkey" index)

                ;write text
                IniWrite(value["text"], iniFileName, this.tabName, "text" index)
            }

            getHotStrings()
        }

        onClickDelete(Button, Info) {
            if !selectedRow {
                return
            }

            hotkeyButton.Text := ""
            hotStringEditGui.Text := ""
            selectedRow := 0
            this.hotStringArrayMap.RemoveAt(selectedRow)
            IniDelete(iniFileName, this.tabName)

            for index, value in this.hotStringArrayMap {
                ; write hotkey
                IniWrite(value["hotkey"], iniFileName, this.tabName, "hotkey" index)

                ;write text
                IniWrite(value["text"], iniFileName, this.tabName, "text" index)
            }

            getHotStrings()
        }

        onClickRow(LV, Row) {
            selectedRow := Row
            hotkeyButton.Text := LV.GetText(Row, 1)
            hotStringEditGui.Text := LV.GetText(Row, 2)
            currenHotkey := this.hotStringArrayMap[Row]["hotkey"]
        }

        ; functions
        getHotStrings() {
            hotStringLV.Delete()
            this.hotStringArrayMap := []

            hk := ""
            text := ""

            hotStringList := IniRead(iniFileName, this.tabName,, "")
            loop parse hotStringList, "`n" {
                split := StrSplit(A_LoopField, "=", , 2)
                if InStr(split[1], "hotkey") {
                    hk := split[2]
                } else if InStr(split[1], "text") {
                    text := split[2]
                    hotStringLV.Add(, ReadableHotkey(hk, true), text)
                    this.hotStringArrayMap.Push(Map(
                        "hotkey", hk,
                        "text", text))
                } else {
                    continue
                }
            }

            this.registerHotkeys()
        }
    }

    registerHotkeys() {
        this.hotStrings := []
        hotStringsTextMap := Map()
        hotStringIndexKey := Map()

        ; filter same hotkey and hot strings together
        for index, value in this.hotStringArrayMap {
            if !hotStringsTextMap.Has(value["hotkey"]) {
                hotStringsTextMap.Set(value["hotkey"], [])
                hotStringIndexKey.Set(value["hotkey"], index)
            }
            hotStringsTextMap[value["hotkey"]].Push(value["text"])
        }

        ; register hotstrings
        for key, value in hotStringsTextMap {
            index := hotStringIndexKey.Get(key)
            this.hotStrings.Push(RemapHK("hotkey" index, this.tabName, WarcraftIII, "",, true, value))
        }
    }

    updateHotStrings() {
        for hk in this.hotStrings {
            hk.registerHotkey()
        }
    }
}