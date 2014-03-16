import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    implicitWidth: 120
    implicitHeight: 60

    property color backgroundColor: '#d2820f'

    signal buttonClicked

    BorderImage {
        anchors.fill: parent
        source: 'images/bubble-message/BubbleMessage-bubble.png'
        border.left: 30
        border.right: 30
        border.top: 0
        border.bottom: 0
    }

    BorderImage {
        id: inner
        anchors.fill: parent
        source: 'images/bubble-message/BubbleMessage-inner.png'
        border.left: 30
        border.right: 30
        border.top: 0
        border.bottom: 0
    }

    // Changing the default color of the inner area
    ColorOverlay {
        anchors.fill: inner
        color: parent.backgroundColor
        source: inner
    }
}
