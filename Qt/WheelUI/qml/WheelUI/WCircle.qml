import QtQuick 2.0

Rectangle {
    implicitWidth: 100 // Default to 100 pixels
    property real diameter: implicitWidth
    property point center: Qt.point(x + diameter / 2, y + diameter / 2)
    width: diameter
    height: diameter
    radius: diameter * 0.6

    onDiameterChanged: {
        width = diameter
        height = width
        radius = width * 0.6

//        x = center.x - diameter / 2
//        y = center.y - diameter / 2
    }

    onCenterChanged: {
        x = center.x - diameter / 2
        y = center.y - diameter / 2
    }
}
