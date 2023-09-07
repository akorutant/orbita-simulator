import QtQuick.Dialogs 1.3

FileDialog {
    id: fileToLoadDialog
    title: 'Выберите файл для загрузки'
    selectFolder: false
    width: 264
    height: 146
    visible: false
    folder: pathToLoad
    onAccepted: {
        var filePath = fileToLoadDialog.fileUrl.toString()
        if (filePath.startsWith("file://")) {
            pathToLoad = filePath.substring(7)
        }

        probes.loadFromXml(pathToLoad)
    }
}
