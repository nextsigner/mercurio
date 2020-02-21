import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import Qt.labs.settings 1.1
ApplicationWindow{
    id: app
    visible: true
    visibility: Qt.platform.os==='android'?"FullScreen":"Windowed"
    color:app.c1
    width: Qt.platform.os==='android'?Screen.width:460
    height: Qt.platform.os==='android'?Screen.height:800
    property string moduleName: 'mercurio'
    property bool rot: Qt.platform.os !== 'android'?app.width>app.height:isLandScape
    property bool isLandScape: (Screen.primaryOrientation === Qt.LandscapeOrientation || Screen.primaryOrientation === Qt.InvertedLandscapeOrientation)
    property int fs: app.rot?app.width*0.03:app.width*0.045

    property int mod: -1

    property color c1
    property color c2
    property color c3
    property color c4

    //Variables Globales
    property var signos: ['Aries', 'Tauro', 'Géminis', 'Cáncer', 'Leo', 'Virgo', 'Libra', 'Escorpio', 'Sagitario', 'Capricornio', 'Acuario', 'Piscis']

    onClosing: {
        if(app.mod===-1){
            close.accepted = true
            Qt.quit()
        }else{
            close.accepted = false
            app.mod=-1
        }

    }
    onModChanged: {
        for(let i=0;i<xMods.children.length;i++){
            xMods.children[i].destroy(10)
        }
        if(mod>=0){
            var comp = Qt.createComponent(xMenu.arrayQmls[mod]+'.qml')
            var obj = comp.createObject(xMods, {});
        }
    }
    FontLoader {name: "FontAwesome";source: "qrc:/fontawesome-webfont.ttf";}
    USettings{
        id: unikSettings
        url:pws+'/launcher.json'
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
        }
        UxBotCirc{
            opacity: labelTit.opacity
            width: app.fs*3
            text: '\uf1fc'//+unikSettings.currentNumColor
            animationEnabled: true
            glowEnabled: true
            anchors.left: parent.left
            anchors.leftMargin: app.fs*0.5
            anchors.top: parent.top
            anchors.topMargin: app.fs*0.5
            onClicked: {
                var cc=unikSettings.defaultColors.split('|').length
                if(unikSettings.currentNumColor<cc-1){
                    unikSettings.currentNumColor++
                }else{
                    unikSettings.currentNumColor=0
                }
                //appSettings.currentNumColors = unikSettings.currentNumColor
                updateUS()
            }
        }
        UxBotCirc{
            opacity: labelTit.opacity
            width: app.fs*3
            text: '\uf011'
            animationEnabled: true
            anchors.right: parent.right
            anchors.rightMargin: app.fs*0.5
            anchors.top: parent.top
            anchors.topMargin: app.fs*0.5
            onClicked: {
                Qt.quit()
            }
        }
        UxBotCirc{
            opacity: labelTit.opacity
            width: app.fs*3
            text: '\uf021'
            animationEnabled: true
            anchors.bottom: parent.bottom
            anchors.bottomMargin: app.fs*0.5
            anchors.left:  parent.left
            anchors.leftMargin: app.fs*0.5
            onClicked: {
                upd.infoText = unikSettings.lang==='es'?'<b>Actualización: </b>Se ha iniciado la actualización\nde <b>MERCURIO</b>':'<b>Update: </b> Updating <b>MERCURIO</b>'
                upd.download('https://github.com/nextsigner/'+moduleName+'.git', pws)
            }
        }
        UxBotCirc{
            id: uxBotCircCfg
            opacity: labelTit.opacity
            width: app.fs*3
            text: '\uf015'
            animationEnabled: true
            anchors.bottom: parent.bottom
            anchors.bottomMargin: app.fs*0.5
            anchors.right: parent.right
            anchors.rightMargin: app.fs*0.5
            property bool seted: false
            onClicked: {
                uxBotCircCfg.seted=!uxBotCircCfg.seted
                let cfgFileLocation=pws+'/cfg.json'
                if(uxBotCircCfg.seted){
                    let cfgData=('{"arg0":"-folder='+pws+'/'+moduleName+'","arg1":"https://github.com/nextsigner/'+moduleName+'.git"}').replace(/ /g, '%20')
                    unik.setFile(cfgFileLocation, cfgData)
                    xSign.visible=false
                }else{
                    xSign.visible=true
                    unik.deleteFile(cfgFileLocation)
                    unik.restartApp()
                }
            }
            Text{
                id: xSign
                visible: false//!uxBotCircCfg.seted
                text: 'X'
                font.pixelSize: parent.width*0.6
                color: 'red'
                anchors.centerIn: parent
            }
            Component.onCompleted: {
                let cfgFileLocation=pws+'/cfg.json'
                seted = unik.fileExist(cfgFileLocation)
                xSign.visible=!seted
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
        }
        UProgressDownload{
            id:upd
            width: app.width
            onDownloaded: {
                unik.setUnikStartSettings('-folder='+unik.currentFolderPath())
                unik.restartApp()
            }
        }
        ULogView{id: logView}
        UWarnings{id: uWarnings}
    }
    Shortcut{
        sequence: 'Esc'
        onActivated: Qt.quit()
    }
    Component.onCompleted: {
        if(Qt.platform.os==='linux'&&unikSettings.lang==='es'){
            unik.ttsLanguageSelected(13)
        }
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
}
