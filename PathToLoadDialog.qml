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
        var folderPath = fileToLoadDialog.folder.toString()

        if (filePath.startsWith("file://") || folderPath.startsWith("file://")) {
            pathToLoad = folderPath.substring(7)
            var fileToSave = filePath.substring(7)
        }

        probes.loadFromXml(fileToSave)
        listViewProbes.currentIndex = probes.size() - 1
        currentProbe = listViewProbes.currentItem.probesModelData

        devicesItems.changeDevices(probes, listViewProbes.currentIndex)
        stepsActivityItems.changeSteps(probes, listViewProbes.currentIndex)
        stepsLandingItems.changeSteps(probes, listViewProbes.currentIndex)

        probeNameText.text = `${currentProbe.probeName}`

        firstNumber.text = `${currentProbe.innerRadius}`
        secondNumber.text = `${currentProbe.outerRadius}`

        itemsEnabled = true
    }
}
