import QtQuick 2.2
import QtGraphicalEffects 1.0
import "apps/clock"

Item {
    id: thisApp
    width: 1920
    height: 1080

    property variant appList: null

    WDesktopBackground {
        anchors.fill: parent
    }

    WRoundButton {
        backgroundColor: "#FF8080"
    }

//    WBubbleMessage {
//        width: 360
//    }

    WIconHome {
        anchors.top: statusBar.bottom
        anchors.bottom: dock.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
    }

    WStatusBar {
        id: statusBar
        anchors.top: parent.top
        anchors.right: parent.right
        width: parent.width * 0.65
    }

    WDock {
        id: dock
        visible: true

        Flickable {
            id: dockFlicker

            width: parent.width - parent.height * 2
            height: parent.height
            anchors.centerIn: parent

            contentWidth: dockRow.width
            contentHeight: dockRow.height
            flickableDirection: Flickable.HorizontalFlick

            Row {
                spacing: 20
                id: dockRow

                function loadDock() {
                    var fileStr = fileReader.readFile(configDir + "app.json");
                    var array = JSON.parse(fileStr);
                    appList = array;

                    var c = Qt.createComponent("WInteractiveIcon.qml");

                    appList.forEach(function(elem, i){
                        var icon = c.createObject(dockRow);
                        icon.iconUrl = imageDir + "apps/" + elem.icon;
                        icon.name = elem.name;
                        icon.width = 80;
                        icon.height = 100;
                    });
                }

                Component.onCompleted: loadDock()
            }

            DirectionalBlur {
                anchors.fill: dockRow
                source: dockRow
                angle: 90
                length: Math.min(Math.abs(dockFlicker.horizontalVelocity) / 60, 50)
                samples: 64
                visible: dockFlicker.moving && ! (dockFlicker.atXBeginning || dockFlicker.atXEnd)
//                onLengthChanged: {
//                    console.log(dockFlicker.horizontalVelocity);
//                }
            }

        }


    }
}

