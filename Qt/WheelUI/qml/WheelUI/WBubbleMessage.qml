import QtQuick 2.0
import QtGraphicalEffects 1.0

WRoundButton {
    implicitWidth: 230
    implicitHeight: 60

    signal bubbleDismissed

    Image {
        anchors.centerIn: parent
        source: 'images/bubble-message/BubbleMessage-coming-from.png'
    }
}
