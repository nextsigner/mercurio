import QtQuick 2.12
import Qt.labs.settings 1.0
import QtWebView 1.0

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: app.c1
    property alias xcn: cn
    property string currentImgUrl: 'http://66.97.44.29:8081/files/1591237517000_Ricardo.png'
    property int mod: 0
    onVisibleChanged: {
        cnCapture.url=currentImgUrl
    }
    onCurrentImgUrlChanged: wv.loadImage(currentImgUrl)
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
        visible: r.mod===0
        XCn{
            id: cn
            transformOrigin: Item.TopLeft
        }
        function zoomExtents(){
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
        function zoom(delta, target, x, y){
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
            enabled: Qt.platform.os!=='android'
            drag.target: cn
            property  real ud
            onDoubleClicked:
            {
                flick.zoomExtents()
            }

            onWheel:
            {

                var delta = wheel.angleDelta.y / 120.0
                if(cn.scale>2.0){
                    flick.zoom(0-ud, cn, mouseX, mouseY)
                    //return
                }else if(cn.scale<0.5){
                    flick.zoom(0-ud, cn, mouseX, mouseY)
                }else{
                    flick.zoom(delta, cn, mouseX, mouseY)
                }
                ud=delta
            }
        }
        MouseArea {
            id: dragAreaPhone
            hoverEnabled: true
            anchors.fill: parent
            enabled: Qt.platform.os==='android'
            property bool inc: false
            drag.target: cn
            onPressAndHold: {
                tz.zoom=!tz.zoom
            }
            //            onPressed: {

            //            }
            onReleased: {
                tz.running=false
            }
            //            onClicked: {
            //                var delta = 60 / 120.0
            //                flick.zoom(delta, cn, dragAreaPhone.mouseX, dragAreaPhone.mouseY)
            //                inc=true
            //            }
            onDoubleClicked:{
                flick.zoomExtents()
            }
            Timer{
                id: tz
                running: false
                repeat: true
                interval: 100
                property bool zoom: false
                onZoomChanged: tz.running=true
                onTriggered: {
                    let a=60
                    if(!zoom){
                        a=-60
                    }
                    var delta = a / 120.0
                    flick.zoom(delta, cn, dragAreaPhone.mouseX, dragAreaPhone.mouseY)
                }
            }
        }
    }
//    Flickable{
//        //anchors.fill: r
//        id: flickCapture
//        width: cnCapture.width
//        height: cnCapture.height
//        anchors.centerIn: r
//        contentWidth: cnCapture.width
//        contentHeight: cnCapture.height
//        visible: r.mod===1
//        XCnCapture{
//            id: cnCapture
//            transformOrigin: Item.TopLeft
//            url: r.currentImgUrl
//            onImageLoaded:botMod.imageLoaded=true
//            onUrlChanged: botMod.imageLoaded=false
//            //scale: 100/(2880-r.height)*2880
//        }
//        function zoomExtents(){
//            // Resize image to fit in View
//            var maxImageBounds = Math.max(cnCapture.width, cnCapture.height)
//            var minViewBounds = Math.min(flickCapture.width, flickCapture.height)
//            var mult = minViewBounds / maxImageBounds
//            cnCapture.scale = mult * 0.99

//            // Center image in view: Works when image's transformOrigin is Center
//            cnCapture.x = flick.contentX + (flickCapture.width - cnCapture.width) * 0.5
//            cnCapture.y = flick.contentY + (flickCapture.height - cnCapture.height) * 0.5
//        }

//        // Zoom About Cursor
//        function zoom(delta, target, x, y){
//            // positive delta zoom in, negative delta zoom out

//            var scaleBefore = target.scale;
//            var zoomFactor = 0.8
//            if (delta > 0)
//            {
//                zoomFactor = 1.0/zoomFactor;
//            }

//            // Zoom the target
//            target.scale = target.scale * zoomFactor;

