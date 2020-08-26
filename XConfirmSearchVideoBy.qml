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
    property string url1: 'null'
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
                    xAsData.addConsulta(r.cuerpo+' en '+r.signo)
                    r.visible=false
                }
            }
            BotonUX{
                text: 'Buscar '+r.cuerpo+' en casa '+r.casa
                onClicked: {
                    let m=['primera', 'segunda', 'tercera', 'cuarta', 'quita', 'sexta', 'septima', 'ocatava', 'novena', 'decima', 'decima primera', 'duodecima']
                    xAsData.addConsulta(r.cuerpo+' en casa '+r.casa+' '+m[parseInt(r.casa)-1]+' casa')
                    r.visible=false
                }
            }
            BotonUX{
                visible: r.url1!==''
                text: 'Ir a video de '+r.cuerpo+' en casa '+r.casa
                onClicked: {
                    xAsData.addXAsWV(r.url1)
                    r.visible=false
                }
            }
            //Boton para Texto sobre Lilith o Quirón
            BotonUX{
                visible: r.cuerpo==='Lilith'||r.cuerpo==='Quirón'
                text: 'Texto sobre '+r.cuerpo+' en casa '+r.casa
                onClicked: {
                    xAsData.addXAsTextData(cuerpo, casa)
                    r.visible=false
                }
            }
            //Boton para Texto de Signo
            BotonUX{
                visible: r.signo!=='null'&&r.cuerpo!=='Lilith'&&r.cuerpo!=='Quirón'
                text: 'Texto sobre '+r.signo
                onClicked: {
                    xAsData.addXAsTextData(cuerpo, casa)
                    r.visible=false
                }
            }
            //Boton para Texto de Signo Solar
            BotonUX{
                visible: r.signo!=='null'&&r.cuerpo==='Sol'
                text: 'Texto de signo solar '+r.signo
                onClicked: {
                    xAsData.addXAsTextData(r.signo, casa)
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
