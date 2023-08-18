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
                    list: devices
                }

                delegate: RowLayout {
                    width: parent.width

                    Text {
                        text: " это " + model.deviceName
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

        ListView {
            id: testView
            implicitWidth: 250
            implicitHeight: 250
            anchors.fill: parent
            clip: true

            model: ProbeModel {
                list: probe
            }

            delegate: Item {
                width: parent.width

                Text {
                    text:"Устройства " + probe
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        testView.currentIndex = index
                    }
                }
            }
        }

        RowLayout {
            Button {
                text: qsTr("Add new item")
                onClicked: devices.appendDevicesItem(probe, 0, "testdsadasd", "te231st", false)
                Layout.fillWidth: true
            }
            Button {
                text: qsTr("Remove completed")
                onClicked: devices.removeDevicesItem(probe, 0, 0)
                Layout.fillWidth: true
            }
        }
    }
}
