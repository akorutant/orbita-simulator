import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow  {
    width: 287
    height: 179
    visible: true
    flags: Qt.Window | Qt.WindowFixedSize

    GridLayout {
        anchors.fill: parent
        columns: 2
        rows: 4

        Text {
            text: "Время"
            Layout.row: 0
            Layout.column: 0
        }


        Text {
            text: "Устройство"
            Layout.row: 1
            Layout.column: 0
        }

        ComboBox {
            editable: false
            model: ListModel {
                id: model
                ListElement { text: "Banana" }
                ListElement { text: "Apple" }
                ListElement { text: "Coconut" }
            }
            onAccepted: {
                if (find(editText) === -1)
                    model.append({text: editText})
            }
        }

        Text {
            text: "Команда"
            Layout.row: 2
            Layout.column: 0
        }

        ComboBox {


        }

        Text {
            text: "Параметр"
            Layout.row: 3
            Layout.column: 0
        }
    }
}
