import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    width: parent.width
    height: 70

    // The main part of the status bar
    Rectangle {
        id: mainBar
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: parent.width - parent.height

        color: "#60404040"
    }

    // The triangle on the left of the bar
    // Also the dragging area of the bar
    Item {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.height

        // a triangle without bottom-left part
        LinearGradient {
            anchors.fill: parent
            start: Qt.point(0, parent.height)
            end: Qt.point(parent.width, 0)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#00000000" }
                GradientStop { position: 0.49999; color: "#00000000" }
                GradientStop { position: 0.50000; color: mainBar.color }
                GradientStop { position: 1.0; color: mainBar.color }
            }
        }
    }

}

