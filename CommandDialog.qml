import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import ComboBoxDevicesModel 1.0

Dialog  {
    id: commandDialog
    width: 287
    height: 179
    visible: false
    modal: true

    x: mainWindow.width / 2 - width / 2
    y: mainWindow.height / 2 - height / 2

    GridLayout {
        anchors.fill: parent
        columns: 2
        rows: 5

        Text {
            id: time
            Layout.preferredWidth: parent.width * 0.5
            Layout.preferredHeight: 23
            text: "Время"
            Layout.row: 0
            Layout.column: 0
        }

        TextInput {
            id: timeInput
            Layout.row: 0
            Layout.column: 1
            Layout.preferredWidth: parent.width * 0.5
            Layout.preferredHeight: 23
            validator: IntValidator {}
            onTextChanged: {
                if (timeInput.text.length > 30) {
                    timeInput.text = timeInput.text.substring(0, 30);
                }
            }

            property string placeholderText: "Введите время"

            Text {
                text: timeInput.placeholderText
                color: "#aaa"
                visible: !timeInput.text
            }
        }


        Text {
            Layout.preferredWidth: parent.width * 0.5
            Layout.preferredHeight: 23
            text: "Устройство"
            Layout.row: 1
            Layout.column: 0
        }

        ComboBox {
            id: devicesBox
            Layout.preferredWidth: parent.width * 0.5
            Layout.preferredHeight: 23
            Layout.row: 1
            Layout.column: 1
            editable: false
            model: ComboBoxDevicesModel {
                id: modelDevices
                list: devicesItems
            }
            onAccepted: {
                if (find(editText) === -1)
                    model.append({name: editText})
            }
        }

        Text {
            Layout.preferredWidth: parent.width * 0.5
            Layout.preferredHeight: 23
            text: "Команда"
            Layout.row: 2
            Layout.column: 0
        }

        ComboBox {
            id: commandsBox
            Layout.preferredWidth: parent.width * 0.5
            Layout.preferredHeight: 23
            Layout.row: 2
            Layout.column: 1
            editable: false
            model: ListModel {
                id: modelCommands
                ListElement { text: "TURNOFF" }
                ListElement { text: "TURNON" }
                ListElement { text: "PERIOD" }
            }
            onAccepted: {
                if (find(editText) === -1)
                    model.append({text: editText})
            }
        }

        Text {
            Layout.preferredWidth: parent.width * 0.5
            Layout.preferredHeight: 23
            text: "Параметр"
            Layout.row: 3
            Layout.column: 0
        }

        TextInput {
            id: argumentInput
            Layout.preferredWidth: parent.width * 0.5
            Layout.preferredHeight: 23
            Layout.row: 3
            Layout.column: 1
            onTextChanged: {
                if (argumentInput.text.length > 30) {
                    argumentInput.text = argumentInput.text.substring(0, 30);
                }
            }

            property string placeholderText: "Введите параметр"

            Text {
                text: argumentInput.placeholderText
                color: "#aaa"
                visible: !argumentInput.text
            }
        }

        Button {
            height: 23
            width: parent.width
            Layout.preferredHeight: 23
            Layout.preferredWidth: parent.width * 0.5
            Layout.column: 0
            Layout.row: 4
            text: "ОК"
            onClicked: {
                if (whatIsWindow) {
                    stepsLandingItems.appendItem(probes,
                                                 whatIsWindow,
                                                 listViewProbes.currentIndex,
                                                 timeInput.text, devicesBox.currentValue,
                                                 commandsBox.currentValue,
                                                 argumentInput.text);
                    listViewStepsLanding.currentIndex = stepsLandingItems.size()
                } else {
                    stepsActivityItems.appendItem(probes,
                                                  whatIsWindow,
                                                  listViewProbes.currentIndex,
                                                  timeInput.text, devicesBox.currentValue,
                                                  commandsBox.currentValue,
                                                  argumentInput.text);
                    listViewStepsPlanetActivity.currentIndex = stepsActivityItems.size()
                }




                timeInput.text = ""
                argumentInput.text = ""
                commandsBox.currentIndex = 0
                devicesBox.currentIndex = 0
                commandDialog.accepted()
                commandDialog.close()
            }

        }

        Button {
            height: 23
            width: parent.width
            Layout.preferredHeight: 23
            Layout.preferredWidth: parent.width * 0.5
            Layout.column: 1
            Layout.row: 4
            text: "Отмена"
            onClicked: {
                timeInput.text = ""
                argumentInput.text = ""
                commandsBox.currentIndex = 0
                devicesBox.currentIndex = 0
                commandDialog.rejected()
                commandDialog.close()
            }

        }
    }
}
