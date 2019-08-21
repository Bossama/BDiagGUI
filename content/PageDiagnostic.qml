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
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Dialogs.qml 1.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import com.ACTIA.BDiag 1.0

Item {
    id: root
    anchors.fill: parent

    Rectangle {
        anchors.fill: parent
        color: "#959792" //"#3C3CA7"
        opacity: 1
    }

    DiagController{
        id : qml_diagcontroller

    }

    ListModel {
       id:diagModel
       ListElement {
           name: "DIAGNOSTIC";
           icon: "qrc:/images/icon_autodiag.png";
           description: " Run a full diagnostic to Check all components connected to the BDiag Tool "
           pageSource: "qrc:/content/PageAutoDiag.qml"}
       ListElement {
           name: "HISTORY";
           icon: "qrc:/images/icon_history.png"
           description: " Show previous diagnostic results and delete fixed one " }
       ListElement {
           name: "MANUAL-DIAG";
           icon: "qrc:/images/diagnostic.png"
           description: " Perform a quick diagnostic by selecting the desired components " }
     }

    Component {
         id: appDelegate
         Item {
             width: 300 ; height: 300
             //scale: PathView.iconScale
             //opacity: PathView.iconOpacity
             Image { // Icon Frame
                 id: icon_img
                 anchors.horizontalCenter: parent.horizontalCenter
                 anchors.top: parent.top
                 source: icon
                 width: 100 ; height: 100
                 fillMode: Image.PreserveAspectCrop
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

             MouseArea {
                 id: mouseArea
                 anchors.fill: parent
                 //onClicked: view.currentIndex = index
                 onClicked: {
                     //qml_diagcontroller.diagRequest()
                     var myModelItem = diagModel.get(path_view.currentIndex)
                     client_area.clientUrl = myModelItem.pageSource
                 }
             }
         }
     }

     Component {
         id: appHighlight
         Item {
             width: 134
             height: 304
         Rectangle {
             width: 134;
             height: 134;
             radius: 10
             opacity: 0.25
             border.color: "#f7eeee"
             color: "#e7e7ee"
         }
         }
     }

     Item {
         id: description_item_dummy
         x: 25
         y: 67
         width: 524
         height: 384
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
             color: "#000000"
             renderType: Text.QtRendering
             anchors.rightMargin: 16
             anchors.bottomMargin: 16
             anchors.leftMargin: 16
             anchors.topMargin: 16
             font.pixelSize: 18
             font.bold: true
             wrapMode: Text.WordWrap

         }

         MouseArea{
             anchors.fill: parent
             onClicked: {
                 qml_diagcontroller.diagRequest()
                 var myModelItem = diagModel.get(path_view.currentIndex)
                 client_area.clientUrl = myModelItem.pageSource
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
                 NumberAnimation{ properties: "x,y,width,height"; easing.type: Easing.OutBack; duration: 200}
                 NumberAnimation{ property: "opacity"; duration: 200 }
             }
         ]
     }


     PathView {
         id: pathView
         anchors.right: parent.right
         anchors.bottom: parent.bottom
         anchors.left: parent.left
         anchors.top: parent.top
         anchors.rightMargin: 0
         model: diagModel
         delegate: appDelegate
         highlight: appHighlight
         preferredHighlightBegin: 0.5
         preferredHighlightEnd: 0.5

            path: Path {
                startY: 187
                startX: 796
//                PathAttribute { name: "iconScale"; value: 0.5 }
//                PathAttribute { name: "iconOpacity"; value: 0.2 }
//                PathAttribute { name: "iconScale"; value: 1.0 }
//                PathAttribute { name: "iconOpacity"; value: 1.0 }
//                PathAttribute { name: "iconScale"; value: 0.5 }
//                PathAttribute { name: "iconOpacity"; value: 0.2 }

                PathCubic {
                    x: 796
                    y: 480
                    control2X: 568.7
                    control1X: 568.3
                    control1Y: 94.9
                    control2Y: 522.1
                }
            }

            onMovementStarted: {
                description_item.state = "NOTVISIBLE"
            }
            onMovementEnded: {
                description_item.state = "VISIBLE"
                var myModelItem = diagModel.get(path_view.currentIndex)
                description_text.text = myModelItem.description
            }
            Component.onCompleted: {
                description_item.state = "VISIBLE"
                var myModelItem = diagModel.get(path_view.currentIndex)
                description_text.text = myModelItem.description
            }
     }

    // Diag selector
    Text {
        id: txt_fileinfo
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 8
        font.bold: true
        color: "grey"
        text: "Please select a Diagnostic"
        anchors.horizontalCenterOffset: -113
        font.pointSize: 20
    }
}
