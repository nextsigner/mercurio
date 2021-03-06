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

    //Current Data
    property string cNombre: ''
    property int cDia: -1
    property int cMes: -1
    property int cAnio: -1
    property int cHora: -1
    property int cMinuto: -1
    property real cLon: 0.0
    property real cLat: 0.0
    property string cCiudad: ''

    onVisibleChanged: {
        cnCapture.url=currentImgUrl
        botLaunchZodiac.visible=apps.zodiacLocation!==''&&unik.fileExist(apps.zodiacLocation)
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
        XCn{
            id: cn
            transformOrigin: Item.TopLeft
            onCnLoaded: {
                console.log('nombre: '+nombre)
                console.log('dia: '+dia)
                console.log('mes: '+mes)
                console.log('año: '+anio)
                console.log('hora: '+hora)
                console.log('minuto: '+minuto)
                console.log('lon: '+lon)
                console.log('lat: '+lat)
                r.cNombre=nombre.replace(/_/g, ' ')
                r.cDia=dia
                r.cMes=mes
                r.cAnio=anio
                r.cHora=hora
                r.cMinuto=minuto
                r.cLon=lon
                r.cLat=lat
                r.cCiudad=ciudad
            }
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
    }
    Flickable{
        //anchors.fill: r
        id: flickCapture
        width: cnCapture.width
        height: cnCapture.height
        anchors.centerIn: r
        contentWidth: cnCapture.width
        contentHeight: cnCapture.height
        visible: r.mod===1&&Qt.platform.os!=='android'
        MouseArea {
            id: dragAreaCapture
            hoverEnabled: true
            anchors.fill: parent
            enabled: Qt.platform.os!=='android'
            drag.target: cnCapture
            property  real ud
            onDoubleClicked:
            {
                flickCapture.zoomExtents()
            }

            onWheel:
            {

                var delta = wheel.angleDelta.y / 120.0
                if(cnCapture.scale>2.0){
                    flickCapture.zoom(0-ud, cnCapture, mouseX, mouseY)
                    //return
                }else if(cn.scale<0.5){
                    flickCapture.zoom(0-ud, cnCapture, mouseX, mouseY)
                }else{
                    flickCapture.zoom(delta, cnCapture, mouseX, mouseY)
                }
                ud=delta
            }
        }
        MouseArea {
            id: dragAreaPhoneCapture
            hoverEnabled: true
            anchors.fill: parent
            enabled: Qt.platform.os==='android'
            property bool inc: false
            drag.target: cnCapture
            onPressAndHold: {
                tzCapture.zoom=!tzCapture.zoom
            }
            //            onPressed: {

            //            }
            onReleased: {
                tzCapture.running=false
            }
            //            onClicked: {
            //                var delta = 60 / 120.0
            //                flick.zoom(delta, cn, dragAreaPhone.mouseX, dragAreaPhone.mouseY)
            //                inc=true
            //            }
            onDoubleClicked:{
                flickCapture.zoomExtents()
            }
            Timer{
                id: tzCapture
                running: false
                repeat: true
                interval: 100
                property bool zoom: false
                onZoomChanged: tzCapture.running=true
                onTriggered: {
                    let a=60
                    if(!zoom){
                        a=-60
                    }
                    var delta = a / 120.0
                    flickCapture.zoom(delta, cnCapture, dragAreaPhoneCapture.mouseX, dragAreaPhoneCapture.mouseY)
                }
            }
        }
        XCnCapture{
            id: cnCapture
            transformOrigin: Item.TopLeft
            url: r.currentImgUrl
            onImageLoaded:{
                botMod.imageLoaded=true
                let d=new Date(Date.now())
                wv.loadImage(r.currentImgUrl+'?r='+d.getTime())
            }
            onUrlChanged: botMod.imageLoaded=false
            //scale: 100/(2880-r.height)*2880
        }
        function zoomExtents(){
            // Resize image to fit in View
            var maxImageBounds = Math.max(cnCapture.width, cnCapture.height)
            var minViewBounds = Math.min(flickCapture.width, flickCapture.height)
            var mult = minViewBounds / maxImageBounds
            cnCapture.scale = mult * 0.99

            // Center image in view: Works when image's transformOrigin is Center
            cnCapture.x = flick.contentX + (flickCapture.width - cnCapture.width) * 0.5
            cnCapture.y = flick.contentY + (flickCapture.height - cnCapture.height) * 0.5
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
    }

    Rectangle{
        width: r.width
        height: r.height
        color: 'black'
        anchors.centerIn: r
        visible: r.mod===1&&Qt.platform.os==='android'
        WebView{
            id: wv
            width: r.width
            height: r.height
            anchors.centerIn: parent
            function loadImage(url){
                wv.loadHtml('<html><body style="background-color:black; width:200%"><img src="'+url+'" style="width:100%; margin-top:50%;"/></body></html>', 'http://localhost')
            }
        }
    }
    Row{
        spacing: app.fs
        z:wv.z+100000
        BotonUX{
            text: 'atras'
            height: app.fs*2
            fontSize: Qt.platform.os==='android'?(app.rot?app.fs*0.5:app.fs):app.fs
            onClicked: r.visible=false
        }
        BotonUX{
            id: botMod
            property bool imageLoaded: false
            text: r.mod===0?imageLoaded?'Ver Imagen':'Preparando Imagen...':'Ver Carta Interactiva'
            height: app.fs*2
            fontSize: Qt.platform.os==='android'?(app.rot?app.fs*0.5:app.fs):app.fs
            onClicked: {
                wv.loadImage(r.currentImgUrl)
                r.mod=r.mod===0?1:0
            }
        }
        BotonUX{
            id: botCopyUrl
            text: 'Copiar Enlace'
            height: app.fs*2
            fontSize: Qt.platform.os==='android'?(app.rot?app.fs*0.5:app.fs):app.fs
            onClicked: {
                console.log('Copy to clipboard: https://nextsigner.github.io/mercurio_server_redir.html?link='+xCnView.currentImgUrl)
                clipboard.setText('https://nextsigner.github.io/mercurio_server_redir.html?link='+xCnView.currentImgUrl)
            }
        }
        BotonUX{
            id: botLaunchZodiac
            text: 'Abrir en Zodiac'
            height: app.fs*2
            fontSize: Qt.platform.os==='android'?(app.rot?app.fs*0.5:app.fs):app.fs
            visible: false
            onClicked: {
                let url=app.serverUrl+':'+app.portFiles+'/zodiacserver/bin/user/'+r.cNombre+'.dat'
                console.log('cNombre:'+r.cNombre+' url:'+url)
                httpObjGetDatFile.fileName=r.cNombre
                httpObjGetDatFile.getHttp(url)
            }
            HttpObject{
                id: httpObjGetDatFile
                property string fileName: ''
                onHttpResponse: {
                    //console.log('R:'+r)
                    let zf='/media/nextsigner/ZONA-A12/nsp/unik-dev-apps/zodiacserver/bin'
                    let fileNameDat=zf+'/user/'+fileName+'.dat'
                    //console.log('FileNameData:'+fileNameDat)
                    //console.log('FileNameData Exist:'+unik.fileExist(fileNameDat))
                    let saved=unik.setFile(fileNameDat, r)
                    unik.ejecutarLineaDeComandoAparte(zf+'/zodiac_server '+fileName)
                }
            }
            Component.onCompleted: {
                if(apps.zodiacLocation!==''&&unik.fileExist(apps.zodiacLocation)){
                    botLaunchZodiac.visible=true
                }
            }
        }
    }
    Item{
        id: xCurrentData
        width: colData1.width+app.fs*2
        height: colData1.height+app.fs*2
        anchors.bottom: parent.bottom
        Rectangle{
            anchors.fill: parent
            opacity: 0.5
            color: app.c1
            border.width: 2
            border.color: app.c2
            radius: app.fs*0.25
        }
        Column{
            id: colData1
            spacing: app.fs*0.25
            anchors.centerIn: parent
            UText{
                text:  'Carta Natal de '+r.cNombre
            }
            UText{
                text:  'Fecha '+r.cDia+'/'+r.cMes+'/'+r.cAnio
            }
            UText{
                text:  'Hora '+r.cHora+':'+r.cMinuto
            }
            UText{
                visible: r.cCiudad!==''
                text:  'Lugar de Nacimiento '+r.cCiudad
                font.pixelSize: app.fs*0.5
            }
            UText{
                text:  'Coords: lon='+r.cLon+' lat='+r.cLat
                font.pixelSize: app.fs*0.5
            }
        }
    }
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
}
