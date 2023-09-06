import QtQuick.Dialogs 1.3

FileDialog {
    id: fileDialog
    title: qsTr("Выберите папку для сохранения")
    selectFolder: true
    width: 264
    height: 146
    visible: false
    folder: pathFile
    onAccepted: {
        var folderPath = fileDialog.folder.toString()
        if (folderPath.startsWith("file://")) {
            folderPath = folderPath.substring(7) // Удаляем "file://"
        }
        pathFile = folderPath + `/${probeNameText.text}.xml`
        probes.saveToXml(listViewProbes.currentIndex, pathFile)
    }
}
