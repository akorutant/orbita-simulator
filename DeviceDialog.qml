import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Dialog  {
    width: 264
    height: 146
    visible: false
    modal: true
    standardButtons: Dialog.Ok | Dialog.Cancel
    x: 254.5
    y: 299.5

    GridLayout {
        anchors.fill: parent
        columns: 2
        rows: 4

        Text {
            id: time
            Layout.preferredWidth: 126
            Layout.preferredHeight: 23
            text: "Устройство"
            Layout.row: 0
            Layout.column: 0
        }

        ComboBox {
            Layout.preferredWidth: 92
            Layout.preferredHeight: 23
            Layout.row: 0
            Layout.column: 1
            editable: false
            model: ListModel {
                id: modelDevice
                ListElement { text: "test" }
            }
            onAccepted: {
                if (find(editText) === -1)
                    model.append({text: editText})
            }
        }

        Text {
            Layout.preferredWidth: 126
            Layout.preferredHeight: 23
            text: "Начальное состояние"
            Layout.row: 1
            Layout.column: 0
        }

        ComboBox {
            Layout.preferredWidth: 92
            Layout.preferredHeight: 23
            Layout.row: 1
            Layout.column: 1
            editable: false
            model: ListModel {
                id: modelStates
                ListElement { text: "ON" }
                ListElement { text: "OF" }
            }
            onAccepted: {
                if (find(editText) === -1)
                    model.append({text: editText})
            }
        }

        Text {
            Layout.preferredWidth: 72
            Layout.preferredHeight: 23
            text: "Safe Mode"
            Layout.row: 2
            Layout.column: 0
        }

        ComboBox {
            Layout.preferredWidth: 92
            Layout.preferredHeight: 23
            Layout.row: 2
            Layout.column: 1
            editable: false
            model: ListModel {
                id: modelCommands
                ListElement { text: "ON" }
                ListElement { text: "OFF" }
            }
            onAccepted: {
                if (find(editText) === -1)
                    model.append({text: editText})
            }
        }


    }

}
