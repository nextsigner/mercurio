import QtQuick 2.12
import QtQuick.Controls 2.12
import "qrc:/"

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: app.c1
    property int cNumSigno: -1
    property int cGradoLuna: -1
    property string cSignoLuna: ''
    onVisibleChanged: {
        if(visible)getTransNow()
    }
    MouseArea{
        anchors.fill: r
    }
    Flickable{
        width: r.width
        height: r.height
        contentWidth: width
        contentHeight: col.height+app.fs*6
        Column{
            id: col
            spacing: app.fs*2
            anchors.horizontalCenter: parent.horizontalCenter
            Flow{
                width:r.width-app.fs
                spacing: app.fs
                BotonUX{
                    text: 'Atras'
                    fontSize: app.rot?app.fs*0.5:app.fs
                    onClicked: {
                        app.mod=-1
                        unik.speak('atras')
                    }
                }
                BotonUX{
                    visible: cbAsc.currentIndex!==0
                    text: 'Detener Voz'
                    fontSize: app.rot?app.fs*0.5:app.fs
                    onClicked: {
                        unik.speak('Detenido.')
                    }
                }
                BotonUX{
                    visible: cbAsc.currentIndex!==0
                    text: 'Leer'
                    fontSize: app.rot?app.fs*0.5:app.fs
                    onClicked: {
                        r.speak(resCarta.text)
                    }
                }
            }
            Text{
                width: xApp.width-app.fs*2
                text: '<b>Crear Carta Natal</b>'
                color: app.c2
                font.pixelSize: app.fs*2
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Column{
                spacing: app.fs
                anchors.horizontalCenter: parent.horizontalCenter
                /*Text{
                    width: xApp.width-app.fs*2
                    text: 'La Luna está en el signo número '+r.cNumSigno
                    color: app.c2
                    font.pixelSize: app.fs*2
                    anchors.horizontalCenter: parent.horizontalCenter
                }*/
                ComboBox{
                    id: cbAsc
                    model: ['Seleccionar', 'Natalia', 'Ricardo', 'Nico', 'Fer', 'Dylan', 'Bruno', 'Hugo', 'Ely Dorgan', 'Mario Pizarro', 'Ascendente '+app.signos[0], 'Ascendente '+app.signos[1], 'Ascendente '+app.signos[2], 'Ascendente '+app.signos[3], 'Ascendente '+app.signos[4], 'Ascendente '+app.signos[5], 'Ascendente '+app.signos[6], 'Ascendente '+app.signos[7], 'Ascendente '+app.signos[8], 'Ascendente '+app.signos[9], 'Ascendente '+app.signos[10], 'Ascendente '+app.signos[11]]
                    property var arrayAsc: [0,11, 11, 5, 4, 2, 7, 12, 1, 11, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
                    width: r.width-app.fs
                    anchors.horizontalCenter: parent.horizontalCenter
                    onCurrentIndexChanged: {
                        if(currentIndex===0)return
                        let numAsc=parseInt(12 - arrayAsc[currentIndex] + r.cNumSigno)
                        //console.log('1::::::->'+currentIndex)
                        //console.log('2::::::->'+r.cNumSigno)
                        //console.log('3::::::->'+numAsc)
                        let numCasa = getNumCasa(app.signos[parseInt(arrayAsc[currentIndex ] - 1)], r.cNumSigno)
                        if(numCasa>12){
                            numCasa=numCasa-12
                        }
                        //console.log('4::::::->'+numCasa)
                        let pp=''
                        let pf=''
                        let destinatario=''
                        if(model[currentIndex].indexOf('Ascendente')===0){
                            destinatario='persona con '+model[currentIndex]
                        }else{
                            destinatario=model[currentIndex]
                        }
                        pp='Actualmente '+destinatario
                        let gradoActualDeLuna = r.cGradoLuna
                        if(gradoActualDeLuna<12){
                            pf+='<br /><br />La persona va a estar así hoy y mañana.'
                        }else if(gradoActualDeLuna>=12&&gradoActualDeLuna<24){
                            pf+='La persona va a estar así hoy y mañana cambia a la casa número '+parseInt(numCasa+1)+' en el signo '+app.signos[r.cNumSigno]
                        }else{
                            pf+='La persona va a estar así hoy'
                        }
                        resCarta.text=pp+' tiene la Luna en tránsito en el grado '+gradoActualDeLuna+' de la casa número '+numCasa+' en el signo  '+app.signos[r.cNumSigno - 1]
                        resCarta.text+='<br /><br />'+getAsunto(numCasa, destinatario)
                        resCarta.text+=pf+'<br /><br />'
                        r.speak(resCarta.text)
                    }
                }
                UText{
                    id: resCarta
                    visible: cbAsc.currentIndex!==0
                    width: r.width-app.fs
                    text: 'Seleccionar un nombre o Ascendente'
                    font.pixelSize: app.fs*1.5
                    wrapMode: Text.WordWrap
                    anchors.horizontalCenter: parent.horizontalCenter
                }

            }
        }
    }
    Component.onCompleted: {
        //https://www.geodatos.net/coordenadas/buscar?q=sfs
    }    
}
