import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import EarthSystemsModel 1.0

Dialog  {
    id: deviceEarthDialog
    width: 450
    height: 146
    visible: false
    modal: true
    x: mainWindow.width / 2 - width / 2
    y: mainWindow.height / 2 - height / 2

    ColumnLayout {
        anchors.fill: parent
        width: parent.width
        height: parent.height

        RowLayout {
            width: parent.width
            height: parent.height * 0.2
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height * 0.2

            Text {
                id: deviceEarthText
                Layout.preferredWidth: parent.width * 0.2
                Layout.preferredHeight: 23
                text: "Устройство"
                Layout.row: 0
                Layout.column: 0
            }

            ComboBox {
                id: deviceEarthBox
                Layout.preferredWidth: parent.width * 0.8
                Layout.preferredHeight: 23
                Layout.row: 0
                Layout.column: 1
                editable: false
                currentIndex: 0
                model: EarthSystemsModel {
                    id: modelDevice
                    list: systems
                }
                onAccepted: {
                    if (find(editText) === -1)
                        model.append({text: editText})

                }
            }
        }
        GridLayout {
            width: parent.width
            height: parent.height * 0.8
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height * 0.8
            columns: 2
            rows: 2

            Text {
                Layout.preferredWidth: parent.width * 0.5
                Layout.preferredHeight: 23
                text: "Нач. состояние"
                Layout.row: 0
                Layout.column: 0
            }

            ComboBox {
                id: startStateEarthBox
                Layout.preferredWidth: parent.width * 0.5
                Layout.preferredHeight: 23
                Layout.row: 0
                Layout.column: 1
                editable: false
                model: ListModel {
                    id: modelStates
                    ListElement { text: "ON" }
                    ListElement { text: "OFF" }
                }
                onAccepted: {
                    if (find(editText) === -1)
                        model.append({text: editText})
                }
            }

            Button {
                height: 23
                width: parent.width
                Layout.preferredHeight: 23
                Layout.preferredWidth: parent.width * 0.5
                Layout.column: 0
                Layout.row: 2
                text: "ОК"
                onClicked: {
                    var startMode = false;
                    if (startStateEarthBox.currentValue === "ON" && systems.getAllowState(deviceEarthBox.currentValue))
                        startMode = true
                    else
                        startMode = false

                    if (earthProbeSystems.checkUniqueType(systems.getType(deviceEarthBox.currentValue))) {
                        errorDialog.textOfError = `Вы уже добавили подсистему типа: ${systems.getType(deviceEarthBox.currentValue)}.`
                        errorDialog.open()
                        return
                    } else {
                        earthProbeSystems.appendEarthSystem(earthProbes,
                                                            listViewEarthProbes.currentIndex,
                                                            systems.getSystemsEngName(deviceEarthBox.currentValue),
                                                            deviceEarthBox.currentValue,
                                                            systems.getType(deviceEarthBox.currentValue),
                                                            systems.getMass(deviceEarthBox.currentValue),
                                                            startMode)

                        systems.currentIndex = earthProbeSystems.size() - 1

                        deviceEarthBox.currentIndex = 0
                        startStateEarthBox.currentIndex = 0
                        deviceEarthDialog.accepted()
                        deviceEarthDialog.close()
                    }

                }

            }

            Button {
                height: 23
                width: parent.width
                Layout.preferredHeight: 23
                Layout.preferredWidth: parent.width * 0.5
                Layout.column: 1
                Layout.row: 2
                text: "Отмена"
                onClicked: {
                    deviceEarthDialog.rejected()
                    deviceEarthDialog.close()
                }

            }


        }

    }


}
