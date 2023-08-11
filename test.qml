import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import ProbeModel 1.0
import DevicesModel 1.0

ApplicationWindow {
    width: 773
    height: 745
    visible: true
    ColumnLayout {
        Frame {
            Layout.fillWidth: true

            ListView {
                id: listViewDevices
                implicitWidth: 250
                implicitHeight: 250
                anchors.fill: parent
                clip: true

                model: DevicesModel {
                    list: probe
                }

                delegate: RowLayout {
                    width: parent.width

                    Text {
                        text: model.deviceName
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            listViewDevices.currentIndex = index
                        }
                    }
                }
            }
        }

        RowLayout {
            Button {
                text: qsTr("Add new item")
                onClicked: probe.appendDevicesItem("testdsadasd", "te231st", false)
                Layout.fillWidth: true
            }
            Button {
                text: qsTr("Remove completed")
                onClicked: probe.removeDevicesItem(0)
                Layout.fillWidth: true
            }
        }
    }
}
