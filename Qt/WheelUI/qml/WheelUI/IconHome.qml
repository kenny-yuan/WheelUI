import QtQuick 2.2
import QtGraphicalEffects 1.0
import "js/layout.js" as IconLayout

Item {
    id: iconHome
    implicitWidth: parent.width
    implicitHeight: parent.height

    Flickable {
        id: iconFlicker
        anchors.fill: parent
        contentWidth: iconRoot.width
        contentHeight: iconRoot.height
        flickableDirection: Flickable.HorizontalFlick

        Item {
            id: iconRoot
            property int display_rows: 5

            width: thisApp.width
            height: thisApp.height - 180

            function loadIcons() {
                var root = iconRoot;
                var fileStr = fileReader.readFile(configDir + "app.json");
                var array = JSON.parse(fileStr);
                appList = array;

                var c = Qt.createComponent("WInteractiveIcon.qml");

                appList.forEach(function(elem, i){
                    var icon = c.createObject(root);
                    icon.name = elem.name;
                    icon.iconUrl = imageDir + "apps/" + elem.icon;
                    icon.blockIndex = i;
                    if ( typeof(elem.app) == 'undefined' ) {
                        elem.app = "";
                    }
                    icon.appUrl = elem.app;

                    // Calc color
                    var r = parseInt("0x" + elem.glowColor.substr(0, 2)) / 255.0;
                    var g = parseInt("0x" + elem.glowColor.substr(2, 2)) / 255.0;
                    var b = parseInt("0x" + elem.glowColor.substr(4, 2)) / 255.0;
                    icon.glowColor = Qt.rgba(r, g, b, 0.33);

                    //
                    icon.relayoutSignal.connect(relayoutBlock);
                    icon.width = 180;
                    icon.height = 180;
                });
                IconLayout.appList = appList;
            }

            function createGridLayout () {
                iconRoot.display_rows = Math.floor(iconRoot.height / 180);
                console.log("displaying rows:", iconRoot.display_rows, iconRoot.height / 180);
                var cols = Math.floor(IconLayout.appList.length / iconRoot.display_rows);
                if ( IconLayout.appList.length % iconRoot.display_rows ) {
                    ++cols;
                }
                IconLayout.theLayoutMgr.createGrid(iconRoot.display_rows, cols);
            }

            function relayoutBlock(index, w, h) {
                var block = IconLayout.theLayoutMgr.elem[index];
                block.width = w / 180;
                block.height = h / 180;
                console.log('new block size: ', block.width, block.height);
                relayout();
            }

            function relayout() {
                var that = IconLayout.theLayoutMgr;
                that.fit();
                that.elem.forEach(function(b, i){
                    var wi = iconRoot.children[i];
                    if ( wi ) {
                        wi.x = b.x * 180;
                        wi.y = b.y * 180;
                    }
                });
            }

            Component.onCompleted: {
                loadIcons();
                createGridLayout();
                relayout();
            }

            onHeightChanged: {
                console.log('Icon home height changed', iconRoot.height);
                createGridLayout();
                relayout();
            }
        }

    }

    DirectionalBlur {
        anchors.fill: iconFlicker
        source: iconFlicker
        angle: 90
        length: 24
        samples: 8
        visible: iconFlicker.moving
    }
}

