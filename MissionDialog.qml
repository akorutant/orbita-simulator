import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Dialog  {
    id: missionDialog
    width: 264
    height: 146
    visible: false
    modal: true
    ErrorMessage {id: errorDialog}
    property ListModel clear: ListModel {}

    title: qsTr("Выберите тип миссии")
    x: mainWindow.width / 2 - width / 2
    y: mainWindow.height / 2 - height / 2
    ColumnLayout {
        anchors.fill: parent
        RowLayout {
            height: parent.height * 0.3
            width: parent.width
            Layout.preferredWidth: width
            Layout.preferredHeight: height
            ComboBox {
                id: missonSelect
                width: parent.width * 0.45
                height: parent.height
                Layout.preferredWidth: width
                Layout.preferredHeight: height
                editable: false
                model: ListModel {
                    id: modelMissions
                    ListElement { text: "Планеты" }
                    ListElement { text: "Земля" }
                }
                onAccepted: {
                    if (find(editText) === -1)
                        model.append({text: editText})
                }
            }

            ComboBox {
                id: typeSelect
                width: parent.width * 0.55
                height: parent.height
                Layout.preferredWidth: width
                Layout.preferredHeight: height
                editable: false
                model: ListModel {
                    id: modelDevice
                    ListElement { text: "Python" }
                    ListElement { text: "Таблица" }
                    ListElement { text: "Диаграмма" }
                }
                onAccepted: {
                    if (find(editText) === -1)
                        model.append({text: editText})
                }
            }
        }

        RowLayout {
            height: 23
            width: parent.width
            Layout.preferredHeight: 23
            Layout.preferredWidth: parent.width
            Button {
                Layout.preferredHeight: 23
                Layout.preferredWidth: parent.width * 0.5
                text: "ОК"
                onClicked: {
                    probeName.text = ""
                    firstNumber.text = ""
                    secondNumber.text = ""
                    showDevices = clear

                    if (missonSelect.currentText === "Планеты") {
                        listViewProbes.model = probesPlanets

                        if (probesPlanets.get(probesPlanets.currentIndex)) {
                            listViewProbes.currentIndex = probesPlanets.count - 1
                            probe = probesPlanets.get(listViewProbes.currentIndex)
                            showStepsLanding = probe.stepsLanding
                            showStepsActivity = probe.stepsActivity
                            probeName.text = `${probe.name}`
                            firstNumber.text = `${probe.outerRadius}`
                            secondNumber.text = `${probe.innerRadius}`
                            showDevices = probe.devices
                        } else {
                            itemsEnabled = false
                        }

                        typeMission = true
                    }

                    if (missonSelect.currentText === "Земля") {
                        listViewProbes.model = probesErath

                        if (probesErath.get(probesErath.currentIndex)) {
                            listViewProbes.currentIndex = probesErath.count - 1
                            probe = probesErath.get(listViewProbes.currentIndex)
                            probeName.text = `${probe.name}`
                            firstNumber.text = `${probe.outerRadius}`
                            secondNumber.text = `${probe.innerRadius}`
                            showDevices = probe.devices
                        } else {
                            itemsEnabled = false
                        }
                        typeMission = false
                    }

                    if (missonSelect.currentText === "Планеты" && typeSelect.currentText === "Таблица") {
                        showPlanetsElems = true
                        showPlanetsDevices = true
                        showPythonArea = false
                        showDiagrammButton = false
                        pythonCode.text = ""

                    }

                    if (missonSelect.currentText === "Планеты" && typeSelect.currentText === "Диаграмма") {
                        errorDialog.textOfError = "Для миссий из группы Планеты \nневозможно выбрать диаграмму!"
                        errorDialog.open()
                        return
                    }


                    if (missonSelect.currentText === "Земля" && typeSelect.currentText === "Таблица") {
                        errorDialog.textOfError = "Для миссий из группы Земля \nневозможно выбрать таблицу!"
                        errorDialog.open()
                        return
                    }

                    if (typeSelect.currentText === "Python") {
                        showPlanetsElems = false
                        showPlanetsDevices = true
                        showPythonArea = true
                        showDiagrammButton = false
                    };

                    if (missonSelect.currentText === "Земля" && typeSelect.currentText === "Диаграмма") {
                        showPlanetsElems = false
                        showPlanetsDevices = true
                        showPythonArea = false
                        showDiagrammButton = true
                        pythonCode.text = ""
                    };



                    newProbeButton.enabled = true
                    missionDialog.accepted()
                    missionDialog.close()
                }
            }

            Button {
                Layout.preferredHeight: 23
                Layout.preferredWidth: parent.width * 0.5
                text: "Отмена"
                onClicked: {
                    missionDialog.rejected()
                    missionDialog.close()
                }
            }
        }
    }
}
