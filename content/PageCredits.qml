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
import QtQml.Models 2.1

Item {
    id: root

    width: 800
    height: 480

    ObjectModel {
        id: itemModel
        Image {
            source: "qrc:/images/page_phytec_1.png"
            width: view.width
            height: view.height
            fillMode: Image.PreserveAspectFit
        }

        Image {
            source: "qrc:/images/page_phytec_2.png"
            width: view.width
            height: view.height
            fillMode: Image.PreserveAspectFit
        }

        Image {
            source: "qrc:/images/page_phytec_3.png"
            width: view.width
            height: view.height
            fillMode: Image.PreserveAspectFit
        }
    }

    ListView {
        id: view
        clip: true
        anchors { fill: parent; bottomMargin: 30 }
        model: itemModel
        preferredHighlightBegin: 0; preferredHighlightEnd: 0
        highlightRangeMode: ListView.StrictlyEnforceRange
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem; flickDeceleration: 2000
        cacheBuffer: 200
        highlightMoveDuration: 500

        Row {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.margins: 16
            spacing: 16
            Image {
                source: "qrc:/images/btn_back.png"
                visible: view.currentIndex != 0
                MouseArea {
                    anchors.fill: parent
                    onClicked: view.decrementCurrentIndex()
                }
            }
            Image {
                source: "qrc:/images/btn_foreward.png"
                visible: view.currentIndex < (view.count -1)
                MouseArea {
                    anchors.fill: parent
                    onClicked: view.incrementCurrentIndex()
                }
            }
        }
    }

    Rectangle {
        width: view.width; height: 30
        anchors { top: view.bottom; bottom: parent.bottom }
        color: "transparent"

        Row {
            anchors.centerIn: parent
            spacing: 20

            Repeater {
                model: itemModel.count

                Rectangle {
                    width: 10; height: 10
                    border.color: "grey"
                    radius: 3
                    color: view.currentIndex == index ? "green" : "white"

                    MouseArea {
                        width: 20; height: 20
                        anchors.centerIn: parent
                        onClicked: { view.currentIndex = index
//                            console.log( "hVelocity=" + view.horizontalVelocity)
                        }
                    }
                }
            }
        }
    }
}
