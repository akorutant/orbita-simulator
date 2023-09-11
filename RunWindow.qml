import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window  {
    id: runWindow
    width: 798
    height: 610
    visible: false
    flags: Qt.Window | Qt.WindowFixedSize
    property var simulationProcess;
    property bool simulationRunning: false;

    ColumnLayout {
        anchors.fill: parent


        Text {
            height: 20
            width: parent.width
            Layout.preferredHeight: 20
            Layout.preferredWidth: parent.width
            Layout.topMargin: 5
            text: "<b>Аппарат:</b "
        }


        RowLayout {
           height: 531
           width: parent.width
           Layout.preferredHeight: 531
           Layout.preferredWidth: parent.width

           GroupBox {
               title: qsTr("Журнал полёта")
               width: parent.width
               height: parent.height
               Layout.preferredHeight: parent.height
               Layout.preferredWidth: parent.width * 0.5

               ColumnLayout {
                   anchors.fill: parent

                   Column {
                       Layout.preferredWidth: parent.width
                       Layout.preferredHeight: 15
                       Text {text: listViewProbes.count ? "Миссия" + currentProbe.missionName : "Миссия: "}
                   }

                   ScrollView {
                       Layout.preferredWidth: parent.width
                       Layout.preferredHeight: 381

                       TextArea {
                           id: missionInfo
                           anchors.fill: parent
                           readOnly: true
                           text: simulationController.telemetryLogContents
                       }
                   }

                   Button {
                       Layout.preferredHeight: 23
                       Layout.preferredWidth: parent.width
                       id: startButton
                       text: "Cтарт!"
                       onClicked: {
                           if (simulationRunning) {
                               simulationController.stopSimulation();
                               simulationRunning = false;
                           } else {
                               simulationController.startSimulation(`${pathToLoad}/${currentProbe.probeName}.xml`);
                               simulationRunning = true;
                           }
                       }

                   }
                   Button {
                       Layout.preferredHeight: 23
                       Layout.preferredWidth: parent.width
                       id: stopButton
                       text: "Остановить"
                       onClicked: {
                            simulationController.stopSimulation();
                            simulationRunning = false;
                       }
                   }
                   Button {
                       Layout.preferredHeight: 23
                       Layout.preferredWidth: parent.width
                       id: printButton
                       text: "Распечатать..."

                   }
               }

           }

           GroupBox {
               title: qsTr("Графики")
               Layout.preferredHeight: parent.height
               Layout.preferredWidth: parent.width * 0.5
               ListView {
                   anchors.fill: parent
                   clip: true
                   model: ListModel {
                       ListElement { imageSource: "" }
                       ListElement { imageSource: "" }
                   }

                   delegate: Item {
                       anchors.fill: parent
                       width: parent.width
                       height: parent.height

                       Image {
                           width: parent.width
                           height: parent.height
                           fillMode: Image.PreserveAspectFit

                           source: model.imageSource
                       }
                   }
               }

           }
        }

          Button {
              id: closeButton
              Layout.preferredHeight: 23
              Layout.preferredWidth: 80
              Layout.alignment: Qt.AlignRight | Qt.AlignTop
              Layout.rightMargin: 5
              Layout.bottomMargin: 10
              text: "Закрыть"
              onClicked: {
                mainWindow.visible = true
                runWindow.visible = false
              }

          }


    }
}
