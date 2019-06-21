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

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.2
import Qt.labs.calendar 1.0
import QtQuick.Window 2.3


Rectangle {
    width: 800
    height: 480
    color: "grey"

//    BusyIndicator {
//        id: busyIndicator
//        x: 337
//        y: 189
//        width: 127
//        height: 102
//        //running: image.status === Image.Loading
//    }

//    Text {
//        id: text1
//        x: 243
//        y: 26
//        width: 198
//        height: 36
//        text: qsTr("Showing Vehicule Infos")
//        font.pixelSize: 31
//    }

//    Text {
//        id: text2
//        x: 316
//        y: 297
//        text: qsTr("Connecting to ECU")
//        font.pixelSize: 20
//    }

    Loader {
        id: popupLoader
        active: false
        source: "qrc:/TestPopup.qml"
        onLoaded: item.open()
    }

    function openMyPopup() {
        if( popupLoader.active )
            popupLoader.item.open()
        else
            popupLoader.active = true
    }

}
