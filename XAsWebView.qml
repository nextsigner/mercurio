import QtQuick 2.0
import QtWebView 1.1

Rectangle{
    id: r
    anchors.fill: parent
    color: app.c1
    property alias url: wv.url
    MouseArea{
        anchors.fill: r
    }
    property string consulta: 'plutón+en+libra'
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
                text: 'Atras'
                height: app.fs*1.2
                onClicked: wv.goBack()
            }
            BotonUX{
                visible: (''+wv.url).indexOf('results?search_query=')<0
                text: 'Copiar Enlace'
                height: app.fs*1.2
                onClicked: clipboard.setText(wv.url)
            }
//            UText{
//                text: 'Videos sobre '+r.consulta.replace(/\+/g,' ')
//                anchors.verticalCenter: parent.verticalCenter
//            }
        }
        WebView {
            id: wv
            width: r.width
            height: r.height-row.height-app.fs*2
        }
    }
}
