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
import Qt.labs.folderlistmodel 2.1
import FriWare.ProcessIf 1.0
import FriWare.FileIO 1.0

Rectangle {
    id: root
    width: 400
    height: 480
    color: "#101020"
    state: "NOTVISIBLE"
    focus: true
    clip: true

    property string selectedFilePath : ""
    property string selectedFileURL : ""
    property string selectedFileName : ""
    property alias folder : folder_model.folder
    property alias nameFilters : folder_model.nameFilters

    signal okClicked( string selectedFilePath )
    signal chancelClicked

    FileIO{
        id: fileIO
    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Functions

    function open() {
        state = "VISIBLE"
    }

    // Evaluates the current selection in the view.
    // Called by onDoubleClicked from delgate or when OH-button is clicked
    function evalSelection( selected_index )
    {
        /*
        console.log( "baseName: " + folder_model.get(selected_index, "fileBaseName" ) )
        console.log( "fileName: " + folder_model.get(selected_index, "fileName" ) )
        console.log( "folder: " + folder_model.folder )
        */

        // Check if current directory exists
        if( fileIO.dirExists( folder_model.folder) ) {
            // console.log( "dir: " + folder_model.folder + " exists" )
        }
        else {
            console.warn( "WARNING: Directory  '" + folder_model.folder + "' does NOT exists! Setting to 'file:///'" )
            folder_model.folder = "file:///"
            return
        }

        if( folder_model.isFolder(selected_index) ) {
            // a folder was selected
            if( folder_model.get( selected_index, "fileName") == ".." ) {
                if( folder_model.folder == "file:///") {
                    // we are in root folder, so ignore
                }
                else {
                    folder_model.folder = folder_model.parentFolder
                }
            }
            else if( folder_model.get( selected_index, "fileName") == "." ) {
                // ignore single dot (means current dir)
            }
            else {
                if( folder_model.folder == "file:///") {
                    folder_model.folder = folder_model.folder  + folder_model.get( selected_index, "fileName" )
                }
                else {
                    console.log( "new folder: " + folder_model.folder  + "/" + folder_model.get( selected_index, "fileName" ) )
                    folder_model.folder = folder_model.folder  + "/" + folder_model.get( selected_index, "fileName" )
                }
            }
        }
        else {
            // handle file selection here
            // console.log( folder_model.get(selected_index, "filePath" ) )

            root.selectedFilePath = folder_model.get(selected_index, "filePath" )
            root.selectedFileURL = folder_model.get(selected_index, "fileURL" )
            root.selectedFileName = folder_model.get(selected_index, "fileName" )
            okClicked( root.selectedFilePath )
            root.state = "NOTVISIBLE"
        }
    }

    states: [
        State {
            name: "VISIBLE"
            PropertyChanges {
                target: root; visible: true
            }
        },
        State {
            name: "NOTVISIBLE"
            PropertyChanges {
                target: root; visible: false
            }
        }
    ]


    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Model data and behaviour
    FolderListModel {
        id: folder_model
        showDotAndDotDot: true
        showDirsFirst: true
        //nameFilters: [ "*.mp4", "*.mpg" ]

        onFolderChanged: {
            folder_name_txt.text = folder_model.folder
        }

        Component.onCompleted: {
            //folder_model.folder = "file:///home/Videos"
            folder_name_txt.text = folder_model.folder
        }
    }


    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Delegate
    Component {
        id: file_delegate
        Item {
            width: root.width
            height: 32
            Image {
                source: folder_model.isFolder(index) ? "../images/icon_folder_30x21.png" : ""
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                id: txt_fileName
                width: root.width * 0.66
                x: 36
                anchors.verticalCenter: parent.verticalCenter
                text: fileName
                color: "lightgrey"
                clip: true
            }
            Text {
                width: root.width * 0.33
                x: txt_fileName.width + txt_fileName.x
                anchors.verticalCenter: parent.verticalCenter
                text: (fileSize/1024).toFixed(2) + " kB"
                color: "lightgrey"
                clip: true
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log( "Clicked " + fileName )
                    console.log( "Current folder: " + folder_model.folder )
                    list_view.currentIndex = index
                }
                onDoubleClicked: {
                    evalSelection( index )
                }
            }
        }
    }


    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Here the current folder is displayed
    Rectangle {
        id: folder_name_rect
        width: root.width
        height: 32
        color: "lightgray"
        Text {
            id: folder_name_txt
            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            text: folder_model.folder
            color: "black"
        }
    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Listview definition
    ListView {
        id: list_view
        width: root.width
        height: 480 - folder_name_rect.height - 120
        y: folder_name_rect.y + folder_name_rect.height
        clip: true

        model: folder_model
        delegate: file_delegate
        highlight: Rectangle {
            width: list_view.width
            height: 16
            color: "#303040"
        }
    }

    /////////////////////////////////////////////////////////////////////////
    // Buttons OK and Chancel
    Row {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 24
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 8
        Rectangle {
            id: btn_ok
            width: 84; height: 48
            color: "darkgrey"
            radius: 5
            Text {
                anchors.centerIn: parent
                text: "Ok"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    evalSelection( list_view.currentIndex )
                }
            }
        }
        Rectangle {
            id: bnt_chancel
            width: 84; height: 48
            color: "darkgrey"
            radius: 5
            Text {
                anchors.centerIn: parent
                text: "Chancel"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    root.state = "NOTVISIBLE"
                    chancelClicked() //emit the signal
                }
            }
        }
    }
}
