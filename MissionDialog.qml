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

    ComboBox {
        width: parent.width
        height: parent.height * 0.5
        anchors.centerIn: parent
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
}
