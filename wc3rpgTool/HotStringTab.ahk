#Requires AutoHotkey v2.0
#Include Helper.ahk
#Include RegisterHotkey.ahk

class HotStringTab {
    tabName := "HotStringTab"
    hotStringArrayMap := []
    hotStrings := Map()
    focused := Gui.Control

    __New(MainGui, Tab) {
        ; init tab
        Tab.UseTab("Hotstring")
        Tab.OnEvent("Change", onChangeTab)

        ; assign
        MainGui.AddGroupBox("Section w550 h120", "Assign")
        MainGui.AddText("xp+20 yp+20 w100 h22", "Hotkey: ")
        MainGui.AddText("x+20", "Message: ")

        hotkeyButton := MainGui.AddButton("xs+20 y+5 w100 -TabStop", "")
        hotkeyButton.OnEvent("Click", onClickHotkey)
        hotStringEditGui := MainGui.AddEdit("x+20 h20 r1 w390")
        hotStringEditGui.OnEvent("Focus", onFocusEdit)

        addButton := MainGui.AddButton("xs+20 y+20 w100 h20 -TabStop", "Add")
        addButton.OnEvent("Click", onClickAdd)

        updateButton := MainGui.AddButton("x+20 w100 -TabStop", "Update")
        updateButton.OnEvent("Click", onClickUpdate)

        deleteButton := MainGui.AddButton("x+20 w100 -TabStop", "Delete")
        deleteButton.OnEvent("Click", onClickDelete)

        ; hot strings list view
        MainGui.AddGroupBox("xs ys y+40 w550 h390", "Hot Strings")
        hotStringLV := MainGui.AddListView("xp+20 yp+30 w510 h340 NoSort -Multi -TabStop", ["Hotkey", "Message"])
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
            if Tab.Text == "Hotstring" {
                hotStringEditGui.Focus()
                ih.OnEnd := endCaptureInput
            }
        }

        endCaptureInput(inputObj) {
            if (!WinActive(MainGui.Title) && Tab.Text != "Hotstring") || this.focused != hotkeyButton {
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

            ; disable old hotstring
            hsMap := this.hotStringArrayMap.Get(selectedRow)
            hs := this.hotStrings.Get(hsMap["hotkey"])
            hs.enable := false
            hs.updateHotkey()

            ; update hotstring
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

            ; disable old hotstring
            hsMap := this.hotStringArrayMap.Get(selectedRow)
            hs := this.hotStrings.Get(hsMap["hotkey"])
            hs.enable := false
            hs.updateHotkey()


            hotkeyButton.Text := ""
            hotStringEditGui.Text := ""
            this.hotStringArrayMap.RemoveAt(selectedRow)
            selectedRow := 0

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
            if !Row {
                return
            }
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

            registerHotkeys()
        }

        registerHotkeys() {
            this.hotStrings := Map()
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
                this.hotStrings.Set(key, RegisterHotkey(key, sendMessages.Bind(value), WarcraftIII, true))
            }
        }
        
        sendMessages(messages) {
            for text in messages {
                wc3Chat(text)
            }
        }
    }

    updateHotStrings() {
        for index, hs in this.hotStrings {
            hs.updateHotkey()
        }
    }
}