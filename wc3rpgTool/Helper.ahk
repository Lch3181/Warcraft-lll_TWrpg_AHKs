SelectFolder() {
    Folder := DirSelect(, 0)
    return Folder
}

GetFileNamesInFolder(path) {
    fileNames := []
    loop files path "\*.txt" {
        fileNames.Push(A_LoopFileName)
    }
    return fileNames
}

Join(sep, params*) {
    for index,param in params
        str .= param . sep
    return SubStr(str, 1, -StrLen(sep))
}