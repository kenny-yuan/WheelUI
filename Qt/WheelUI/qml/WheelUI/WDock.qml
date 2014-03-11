import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    height: 110
    width: parent.width * 0.8

    Item {
        id: halfHeightArea
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: parent.height * 0.40

        Rectangle {
            id: mainDock
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - parent.height * 2

            color: "#80cccccc"
        }

        // Left part
        Item {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: parent.height

            // a triangle without top-left part
            LinearGradient {
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(parent.width, parent.height)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#00000000" }
                    GradientStop { position: 0.49999; color: "#00000000" }
                    GradientStop { position: 0.50000; color: mainDock.color }
                    GradientStop { position: 1.0; color: mainDock.color }
                }
            }
        }

        // Right part
        Item {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: parent.height

            // a triangle without top-right part
            LinearGradient {
                anchors.fill: parent
                start: Qt.point(parent.width, 0)
                end: Qt.point(0, parent.height)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#00000000" }
                    GradientStop { position: 0.49999; color: "#00000000" }
                    GradientStop { position: 0.50000; color: mainDock.color }
                    GradientStop { position: 1.0; color: mainDock.color }
                }
            }
        }

    }


}

