#Requires AutoHotkey v2.0
#Include Helper.ahk

class HostTab {
    __New(MainGui, Tab) {
        ; init tab
        Tab.UseTab("Host")

        ; hosting
        MainGui.AddGroupBox("Section w550 h380", "Host")

        ; bot name
        MainGui.AddText("xp+20 yp+20 w200", "Bot Name: ")
        botNameCB := MainGui.AddComboBox("y+5 w200", [])
        MainGui.AddButton("x+20 yp-1 w100 -TabStop vbotNameClear", "Clear")
            .OnEvent("Click", onClickClear)
        MainGui.AddButton("x+20 w100 -TabStop vbotNameDelete", "Delete")
            .OnEvent("Click", onClickDelete)

        ; trigger
        MainGui.AddText("xs+20 y+20 w200", "Trigger: ")
        triggerCB := MainGui.AddComboBox("y+5 w200 Choose1", ["!"])
        MainGui.AddButton("x+20 yp-1 w100 -TabStop vtriggerClear", "Clear")
            .OnEvent("Click", onClickClear)
        MainGui.AddButton("x+20 w100 -TabStop vtriggerDelete", "Delete")
            .OnEvent("Click", onClickDelete)

        ; game name
        MainGui.AddText("xs+20 y+20 w200", "Game Name:")
        gameNameCB := MainGui.AddComboBox("y+5 w200", [])
        MainGui.AddButton("x+20 yp-1 w100 -TabStop vgameNameClear", "Clear")
            .OnEvent("Click", onClickClear)
        MainGui.AddButton("x+20 w100 -TabStop vgamenameDelete", "Delete")
            .OnEvent("Click", onClickDelete)

        ; extra command before host
        MainGui.AddText("xs+20 y+20 w200", "Extra Command Before Host:")
        exCommandBeforeCB := MainGui.AddComboBox("y+5 w200", [])
        MainGui.AddButton("x+20 yp-1 w100 -TabStop vexCommandBeforeClear", "Clear")
            .OnEvent("Click", onClickClear)
        MainGui.AddButton("x+20 w100 -TabStop vexCommandBeforeDelete", "Delete")
            .OnEvent("Click", onClickDelete)

        ; extra command after host
        MainGui.AddText("xs+20 y+20 w200", "Extra Command After Host:")
        exCommandAfterCB := MainGui.AddComboBox("y+5 w200", [])
        MainGui.AddButton("x+20 yp-1 w100 -TabStop vexCommandAfterClear", "Clear")
            .OnEvent("Click", onClickClear)
        MainGui.AddButton("x+20 w100 -TabStop vexCommandAfterDelete", "Delete")
            .OnEvent("Click", onClickDelete)

        ; send hosting message
        MainGui.AddButton("xs+20 y+20 w210 h40 -TabStop vprivate", "Host Private Lobby")
            .OnEvent("Click", onClickHostButton)
        MainGui.AddButton("x+20 w210 h40 -TabStop vpublic", "Host Public Lobby")
            .OnEvent("Click", onClickHostButton)

        ; hotstrings
        MainGui.AddGroupBox("xs ys y+40 Section w550 h100", "Hotstrings")
        MainGui.AddText("xp+20 yp+25 w120 h20 Border 0x200 Center", "-h / -host").SetFont("s10")
        MainGui.AddText("x+20 yp+2", "wc3 Ingame Command to Host Private Lobby")

        MainGui.AddText("xs+20 y+20 w120 h20 Border 0x200 Center", "-hp / -hostpub").SetFont("s10")
        MainGui.AddText("x+20 yp+2", "wc3 Ingame Command to Host Public Lobby")

        ; init
        tabName := "HostTab"
        botNameCB.Delete()
        botNameCB.Add(StrSplit(IniRead(iniFileName, tabName, "botName", ""), "|"))
        botNameCB.Text := IniRead(iniFileName, tabName, "botNameHistory", "geybot")

        triggerCB.Delete()
        triggerCB.Add(StrSplit(IniRead(iniFileName, tabName, "trigger", ""), "|"))
        triggerCB.Text := IniRead(iniFileName, tabName, "triggerHistory", "!")

        gameNameCB.Delete()
        gameNameCB.Add(StrSplit(IniRead(iniFileName, tabName, "gameName", ""), "|"))
        gameNameCB.Text := IniRead(iniFileName, tabName, "gameNameHistory", "sey")

        exCommandBeforeCB.Delete()
        exCommandBeforeCB.Add(StrSplit(IniRead(iniFileName, tabName, "exCommandBefore", ""), "|"))
        exCommandBeforeCB.Text := IniRead(iniFileName, tabName, "exCommandBeforeHistory", "")

        exCommandAfterCB.Delete()
        exCommandAfterCB.Add(StrSplit(IniRead(iniFileName, tabName, "exCommandAfter", ""), "|"))
        exCommandAfterCB.Text := IniRead(iniFileName, tabName, "exCommandAfterHistory", "")


        ; hotstring
        HotIfWinactive(WarcraftIII)
        Hotstring(":XB0:-h", hostPriv)
        Hotstring(":XB0:-host", hostPriv)
        Hotstring(":XB0:-hp", hostPub)
        Hotstring(":XB0:-hostpub", hostPub)
        HotIfWinactive()

        ; events
        onClickClear(Button, Info) {
            switch true {
                case Instr(Button.Name, "botName"):
                    botNameCB.Text := ""
                case Instr(Button.Name, "trigger"):
                    triggerCB.Text := ""
                case Instr(Button.Name, "gameName"):
                    gameNameCB.Text := ""
                case Instr(Button.Name, "exCommandBefore"):
                    exCommandBeforeCB.Text := ""
                case Instr(Button.Name, "exCommandAfter"):
                    exCommandAfterCB.Text := ""
                default:
                    return
            }
        }

        onClickDelete(Button, Info) {
            switch true {
                case Instr(Button.Name, "botName"):
                    row := botNameCB.Value
                    if row {
                        ; remove row
                        botNameCB.Delete(row)
                        botNameArray := ControlGetItems(botNameCB.hwnd)
                        IniWrite(Join("|", botNameArray*), iniFileName, tabName, "botName")                        
                    }

                    ; remove history if equal
                    if IniRead(iniFileName, tabName, "botNameHistory", "") == botNameCB.Text {
                        IniWrite("", iniFileName, tabName, "botNameHistory")
                    }

                    ; clear text
                    botNameCB.Text := ""
                case Instr(Button.Name, "trigger"):
                    row := triggerCB.Value
                    if row {
                        ; remove row
                        triggerCB.Delete(row)
                        triggerArray := ControlGetItems(triggerCB.hwnd)
                        IniWrite(Join("|", triggerArray*), iniFileName, tabName, "trigger")
                    }

                    ; remove history if equal
                    if IniRead(iniFileName, tabName, "triggerHistory", "") == triggerCB.Text {
                        IniWrite("", iniFileName, tabName, "triggerHistory")
                    }

                    ; clear text
                    triggerCB.Text := ""
                case Instr(Button.Name, "gameName"):
                    row := gameNameCB.Value
                    if row {
                        ; remove row
                        gameNameCB.Delete(row)
                        gameNameArray := ControlGetItems(gameNameCB.hwnd)
                        IniWrite(Join("|", gameNameArray*), iniFileName, tabName, "gameName")
                    }

                    ; remove history if equal
                    if IniRead(iniFileName, tabName, "gameNameHistory", "") == gameNameCB.Text {
                        IniWrite("", iniFileName, tabName, "gameNameHistory")
                    }

                    ; clear text
                    gameNameCB.Text := ""
                case Instr(Button.Name, "exCommandBefore"):
                    row := exCommandBeforeCB.Value
                    if row {
                        ; remove row
                        exCommandBeforeCB.Delete(row)
                        exCommandBeforeArray := ControlGetItems(exCommandBeforeCB.hwnd)
                        IniWrite(Join("|", exCommandBeforeArray*), iniFileName, tabName, "exCommandBefore")
                    }

                    ; remove history if equal
                    if IniRead(iniFileName, tabName, "exCommandBeforeHistory", "") == exCommandBeforeCB.Text {
                        IniWrite("", iniFileName, tabName, "exCommandBeforeHistory")
                    }

                    ; clear text
                    exCommandBeforeCB.Text := ""
                case Instr(Button.Name, "exCommandAfter"):
                    row := exCommandAfterCB.Value
                    if row {
                        ; remove row
                        exCommandAfterCB.Delete(row)
                        exCommandAfterArray := ControlGetItems(exCommandAfterCB.hwnd)
                        IniWrite(Join("|", exCommandAfterArray*), iniFileName, tabName, "exCommandAfter")
                    }

                    ; remove history if equal
                    if IniRead(iniFileName, tabName, "exCommandAfterHistory", "") == exCommandAfterCB.Text {
                        IniWrite("", iniFileName, tabName, "exCommandAfterHistory")
                    }

                    ; clear text
                    exCommandAfterCB.Text := ""
                default:
                    return
            }


        }

        onClickHostButton(Button, Info) {
            switch Button.Name {
                case "private":
                    host()
                case "public":
                    host(false)
                default:
                    return
            }
        }

        hostPriv(*) {
            host()
        }

        hostPub(*) {
            host(false)
        }

        ; functions
        host(private := true) {
            ; guard info
            if !botNameCB.Text || !triggerCB.Text || !gameNameCB.Text {
                ToolTip("bot name, trigger, and game name cannot be empty")
                SetTimer () => ToolTip(), -5000
                return
            }

            ; guard wc3 exist
            if WinExist(WarcraftIII) && !WinActivate(WarcraftIII) {
                WinActivate
            } else {
                ToolTip("Warcraft III not found")
                SetTimer () => ToolTip(), -5000
                return
            }

            MainGui.Submit()
            global showMainGui := false

            ; lobby type
            lobbyType := "priv"
            if !private {
                lobbyType := "pub"
            }

            if exCommandBeforeCB.Text {
                wc3Chat("/w " botNameCB.Text " " triggerCB.Text exCommandBeforeCB.Text)

            }
            wc3Chat("/w " botNameCB.Text " " triggerCB.Text lobbyType " " gameNameCB.Text)
            if exCommandAfterCB.Text {
                wc3Chat("/w " botNameCB.Text " " triggerCB.Text exCommandAfterCB.Text)
            }
            wc3Chat("Game Name: " gameNameCB.Text)

            ; write ini
            IniWrite(botNameCB.Text, iniFileName, tabName, "botNameHistory")
            IniWrite(triggerCB.Text, iniFileName, tabName, "triggerHistory")
            IniWrite(gameNameCB.Text, iniFileName, tabName, "gameNameHistory")
            IniWrite(exCommandBeforeCB.Text, iniFileName, tabName, "exCommandBeforeHistory")
            IniWrite(exCommandAfterCB.Text, iniFileName, tabName, "exCommandAfterHistory")

            botNameArray := ControlGetItems(botNameCB.hwnd)
            triggerArray := ControlGetItems(triggerCB.hwnd)
            gameNameArray := ControlGetItems(gameNameCB.hwnd)
            exCommandBeforeArray := ControlGetItems(exCommandBeforeCB.hwnd)
            exCommandAfterArray := ControlGetItems(exCommandAfterCB.hwnd)

            if !ArrayItemExist(botNameCB.Text, botNameArray*) {
                botNameArray.Push(botNameCB.Text)
            }
            if !ArrayItemExist(triggerCB.Text, triggerArray*) {
                triggerArray.Push(triggerCB.Text)
            }
            if !ArrayItemExist(gameNameCB.Text, gameNameArray*) {
                gameNameArray.Push(gameNameCB.Text)
            }
            if !ArrayItemExist(exCommandAfterCB.Text, exCommandAfterArray*) {
                exCommandAfterArray.Push(exCommandAfterCB.Text)
            }
            if !ArrayItemExist(exCommandBeforeCB.Text, exCommandBeforeArray*) {
                exCommandBeforeArray.Push(exCommandBeforeCB.Text)
            }

            IniWrite(Join("|", botNameArray*), iniFileName, tabName, "botName")
            IniWrite(Join("|", triggerArray*), iniFileName, tabName, "trigger")
            IniWrite(Join("|", gameNameArray*), iniFileName, tabName, "gameName")
            IniWrite(Join("|", exCommandBeforeArray*), iniFileName, tabName, "exCommandBefore")
            IniWrite(Join("|", exCommandAfterArray*), iniFileName, tabName, "exCommandAfter")

            ; update combobox
            botNameCB.Delete()
            botNameCB.Add(StrSplit(IniRead(iniFileName, tabName, "botName", ""), "|"))
            botNameCB.Text := IniRead(iniFileName, tabName, "botNameHistory", "")

            triggerCB.Delete()
            triggerCB.Add(StrSplit(IniRead(iniFileName, tabName, "trigger", ""), "|"))
            triggerCB.Text := IniRead(iniFileName, tabName, "triggerHistory", "!")

            gameNameCB.Delete()
            gameNameCB.Add(StrSplit(IniRead(iniFileName, tabName, "gameName", ""), "|"))
            gameNameCB.Text := IniRead(iniFileName, tabName, "gameNameHistory", "")

            exCommandBeforeCB.Delete()
            exCommandBeforeCB.Add(StrSplit(IniRead(iniFileName, tabName, "exCommandBefore", ""), "|"))
            exCommandBeforeCB.Text := IniRead(iniFileName, tabName, "exCommandBeforeHistory", "")

            exCommandAfterCB.Delete()
            exCommandAfterCB.Add(StrSplit(IniRead(iniFileName, tabName, "exCommandAfter", ""), "|"))
            exCommandAfterCB.Text := IniRead(iniFileName, tabName, "exCommandAfterHistory", "")
        }
    }
}