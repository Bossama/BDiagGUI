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
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2


Rectangle {
    width: 100
    height: 62
    color: "black"

    Item {
        width: parent.width/3
        height: parent.height
        Text {
            text: "Reaktor<br>Pressure"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            font.bold: true
            font.pixelSize: 24
            horizontalAlignment: Text.AlignHCenter
            color: "lightgrey"
        }

        AnalogMeter {
            id: analogMeter
            anchors.centerIn: parent
            value: analogMeterSlider.value
            minValue: analogMeterSlider.minimumValue
            maxValue: analogMeterSlider.maximumValue
            unit: "Bar"

        }

        Slider {
            id: analogMeterSlider
            width: parent.width - 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30
            minimumValue: 0
            maximumValue: 250
            stepSize: 1
            style: SliderStyle {
                handle: Rectangle {
                    width: 40
                    height: 40
                    color: "lightgrey"
                    radius: 8
                }
            }
        }
    }

    Item {
        width: parent.width/3
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            text: "Ambient<br>Temperature"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            font.bold: true
            font.pixelSize: 24
            horizontalAlignment: Text.AlignHCenter
            color: "lightgrey"
        }
        Thermometer {
            id: thermometer
            anchors.centerIn: parent
            minValue: -30
            maxValue: 70
            value: thermometerSlider.value
            unit: "°C"
//            scale: 0.8
        }
        Slider {
            id: thermometerSlider
            minimumValue: thermometer.minValue
            maximumValue: thermometer.maxValue
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30
            width: parent.width - 60
            stepSize: 1
            style: SliderStyle {
                handle: Rectangle {
                    width: 40
                    height: 40
                    color: "lightgrey"
                    radius: 8
                }
            }
        }
    }

    Item {
        width: parent.width/3
        height: parent.height
        anchors.right: parent.right
        Text {
            text: "Audio Fader"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            font.bold: true
            font.pixelSize: 24
            horizontalAlignment: Text.AlignHCenter
            color: "lightgrey"
        }
        AudioFader {
            id: audioFader
            anchors.centerIn: parent
        }

        Timer {
            interval: 50
            running: true
            repeat: true

            onTriggered: {
                audioFader.meterValue = (0.75 + (Math.random()/4)) * audioFader.faderValue

            }
        }
    }
}
