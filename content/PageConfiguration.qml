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
import Qt.labs.folderlistmodel 2.1

Rectangle {
    id: root
    width: 800
    height: 480
    color: "black"

    function resetImagePos() {
        imageViewer.scale = 1.0
        imageViewer.rotation = 0.0
        imageViewer.x = 0
        imageViewer.y = 0
    }

    ///////////////////////////////////////////////////////////////
    // Display the selected image
    Rectangle {
        height: parent.height* 4 / 5
        width: parent.width
        anchors.top: parent.top
        clip: true
        color: "grey"
        Image {
            id: imageViewer
            height: parent.height
            width: parent.width
            fillMode: Image.PreserveAspectFit
            PinchArea {
                anchors.fill: parent
                pinch.target: imageViewer
                pinch.minimumScale: 0.5
                pinch.maximumScale: 3.0
                pinch.minimumRotation: -3600
                pinch.maximumRotation: 3600
                pinch.dragAxis: Pinch.XAndYAxis
            }
        }
    }


    ///////////////////////////////////////////////////////////////
    // Display the name of the selected file on top center position
    Item {
        anchors.horizontalCenter: root.horizontalCenter
        anchors.top: root.top
        anchors.topMargin: 20
        Rectangle {
            anchors.centerIn: parent
            width: file_name.width + 8
            height: file_name.height + 8
            color: "grey"
            opacity: 0.75
            radius: height / 3.0
        }
        Text {
            id: file_name
            anchors.centerIn: parent
            text: "no file selected"
        }
    }


    ///////////////////////////////////////////////////////////////
    // Get files in the folder
    FolderListModel {
        id: folder_model
        showDirs: false
        //showDotAndDotDot: true
        //showDirsFirst: true
        nameFilters: [ "*.png", "*.jpg", "*.JPG" ]

        onFolderChanged: {
            //folder_name_txt.text = folder_model.folder
        }

        Component.onCompleted: {
            folder_model.folder = "file:///usr/share/phytec-qtdemo/images"
        }
    }

    ///////////////////////////////////////////////////////////////
    // preview area
    ListView {
        id: list_view
        width: parent.width
        height: parent.height / 5
        anchors.bottom: parent.bottom
        orientation: ListView.Horizontal
        model: folder_model
        spacing: 10
        delegate: preview_delegate
    }

    Component {
        id: preview_delegate
        Rectangle {
            id: delegate_rect
            height: list_view.height
            width: height * 4.0 / 3.0
            border.color: ListView.isCurrentItem ? "lightgrey" : "transparent"
            color: "#303030"

            Image {
                anchors.fill: parent
                anchors.margins: 3
                source: fileURL
                fillMode: Image.PreserveAspectFit

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        imageViewer.source = fileURL
                        console.log( "Image scale = " + imageViewer.scale + ", Pos X/Y: " + imageViewer.x + " / " + imageViewer.y )
                        resetImagePos()
                        file_name.text = fileName
                        list_view.currentIndex = index
                    }
                }
            }
        }
    }

    ///////////////////////////////////////////////////////////////
    // File selector
    Image {
        source: "../images/btn_file.png"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20
        MouseArea{
            anchors.fill: parent
            onClicked: {
                file_open_box.open();

            }
        }
    }

    FileOpenBox {
        id: file_open_box

        anchors.fill: parent
        anchors.margins: 16
        folder: folder_model.folder
        onOkClicked: {
            folder_model.folder = folder
            imageViewer.source = selectedFileURL
            file_name.text = selectedFileName
            list_view.currentIndex = -1
            resetImagePos()
        }
        Component.onCompleted: {
            nameFilters = folder_model.nameFilters
        }
    }
}
