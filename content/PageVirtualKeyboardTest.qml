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
import QtQuick.Controls 1.2



// just a simple gui, for testing virtual keyboard
Rectangle {
    width: 800
    height: 480
    color: "black"

    Rectangle {
        id: textInput
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 20
        height: 30
        width: 360
        color: "black"
        border.color: "white"
        clip: true
        TextInput {
            anchors.fill: parent
            text: "Textinput 1"
            font.pixelSize: 24
            color: "white"
        }
    }

    Item {
        id: textInputRO
        anchors.left: parent.left
        anchors.top: textInput.bottom
        anchors.margins: 20
        height: 30
        width: 280
        Rectangle {
            anchors.fill: parent
            color: "black"
            border.color: "white"
            clip: true
            TextInput {
                anchors.left: parent.left
                anchors.top: parent.top
                height: parent.height
                width: parent.width
                text: roSwitch.checked ? "Textinput read only" : "TextInput"
                font.pixelSize: 24
                color: "white"
                readOnly: roSwitch.checked
            }
        }
        Switch {
            id: roSwitch
            anchors.left: parent.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            width: 40
            height: 30
            checked: true
        }
    }

    Item {
        anchors.left: parent.left
        anchors.top: textInputRO.bottom
        anchors.margins: 20
        height: 60
        width: 360

        Label {
            anchors.left: parent.left
            anchors.bottom: numberInput.top
            text: "Number input:"
            color: "white"
            font.bold: true
        }

        Rectangle {
            id: numberInput
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            //anchors.margins: 20
            height: parent.height/2
            width: parent.width
            color: "black"
            border.color: "white"
            clip: true
            TextInput {
                anchors.fill: parent
                font.pixelSize: 24
                color: "white"
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                validator: IntValidator{}
            }
        }
    }

    // textedit background
    Rectangle {
        color: "black"
        border.color: "white"
        width: 360; height: 240;
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 20

        Flickable {
            id: flick
            anchors.fill: parent
            anchors.margins: 2
            contentWidth: edit.paintedWidth
            contentHeight: edit.paintedHeight
            clip: true

            function ensureVisible(r)
            {
                if (contentX >= r.x)
                    contentX = r.x;
                else if (contentX+width <= r.x+r.width)
                    contentX = r.x+r.width-width;
                if (contentY >= r.y)
                    contentY = r.y;
                else if (contentY+height <= r.y+r.height)
                    contentY = r.y+r.height-height;
            }

            TextEdit {
                id: edit
                width: flick.width
                height: flick.height
                color: "white"
                text: "\nthis is a textEdit"
                font.pixelSize: 20
                wrapMode: TextEdit.Wrap
                onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
            }
        }
    }
}
