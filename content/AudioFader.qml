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
  \brief   Display a Thermometer

  */

import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Item {
    id: root
    width: bargraph_background.width
    height: bargraph_background.height

    // 0 = min, 1.0 = max (+5dB)
    property real faderValue

    // 0 = min, 1.0=max (+5dB)
    property real meterValue

    Image {
        id : bargraph_background
        source: "qrc:/images/bargraph_background.png"
    }
    Item {
        anchors.horizontalCenter: bargraph_background.horizontalCenter
        width: bargraph_background.width
        anchors.bottom: bargraph_background.bottom
        height: root.meterValue*(bargraph_on.sourceSize.height-56)+20
        clip: true
        Image {
            id : bargraph_on
            source: "qrc:/images/bargraph_on.png"
            anchors.bottom: parent.bottom
        }
    }
    Image {
        id : bargraph_scale
        source: "qrc:/images/bargraph_scale.png"
    }

    Image {
        id: fade_background
        source: "qrc:/images/fader_background.png"
        anchors.left: bargraph_background.right

        Image {
            id: fader_knob
            source: "qrc:/images/fader_knob.png"
            anchors.horizontalCenter: parent.horizontalCenter
            y: -root.faderValue*195 + (230-fader_knob.height/2)
        }
        MouseArea {
            anchors.fill: parent

            onPositionChanged: {
                if( mouse.y > 35 && mouse.y <230) {
                    // fader_knob.y = mouse.y - fader_knob.height/2
                    // console.log( "y:" + mouse.y + ", faderValue = " + (1-(mouse.y-36)/193) )
                    root.faderValue = (1-(mouse.y-36)/193)
                }
            }

        }
    }
}
