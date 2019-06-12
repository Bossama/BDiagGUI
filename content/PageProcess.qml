import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import FriWare.ProcessIf 1.0
//import "content"

Item {
    id: pageRoot
    x: 4
    y: 4
    width: 680 - (2*x)
    height: 480 - (2*y)

    Rectangle {
        anchors.fill: parent
        color: "grey"
        opacity: 0.75
        Image {
            source: "qrc:/images/Fliessbild_test.png"

        }

        FBPumpe {
            x: 65
            y: 148
            state: ProcessIf.pumpeSpeisungDo ? "ON" : "OFF"
            onClicked: {
                console.log( "Testpage: Pumpe Speisung clicked event")
                ProcessIf.pumpeSpeisungDo ? ProcessIf.pumpeSpeisungDo = false : ProcessIf.pumpeSpeisungDo = true
            }
        }

        FBPumpe {
            x: 65
            y: 225
            state: ProcessIf.pumpeSpeisungDo ? "ON" : "OFF"
            onClicked: {
                console.log( "Testpage: Pumpe Speisung clicked event")
                ProcessIf.pumpeSpeisungDo ? ProcessIf.pumpeSpeisungDo = false : ProcessIf.pumpeSpeisungDo = true
            }
        }

        FBReaktor {
            x: 220
            y: 155

            onClicked: {
                ProcessIf.reaktorHeizungDo ? ProcessIf.reaktorHeizungDo = false : ProcessIf.reaktorHeizungDo = true
            }
        }

//        Slider {
//             maximumValue: 150
//             minimumValue: -150
//             value: 150
//             stepSize: 50
//             //valueIndicatorVisible: true
//         }
//        Slider {
//            anchors.centerIn: parent
//            style: SliderStyle {
//                groove: Rectangle {
//                    implicitWidth: 200
//                    implicitHeight: 8
//                    color: "gray"
//                    radius: 8
//                }
//                handle: Rectangle {
//                    anchors.centerIn: parent
//                    color: control.pressed ? "white" : "lightgray"
//                    border.color: "gray"
//                    border.width: 2
//                    implicitWidth: 34
//                    implicitHeight: 34
//                    radius: 4
//                }
//            }
//        }
    }
}
