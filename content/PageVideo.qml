import QtQuick 2.0
import QtMultimedia 5.9
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.2


Item {

    Rectangle {
        id: rectangle
        color: "#000000"
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

        Video {
            id: video
            x: 1
            y: -1
            width : 800
            height : 401
            /* Each one of this paths working in a specific machine */
            //source: "file:///home/boss/qt_Workspace/BDiagGUI-master/media/caminandes.webm"
            source: "file:///home/boss/Desktop/BDiagGUI-Demo/media/hotengine.mp4"
            //source: "file:///home/root/media/refroidissement.mkv"

            /* MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        video.play()
                    }

                }*/

            MouseArea {
                id: playArea
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: -1
                anchors.fill: parent
                onPressed:   video.playbackState == MediaPlayer.PlayingState ? video.pause() : video.play()
            }
            focus: true
            Keys.onSpacePressed: video.playbackState == MediaPlayer.PlayingState ? video.pause() : video.play()
            Keys.onLeftPressed: video.seek(video.position - 5000)
            Keys.onRightPressed: video.seek(video.position + 5000)
        }
    }
}
