import QtQuick 2.2
import QtGraphicalEffects 1.0
import "apps/clock"

Item {
    id: myItem

    implicitWidth: 180
    implicitHeight: 180

    property string name: 'Icon Label'
    property string iconUrl: ''
    property string appUrl: ''
    property color glowColor: '#00000000'

    property size widgetSize: Qt.size(0, 0)
    property size iconSize: Qt.size(0, 0)
    property bool widgetLoaded: false
    property int blockIndex: -1

    state: 'icon-mode'

    signal relayoutSignal(int iconIndex, int width, int height)

    Rectangle {
        anchors.fill: parent
        radius: 2
        anchors.margins: 2
        //color: "#40cccccc"
        color: parent.glowColor
    }

    Item {
        id: icon

        anchors.fill: parent

        // The round shape
        WCircle {
            id: plate
            anchors.centerIn: parent
            diameter: 95
            color: "white"
            opacity: 0
        }

        // The colorful "shadow"
//        RectangularGlow {
//            id: effect
//            anchors.fill: plate
//            glowRadius: 0
//            spread: 0.0
//            color: myItem.glowColor
//            cornerRadius: plate.radius + glowRadius
//        }

        // The icon frame under the app icon
        Image {
            anchors.centerIn: plate
            width: 80
            height: 80
            source: "./images/icon-frame.png"
            opacity: 0.85
        }

        // The app icon
        Image {
            id: image
            anchors.centerIn: plate
            source: myItem.iconUrl
        }

        // The shadow of the text label
        RectangularGlow {
            id: labelGlow
            anchors.fill: label
            glowRadius: 0
            spread: 0.0
            color: "#70000000"
            cornerRadius: label.height * 0.5
        }

        // The text label
        Text {
            id: label
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: image.bottom;
            anchors.topMargin: 10
            text: myItem.name
            font.family: "Arial"
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 12
            color: "white"
        }
    }

    Item {
        id: widget
        anchors.left: parent.left
        anchors.top: parent.top
        width: 360
        height: 360

        Item {
            anchors.fill: parent
            id: widgetInsertPos
        }

//        Image {
//            id: widgetIconFrame
//            anchors.right : parent.right
//            anchors.top: parent.top

//            source: "./images/icon-frame.png"
//            opacity: 0.85

//            width: 80 * 0.6667
//            height: 80 * 0.6667
//        }

//        Image {
//            anchors.centerIn: widgetIconFrame
//            source: myItem.iconUrl
//            width: sourceSize.width * 0.6667
//            height: sourceSize.height * 0.6667
//        }

        // The shadow for the Widget label
        RectangularGlow {
            id: widgetLabelGlow
            anchors.fill: widgetLabel
            glowRadius: 0
            spread: 0.0
            color: "#70000000"
            cornerRadius: label.height * 0.5
        }

        Text {
            id: widgetLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            text: myItem.name
            font.family: "Arial"
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 12
            color: "white"
        }

        // The suspended app indicator
        Item {
            id: suspendedOverlay
            anchors.fill: parent
            opacity: 0.75
            visible: false

            Image {
                anchors.fill: parent
                fillMode: Image.Tile
                source: "./images/interactive-icon/suspended.png"
            }

        }
    }

    Component.onCompleted: {
        myItem.iconSize = Qt.size(myItem.width, myItem.height)
    }


    states: [
        State {
            name: "icon-mode"
            PropertyChanges { target: myItem; width: 180; height: 180; }
            PropertyChanges { target: icon;   opacity: 1.0; scale: 1.0; x: 0; y: 0; }
            PropertyChanges { target: widget; opacity: 0.0;}
        },
        State {
            name: "widget-mode"
            PropertyChanges { target: myItem; width: 360; height: 360; }
            PropertyChanges { target: icon;   opacity: 0.0; scale: 3.0; x: 0; y: 90; }
            PropertyChanges { target: widget; opacity: 1.0; }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation {
                properties: "opacity, scale";
                easing.type: Easing.InOutQuad
                duration: 400
            }
        }
    ]

    // Icon movement animation
    Behavior on x { XAnimator { duration: 300 + Math.max(100, blockIndex * 10); easing.type: Easing.OutBack; easing.overshoot: 2.0 } }
    Behavior on y { YAnimator { duration: 300 + Math.max(100, blockIndex * 10); easing.type: Easing.OutBack; easing.overshoot: 0.5 } }

    MouseArea {
        id: mouseHandler
        anchors.fill: parent

//        onWidthChanged: {
//            console.log("MouseArea width:", mouseHandler.width);
//        }

        onClicked: {
            //console.log(myItem.appUrl);
            if ( myItem.appUrl != "" ) {

                if ( myItem.state == 'icon-mode' ) {
                    myItem.state = 'widget-mode';
                } else {
                    myItem.state = 'icon-mode';
                }

                if ( myItem.state == 'widget-mode' && ! myItem.widgetLoaded ) {
                    var c = Qt.createComponent(myItem.appUrl);
                    var w = c.createObject(widgetInsertPos);
                    //console.log('widget: ', w, '; component: ', c);
                    myItem.widgetSize = Qt.size(widget.width, widget.height)
                    myItem.widgetLoaded = true;
                }

                myItem.relayoutSignal(myItem.blockIndex, width, height);
            }

        }
    }

}
