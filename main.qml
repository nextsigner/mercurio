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
    property bool rot: app.width>app.height
    property int fs: app.width*0.03
    property var arrayDataCasas: []
    property int cCasa: -1
    property color c1
    property color c2
    property color c3
    property color c4
    Settings{
        id: appSettings
        category: 'conf-'+app.moduleName
        property int currentNumColors
    }
    UnikSettings{
        id: unikSettings
        url:pws+'/launcher.json'
        onCurrentNumColorChanged: {
            if(unikSettings.sound&&currentNumColor>=0){
                let s=unikSettings.lang==='es'?'Color actual ':'Current color  '
                s+=parseInt(currentNumColor+1)
                speak(s)
            }
        }
        Component.onCompleted: {
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
        }
    }
    MouseArea{
        anchors.fill: parent
        onDoubleClicked: Qt.quit()
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
                appSettings.currentNumColors = unikSettings.currentNumColor
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
        Grid{
            visible: app.cCasa===-1
            anchors.centerIn: parent
            columns: app.rot?6:3
            spacing: app.rot?app.fs*0.25:app.fs
            Repeater{
                id: repIconCasas
                model: 12
                BotonUX{
                    width: app.rot?app.fs*4:app.fs*8
                    height: width
                    text: "Casa "+parseInt(modelData + 1)
                    fontSize: app.rot?app.fs:app.fs*2
                    onClicked: app.cCasa=index
                }
            }
        }
        Item{
            id: xDataCasas
            visible: app.cCasa!==-1
            Repeater{
                id: repDataCasas
                Rectangle{
                    visible: app.cCasa===index
                    width: xApp.width
                    height: xApp.height
                    radius: app.fs*0.5
                    color: app.c1
                    onVisibleChanged: {
                        if(visible){
                            unik.speak((''+modelData).replace(/<br \/>/g, '        '))
                        }
                    }
                    Flickable{
                        anchors.top: parent.top
                        anchors.topMargin: app.fs*2
                        width: parent.width
                        height: parent.height
                        contentWidth: parent.width
                        contentHeight: colDataCasas.height+app.fs*6
                        Column{
                            id: colDataCasas
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: app.fs
                            Row{
                                spacing: app.fs
                                BotonUX{
                                    text: 'Atras'
                                    onClicked: {
                                        unik.speak('atras')
                                        app.cCasa=-1
                                    }
                                }
                                BotonUX{
                                    text: 'Detener Audio'
                                    onClicked: {
                                        unik.speak('detenido')
                                    }
                                }
                                BotonUX{
                                    text: 'Leer'
                                    onClicked: {
                                        unik.speak((''+modelData).replace(/<br \/>/g, '        '))
                                    }
                                }
                            }
                            Item{width: 1; height: app.fs}
                            Text{
                                width: xApp.width-app.fs*2
                                text: modelData
                                color: app.c2
                                font.pixelSize: app.fs*2
                                wrapMode: Text.WordWrap
                                textFormat: Text.RichText
                            }
                        }
                    }
                }
            }
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
        let d1=unik.getFile('dataCasas.json')
        let json = JSON.parse(d1)
        for(let i=1;i<=12;i++){
            console.log('D: '+json['casas']['casa'+i])
            arrayDataCasas.push(json['casas']['casa'+i])
        }
        repDataCasas.model = app.arrayDataCasas
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
