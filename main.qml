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
    height: Qt.platform.os==='android'?Screen.height:700
    property string moduleName: 'mercurio'
    property bool rot: Qt.platform.os !== 'android'?app.width>app.height:isLandScape
    property bool isLandScape: (Screen.primaryOrientation === Qt.LandscapeOrientation || Screen.primaryOrientation === Qt.InvertedLandscapeOrientation)
    property int fs: app.width*0.03

    property int mod: -1

    property color c1
    property color c2
    property color c3
    property color c4

    //Variables Globales
    property var signos: ['Aries', 'Tauro', 'Géminis', 'Cancer', 'Leo', 'Virgo', 'Libra', 'Escorpio', 'Sagitario', 'Capricornio', 'Acuario', 'Piscis']

    onClosing: {
        if(app.mod===-1){
            close.accepted = true
            Qt.quit()
        }else{
            close.accepted = false
            app.mod=-1
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
        XMenu{id: xMenu; visible: app.mod===-1;}
        UxBotCirc{
            opacity: labelTit.opacity
            padding: 0-app.fs*3
            text: '\uf1fc'//+unikSettings.currentNumColor
            fontSize: app.fs*2
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
            padding: 0-app.fs*3
            text: '\uf011'
            fontSize: app.fs*2
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
            padding: 0-app.fs*3
            text: '\uf021'
            fontSize: app.fs*2
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
        UText{
            id: labelTit
            font.pixelSize: app.fs*2
            color: app.c2
            text: 'Mercurio'
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: app.fs
            opacity: xMenu.posY!==0?0.0:1.0
            Behavior on opacity {NumberAnimation{duration: 500}}
        }
        XPlanetas{id: xPlanetas;visible: app.mod===0;}
        XCasas{id: xCasas; visible: app.mod===1;}
        XCasasLilith{id: xCasasLilith;visible: app.mod===2;}
        XCasasQuiron{id: xCasasQuron;visible: app.mod===3;}
        XTransLunar{id: xTransLunar;visible: app.mod===4;}
        XTrans{id: xTrans;visible: app.mod===5;}



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

    }
    function updateUS(){
        var nc=unikSettings.currentNumColor
        var cc1=unikSettings.defaultColors.split('|')
        var cc2=cc1[nc].split('-')
        app.c1=cc2[0]
        app.c2=cc2[1]
        app.c3=cc2[2]
        app.c4=cc2[3]

        unikSettings.zoom=1.4
        unikSettings.borderWidth=app.fs*0.5
        unikSettings.padding=0.5

        app.visible=true
    }
}
