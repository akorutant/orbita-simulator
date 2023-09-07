import QtQuick.Dialogs 1.3

FileDialog {
    id: fileToSaveDialog
    title: 'Выберите папку для сохранения'
    selectFolder: true
    width: 264
    height: 146
    visible: false
    folder: pathToSave
    onAccepted: {
        var folderPath = fileDialog.folder.toString()
        if (folderPath.startsWith("file://")) {
        folderPath = folderPath.substring(7)
        }

        pathToSave = folderPath + `/${probeNameText.text}.xml`
        probes.saveToXml(listViewProbes.currentIndex, pathToSave)

//    var filerPath = fileDialog.fileUrl.toString()
//    if (filerPath.startsWith("file://")) {
//    filerPath = filerPath.substring(7)
//    }

//    pathToLoad = filerPath
//    probes.loadFromXml(pathToLoad)


    }
}
