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

/*
  author:  Werner Fries
  company: friWare - Embedded Logic Solutions
  web:     www.friware.com
  e-mail:  info(at)friware.com

  \qmltype Thermometer
  \brief   Display a Thermometer

  */

import QtQuick 2.3

Item {
    id: root
    width: backgndImg.width
    height: backgndImg.height

    property real value: 0
    property real minValue: 0
    property real maxValue: 100
    property string unit: "° C"

    Image {
        id: backgndImg
        source: "qrc:/images/Temperature Background.png"

        Item {
            //////////////////////////////////////////////////////////////////
            // this Item is used to mask the Temperature Gradient Image
            id: maskRect
            anchors.horizontalCenter: backgndImg.horizontalCenter
            anchors.bottom: backgndImg.bottom
            anchors.bottomMargin: 17
            width: backgndImg.sourceSize.width
            height: (250.0/(root.maxValue-root.minValue)) * (root.value-root.minValue) + 55
            clip: true

            // The Image is masked by the parent item
            Image {
                id: tempGradient
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                source: "qrc:/images/Temperature Gradient.png"
            }
        }
        Rectangle {
            ///////////////////////////////////////////////////
            // display the current value in a rect
            anchors.verticalCenter: maskRect.top
            anchors.right: maskRect.right
            anchors.rightMargin: -30
            width: 70
            height: 25
            color: "lightgrey"
            border.width: 1
            border.color: "darkgrey"
            radius: 3
            Text {
                text: root.value + " " + unit
                anchors.fill: parent
                color: "black"
                font.bold: true
                font.pixelSize: 18
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        Image {
            id: borderImg
            anchors.centerIn: parent
            source: "qrc:/images/Temperature Border.png"
            Repeater {
                ///////////////////////////////////////////////////
                // Draw the scale
                id: scaleRepeater
                model: 10
                Rectangle {
                    color: "lightgrey"
                    height: 2
                    width: 5
                    x: 2
                    y: (borderImg.height-36)*( 1-1/scaleRepeater.count *index)
                    Text {
                        width: 20
                        anchors.right: parent.left
                        anchors.rightMargin: 3
                        anchors.verticalCenter: parent.verticalCenter
                        text: root.minValue + (root.maxValue-root.minValue)/scaleRepeater.count*index
                        color: "lightgrey"
                        horizontalAlignment: Text.AlignRight
                        font.pixelSize: 14
                        font.bold: true
                    }
                }
            }
        }
    }
}
