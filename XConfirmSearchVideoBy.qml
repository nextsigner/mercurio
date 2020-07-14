import QtQuick 2.0
import "func.js" as JS

Rectangle {
    id: r
    width: bot1.width+app.fs*4
    height: col1.height+app.fs
    color: app.c1
    border.width: 2
    border.color: app.c2
    radius: app.fs*0.5
    anchors.centerIn: parent
    property string cuerpo: 'null'
    property string signo: 'null'
    property string casa: 'null'
    MouseArea{
        anchors.fill: r
    }
    Column{
        id: col1
        spacing: app.fs
        anchors.centerIn: parent
        Item{width: 1;height: app.fs*0.5}
        UText{
            text: '<b>Seleccionar tipo de búsqueda</b>'
            color: app.c2
            width: r.width-app.fs
            wrapMode: Text.WordWrap
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Column{
            spacing: app.fs
            anchors.horizontalCenter: parent.horizontalCenter
            BotonUX{
                id: bot1
                text: 'Buscar '+r.cuerpo+' en '+r.signo
                onClicked: {
                    xWebViews.addConsulta(r.cuerpo+' en '+r.signo)
                    r.visible=false
                }
            }
            BotonUX{
                text: 'Buscar '+r.cuerpo+' en casa '+r.casa
                onClicked: {
                    let m=['primera', 'segunda', 'tercera', 'cuarta', 'quita', 'sexta', 'septima', 'ocatava', 'novena', 'decima', 'decima primera', 'duodecima']
                    xWebViews.addConsulta(r.cuerpo+' en casa '+r.casa+' '+m[parseInt(r.casa)-1]+' casa')
                    r.visible=false
                }
            }
        }
        BotonUX{
            text: 'Cancelar'
            anchors.right: parent.right
            //anchors.rightMargin: app.fs
            onClicked: {
                r.visible=false
            }
        }
    }
}
