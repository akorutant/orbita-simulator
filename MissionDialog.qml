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
    x: mainWindow.width / 2 - width / 2
    y: mainWindow.height / 2 - height / 2
    ColumnLayout {
        anchors.fill: parent
        ComboBox {
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height * 0.3
            editable: false
            model: ListModel {
                id: modelDevice
                ListElement { text: "Луна" }
                ListElement { text: "Марс" }
            }
            onAccepted: {
                if (find(editText) === -1)
                    model.append({text: editText})
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
                    mainWindow.itemsEnabled = true
                    missionDialog.accepted()
                    missionDialog.close()
                }
            }

            Button {
                Layout.preferredHeight: 23
                Layout.preferredWidth: parent.width * 0.5
                text: "Отмена"
                onClicked: {
                    mainWindow.itemsEnabled = false
                    missionDialog.rejected()
                    missionDialog.close()
                }
            }
        }
    }
}
