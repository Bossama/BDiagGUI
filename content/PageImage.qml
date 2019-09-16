import QtQuick 2.3
import Qt.labs.folderlistmodel 2.1
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.2

    Item {

        Rectangle {
            id: rectangle
            color: "#babdb6"
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            anchors.fill: parent
            Button {
                id: button1
                x: 645
                y: 405
                width: 100
                height: 67
                text: "Back to Diag"
                focusPolicy: Qt.TabFocus
                checkable: button.enabled = false
                MouseArea {
                    anchors.fill: parent
                    onClicked:  {
                       // video.stop()
                        client_area.clientUrl = "qrc:/content/PageAutoDiag.qml"}
                }
        }
        BorderImage {
            id: borderImage
            x: 26
            y: 17
            width: 591
            height: 450
            source: "file:///home/root/media/filtre.JPG"
        }
    }
}
