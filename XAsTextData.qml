import QtQuick 2.0
import QtQuick.Controls 2.12

Rectangle{
    id: r
    anchors.fill: parent
    color: app.c1
    property string cuerpo: '?'
    property int casa: -1
    property alias textData: textData.text
    MouseArea{
        anchors.fill: r
    }
    Column{
        anchors.fill: parent
        spacing: app.fs
        Item{
            width: 1
            height: app.fs
        }
        Row{
            id: row
            spacing: app.fs
            BotonUX{
                text: 'Cerrar'
                height: app.fs*1.2
                onClicked: r.destroy(500)
            }
            BotonUX{
                //visible: (''+wv.url).indexOf('results?search_query=')<0
                text: 'Leer Texto'
                height: app.fs*1.2
                onClicked: unik.speak(textData.text)
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
            height: r.height
            contentWidth: width
            contentHeight: textData.contentHeight
            ScrollBar.vertical: ScrollBar { }
            UText {
                id: textData
                width: r.width-app.fs
                height: r.height-row.height-app.fs*2
                wrapMode: Text.WordWrap
            }
        }
    }
    Component.onCompleted: {
        let cuerpoCorr=r.cuerpo.replace(/á/g, 'a').replace(/é/g, 'e').replace(/í/g, 'i').replace(/ó/g, 'o').replace(/ú/g, 'u')
        let d1=unik.getFile('dataCasas'+cuerpoCorr+'.json').replace(/\n/g,'<br /><br />').replace('}}<br /><br />','}}')
        let json = JSON.parse(d1)
        r.textData=json['casas']['casa'+parseInt(r.casa)]
    }
}
