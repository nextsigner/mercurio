import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import Qt.labs.settings 1.1
import "qrc:/"
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
    property var arrayDataCasas: []
    property int cCasa: -1
    property color c1
    property color c2
    property color c3
    property color c4
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
        /*Component.onCompleted: {
            console.log('Seted... ')
            console.log('UnikColorTheme currentNumColor: '+unikSettings.currentNumColor)
            console.log('UnikColorTheme defaultColors: '+unikSettings.defaultColors)
            var nc=unikSettings.currentNumColor
            var cc1=unikSettings.defaultColors.split('|')
            var cc2=cc1[nc].split('-')
            app.c1=cc2[0]
            app.c2=cc2[1]
            app.c3=cc2[2]
            app.c4=cc2[3]
            app.visible=true
        }*/
    }
    onIsLandScapeChanged: {
        tOpacidadRaiz.restart()
    }
    Timer{
        id: tOpacidadRaiz
        repeat: true
        running: false
        interval: 100
        property int uAppWidth: 0
        onTriggered: {
            if(xApp.opacity<=1.0){
                xApp.opacity+=0.1
            }else{
                stop()
            }
            if(uAppWidth !== Screen.width){
                xApp.opacity=0.0
            }
            uAppWidth = Screen.width
        }
    }
    Item {
        id: xApp
        anchors.fill: parent
        UxBotCirc{
            text: '\uf1fc'//+unikSettings.currentNumColor
            fontSize: app.fs
            animationEnabled: false
            blurEnabled: false
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
            text: '\uf011'
            fontSize: app.fs
            animationEnabled: false
            blurEnabled: false
            anchors.right: parent.right
            anchors.rightMargin: app.fs*0.5
            anchors.top: parent.top
            anchors.topMargin: app.fs*0.5
            onClicked: {
                Qt.quit()
            }
        }
        UxBotCirc{
            text: '\uf021'
            animationEnabled: false
            blurEnabled: false
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
            font.pixelSize: app.fs*2
            color: app.c2
            text: 'Mercurio'
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: app.fs
        }
        XCasas{id: xCasas}
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
