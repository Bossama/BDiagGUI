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


import QtQuick 2.0

Item {
    id: root
    width: 100
    height: 42

    property alias label: txtLabel.text
    signal switchOnRequest
    signal switchOffRequest
    property bool isOn: false

    onIsOnChanged: {
        if( isOn )
            state = "ON"
        else
            state = "OFF"
    }


    state: "OFF"

    Text {
        id: txtLabel
        anchors.left: parent.left
        anchors.verticalCenter: imgSwitch.verticalCenter
        font.pixelSize: 16
//        font.bold: true
        color: "lightgrey"
        text: "<label>"
    }

    Image {
        id: imgSwitch
        anchors.right: parent.right
        anchors.top: parent.top
        source: "qrc:/controls/icon_btn_on.png"

        MouseArea {
            anchors.fill: parent

            onClicked: {
                if( isOn ) {
                    root.state = "OFF_REQUESTED"
                    timer.start()
                    root.switchOffRequest()
                }
                else {
                    root.state = "ON_REQUESTED"
                    timer.start()
                    root.switchOnRequest()
                }

            }
        }
    }

    states: [
        State {
            name: "OFF"
            PropertyChanges { target: imgSwitch; source: "qrc:/controls/icon_btn_on.png" }
        },
        State {
            name: "ON_REQUESTED"
            PropertyChanges { target: imgSwitch; source: "qrc:/controls/icon_btn_on_active.png" }
        },
        State {
            name: "ON"
            PropertyChanges { target: imgSwitch; source: "qrc:/controls/icon_btn_on_active.png" }
        },
        State {
            name: "OFF_REQUESTED"
            PropertyChanges { target: imgSwitch; source: "qrc:/controls/icon_btn_on.png" }
        }
    ]

    Timer {
        id: timer
        interval: 1500
        running: false
        repeat: false
        onTriggered: {
            if( root.state === "ON_REQUESTED" )
                root.state = "OFF"
            else if ( root.state === "OFF_REQUESTED" )
                root.state = "ON"
        }

    }
}
