import QtQuick 2.0

Item {

    // Background Image
    Rectangle {
        anchors.fill: parent;
        color: "#ffffff"
    }

    Image {
        id: singleImageBackground
        anchors.left: parent.left
        anchors.top: parent.top
        source: "./images/background/colorful-1920.png"
        sourceSize: Qt.size(1920, 1536)
        visible: false
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            //console.log("background toggling");
            singleImageBackground.visible = ! singleImageBackground.visible;
        }
    }

}
