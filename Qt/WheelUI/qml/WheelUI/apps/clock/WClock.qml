import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id : clock
    anchors.centerIn: parent

    implicitWidth: 360
    implicitHeight: 360

    property alias city: cityLabel.text
    property int hours
    property int minutes
    property int seconds
    property real shift: 8
    property bool night: false
    property bool internationalTime: true //Unset for local time

    function timeChanged() {
        var date = new Date;
        hours = internationalTime ? date.getUTCHours() + Math.floor(clock.shift) : date.getHours()
        night = ( hours < 7 || hours > 19 )
        minutes = internationalTime ? date.getUTCMinutes() + ((clock.shift % 1) * 60) : date.getMinutes()
        seconds = date.getUTCSeconds();
    }

    Timer {
        interval: 500; running: true; repeat: true;
        onTriggered: clock.timeChanged()
    }

//    RectangularGlow {
//        id: effect
//        anchors.fill: parent
//        glowRadius: 0
//        spread: 0.0
//        color: "#40FF0000"
//        cornerRadius: parent.width / 2 + glowRadius
//    }

//    Image {
//        anchors.centerIn: parent
//        source: "clock-background.png"
//    }

    Item {
        anchors.centerIn: parent

        Image {
            id: background;
            anchors.centerIn: parent
            source: "face.png";
            visible: clock.night == false
        }
        Image {
            anchors.centerIn: parent
            source: "face.png";
            visible: clock.night == true
        }


        Image {
            x: parent.width - 7
            y: -80
            source: "hour-hand.png"
            transform: Rotation {
                id: hourRotation
                origin.x: 8; origin.y: 80;
                angle: (clock.hours * 30) + (clock.minutes * 0.5)
                Behavior on angle {
                    SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
                }
            }
        }

        Image {
            x: parent.width - 12.5
            y: -125
            source: "minute-hand.png"
            transform: Rotation {
                id: minuteRotation
                origin.x: 12.5; origin.y: 125;
                angle: clock.minutes * 6
                Behavior on angle {
                    SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
                }
            }
        }

        Image {
            x: parent.width - 7.5
            y: -111
            source: "second-hand.png"
            transform: Rotation {
                id: secondRotation
                origin.x: 7.5; origin.y: 111;
                angle: clock.seconds * 6
                Behavior on angle {
                    SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
                }
            }
        }

        Image {
            anchors.centerIn: background; source: "center.png"
        }

        Text {
            id: cityLabel
            anchors.top: background.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            font.family: "Helvetica"
            font.bold: true; font.pixelSize: 16
            style: Text.Raised; styleColor: "black"
        }
    }
}
