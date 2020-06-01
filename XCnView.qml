import QtQuick 2.12
import Qt.labs.settings 1.0
import "func.js" as JS

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: app.c1
    property alias xcn: cn
    Settings{
        id: sCnView
        fileName: pws+'/'+app.moduleName+'/scnview'
        property real zoom: 1.0
    }
    Flickable{
        //anchors.fill: r
        id: flick
        width: cn.width//cn.width
        height: cn.height//cn.height
        anchors.centerIn: r
        contentWidth: cn.width//*2.0//*1.5
        contentHeight: cn.height//*2.0//*1.5
        XCn{
            id: cn
            transformOrigin: Item.TopLeft
        }
        function zoomExtents()
        {
            // Resize image to fit in View
            var maxImageBounds = Math.max(cn.width, cn.height)
            var minViewBounds = Math.min(flick.width, flick.height)
            var mult = minViewBounds / maxImageBounds
            cn.scale = mult * 0.99

            // Center image in view: Works when image's transformOrigin is Center
            cn.x = flick.contentX + (flick.width - cn.width) * 0.5
            cn.y = flick.contentY + (flick.height - cn.height) * 0.5
        }

        // Zoom About Cursor
        function zoom(delta, target, x, y)
        {
            // positive delta zoom in, negative delta zoom out
            var scaleBefore = target.scale;
            var zoomFactor = 0.8
            if (delta > 0)
            {
                zoomFactor = 1.0/zoomFactor;
            }

            // Zoom the target
            target.scale = target.scale * zoomFactor;

            // X,Y coordinates of zoom location relative to top left corner
            // Calculate displacement of zooming position
            var dx = (x - target.x) * (zoomFactor - 1)
            var dy = (y - target.y) * (zoomFactor - 1)

            // Compensate for displacement
            target.x = target.x - dx
            target.y = target.y - dy
        }
        MouseArea {
            id: dragArea
            hoverEnabled: true
            anchors.fill: parent
            drag.target: cn

            onDoubleClicked:
            {
                flick.zoomExtents()
            }

            onWheel:
            {
                var delta = wheel.angleDelta.y / 120.0
                flick.zoom(delta, cn, mouseX, mouseY)
            }
        }
    }
    BotonUX{
        text: 'atras'
        onClicked: r.visible=false
    }
    Text{
        id: iz
        //text: 'Z:'+parseFloat(sCnView.zoom).toFixed(2)+' x:'+flCn.contentX
        text: 'Z:'+cn.zf
        //text: 'X:'+cn.ppx
        font.pixelSize: 30
        color: 'red'
    }
    //Component.onCompleted: sCnView.zoom=1


}
