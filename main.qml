import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15


ApplicationWindow  {
    width: 773
    height: 745
    visible: true
    title: qsTr("Orbita-app")
    flags: Qt.Window | Qt.WindowFixedSize
    MissionDialog {id: missionDialog}
    DeviceDialog {id: deviceDialog}
    CommandDialog {id: commandDialog}

    RowLayout {
        anchors.fill: parent
        x: 9
        GroupBox {
            id: groupBoxProbe
            title: qsTr("Cписок аппаратов")
            Layout.preferredWidth: 280
            Layout.fillHeight: true


            ListView {
                id: listViewProbes
                anchors.fill: parent
                model: Probes {}
                width: parent.width
                height: parent.height - newProbeButton.height
                anchors.bottomMargin: 158
                clip: true
                enabled: false

                ScrollBar.vertical: ScrollBar {
                    id: probesScrollBar
                    anchors {
                        right: parent.right
                        top: parent.top
                        bottom: parent.bottom
                        margins: 0
                    }
                }

                delegate: Item {
                    width: listViewProbes.width
                    height: 50

                    Rectangle {
                        width: parent.width - probesScrollBar.width
                        height: parent.height - 5
                        color: listViewProbes.currentIndex === index && listViewProbes.enabled? "lightblue" : "white"
                        border.color: "grey"


                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                listViewProbes.currentIndex = index
                            }
                        }
                    }

                    Column {
                        anchors.fill: parent
                        anchors.leftMargin: 5
                        anchors.topMargin: 15
                        Text {

                            text: index >= 0 && index < listViewProbes.count ? '<b>Аппарат:</b> ' + model.name + " " + model.number : ""
                        }
                    }
                }
            }


            Button {
                id: selectMissonButton

                width: parent.width; height: 23
                text: "Выбрать миссию"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 125
                onClicked: missionDialog.open()
            }

            Button {
                id: newProbeButton
                width: parent.width; height: 23
                text: "Cоздать новый"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 96
                enabled: false
            }

            Button {
                id: loadProbeButton
                width: parent.width; height: 23
                text: "Загрузить"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 67
                enabled: false
            }

            Button {
                id: saveProbeButton
                width: parent.width; height: 23
                text: "Сохранить"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 38
                enabled: false
            }

            Button {
                id: runButton
                width: parent.width; height: 23
                text: "Запустить"
                anchors.bottom: parent.bottom
                enabled: false
            }
        }

        GroupBox {
            id: probesConstructor
            Layout.preferredWidth: parent.width - groupBoxProbe.width - 10
            Layout.fillHeight: true
            title: qsTr("Аппарат")
            ColumnLayout {
                anchors.fill: parent
                RowLayout {
                    Layout.preferredHeight: 20
                    Text {
                        height: probeName.implicitHeight
                        text: "Название:"
                    }
                    TextInput {
                        id: probeName
                        width: 200
                        height: 10
                        enabled: false
                        onTextChanged: {
                            if (probeName.text.length > 30) {
                                probeName.text = probeName.text.substring(0, 30);
                            }
                        }

                        property string placeholderText: "Введите название..."

                        Text {
                            text: probeName.placeholderText
                            color: "#aaa"
                            visible: !probeName.text
                        }
                    }
                }

                GroupBox {
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 100
                    title: qsTr("Общие параметры")

                    GridLayout {
                        height: parent.height
                        columns: 2 // Две колонки
                        rows: 2    // Две строки

                        Text {
                            text: "Внутренний радиус (м)"
                            Layout.row: 0
                            Layout.column: 0
                        }

                        TextInput {
                            id: firstNumber
                            Layout.row: 0    // Первая строка
                            Layout.column: 1 // Вторая колонка
                            width: 200
                            height: 10
                            validator: IntValidator {}
                            enabled: false

                            onTextChanged: {
                                if (firstNumber.text.length > 10) {
                                    firstNumber.text = firstNumber.text.substring(0, 10);
                                }
                            }

                            property string placeholderText: "Введите число..."

                            Text {
                                text: firstNumber.placeholderText
                                color: "#aaa"
                                visible: !firstNumber.text
                            }
                        }

                        Text {
                            text: "Внешний радиус (м)"
                            Layout.row: 1
                            Layout.column: 0
                        }

                        TextInput {
                            id: secondNumber
                            Layout.row: 1
                            Layout.column: 1
                            width: 200
                            height: 10
                            validator: IntValidator {}
                            enabled: false

                            onTextChanged: {
                                if (secondNumber.text.length > 10) {
                                    secondNumber.text = secondNumber.text.substring(0, 10);
                                }
                            }

                            property string placeholderText: "Введите число..."

                            Text {
                                text: secondNumber.placeholderText
                                color: "#aaa"
                                visible: !secondNumber.text
                            }
                        }
                    }
                }

                GroupBox {
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 140
                    title: qsTr("Устройства")
                    RowLayout {
                        anchors.fill: parent

                        ListView {
                            id: listViewDevices
                            model: Devices {}
                            width: parent.width - devicesButtons.width
                            height: parent.height
                            clip: true
                            enabled: false


                            ScrollBar.vertical: ScrollBar {
                                id: devicesScrollBar
                                anchors {
                                    right: parent.right
                                    top: parent.top
                                    bottom: parent.bottom
                                    margins: 0
                                }
                            }

                            delegate: Item {
                                width: listViewDevices.width
                                height: 100
                                Rectangle {
                                    width: parent.width - devicesScrollBar.width
                                    height: parent.height - 5
                                    color: listViewDevices.currentIndex === index ** listViewDevices.enabled? "lightblue" : "white"
                                    border.color: "grey"

                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            listViewDevices.currentIndex = index
                                        }
                                    }
                                }

                                Column {
                                    anchors.fill: parent
                                    anchors.leftMargin: 5
                                    anchors.topMargin: 8

                                    Text { text: index >= 0 && index < listViewDevices.count && model.number ? '<b>Номер:</b> ' + model.number : "<b>Номер:</b> None" }

                                    Text { text: index >= 0 && index < listViewDevices.count && model.name ? '<b>Название:</b> ' + model.name : "<b>Название:</b> None" }

                                    Text { text: index >= 0 && index < listViewDevices.count && model.type ? '<b>Тип:</b> ' + model.type : "<b>Тип:</b> None" }

                                    Text { text: index >= 0 && index < listViewDevices.count && model.startState ? '<b>Начальное состояние:</b> ' + model.startState : "<b>Начальное состояние:</b> None" }

                                    Text { text: index >= 0 && index < listViewDevices.count && model.inSafeMode ? '<b>Safe Mode:</b> ' + model.inSafeMode : "<b>Safe Mode:</b> None" }

                                }
                            }
                        }

                        ColumnLayout {
                            id: devicesButtons
                            Layout.preferredHeight: 23
                            Layout.preferredWidth: 80
                            Layout.alignment: Qt.AlignRight | Qt.AlignTop
                            Button {
                                id: buttonAddDevice
                                Layout.preferredHeight: 23
                                text: "Добавить"
                                enabled: false

                            }

                            Button {
                                id: buttonDeleteDevice
                                Layout.preferredHeight: 23
                                text: "Удалить"
                                enabled: false
                            }
                        }

                    }


                }

                GroupBox {
                    id: commandsGroupBox
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 400
                    title: qsTr("Команды")
                    ColumnLayout {
                        anchors.fill: parent
                        GroupBox {
                            id: stepsLandingGroupBox
                            Layout.preferredWidth: parent.width
                            Layout.preferredHeight: parent.height * 0.5
                            title: qsTr("Этап приземления")
                            RowLayout {
                                anchors.fill: parent
                                ListView {
                                    id: listViewStepsLanding
                                    model: StepsLanding {}
                                    width: parent.width - sLButton.width
                                    height: parent.height
                                    clip: true
                                    enabled: false


                                    ScrollBar.vertical: ScrollBar {
                                        id: stepsLandingScrollBar
                                        anchors {
                                            right: parent.right
                                            top: parent.top
                                            bottom: parent.bottom
                                            margins: 0
                                        }
                                    }

                                    delegate: Item {
                                        width: listViewStepsLanding.width
                                        height: 80
                                        Rectangle {
                                            width: parent.width - devicesScrollBar.width
                                            height: parent.height - 5
                                            color: listViewStepsLanding.currentIndex === index && listViewStepsLanding.enabled? "lightblue" : "white"
                                            border.color: "grey"

                                            MouseArea {
                                                anchors.fill: parent
                                                onClicked: {
                                                    listViewStepsLanding.currentIndex = index
                                                }
                                            }
                                        }

                                        Column {
                                            anchors.fill: parent
                                            anchors.leftMargin: 5
                                            anchors.topMargin: 8

                                            Text { text: index >= 0 && index < listViewStepsLanding.count && model.time? '<b>Время:</b> ' + model.time : "<b>Время:</b> None" }

                                            Text { text: index >= 0 && index < listViewStepsLanding.count && model.device ? '<b>Устройство:</b> ' + model.device : "<b>Устройство:</b> None" }

                                            Text { text: index >= 0 && index < listViewStepsLanding.count && model.command ? '<b>Команда:</b>' + model.command : "<b>Команда:</b> None" }

                                            Text { text: index >= 0 && index < listViewStepsLanding.count && model.argument ? '<b>Параметр:</b> ' + model.argument : "<b>Параметр:</b> None" }
                                        }
                                    }
                                }


                                ColumnLayout {
                                    id: sLButton
                                    height: 23
                                    Layout.alignment: Qt.AlignRight | Qt.AlignTop
                                    Button {
                                        id: buttonAddSL
                                        Layout.preferredHeight: 23
                                        text: "Добавить"
                                        enabled: false
                                    }

                                    Button {
                                        id: buttonDeleteSL
                                        Layout.preferredHeight: 23
                                        text: "Удалить"
                                        enabled: false
                                    }
                                }
                            }
                        }

                        GroupBox {
                                id: stepsPlanetActivityGroupBox
                                title: qsTr("Этапы Планетарной активности")
                                Layout.preferredWidth: parent.width
                                Layout.preferredHeight: parent.height * 0.5
                                RowLayout {
                                    anchors.fill: parent
                                    ListView {
                                        id: listViewStepsPlanetActivity
                                        model: StepsActivity {}
                                        width: parent.width - sPAButtons.width
                                        height: parent.height
                                        clip: true
                                        enabled: false


                                        ScrollBar.vertical: ScrollBar {
                                            id: stepsPlanetActivityScrollBar
                                            anchors {
                                                right: parent.right
                                                top: parent.top
                                                bottom: parent.bottom
                                                margins: 0
                                            }
                                        }

                                        delegate: Item {
                                            width: listViewStepsPlanetActivity.width
                                            height: 80
                                            Rectangle {
                                                width: parent.width - devicesScrollBar.width
                                                height: parent.height - 5
                                                color: listViewStepsPlanetActivity.currentIndex === index && listViewStepsPlanetActivity.enabled? "lightblue" : "white"
                                                border.color: "grey"

                                                MouseArea {
                                                    anchors.fill: parent
                                                    onClicked: {
                                                        listViewStepsPlanetActivity.currentIndex = index
                                                    }
                                                }
                                            }

                                            Column {
                                                anchors.fill: parent
                                                anchors.leftMargin: 5
                                                anchors.topMargin: 8

                                                Text { text: index >= 0 && index < listViewStepsPlanetActivity.count && model.time? '<b>Время:</b> ' + model.time : "<b>Время:</b> None" }

                                                Text { text: index >= 0 && index < listViewStepsPlanetActivity.count && model.device ? '<b>Устройство:</b> ' + model.device : "<b>Устройство:</b> None" }

                                                Text { text: index >= 0 && index < listViewStepsPlanetActivity.count && model.command ? '<b>Команда:</b>' + model.command : "<b>Команда:</b> None" }

                                                Text { text: index >= 0 && index < listViewStepsPlanetActivity.count && model.argument ? '<b>Параметр:</b> ' + model.argument : "<b>Параметр:</b> None" }
                                            }
                                        }
                                    }


                                    ColumnLayout {
                                        id: sPAButtons
                                        Layout.preferredHeight: 23
                                        Layout.alignment: Qt.AlignRight | Qt.AlignTop
                                        Button {
                                            id: buttonAddSPA
                                            Layout.preferredHeight: 23
                                            text: "Добавить"
                                            enabled: false
                                        }

                                        Button {
                                            id: buttonDeleteSPA
                                            Layout.preferredHeight: 23
                                            text: "Удалить"
                                            enabled: false
                                        }
                                    }
                                }
                            }

                    }


                }
            }

        }
    }
}