//            // X,Y coordinates of zoom location relative to top left corner
//            // Calculate displacement of zooming position
//            var dx = (x - target.x) * (zoomFactor - 1)
//            var dy = (y - target.y) * (zoomFactor - 1)

//            // Compensate for displacement
//            target.x = target.x - dx
//            target.y = target.y - dy
//        }
//        MouseArea {
//            id: dragAreaCapture
//            hoverEnabled: true
//            anchors.fill: parent
//            enabled: Qt.platform.os!=='android'
//            drag.target: cnCapture
//            property  real ud
//            onDoubleClicked:
//            {
//                flickCapture.zoomExtents()
//            }

//            onWheel:
//            {

//                var delta = wheel.angleDelta.y / 120.0
//                if(cnCapture.scale>2.0){
//                    flickCapture.zoom(0-ud, cnCapture, mouseX, mouseY)
//                    //return
//                }else if(cn.scale<0.5){
//                    flickCapture.zoom(0-ud, cnCapture, mouseX, mouseY)
//                }else{
//                    flickCapture.zoom(delta, cnCapture, mouseX, mouseY)
//                }
//                ud=delta
//            }
//        }
//        MouseArea {
//            id: dragAreaPhoneCapture
//            hoverEnabled: true
//            anchors.fill: parent
//            enabled: Qt.platform.os==='android'
//            property bool inc: false
//            drag.target: cnCapture
//            onPressAndHold: {
//                tzCapture.zoom=!tzCapture.zoom
//            }
//            //            onPressed: {

//            //            }
//            onReleased: {
//                tzCapture.running=false
//            }
//            //            onClicked: {
//            //                var delta = 60 / 120.0
//            //                flick.zoom(delta, cn, dragAreaPhone.mouseX, dragAreaPhone.mouseY)
//            //                inc=true
//            //            }
//            onDoubleClicked:{
//                flickCapture.zoomExtents()
//            }
//            Timer{
//                id: tzCapture
//                running: false
//                repeat: true
//                interval: 100
//                property bool zoom: false
//                onZoomChanged: tzCapture.running=true
//                onTriggered: {
//                    let a=60
//                    if(!zoom){
//                        a=-60
//                    }
//                    var delta = a / 120.0
//                    flickCapture.zoom(delta, cnCapture, dragAreaPhoneCapture.mouseX, dragAreaPhoneCapture.mouseY)
//                }
//            }
//        }
//    }

    WebView{
        id: wv
        width: r.width
        height: r.height
        visible: r.mod===1
        function loadImage(url){
            wv.loadHtml('<html><body style="background-color:black; width:200%"><img src="'+url+'" style="width:100%; margin: 0 auto;"/></body></html>', 'http://localhost')
        }
    }
    Row{
        spacing: app.fs
        z:wv.z+1
        BotonUX{
            text: 'atras'
            onClicked: r.visible=false
        }
        BotonUX{
            id: botMod
            property bool imageLoaded: false
            text: r.mod===0?imageLoaded?'Ver Imagen':'Preparando Imagen...':'Ver Carta Interactiva'
            onClicked: {
                wv.loadImage(r.currentImgUrl)
                r.mod=r.mod===0?1:0
            }
        }
    }
//    Text{
//        id: iz
//        text: 'S:'+cnCapture.scale//parseFloat(sCnView.zoom).toFixed(2)+' x:'+flCn.contentX
//        //text: 'url:'+cnCapture.url
//        //text: 'X:'+cn.ppx
//        font.pixelSize: 30
//        color: 'red'
//    }
    Timer{
        id: tAlejar
        running: true
        repeat: true
        interval: 100
        onTriggered: {
             if(cnCapture.scale<0.3){
                stop()
                 return
             }
            flickCapture.zoom(-120/120, cnCapture, cnCapture.width*0.5, cnCapture.height*0.5)
        }
    }
    Component.onCompleted: {

    }


}
