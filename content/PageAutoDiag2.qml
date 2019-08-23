
import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Window 2.2
import QtQml.Models 2.11
import com.ACTIA.BDiag 1.0

Item {
    id: autodiag
    anchors.fill: parent

    DiagController{
        id: qml_diagcontroller
    }

    Rectangle {
        anchors.fill: parent
        color: "#959792" //"#3C3CA7"
        opacity: 1
    }


    TableView {
        id: tableView

        frameVisible: false
        sortIndicatorVisible: true

        anchors.fill: parent

        Layout.minimumWidth: 400
        Layout.minimumHeight: 240
        Layout.preferredWidth: 600
        Layout.preferredHeight: 400

        TableViewColumn {
            id: dTCColumn
            title: "DTC List"
            role: "DTC"
            movable: false
            resizable: false
            width: tableView.viewport.width /3 //- authorColumn.width
        }

        TableViewColumn {
            id: descptionColumn
            title: "Descreption"
            role: "description"
            movable: false
            resizable: false
            width: tableView.viewport.width /3
        }

        TableViewColumn {
            id: demoColumn
            title: "Demo"
            role: "demo"
            movable: false
            resizable: false
            width: tableView.viewport.width /3
        }

        model: ListModel {
            id: libraryModel
            ListElement {
                DTC: "30000500000000"
                description: "Some problems in the"
                demo: "Available"
            }
            ListElement {
                DTC: "35000500000000"
                description: "Shut down your engine"
                demo: "Available"
            }
            ListElement {
                DTC: "30080500000000"
                description: "Some problems in the..."
                demo: "Available"
            }
            ListElement {
                DTC: "30000500000000"
                description: "Some problems in the"
                demo: "Available"
            }
            ListElement {
                DTC: "35000500000000"
                description: "Shut down your engine"
                demo: "Available"
            }
            ListElement {
                DTC: "30080500000000"
                description: "Some problems in the..."
                demo: "Available"
            }
            ListElement {
                DTC: "30000500000000"
                description: "Some problems in the"
                demo: "Available"
            }
            ListElement {
                DTC: "35000500000000"
                description: "Shut down your engine"
                demo: "Available"
            }
            ListElement {
                DTC: "30080500000000"
                description: "Some problems in the..."
                demo: "Available"
            }
            ListElement {
                DTC: "30000500000000";
                description: "Some problems in the";
                demo: "Available";
            }
            ListElement {
                DTC: "35000500000000"
                description: "Shut down your engine"
                demo: "Available"
            }
            ListElement {
                DTC: "30080500000000"
                description: "Some problems in the..."
                demo: "Available"
            }
        }


        }

}


