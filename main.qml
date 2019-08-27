/*******************************************************************************
**
** MIT License
**
** Copyright (c) 2015 Werner Fries <werner.fries@fri-ware.de>
**
** Permission is hereby granted, free of charge, to any person obtaining a copy
** of this software and associated documentation files (the "Software"), to deal
** in the Software without restriction, including without limitation the rights
** to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
** copies of the Software, and to permit persons to whom the Software is
** furnished to do so, subject to the following conditions:
**
** The above copyright notice and this permission notice shall be included in
** all copies or substantial portions of the Software.
**
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
** IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
** AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
** OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
** THE SOFTWARE.
**
****************************************************************************/

import QtQuick 2.3
import QtQuick.Window 2.0
import QtQuick.Controls 1.2
import QtGraphicalEffects 1.0
import QtQuick.VirtualKeyboard 1.0
import com.ACTIA.BDiag 1.0


Window {
    visible: true
    // a fixed size is required by qt 5.7 2d renderer with linuxfb
    width: 800
    height: 480
    id: root
    title: qsTr("BDiag_GUI")
    color: "black"
    Component.onCompleted: root.showMaximized()

    DiagController{
        id :qml_diagcontroller
    }

    Image {
        id: background_image
        anchors.fill: parent
        source: "qrc:/images/BG_Image_Phytec_800x480.png"
    }

    ListModel {
        id: menue_model
        ListElement {
            name: "Diagnostic"
            icon: "images/icon_diagnostic.png"
            pageSource: "content/PageDiagnostic.qml"
            description: "RUN DIAGNOSTIC"
        }
        ListElement {
            name: "Configure"
            icon: "images/icon_config.png"
            pageSource: "content/PageConfiguration.qml"
            description: "SET CONFIGURATION"
        }
        ListElement {
            name: "Info"
            icon: "images/icon_info.png"
            pageSource: "content/PageAnalogMeters.qml"
            description: "VISUALIZE INFO TAINEMENT"
        }
       /* ListElement {
            name: "Multitouch<br>Demo"
            icon: "images/icon_multitouch.png"
            pageSource: "content/PageMultitouch.qml"
            description: "USE MULTITOUCH"
        }
        ListElement {
            name: "WebBrowser"
            icon: "images/icon_web_128x128.png"
            pageSource: "content/PageWebbrowser.qml"
            description: "BROWSE THE WEB"
        }
        ListElement {
            name: "Virtual Keyboard Test"
            icon: "qrc:/images/icon_vkey_128x128.png"
            pageSource: "qrc:/content/PageVirtualKeyboardTest.qml"
            description: "TYPE IN TEXT"
        }
        ListElement {
            name: "Info"
            icon: "qrc:/images/icon_phytec.png"
            pageSource: "content/PageCredits.qml"
            description: "SHOW COMPANY INFORMATION"
        }*/
    }

    Component {
        id: menu_delegate
        Item {
            width: 134
            height: 174
            scale: PathView.iconScale
            opacity: PathView.iconOpacity
            Image { //Icon  Size
                id: icon_img
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                source: icon
                width: 200 ; height: 200
                fillMode: Image.PreserveAspectFit
                smooth: true
            }
            Text {
                id: nameText
                width: 134
                height: 40
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: icon_img.bottom
                anchors.topMargin: 4
                text: name
                color: "black"
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }

    Component {
        id: menu_highlight
        Item {  // Icon Baground Position
            width: 134
            height: 174
            Rectangle {
                x: -33
                y: 0 // Rectangle for Icon
                width: 200
                height: 200
                radius: 10
                opacity: 0.25
                border.color: "white"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    var myModelItem = menue_model.get(path_view.currentIndex)
                    client_area.clientUrl = myModelItem.pageSource
                    //qml_diagcontroller.diagRequest()
                }
            }
        }
    }


    Item {
        id: description_item_dummy
        width: 600
        height: 120
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        y: (root.height*3/5)
        anchors.horizontalCenter: parent.horizontalCenter
    }


    ////////////////////////////////////////////////////////////////////////////
    // This Item displays the description text
    // It has two States "VISIBLE" and "NOTVISIBLE".
    // The States are set from PathView depending on movement of the icons

    Item {
        id: description_item

        Rectangle {
            anchors.fill: parent
            radius: 10
            opacity: 0.25
            color: "grey"
        }
        Text {
            id: description_text
            anchors.fill: parent
            anchors.margins: 16
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            clip: true
            color: "black"
            font.pixelSize: 18
            font.bold: true
            wrapMode: Text.WordWrap

        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                var myModelItem = menue_model.get(path_view.currentIndex)
                client_area.clientUrl = myModelItem.pageSource
                //qml_diagcontroller.diagRequest()
            }
        }

        states: [
            State {
                name: "VISIBLE"
                PropertyChanges {
                    target: description_item
                    opacity: 1.0
                    x: description_item_dummy.x
                    y: description_item_dummy.y
                    width: description_item_dummy.width
                    height: description_item_dummy.height
                }
            },
            State {
                name: "NOTVISIBLE"
                PropertyChanges {
                    target: description_item
                    opacity: 0.0
                    x: root.width/2
                    y: 150
                    width: menu_highlight.width
                    height: menu_highlight.height
                }
            }
        ]
        transitions: [
            Transition {
                from: "*"
                to: "VISIBLE"
                NumberAnimation{ properties: "x,y,width,height"; easing.type: Easing.OutBack; duration: 500}
                NumberAnimation{ property: "opacity"; duration: 500 }
            }
        ]
    }

    Image {
        id: icon_loading
        anchors.centerIn: parent
        source: "qrc:/images/icon_loading.png"
        visible: false
        NumberAnimation on rotation {
             from: 0
             to: 360
             running: icon_loading.visible == true
             loops: Animation.Infinite
             duration: 900
         }
    }


    ////////////////////////////////////////////////////////////////////////////
    // Client Items are displayed inside this item
    // they are shown or not by setting the visibility

    PathView {
        id: path_view
        anchors.fill: parent
        model: menue_model
        delegate: menu_delegate
        highlight: menu_highlight
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5

        path: Path {
            startX: root.width/5
            startY: 100
            PathAttribute { name: "iconScale"; value: 0.5 }
            PathAttribute { name: "iconOpacity"; value: 0.2 }
            PathQuad { x: root.width/2; y: root.height/3; controlX: 100; controlY: root.height/3 }
            PathAttribute { name: "iconScale"; value: 1.0 }
            PathAttribute { name: "iconOpacity"; value: 1.0 }
            PathQuad { x: root.width-root.width/5; y: 100; controlX: root.width-100; controlY: root.height/3 }
            PathAttribute { name: "iconScale"; value: 0.5 }
            PathAttribute { name: "iconOpacity"; value: 0.2 }

        }
        onMovementStarted: {
            description_item.state = "NOTVISIBLE"
        }

        onMovementEnded: {
            description_item.state = "VISIBLE"
            var myModelItem = menue_model.get(path_view.currentIndex)
            description_text.text = myModelItem.description
        }
        Component.onCompleted: {
            description_item.state = "VISIBLE"
            var myModelItem = menue_model.get(path_view.currentIndex)
            description_text.text = myModelItem.description
        }

        Text {
            id: text_loading
            anchors.horizontalCenter: parent.horizontalCenter
            y: 20
            color: "grey"
            text: "loading..."
            font.bold: true
            visible: false
        }
    }

    Item {
        id: client_area
        anchors.fill: parent
        visible: false
        clip: true
        property url clientUrl
        onClientUrlChanged: visible = (clientUrl == '' ? false : true); //Setting exampleUrl automatically shows example

        MouseArea {
            anchors.fill: parent
            enabled: client_area.visible
            // eat mouse events
        }
        Loader {
            id: client_loader
            focus: true
            source: client_area.clientUrl
            anchors.fill: parent
            asynchronous: true  // must be true to to get the "Loading" Status
            onStatusChanged: {
                if( status === Loader.Loading ) {
                    icon_loading.visible = true
                }
                else {
                    icon_loading.visible = false
                }
            }
        }

        Image {
            id: back
            x: 8
            anchors.rightMargin: 738
            anchors.topMargin: 418
            source: "qrc:/images/btn_home2.png"
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 16
            MouseArea {
                anchors.fill: parent
                onClicked: client_area.clientUrl = ""
            }
        }
    }


    InputPanel {
        id: inputPanel
        z: 99
        y: root.height
        anchors.left: parent.left
        anchors.right: parent.right
        states: State {
            name: "visible"
            when: Qt.inputMethod.visible
            PropertyChanges {
                target: inputPanel
                y: root.height - inputPanel.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 150
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }

}
