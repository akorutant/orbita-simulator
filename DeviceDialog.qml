import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Dialog  {
    id: deviceDialog
    width: 264
    height: 146
    visible: false
    modal: true
    x: mainWindow.width / 2 - width / 2
    y: mainWindow.height / 2 - height / 2

    GridLayout {
        anchors.fill: parent
        columns: 2
        rows: 5

        Text {
            id: deviceText
            Layout.preferredWidth: parent.width * 0.5
            Layout.preferredHeight: 23
            text: "Устройство"
            Layout.row: 0
            Layout.column: 0
        }

        ComboBox {
            id: deviceBox
            Layout.preferredWidth: parent.width * 0.5
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
            Layout.preferredWidth: parent.width * 0.5
            Layout.preferredHeight: 23
            text: "Нач. состояние"
            Layout.row: 1
            Layout.column: 0
        }

        ComboBox {
            id: startStateBox
            Layout.preferredWidth: parent.width * 0.5
            Layout.preferredHeight: 23
            Layout.row: 1
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

        Text {
            Layout.preferredWidth: parent.width * 0.5
            Layout.preferredHeight: 23
            text: "Safe Mode"
            Layout.row: 2
            Layout.column: 0
        }

        ComboBox {
            id: safeModeBox
            Layout.preferredWidth: parent.width * 0.5
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



        Button {
            height: 23
            width: parent.width
            Layout.preferredHeight: 23
            Layout.preferredWidth: parent.width * 0.5
            Layout.column: 0
            Layout.row: 4
            text: "ОК"
            onClicked: {
                probe.devices.append({
                                         name: deviceBox.currentValue,
                                         type: "none",
                                         number: `${devices.count === 0 ? 1 : devices.count + 1}`,
                                         startState: startStateBox.currentValue,
                                         inSafeMode: safeModeBox.currentIndex === 1 ? false : true,
                                     })
                deviceDialog.accepted()
                deviceDialog.close()
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
                deviceDialog.rejected()
                deviceDialog.close()
            }

        }


    }

}
