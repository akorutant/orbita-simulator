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
        folderProbesPath = fileToSaveDialog.folder.toString()
        if (folderProbesPath.startsWith("file://")) {
        folderProbesPath = folderProbesPath.substring(7)
        }

        settingsManager.setProbesPath(folderProbesPath)

        if (listViewProbes.currentItem) {
            pathToSave = folderProbesPath + `/${probeNameText.text}.xml`
            probes.saveToXml(listViewProbes.currentIndex, planetsItems, missionIndex, pathToSave)
        }
    }
}
