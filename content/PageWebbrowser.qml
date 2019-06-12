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
import QtWebKit 3.0
import QtQuick.Controls.Styles 1.2
import QtQuick.XmlListModel 2.0
import QtQuick.Dialogs 1.2
import FriWare.FileIO 1.0

Rectangle {
    id: root
    width: 400
    height: 240
    color: "black"

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Menu bar (on top of the page)
    Item {
        id: menubar
        height: 40
        width: parent.width
        anchors.top: parent.top

        /////////////////////////////////////////////////////////////
        // Menu Button
        Rectangle {
            id: menuBtn
            width: 60
            height: parent.height
            color: "black"
            //border.color: "lightgrey"
            opacity: 0.8
            // radius: 4
            Image {
                source: "qrc:/images/btn_menu_40x40.png"
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    // console.log( "btnState = " + menuBtn.state )
                    menuBtn.state == "MENUOFF" ? menuBtn.state = "MENUON" : menuBtn.state = "MENUOFF"
                }
            }

            state: "MENUOFF"
            states: [
                State {
                    name: "MENUOFF"
                    PropertyChanges {
                        target: dropDownMenu; width: 0
                    }
                    PropertyChanges {
                        target: menuBtn; color: "black"
                    }
                },
                State {
                    name: "MENUON"
                    PropertyChanges {
                        target: dropDownMenu; width: 200
                    }
                    PropertyChanges {
                        target: menuBtn; color: "darkgrey"

                    }
                }
            ]
        }

        /////////////////////////////////////////////////////////////
        // Back Button
        Rectangle{
            id: backBtn
            width: 50
            height: parent.height
            color: maBack.pressed ? "darkgrey" : "black"
            anchors.left: menuBtn.right
            opacity: 0.8
            Image {
                source: "qrc:/images/btn_back_40x40.png"
                anchors.centerIn: parent
                opacity: webview.canGoBack ? 1 : 0.5
            }
            MouseArea{
                id: maBack
                anchors.fill: parent
                onClicked: webview.goBack()
            }
        }


        /////////////////////////////////////////////////////////////
        // Foreward Button
        Rectangle{
            id: forewardBtn
            width: 50
            height: parent.height
            color: maForeward.pressed ? "darkgrey" : "black"
            anchors.left: backBtn.right
            opacity: 0.8
            Image {
                source: "qrc:/images/btn_foreward_40x40.png"
                anchors.centerIn: parent
                opacity: webview.canGoForward ? 1 : 0.5
            }
            MouseArea{
                id: maForeward
                anchors.fill: parent
                onClicked: webview.goForward()
            }
        }

        /////////////////////////////////////////////////////////////
        // Load/reload/stop Button
        Rectangle{
            id: loadBtn
            width: 50
            height: parent.height
            color: maLoad.pressed ? "darkgrey" : "black"
            anchors.left: forewardBtn.right
            opacity: 0.8

            state: if( webview.loading )
                   {
                       "LOADING"
                   }
                   else
                   {
                       if( urlTextInput.text == webview.url )
                       {
                           "RELOAD"
                       }
                       else
                       {
                           "LOAD"
                       }
                   }

            states: [
                State {
                    name: "LOADING"
                    PropertyChanges {
                        target: loadBtnImg; source: "qrc:/images/btn_stopload_40x40.png"
                    }
                },
                State {
                    name: "RELOAD"
                    PropertyChanges {
                        target: loadBtnImg; source: "qrc:/images/btn_reload_40x40.png"
                    }
                },
                State {
                    name: "LOAD"
                    PropertyChanges {
                        target: loadBtnImg; source: "qrc:/images/btn_load_40x40.png"
                    }
                }
            ]

            Image {
                id: loadBtnImg
                source: "qrc:/images/btn_load_40x40.png"
                anchors.centerIn: parent
            }
            MouseArea{
                id: maLoad
                anchors.fill: parent
                onClicked: {
                    if( loadBtn.state == "LOADING" )
                        webview.stop()
                    else if( loadBtn.state == "RELOAD" )
                        webview.reload()
                    else
                        webview.url = urlTextInput.text
                }

            }
        }

        /////////////////////////////////////////////////////////////
        // URL Text input area
        Rectangle {
            anchors.left: loadBtn.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.margins: 4
            opacity: 0.8
            border.color: "black"
            radius:4
            TextInput {
                id: urlTextInput
                anchors.fill: parent
                anchors.margins: 4
                anchors.rightMargin: 32
                clip: true
                text: webview.url == "" ? "file:///usr/share/phytec-qtdemo/html/index.html" : webview.url
                verticalAlignment: Text.AlignVCenter
                selectByMouse: true
                onAccepted: webview.url = text
            }
        }
    }


    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Web Page Area
    ScrollView {
        anchors.top: menubar.bottom
        anchors.bottom: parent.bottom
        width: parent.width
        WebView {
            id: webview
            anchors.fill: parent
            url: "file:///usr/share/phytec-qtdemo/html/index.html"
            /*onNavigationRequested: {
                console.log( "OnNavigationRequest: " + request.url)
                // detect URL scheme prefix, most likely an external link
                var schemaRE = /^\w+:/;
                if (schemaRE.test(request.url)) {
                    request.action = WebView.AcceptRequest;
                } else {
                    request.action = WebView.IgnoreRequest;
                    // delegate request.url here
                    console.log( "onNavigationRequested:IgnoreRequest" );
                    message_dialog.title = "WebBrowser Error"
                    message_dialog.text  = "Sorry Navigation Request \"" + request.url + "\" not supported"
                    message_dialog.icon = StandardIcon.Warning
                    message_dialog.width = 400
                    message_dialog.height = 240
                    message_dialog.open()
                }
            }*/
            onLoadingChanged : {
                console.log( "onLoadingChanged: " + loadRequest.url + ", LoadStatus: " +  loadRequest.status )
                console.log( "  ErrorDomain: " + loadRequest.errorDomain + " errorString: " +  loadRequest.errorString )
                if( loadRequest.status == WebView.LoadFailedStatus )
                {   // display error message in browser
                    webview.loadHtml( "
                            <html>
                                <head>
                                    <title>Error</title>
                                </head>
                                <body>
                                    <h1>Error Loading '" + loadRequest.url + "'</h1>
                                    <h2>Error String: " + loadRequest.errorString + "</h2>
                                </body>
                            </html>", "error", "error" )
                }
            }
        }
    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // The Progressbar indicates the LoadProgress of the Webpage
    ProgressBar {
        id: progressBar
        anchors.top : menubar.bottom
        width: root.width
        height: 8
        minimumValue: 0
        maximumValue: 100
        opacity: webview.loading ? 0.8 : 0 // only visible when loading is in progress
        value: webview.loadProgress
        Behavior on opacity {
            NumberAnimation {
                duration: 500
            }
        }

        style: ProgressBarStyle {
                background: Rectangle {
                    radius: 2
                    color: "lightgray"
                    border.color: "gray"
                    border.width: 1
                    implicitWidth: 200
                    implicitHeight: 24
                }
                progress: Rectangle {
                    color: "steelblue"
                    // border.color: "steelblue"
                }
            }
    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // DropDown menu
    Rectangle {
        id: dropDownMenu
        color: "black"
        width: 200
        anchors.top: menubar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        opacity: 0.8

        Behavior on width {
            NumberAnimation{ duration: 250 }
        }

        // use this way to put favorites directly into source code
        // (Change model to favoritesModel in ListView below to enable)
        ListModel {
            id: favoritesModel

            ListElement{
                name:   "Phytec"
                url:    "http://www.phytec.de"
            }
            ListElement{
                name:   "Qt"
                url:    "http://www.qt.io"
            }
            ListElement{
                name:   "google"
                url:    "http://www.google.de"
            }
            ListElement{
                name:   "Https-Test"
                url:    "https://www.wikipedia.de"
            }
        }

        FileIO {
            id:favFile
            source: "/usr/share/phytec-qtdemo/favorites.xml"
            onError: {
                console.log( msg )
                message_dialog.title = "WebBrowser Error"
                message_dialog.icon = StandardIcon.Warning
                message_dialog.width = 400
                message_dialog.height = 240
                message_dialog.text  = "Error opening File " + favFile.source // + ".\nErrorString: " + msg
                message_dialog.informativeText = msg
                message_dialog.open()
            }
        }

        // use this way to load favorites from Xml-File
        XmlListModel {
            id: favoritesXmlModel
            xml: favFile.read() // read XmlFile
            query: "/favorites/item"
            XmlRole { name: "name"; query: "name/string()" }
            XmlRole { name: "url"; query: "url/string()" }

            onStatusChanged: {
                console.log( "XmlListModel status = " + status )
                if( favoritesXmlModel.status === 3 )
                {
                    message_dialog.title = "WebBrowser Error"
                    message_dialog.text  = "XmlListModel ERROR!:\nCheck syntax of the file " + favFile.source
                    message_dialog.icon = StandardIcon.Warning
                    message_dialog.width = 400
                    message_dialog.height = 240
                    message_dialog.open()
                }
            }
        }

        ListView {
            id: favoritesView
            anchors.fill: parent
            height: 200
            clip: true
            model: favoritesXmlModel

            delegate: Item {
                width: dropDownMenu.width
                height: 40
                Rectangle {
                    anchors.fill: parent
                    id: highlightRect
                    color: "darkgrey"
                    opacity: 0.5
                    visible: mouseArea.pressed
                }

                Text {
                    anchors.centerIn: parent
                    text: name
                    color: "lightgrey"
                    font.bold: true

                }
                MouseArea{
                    id: mouseArea
                    anchors.fill: parent
                    onClicked: {
                        webview.url = url
                        menuBtn.state = "MENUOFF"
                        //favoritesView.currentIndex = index
                    }
                }
            }
        }
    }

    MessageDialog {
        id: message_dialog
    }

}
