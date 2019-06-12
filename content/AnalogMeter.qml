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

  \qmltype AnalogMeter
  \brief   Display a Analog Meter

  */


import QtQuick 2.3
import QtGraphicalEffects 1.0


Item {
    id: root
    width: scaleImg.width + 80
    height: scaleImg.height + 30

    property real value: 0
    property real minValue: 0
    property real maxValue: 100
    property string unit: ""

    Image {
        ////////////////////////////////////////////////////////////////////////////////////////////
        // Draw the AnalogMeter Background Image
        id:scaleImg
        source: "qrc:/images/Scale.png"
        anchors.top: root.top
        anchors.horizontalCenter: root.horizontalCenter

        Image {
            /////////////////////////////////////////////////////////////////////////////////////////
            // Draw the needle shadow
            id: needleShadow
            source: "qrc:/images/Needle_shadow.png"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            transform: Rotation {
                origin.x: needleShadow.width/2; origin.y : 11
                angle: needleRotation.angle
            }
        }

        Image {
            /////////////////////////////////////////////////////////////////////////////////////////
            // Draw the needle shadow
            id: needle
            source: "qrc:/images/Needle.png"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            // rotate the needle depending on property "value"
            transform: Rotation {
                id: needleRotation
                origin.x: needle.width/2; origin.y: 13;
                angle: (value-root.minValue) * 300/(root.maxValue-root.minValue) + 30
                Behavior on angle { SpringAnimation { spring: 2.4; damping: 0.15} }
//                Behavior on angle { PropertyAnimation {easing.type: Easing.OutElastic} }
            }
        }
        /////////////////////////////////////////////////////////////////////////////////////////
        // Define positions of the text
        ListModel {
            id: textModel
            ListElement { xpos:  4 ; ypos: 162; align: Text.AlignRight }
            ListElement { xpos: -31; ypos: 130; align: Text.AlignRight }
            ListElement { xpos: -42; ypos:  83; align: Text.AlignRight }
            ListElement { xpos: -31; ypos:  36; align: Text.AlignRight }
            ListElement { xpos:   4; ypos:   0; align: Text.AlignRight }
            ListElement { xpos:  70; ypos: -16; align: Text.AlignHCenter }
            ListElement { xpos: 139; ypos:   0; align: Text.AlignLeft }
            ListElement { xpos: 170; ypos:  36; align: Text.AlignLeft }
            ListElement { xpos: 185; ypos:  83; align: Text.AlignLeft }
            ListElement { xpos: 172; ypos: 130; align: Text.AlignLeft }
            ListElement { xpos: 139; ypos: 162; align: Text.AlignLeft }
        }

        Repeater {
            model: textModel
            delegate: Text{
                x: xpos ; y: ypos; width: 40
                color: "lightgrey";
                text: minValue + (maxValue - minValue)/10 * index;
                horizontalAlignment: Text.AlignJustify
                font.pixelSize: 14
                font.bold: true
            }
        }

    }

    Rectangle {
        width: 90
        height: 25
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        color: "lightgrey"
        border.width: 1
        border.color: "darkgrey"
        radius: 3


        Text {
            id: txtValue
            anchors.fill: parent
            text: root.value + " " + root.unit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "black"
            font.bold: true
            font.pixelSize: 18
        }
    }
}
