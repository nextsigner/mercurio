import QtQuick 2.0
import "func.js" as JS

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: app.c1
    property int cCasa: -1
    property var arrayDataCasas: []
    MouseArea{
        anchors.fill: r
    }
    Column{
        spacing: app.fs
        anchors.centerIn: parent
        Item{width: 1;height: app.fs*0.5}
        BotonUX{
            text: 'Atras'
            fontSize: app.rot?app.fs*0.5:app.fs
            onClicked: {
                app.mod=-3
                unik.speak('atras')
            }
        }
        Text{
            width: xApp.width-app.fs*2
            text: '<b>Lilith en las Casas</b>'
            color: app.c2
            font.pixelSize: app.fs
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Grid{
            visible: r.cCasa===-1&&r.visible
            columns: app.rot?6:3
            spacing: app.rot?app.fs*0.25:app.fs
            anchors.horizontalCenter: parent.horizontalCenter
            onVisibleChanged: {
                if(visible)unik.speak('Seleccionar casa')
            }
            Repeater{
                id: repIconCasas
                model: 12
                BotonUX{
                    width: app.rot?app.fs*3:app.fs*5
                    height: width
                    text: "Casa "+parseInt(modelData + 1)
                    fontSize: app.rot?app.fs*0.5:app.fs
                    onClicked: r.cCasa=index
                }
            }
        }
    }
    Item{
        id: xDataCasas
        visible: r.cCasa!==-1
        Repeater{
            id: repDataCasas
            Rectangle{
                visible: r.cCasa===index
                width: xApp.width
                height: xApp.height
                radius: app.fs*0.5
                color: app.c1
                onVisibleChanged: {
                    if(visible){
                        r.speak(modelData)
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
                        width: parent.width-app.fs
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: app.fs
                        Flow{
                            width: parent.width
                            spacing: app.fs
                            BotonUX{
                                text: 'Atras'
                                onClicked: {
                                    unik.speak('atras')
                                    r.cCasa=-1
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
                                    //let s = (''+modelData).replace(/<br \/>/g, '        ').replace(/<b>/g, '').replace(/<\/b>/g, '')
                                    //logView.showLog(s)
                                    r.speak(modelData)
                                }
                            }
                        }
                        Item{width: 1; height: app.fs}
                        Text{
                            width: xApp.width-app.fs*2
                            text: modelData
                            color: app.c2
                            font.pixelSize: app.fs
                            wrapMode: Text.WordWrap
                            textFormat: Text.RichText
                        }
                    }
                }
            }
        }
    }
    Component.onCompleted: {
        let d1=unik.getFile('dataCasasLilith.json').replace(/\n/g,'<br /><br />').replace('}}<br /><br />','}}')
        let json = JSON.parse(d1)
        for(let i=1;i<=12;i++){
            //console.log('D: '+json['casas']['casa'+i])
            arrayDataCasas.push(json['casas']['casa'+i])
        }
        repDataCasas.model = r.arrayDataCasas
    }
    function speak(text){
        let s = (''+text).replace(/<br \/>/g, '        ').replace(/<b>/g, '').replace(/<\/b>/g, '').replace(/LILITH/g, 'la luna negra').replace(/Lilith/g, 'la luna negra').replace(/Casa IV/g, 'casa 4').replace(/Casa IX/g, 'casa 9').replace(/Casa III/g, 'casa 3').replace(/Casa II/g, 'casa 2').replace(/Casa I/g, 'casa 1').replace(/Casa V/g, 'casa 5').replace(/Casa VIII/g, 'casa 8').replace(/Casa VII/g, 'casa 7').replace(/Casa VI/g, 'casa 6').replace(/Casa X/g, 'casa 10').replace(/Casa XII/g, 'casa 12').replace(/Casa XI/g, 'casa 11').replace(/CASA IV/g, 'casa 4').replace(/CASA IX/g, 'casa 9').replace(/CASA III/g, 'casa 3').replace(/CASA II/g, 'casa 2').replace(/CASA I/g, 'casa 1').replace(/CASA V/g, 'casa 5').replace(/CASA VIII/g, 'casa 8').replace(/CASA VII/g, 'casa 7').replace(/CASA VI/g, 'casa 6').replace(/CASA X/g, 'casa 10').replace(/CASA XII/g, 'casa 12').replace(/CASA XI/g, 'casa 11')
        unik.speak(s)
    }
}
