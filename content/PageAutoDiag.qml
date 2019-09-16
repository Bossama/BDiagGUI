import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Dialogs.qml 1.0
import com.ACTIA.BDiag 1.0


Item {
    ListModel {
        id: page_model
        ListElement {
            name: "Video"
            pageSource: "content/PageVideo.qml"
        }
        ListElement {
            name: "Image"
            pageSource: "qrc:/content/PageVirtualKeyboard.qml"
        }
    }

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


        TextField {
            id: textField
            x: 270
            y: 114
            width: 260
            height: 71
            text: "The motor tempeture is too high"
            font.pointSize: 12
            placeholderText: qsTr("Text Field")
            //text: qml_diagcontroller.diagRequest()
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
            x: 587
            y: 56
            text: qsTr("Help Support")
            font.pointSize: 16
        }

        MouseArea {
            x: 5
            y: 5
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            anchors.fill: parent

            Button {
                id: button
                x: 596
                y: 130
                width: 100
                height: 40
                text: "Available"
                enabled: true
                focusPolicy: Qt.TabFocus
                checkable: button.enabled = true
                MouseArea {
                    enabled: true
                    anchors.fill: parent
                    onClicked:  client_area.clientUrl = "qrc:/content/PageVideo.qml"
                }
                //checkable: button.enabled = true

            }

            Switch {
                id: switch1
                x: 50
                y: 130
                text: qsTr("Engine")
                font.pointSize: 12
                //checkable: button.enabled = false
                //onCheckedChanged: button.enable = true
            }

            Switch {
                id: switch2
                x: 50
                y: 215
                text: qsTr("ABS Brakes")
                font.pointSize: 12
            }

            Switch {
                id: switch3
                x: 50
                y: 304
                text: qsTr("Airbags")
                font.pointSize: 12
            }

            Button {
                id: button2
                x: 596
                y: 304
                text: "Available"
                enabled: true
                focusPolicy: Qt.TabFocus
                checkable: button.enabled = false
                MouseArea {
                    anchors.fill: parent
                    onClicked:  client_area.clientUrl = "qrc:/content/PageGIF.qml"
                }
            }

            Button {
                id: button1
                x: 596
                y: 215
                text: "Available"
                enabled: true
                focusPolicy: Qt.TabFocus
                checkable: button.enabled = true
                MouseArea {anchors.fill: parent
                    onClicked:  client_area.clientUrl = "qrc:/content/PageImage.qml"
                }
            }

            Button {
                id: button3
                x: 598
                y: 396
                text: "Available"
                enabled: false
                focusPolicy: Qt.TabFocus
                checkable: button.enabled = false
                MouseArea {

                }
            }

            Switch {
                id: switch4
                x: 50
                y: 393
                text: qsTr("Pression")
                font.pointSize: 12
            }


        }

        TextField {
            id: textField1
            x: 270
            y: 205
            width: 260
            height: 71
            text: "Wait diagnostic results ..."
            font.pointSize: 10
            placeholderText: qsTr("Text Field")
        }

        TextField {
            id: textField2
            x: 270
            y: 295
            width: 260
            height: 71
            text: "Wait diagnostic results ..."
            font.pointSize: 10
            placeholderText: qsTr("Text Field")
        }

        TextField {
            id: textField3
            x: 270
            y: 387
            width: 260
            height: 71
            text: "Wait diagnostic results ..."
            font.pointSize: 10
            placeholderText: qsTr("Text Field")
        }

    }

}

