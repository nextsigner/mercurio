import QtQuick 2.0
import QtQuick.Controls 2.12

Rectangle{
    id: r
    color: app.c1
    clip: true
    property string cuerpo: '?'
    property int casa: -1
    property alias textData: textData.text
    MouseArea{
        anchors.fill: r
    }
    Column{
        width: r.width-app.fs
        height: r.height-app.fs
        anchors.centerIn: r
        spacing: app.fs
        Item{
            width: 1
            height: app.fs
        }
        Flow{
            id: row
            width: r.width-app.fs
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: app.fs
            BotonUX{
                text: 'Cerrar'
                height: app.fs*1.2
                visible: !btnClose.visible
                onClicked: r.destroy(1)
            }
            BotonUX{
                //visible: (''+wv.url).indexOf('results?search_query=')<0
                text: 'Leer Texto'
                height: app.fs*1.2
                onClicked: Qt.platform.os!=='linux'?unik.speak(textData.text):uText2Mp3.speak(textData.text)
            }
            BotonUX{
                //visible: (''+wv.url).indexOf('results?search_query=')<0
                text: 'Copiar Texto'
                height: app.fs*1.2
                onClicked: clipboard.setText(textData.text)
            }
            //            UText{
            //                text: 'Videos sobre '+r.consulta.replace(/\+/g,' ')
            //                anchors.verticalCenter: parent.verticalCenter
            //            }
        }
        Flickable{
            width: r.width-app.fs
            height: r.height-row.height-app.fs*4
            contentWidth: width
            contentHeight: textData.contentHeight
            clip: true
            ScrollBar.vertical: ScrollBar { }
            UText {
                id: textData
                width: r.width-app.fs
                height: r.height-row.height-app.fs*2
                wrapMode: Text.WordWrap
            }
        }
    }
    UxBotCirc{
        id: btnClose
        visible: false
        anchors.right: parent.right
        anchors.rightMargin: app.fs*0.5
        anchors.top: parent.top
        anchors.topMargin: app.fs*0.5
        opacity: labelTit.opacity
        width: app.fs*2
        text: 'X'
        animationEnabled: true
        onClicked: {
            r.destroy(1)
        }
    }
    function setSize(fullSize){
        if(fullSize){
            btnClose.visible=false
            r.anchors.fill=r.parent
        }else{
            btnClose.visible=true
            r.anchors.centerIn=r.parent
            r.width=app.fs*20
            r.height=app.fs*20
            r.border.width= app.fs*0.25
            r.border.color=app.c2
            r.radius=app.fs*0.5
        }
    }
    Component.onCompleted: {
        if(app.signos.indexOf(r.cuerpo)>=0){
            let d1=unik.getFile('dataSignosPalabrasClaves.json').replace(/\n/g,'<br /><br />').replace('}}<br /><br />','}}')
            let json = JSON.parse(d1)
            r.textData=json['signos']['signo'+parseInt(app.signos.indexOf(r.cuerpo) + 1)]//JSON.stringify(json)
            //r.textData+=json['signos']['signo'+parseInt(app.signos.indexOf(r.cuerpo) + 1)]//JSON.stringify(json)
            //r.textData+=json['signos']['signo'+parseInt(app.signos.indexOf(r.cuerpo) + 1)]//JSON.stringify(json)
            //r.textData+=json['signos']['signo'+parseInt(app.signos.indexOf(r.cuerpo) + 1)]//JSON.stringify(json)

            setSize(false)
            return
        }
        let cuerpoCorr=r.cuerpo.replace(/á/g, 'a').replace(/é/g, 'e').replace(/í/g, 'i').replace(/ó/g, 'o').replace(/ú/g, 'u')
        let d1=unik.getFile('dataCasas'+cuerpoCorr+'.json').replace(/\n/g,'<br /><br />').replace('}}<br /><br />','}}')
        let json = JSON.parse(d1)
        r.textData=json['casas']['casa'+parseInt(r.casa)]
        setSize(true)
    }
}
