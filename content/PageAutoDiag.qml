import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Dialogs.qml 1.0
import com.ACTIA.BDiag 1.0


Item {
    Rectangle {
        id: rectangle
        color: "#babdb6"
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent

        DiagController{
            id: qml_diagcontroller
        }

        Button {
            id: button
            x: 596
            y: 125
            width: 106
            height: 40
            text: "Available"
            focusPolicy: Qt.TabFocus

        }

        TextField {
            id: textField
            x: 300
            y: 119
            placeholderText: qsTr("Text Field")
            text: qml_diagcontroller.diagRequest()
        }

        Switch {
            id: switch1
            x: 50
            y: 114
            text: qsTr("Engine")
            checkable: button.enabled = true
        }

        Button {
            id: button1
            x: 596
            y: 215
            text: "Available"
            focusPolicy: Qt.TabFocus
        }

        TextField {
            id: textField1
            x: 300
            y: 220
            text: qsTr("Text Field")
        }

        Switch {
            id: switch2
            x: 50
            y: 215
            text: qsTr("Oiel")
        }

        Button {
            id: button2
            x: 596
            y: 304
            text: "Available"
            focusPolicy: Qt.TabFocus
        }

        TextField {
            id: textField2
            x: 300
            y: 309
            text: qsTr("Text Field")
        }

        Switch {
            id: switch3
            x: 50
            y: 304
            text: qsTr("Pression")
        }

        Grid {
        }

        Row {
        }

        Column {
        }

        Column {
        }

        Label {
            id: label
            x: 320
            y: 56
            text: qsTr("DTC Descreption")
            font.pointSize: 16
        }

        Label {
            id: label1
            x: 596
            y: 56
            text: qsTr("Help Support")
            font.pointSize: 16
        }

        Label {
            id: label2
            x: 60
            y: 56
            text: qsTr("Diagnostics")
            font.pointSize: 16
        }
    }

}
