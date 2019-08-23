import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Dialogs.qml 1.0

Item {
    Rectangle {
        id: rectangle
        color: "#a2a2a2"
        anchors.fill: parent

        Button {
            id: button
            x: 450
            y: 96
            text: qsTr("Button")
        }
    }

}
