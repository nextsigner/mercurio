import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import Qt.labs.settings 1.1
ApplicationWindow{
    id: app
    visible: true
    visibility: isPhone?"FullScreen":"Maximized"
    color:app.c1
    width: isPhone?Screen.width:Screen.width-30//360
    height: isPhone?Screen.height:Screen.height-30//600
    property string moduleName: 'mercurio'
    property bool rot: Qt.platform.os !== 'android'?app.width>app.height:isLandScape
    property bool isLandScape: (Screen.primaryOrientation === Qt.LandscapeOrientation || Screen.primaryOrientation === Qt.InvertedLandscapeOrientation)
    property int fs: isPhone?(app.rot?app.width*0.03:app.width*0.045):app.width*0.015

    property bool isPhone: Qt.platform.os==='android'

    property int mod: -1
    property string serverUrl: 'http://localhost'
    property int portRequest: 8080
    property int portFiles: 8081

    property color c1
    property color c2
    property color c3
    property color c4

    //Variables Globales
    property var signos: ['Aries', 'Tauro', 'Géminis', 'Cáncer', 'Leo', 'Virgo', 'Libra', 'Escorpio', 'Sagitario', 'Capricornio', 'Acuario', 'Piscis']
    property var planetas: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'Quirón', 'Proserpina', 'Selena', 'Lilith', 'N.Sur', 'N.Norte']

    onClosing: {
        if(app.mod===-1){
            close.accepted = true
            Qt.quit()
        }else{
            close.accepted = false
            if(xMods.children[0]&&xMods.children[0].objectName==='xgetcarta'){
                xMods.children[0].escForm()
                return
            }
            app.mod=-1
        }

    }
    onModChanged: {
        for(let i=0;i<xMods.children.length;i++){
            xMods.children[i].destroy(10)
        }
        if(mod>=0){
            //logView.showLog('xMenu.arrayQmls['+mod+']: '+xMenu.arrayQmls[mod])
            var comp = Qt.createComponent(xMenu.arrayQmls[mod+2]+'.qml')
            var obj = comp.createObject(xMods, {});
        }
    }
    FontLoader {name: "FontAwesome";source: "qrc:/fontawesome-webfont.ttf";}
    USettings{
        id: unikSettings
        //url:pws+'/launcher.json'
        url:pws+'/mercurio.json'
        function refresh(){
            var nc=unikSettings.currentNumColor
            if(unikSettings.defaultColors){
                var cc1=unikSettings.defaultColors.split('|')
                var cc2=cc1[nc].split('-')
                app.c1=cc2[0]
                app.c2=cc2[1]
                app.c3=cc2[2]
                app.c4=cc2[3]
                app.visible=true
            }
        }
        Component.onCompleted: refresh()
        onDataChanged:  refresh()
        onCurrentNumColorChanged: {
            if(unikSettings.sound&&currentNumColor>=0){
                let s=unikSettings.lang==='es'?'Color actual ':'Current color  '
                s+=parseInt(currentNumColor+1)
                speak(s)
            }
        }
    }
    Item {
        id: xApp
        anchors.fill: parent
        XMenu{
            id: xMenu
            visible: app.mod===-1
            cTipo: 'menu'
            onPosYChanged: {
                labelTit.opacity=0.0
                tOcultarMenu.restart()
            }
        }
        XMenu{
            id: xMenuTrans
            visible: app.mod===-2
            cTipo: 'trans'
            onPosYChanged: {
                labelTit.opacity=0.0
                tOcultarMenu.restart()
            }
        }
        XMenu{
            id: xMenuLearn
            visible: app.mod===-3
            cTipo: 'learn'
            onPosYChanged: {
                labelTit.opacity=0.0
                tOcultarMenu.restart()
            }
        }
        Timer{
            id:tOcultarMenu
            running:false
            repeat:false
            interval: 1000
            onTriggered: {
                labelTit.opacity=1.0
            }
        }
        UText{
            id: labelTit
            font.pixelSize: app.fs*2
            color: app.c2
            text: 'Mercurio'
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: app.fs
            visible: xMenu.visible || xMenuTrans.visible || xMenuLearn.visible
            Behavior on opacity {NumberAnimation{duration: 500}}
            Rectangle{
                width: xApp.width
                height: app.fs*8
                gradient: Gradient {
                    GradientStop {
                        position: 0.00;
                        color: app.c1;
                    }
                    GradientStop {
                        position: 0.70;
                        color: app.c1;
                    }
                    GradientStop {
                        position: 1.00;
                        color: "transparent";
                    }
                }
                z:parent.z-1
                anchors.centerIn: parent
            }
            UText{
                id: labelTit2
                font.pixelSize: app.fs
                color: app.c2
                text: 'Versión '+version
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0-app.fs
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
        UxBotCirc{
            opacity: labelTit.opacity
            width: app.fs*3
            text: '\uf013'
            animationEnabled: true
            anchors.right: parent.right
            anchors.rightMargin: app.fs*0.5
            anchors.top: parent.top
            anchors.topMargin: app.fs*0.5
            onClicked: {
                var comp = Qt.createComponent('XConfig.qml')
                var obj = comp.createObject(xMods, {});
            }
        }
        Item{
            id: xMods
            anchors.fill: parent
            /*XSignos{id: xSignos;visible: app.mod===0;}
            XPlanetas{id: xPlanetas;visible: app.mod===1;}
            XCasas{id: xCasas; visible: app.mod===2;}
            XCasasLilith{id: xCasasLilith;visible: app.mod===3;}
            XCasasQuiron{id: xCasasQuron;visible: app.mod===4;}
            XTransLunar{id: xTransLunar;visible: app.mod===5;}
            XTrans{id: xTrans;visible: app.mod===6;}*/
            //XGetCarta{}
            XCnView{}
            //UGetYouTubeVideo{}
        }
        UProgressDownload{
            id:upd
            width: app.width
            onDownloaded: {
                unik.setUnikStartSettings('-folder='+unik.currentFolderPath())
                unik.restartApp()
            }
        }
        Item{
            id: xAsData
            anchors.fill: parent
            function clear(){
                for(var i=0;i<xAsData.children.length;i++){
                    xAsData.children[i].destroy(1)
                }
            }
            function addXAsTextData(cuerpo, casa){
               xAsData.clear()
                let comp=Qt.createComponent('XAsTextData.qml')
                let obj=comp.createObject(xAsData, {cuerpo: cuerpo, casa: casa})
            }
            function addXAsWV(url){
               xAsData.clear()
                let comp=Qt.createComponent('XAsWebView.qml')
                let obj=comp.createObject(xAsData, {url:url})
            }
            function addConsulta(cons){
               xAsData.clear()
                let comp=Qt.createComponent('UGetYouTubeVideo.qml')
                let obj=comp.createObject(xAsData, {consulta:cons})
            }
        }
        XConfirmSearchVideoBy{id: xConfirmSearchVideoBy;visible:false}
        ULogView{id: logView}
        UWarnings{
            id: uWarnings
            showEnabled: false
        }
    }
    Shortcut{
        sequence: 'Esc'
        onActivated: {
            if(xMods.children[0]&&xMods.children[0].objectName==='xgetcarta'){
                xMods.children[0].escForm()
                return
            }
            Qt.quit()
        }
    }
    Shortcut{
        sequence: 'Up'
        onActivated: {
            xMods.children[0].upForm()
        }
    }
    Shortcut{
        sequence: 'Down'
        onActivated: {
            xMods.children[0].downForm()
        }
    }
    Shortcut{
        sequence: 'Right'
        onActivated: {
            xMods.children[0].rightForm()
        }
    }
    Shortcut{
        sequence: 'Left'
        onActivated: {
            xMods.children[0].leftForm()
        }
    }
    Shortcut{
        sequence: 'Shift+Right'
        onActivated: {
            xMods.children[0].shiftRightForm()
        }
    }
    Shortcut{
        sequence: 'Shift+Left'
        onActivated: {
            xMods.children[0].shiftLeftForm()
        }
    }
    Shortcut{
        sequence: 'Return'
        onActivated: {
            xMods.children[0].enterForm()
        }
    }
    Component.onCompleted: {
        if(Qt.platform.os==='linux'&&unikSettings.lang==='es'){
            let m0=(''+ttsLocales).split(',')
            let index=0
            for(var i=0;i<m0.length;i++){
                console.log('Language: '+m0[i])
                if((''+m0[i]).indexOf('Spanish (Spain)')>=0){
                    index=i
                    break
                }
            }
            unik.ttsLanguageSelected(index)
            //unik.speak('Idioma Español seleccionado.')
        }
        getServerUrl()
    }
    function updateUS(){
        var nc=unikSettings.currentNumColor
        var cc1=unikSettings.defaultColors.split('|')
        var cc2=cc1[nc].split('-')
        app.c1=cc2[0]
        app.c2=cc2[1]
        app.c3=cc2[2]
        app.c4=cc2[3]

        //unikSettings.zoom=1.4
        //unikSettings.borderWidth=app.fs*0.5
        //unikSettings.padding=0.5

        app.visible=true
    }
    function getServerUrl(){
        let url='https://raw.githubusercontent.com/nextsigner/nextsigner.github.io/master/mercurio_server'
        console.log('Get '+app.moduleName+' server from '+url)
        var req = new XMLHttpRequest();
        req.open('GET', url, true);
        req.onreadystatechange = function (aEvt) {
            if (req.readyState === 4) {
                if(req.status === 200){
                    let m0=req.responseText.split('|')
                    if(m0.length>2){
                        app.serverUrl=m0[0]
                        app.portRequest=m0[1]
                        app.portFiles=m0[2]
                        console.log('Mercurio Server='+app.serverUrl+' '+app.portRequest+' '+app.portFiles)
                    }else{
                        logView.showLog("Error el cargar el servidor de Mercurio. Code 2\n");
                    }
                }else{
                    logView.showLog("Error el cargar el servidor de Mercurio. Code 1\n");
                }
            }
        };
        req.send(null);
    }
}
