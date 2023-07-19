import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    width: 773
    height: 745
    visible: true
    title: qsTr("Orbita-app")

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
                anchors.bottomMargin: 135
                clip: true

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
                    height: 40
                    Rectangle {
                        width: parent.width - probesScrollBar.width
                        height: parent.height - 1
                        color: listViewProbes.currentIndex === index ? "lightblue" : "white"
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
                        Text {
                            text: index >= 0 && index < listViewProbes.count ? '<b>Аппарат:</b> ' + model.name + " " + model.number : ""
                        }
                    }
                }
            }

            Button {
                id: newProbeButton
                width: parent.width; height: 23
                text: "Cоздать новый"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 96
            }

            Button {
                id: loadProbeButton
                width: parent.width; height: 23
                text: "Загрузить"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 67
            }

            Button {
                id: saveProbeButton
                width: parent.width; height: 23
                text: "Сохранить"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 38
            }

            Button {
                id: runButton
                width: parent.width; height: 23
                text: "Запустить"
                anchors.bottom: parent.bottom
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
                                    height: listViewDevices.height
                                    color: listViewDevices.currentIndex === index ? "lightblue" : "white"
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
                                    Text { text: index >= 0 && index < listViewDevices.count ? '<b>Номер:</b> ' + model.number : "" }

                                    Text { text: index >= 0 && index < listViewDevices.count ? '<b>Название:</b> ' + model.name : "" }

                                    Text { text: index >= 0 && index < listViewDevices.count ? '<b>Тип:</b> ' + model.type : "" }

                                    Text { text: index >= 0 && index < listViewDevices.count ? '<b>Начальное состояние:</b> ' + model.startState : "" }

                                    Text { text: index >= 0 && index < listViewDevices.count ? '<b>Safe Mode:</b> ' + model.inSafeMode : "" }

                                }
                            }
                        }

                        ColumnLayout {
                            id: devicesButtons
                            height: 23
                            Layout.alignment: Qt.AlignRight | Qt.AlignTop
                            Button {
                                id: buttonAddDevice
                                text: "Добавить"
                                height: 23
                                width: 80
                            }

                            Button {
                                id: buttonDeleteDevice
                                text: "Удалить"
                                height: 23
                                width: 80
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
                                        height: 100
                                        Rectangle {
                                            width: parent.width - devicesScrollBar.width
                                            height: listViewStepsLanding.height
                                            color: listViewStepsLanding.currentIndex === index ? "lightblue" : "white"
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
                                            Text { text: index >= 0 && index < listViewStepsLanding.count ? '<b>Время:</b> ' + model.time : "" }

                                            Text { text: index >= 0 && index < listViewStepsLanding.count ? '<b>Устройство:</b> ' + model.device : "" }

                                            Text { text: index >= 0 && index < listViewStepsLanding.count ? '<b>Команда:</b> ' + model.command : "" }

                                            Text { text: index >= 0 && index < listViewStepsLanding.count ? '<b>Параметр:</b> ' + model.argument : "" }
                                        }
                                    }
                                }


                                ColumnLayout {
                                    id: sLButton
                                    height: 23
                                    Layout.alignment: Qt.AlignRight | Qt.AlignTop
                                    Button {
                                        id: buttonAddSL
                                        text: "Добавить"
                                        height: 23
                                        width: 80
                                    }

                                    Button {
                                        id: buttonDeleteSL
                                        text: "Удалить"
                                        height: 23
                                        width: 80
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
                                            height: 100
                                            Rectangle {
                                                width: parent.width - devicesScrollBar.width
                                                height: listViewStepsPlanetActivity.height
                                                color: listViewStepsPlanetActivity.currentIndex === index ? "lightblue" : "white"
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
                                                Text { text: index >= 0 && index < listViewStepsPlanetActivity.count ? '<b>Время:</b> ' + model.time : "" }

                                                Text { text: index >= 0 && index < listViewStepsPlanetActivity.count ? '<b>Устройство:</b> ' + model.device : "" }

                                                Text { text: index >= 0 && index < listViewStepsPlanetActivity.count ? '<b>Команда:</b> ' + model.command : "" }

                                                Text { text: index >= 0 && index < listViewStepsPlanetActivity.count ? '<b>Параметр:</b> ' + model.argument : "" }
                                            }
                                        }
                                    }


                                    ColumnLayout {
                                        id: sPAButtons
                                        height: 23
                                        Layout.alignment: Qt.AlignRight | Qt.AlignTop
                                        Button {
                                            id: buttonAddSPA
                                            text: "Добавить"
                                            height: 23
                                            width: 80
                                        }

                                        Button {
                                            id: buttonDeleteSPA
                                            text: "Удалить"
                                            height: 23
                                            width: 80
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
