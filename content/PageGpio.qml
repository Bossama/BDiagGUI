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
import "../controls"
import FriWare.ProcessIf 1.0

Rectangle {
    id: root
    width: 800
    height: 480
    color: "black"

    QtObject {
        id: properties
        property int margins: 8
    }

    ////////////////////////////////////////////////////////////////////////////////////////////
    // Draw the Header
    Rectangle {
        id: headerRect
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: properties.margins
        height: 32
        Text {
            anchors.centerIn: parent
            text: "Accessing hardware demo"
            font.bold: true
            font.pixelSize: 24
        }
    }

    ////////////////////////////////////////////////////////////////////////////////////////////
    // Draw LED related gui
    Rectangle {
        id: ledRect
        anchors.top: headerRect.bottom
        anchors.bottom: root.bottom
        anchors.left: root.left
        width: root.width/2 - properties.margins * 1.5
        anchors.margins: properties.margins
        color: "darkgreen"

        Column {
            anchors.fill: parent
            anchors.margins: properties.margins
            spacing: 8
            Text {
                width: parent.width
                text: "Example of how to access <br>LED's via sys-fs led-class. <br>Press the buttons below, <br>to toggle LED's on/off"
                font.bold: true
                font.pixelSize: 18
                wrapMode: Text.Wrap
                color: "white"
                //horizontalAlignment: Text.AlignHCenter
            }
            OnOffSwitch {
                id: led1switch
                width: parent.width
                label: "LED 1"
                isOn: ProcessIf.led1 === 0 ? false : true

                onSwitchOffRequest: {
                    console.log( "switch OFF request")
                    ProcessIf.led1 = 0
                }
                onSwitchOnRequest: {
                    console.log( "switch ON request")
                    ProcessIf.led1 = 255
                }
            }
            OnOffSwitch {
                id: led2switch
                width: parent.width
                label: "LED 2"
                isOn: ProcessIf.led2 === 0 ? false : true

                onSwitchOffRequest: {
                    console.log( "switch OFF request")
                    ProcessIf.led2 = 0
                }
                onSwitchOnRequest: {
                    console.log( "switch ON request")
                    ProcessIf.led2 = 255
                }
            }
            OnOffSwitch {
                id: led3switch
                width: parent.width
                label: "LED 3"
                isOn: ProcessIf.led3 === 0 ? false : true

                onSwitchOffRequest: {
                    console.log( "switch OFF request")
                    ProcessIf.led3 = 0
                }
                onSwitchOnRequest: {
                    console.log( "switch ON request")
                    ProcessIf.led3 = 255
                }
            }

            Rectangle { width: parent.width; height: 1 }

            Text {
                width: parent.width
                text: "Values read from ProcessIf.led1/2/3 properties:"
                font.bold: true
                font.pixelSize: 18
                wrapMode: Text.Wrap
                color: "white"
            }
            Text {
                color: "white"
                width: parent.width
                text: "LED1 value: " + ProcessIf.led1
            }
            Text {
                color: "white"
                width: parent.width
                text: "LED2 value: " + ProcessIf.led2
            }
            Text {
                color: "white"
                width: parent.width
                text: "LED3 value: " + ProcessIf.led3
            }


        }
    }
    Rectangle {
        id: gpioRect
        anchors.top: headerRect.bottom
        anchors.bottom: root.bottom
        //            anchors.left: root.left
        width: root.width/2 - properties.margins * 1.5
        anchors.right: root.right
        anchors.margins: properties.margins
        color: "darkblue"
        Column {
            anchors.fill: parent
            anchors.margins: properties.margins
            spacing: 8

            Text {
                width: parent.width
                text: "Example how to access GPIO from QML.<br>Press the buttons on PEB-EVAL-01:"
                font.bold: true
                font.pixelSize: 18
                wrapMode: Text.Wrap
                color: "white"
            }
            Text {
                color: "white"
                width: root.width/2 - properties.margins * 1.5
                text: "Gpio 1 value: " + ProcessIf.gpio1
            }

            Text {
                color: "white"
                width: root.width/2 - properties.margins * 1.5
                text: "Gpio 2 value: " + ProcessIf.gpio2
            }

            Text {
                color: "white"
                width: root.width/2 - properties.margins * 1.5
                text: "Gpio 3 value: " + ProcessIf.gpio3
            }

            Rectangle { width: parent.width; height: 1 }

            Text {
                color: "white"
                width: root.width/2 - properties.margins * 1.5
                text: "<b>NOTE:</b>"
            }
            Text {
                color: "white"
                width: root.width/2 - properties.margins * 1.5
                wrapMode: Text.Wrap
                text: "The GPIO numbers and the LED's have to be configured in the application configuration file.\
Normaly it can be found at the following location in the filesystem: '/home/root/.config/Phytec/PhyKitDemo.conf'"
            }
        }
    }
}
