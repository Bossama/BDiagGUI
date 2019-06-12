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
import QtMultimedia 5.0
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Item {
    id: root
    anchors.fill: parent

    MediaPlayer {
        id: mediaPlayer
        autoPlay: true

        onStopped: { btn_active_bgnd.anchors.centerIn = btn_stop }
        onPaused:  { btn_active_bgnd.anchors.centerIn = btn_pause }
        onPlaying: { btn_active_bgnd.anchors.centerIn = btn_play }

        onError: {
            message_dialog.title = "MediaPlayer Error"
            message_dialog.text = "MediaPlayer Error"
            message_dialog.informativeText  = errorString
            message_dialog.icon = StandardIcon.Warning
            message_dialog.width = 400
            message_dialog.height = 240
            message_dialog.open()
        }

    }
    Rectangle {
        anchors.fill: parent
        color: "#101030" //"#3C3CA7"
        opacity: 0.9
    }

    VideoOutput {
        id: video
        antialiasing: false
        clip: false
        visible: true
        anchors.fill: parent
        source: mediaPlayer

        PathView {
            id: pathView
            x: 8
            y: 122
            width: 624
            height: 269
            anchors.right: parent.right
            anchors.rightMargin: 8
            interactive: true
            flickDeceleration: 100
            offset: 0
            preferredHighlightEnd: 0
            preferredHighlightBegin: 0
            highlightMoveDuration: 301
            highlightRangeMode: PathView.StrictlyEnforceRange
            model: ListModel {
                ListElement {
                    name: "Grey"
                    colorCode: "grey"
                }

                ListElement {
                    name: "Red"
                    colorCode: "red"
                }

                ListElement {
                    name: "Blue"
                    colorCode: "blue"
                }

                ListElement {
                    name: "Green"
                    colorCode: "green"
                }
            }
            path: Path {
                startY: -76
                startX: 665

                PathCubic {
                    x: 676
                    y: 317
                    control1X: 372.3
                    control1Y: -9.1
                    control2Y: 271.1
                    control2X: 371.7
                }
            }
            delegate: Column {
                spacing: 5
                Rectangle {
                    width: 40
                    height: 40
                    color: colorCode
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    x: 5
                    text: name
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: true
                }
            }
        }
    }

    /////////////////////////////////////////////////////////////////////////////
    // Navigation buttons stop, pause, play
    Item {
        anchors.bottom: parent.bottom
        // anchors.bottomMargin: 20
        height: 96
    }

    ///////////////////////////////////////////////////////////////
    // File selector

    Text {
        id: txt_fileinfo
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 16
        font.bold: true
        color: "grey"
        text: "Please select a Diagnostic"
        font.pointSize: 20
    }


    MessageDialog {
        id: message_dialog
    }

}
